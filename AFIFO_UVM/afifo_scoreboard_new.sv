`uvm_analysis_imp_decl(_w)
`uvm_analysis_imp_decl(_r)


class afifo_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(afifo_scoreboard)
  uvm_analysis_imp_w #(afifo_write_sequence_item, afifo_scoreboard) write_port;
  uvm_analysis_imp_r #(afifo_read_sequence_item, afifo_scoreboard) read_port;


  virtual afifo_if vif;
  bit [`DATA_WIDTH-1:0] mem [`FIFO_DEPTH-1:0];
 
  bit [`ADDR_WIDTH:0] wbin;           
  bit [`ADDR_WIDTH:0] wptr;         
  bit [`ADDR_WIDTH:0] wq2_rptr_q1;   
  bit [`ADDR_WIDTH:0] wq2_rptr;       
  bit wfull;                          
  bit [`ADDR_WIDTH:0] wgray_next, wbin_next;
  bit wfull_val;
  bit [`ADDR_WIDTH-1:0] waddr;

  bit [`ADDR_WIDTH:0] rbin;          
  bit [`ADDR_WIDTH:0] rptr;           
  bit [`ADDR_WIDTH:0] rq2_wptr_q1;    
  bit [`ADDR_WIDTH:0] rq2_wptr;       
  bit rempty;                        
  bit [`ADDR_WIDTH:0] rgray_next, rbin_next;
  bit rempty_val;
  bit [`ADDR_WIDTH-1:0] raddr;
  bit [`DATA_WIDTH-1:0] expected_data;

  int write_count = 0;
  int read_count = 0;
  int data_pass = 0;
  int data_fail = 0;
  int wfull_pass = 0;
  int wfull_fail = 0;
  int rempty_pass = 0;
  int rempty_fail = 0;

  function new(string name = "afifo_scoreboard", uvm_component parent);
    super.new(name, parent);
    wbin = 0;
    wptr = 0;
    wq2_rptr_q1 = 0;
    wq2_rptr = 0;
    wfull = 0;

    rbin = 0;
    rptr = 0;
    rq2_wptr_q1 = 0;
    rq2_wptr = 0;
    rempty = 1;  // FIFO starts empty
  endfunction
 
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    write_port = new("write_analysis_imp", this);
    read_port = new("read_analysis_imp", this);
    if(!uvm_config_db#(virtual afifo_if)::get(this, "", "vif", vif)) begin
        `uvm_fatal("NOVIF", "No virtual interface found");
    end
  endfunction
 
  // Binary to Gray conversion
  function bit [`ADDR_WIDTH:0] bin2gray(bit [`ADDR_WIDTH:0] bin);
    return (bin >> 1) ^ bin;
  endfunction
 
  // WRITE PROCESSING
  virtual function void write_w(afifo_write_sequence_item trans);   
    if (!vif.sb_write_mon_cb.wrst_n) begin
      wbin = 0;
      wptr = 0;
      wq2_rptr_q1 = 0;
      wq2_rptr = 0;
      wfull = 0;
      `uvm_info(get_type_name(), $sformatf("[%0t] WRITE DOMAIN RESET", $time), UVM_MEDIUM);
    end
    
    // In DUT: always @(posedge wclk) if (wclk_en && !wfull) mem[waddr] <= wdata;
    waddr = wbin[`ADDR_WIDTH-1:0];  // Current write address
    // Check if write happened: winc && !wfull_old
    if (trans.winc && !wfull) begin
      mem[waddr] = trans.wdata;
      write_count++;
      `uvm_info(get_type_name(), $sformatf("[%0t] WRITE: addr=%0d, data=%0d, Memory contents: %p",
                $time, waddr, trans.wdata, mem), UVM_MEDIUM);
      // In DUT: assign wbin_next = wbin + (winc & ~wfull);
      wbin_next = wbin + (trans.winc & ~wfull);
      wgray_next = bin2gray(wbin_next);
    $display("write_count:%0d wbin_next=%0d, wgray_next=%0d", write_count, wbin_next, wgray_next);
    end else if (trans.winc && wfull) begin
      `uvm_info(get_type_name(), $sformatf("[%0t] WRITE BLOCKED: FIFO full, Memory contents: %p", $time, mem), UVM_MEDIUM);
    end

    // Check DUT's wfull matches our calculated wfull
    if (trans.wfull != wfull) begin
      `uvm_error(get_type_name(), $sformatf("[%0t] WFULL MISMATCH: SB=%0b, DUT=%0b, wbin=%0d, wq2_rptr=%0d",
                $time, wfull, trans.wfull, wbin, wq2_rptr));
      wfull_fail++;
      $display("===================== WFULL FAIL ========================");
    end
    else begin
      `uvm_info(get_type_name(), $sformatf("[%0t] WFULL MATCH: SB=%0b, DUT=%0b, wbin=%0d, wq2_rptr=%0d",
                $time, wfull, trans.wfull, wbin, wq2_rptr), UVM_MEDIUM);
      wfull_pass++;
    end

   // always @(posedge wclk) {wbin, wptr} <= {wbin_next, wgray_next};
    wbin = wbin_next;
    wptr = wgray_next;

    // In DUT: assign wfull_val = (wgray_next=={~wq2_rptr[MSB:MSB-1], wq2_rptr[MSB-2:0]});
    //         always @(posedge wclk) wfull <= wfull_val;   
    wfull_val = (wgray_next == {~wq2_rptr[`ADDR_WIDTH:`ADDR_WIDTH-1],
                                    wq2_rptr[`ADDR_WIDTH-2:0]});
    wfull = wfull_val;

    // In DUT: always @(posedge wclk) {q2, q1} <= {q1, din};
    wq2_rptr = wq2_rptr_q1;
    wq2_rptr_q1 = rptr;
  endfunction
 
  // READ PROCESSING
  virtual function void write_r(afifo_read_sequence_item trans);
    if (!vif.sb_read_mon_cb.rrst_n) begin
      rbin = 0;
      rptr = 0;
      rq2_wptr_q1 = 0;
      rq2_wptr = 0;
      rempty = 1;
      `uvm_info(get_type_name(), $sformatf("[%0t] READ DOMAIN RESET", $time), UVM_MEDIUM);
    end

    // Check if read happened: rinc && !rempty_old
    if (trans.rinc && !rempty) begin
      read_count++;
      `uvm_info(get_type_name(), $sformatf("[%0t] READ: addr=%0d, expected=%0d, actual=%0d, Memory contents: %p",
                $time, raddr, expected_data, trans.rdata, mem), UVM_MEDIUM);
     
      // In DUT: always @(posedge rclk) if(r_en & !rempty) rdata <= mem[raddr]; 
      raddr = rbin[`ADDR_WIDTH-1:0]; 
      expected_data = mem[raddr];
      // Data check
      if (trans.rdata == expected_data) begin
        `uvm_info(get_type_name(), $sformatf("[%0t] DATA CHECK PASS", $time), UVM_MEDIUM);
        data_pass++;
      end else begin
        `uvm_error(get_type_name(), $sformatf("[%0t] DATA MISMATCH: Expected=%0d, Actual=%0d",
                  $time, expected_data, trans.rdata));
        data_fail++;
        $display("===================== DATA FAIL ========================");
      end
      // In DUT: assign rbin_next = rbin + (rinc & ~rempty);
      rbin_next = rbin + (trans.rinc & ~rempty);
      rgray_next = bin2gray(rbin_next);
    end else if (trans.rinc && rempty) begin
      `uvm_info(get_type_name(), $sformatf("[%0t] READ BLOCKED: FIFO empty, Memory contents: %p", $time, mem), UVM_MEDIUM);
    end
    
    // Check DUT's rempty matches our calculated rempty
    if (trans.rempty != rempty) begin
      `uvm_error(get_type_name(), $sformatf("[%0t] REMPTY MISMATCH: SB=%0b, DUT=%0b, rbin=%0d, rq2_wptr=%0d",
                $time, rempty, trans.rempty, rbin, rq2_wptr));
      rempty_fail++;
      $display("===================== REMPTY FAIL ========================");
    end
    else begin
      `uvm_info(get_type_name(), $sformatf("[%0t] REMPTY MATCH: SB=%0b, DUT=%0b, rbin=%0d, rq2_wptr=%0d",
                $time, rempty, trans.rempty, rbin, rq2_wptr), UVM_MEDIUM);
      rempty_pass++;
    end

    //         always @(posedge rclk) {rbin, rptr} <= {rbin_next, rgray_next};
    rbin = rbin_next;
    rptr = rgray_next;

    // In DUT: assign rempty_val = (rgray_next == rq2_wptr);
    //         always @(posedge rclk) rempty <= rempty_val;
    rempty_val = (rgray_next == rq2_wptr);
    rempty = rempty_val;

    // In DUT: always @(posedge rclk) {q2, q1} <= {q1, din};
    rq2_wptr = rq2_wptr_q1;
    rq2_wptr_q1 = wptr;
  endfunction
 
  virtual function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    `uvm_info(get_type_name(), "==============================================", UVM_NONE);
    `uvm_info(get_type_name(), "         SCOREBOARD SUMMARY", UVM_NONE);
    `uvm_info(get_type_name(), "==============================================", UVM_NONE);
    `uvm_info(get_type_name(), $sformatf("  Total Writes:    %0d", write_count), UVM_NONE);
    `uvm_info(get_type_name(), $sformatf("  Total Reads:     %0d", read_count), UVM_NONE);
    `uvm_info(get_type_name(), "----------------------------------------------", UVM_NONE);
    `uvm_info(get_type_name(), $sformatf("  DATA Checks:     Pass=%0d, Fail=%0d", data_pass, data_fail), UVM_NONE);
    `uvm_info(get_type_name(), $sformatf("  WFULL Checks:    Pass=%0d, Fail=%0d", wfull_pass, wfull_fail), UVM_NONE);
    `uvm_info(get_type_name(), $sformatf("  REMPTY Checks:   Pass=%0d, Fail=%0d", rempty_pass, rempty_fail), UVM_NONE);
    `uvm_info(get_type_name(), "==============================================", UVM_NONE);
  endfunction

endclass



