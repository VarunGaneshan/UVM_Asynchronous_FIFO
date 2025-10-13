`uvm_analysis_imp_decl(_w)
`uvm_analysis_imp_decl(_r)


class afifo_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(afifo_scoreboard)
  uvm_analysis_imp_w #(afifo_write_sequence_item, afifo_scoreboard) write_port;
  uvm_analysis_imp_r #(afifo_read_sequence_item, afifo_scoreboard) read_port;


  virtual afifo_if vif;
  bit [`DATA_WIDTH-1:0] mem [`FIFO_DEPTH-1:0];
 
  bit [`ADDR_WIDTH:0] wbin;           // Binary write pointer
  bit [`ADDR_WIDTH:0] wptr;           // Gray write pointer
  bit [`ADDR_WIDTH:0] wq2_rptr_q1;    // Sync FF stage 1
  bit [`ADDR_WIDTH:0] wq2_rptr;       // Sync FF stage 2
  bit wfull;                          // Full flag


  bit [`ADDR_WIDTH:0] rbin;           // Binary read pointer
  bit [`ADDR_WIDTH:0] rptr;           // Gray read pointer
  bit [`ADDR_WIDTH:0] rq2_wptr_q1;    // Sync FF stage 1
  bit [`ADDR_WIDTH:0] rq2_wptr;       // Sync FF stage 2
  bit rempty;                         // Empty flag
 
  int write_count = 0;
  int read_count = 0;
  int data_pass = 0;
  int data_fail = 0;
  int wfull_pass = 0;
  int wfull_fail = 0;
  int rempty_pass = 0;
  int rempty_fail = 0;

  bit [`ADDR_WIDTH:0] wgray_next, wbin_next;
  bit wfull_val;
  bit [`ADDR_WIDTH-1:0] waddr;
  bit [`ADDR_WIDTH:0] rgray_next, rbin_next;
  bit rempty_val=1;
  bit [`ADDR_WIDTH-1:0] raddr;
  bit [`DATA_WIDTH-1:0] expected_data;

  function new(string name = "afifo_scoreboard", uvm_component parent);
    super.new(name, parent);
    // Initialize to reset state
    wbin = 0;
    wptr = 0;
    wq2_rptr_q1 = 0;
    wq2_rptr = 0;
    wfull = 0;
   
    rbin = 0;
    rptr = 0;
    rq2_wptr_q1 = 0;
    rq2_wptr = 0;
    rempty = 1;  // Empty at reset
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
    // Handle reset
    if (!vif.wrst_n) begin
      wbin = 0;
      wptr = 0;
      wq2_rptr_q1 = 0;
      wq2_rptr = 0;
      wfull = 0;
      `uvm_info(get_type_name(), $sformatf("[%0t] WRITE DOMAIN RESET", $time), UVM_MEDIUM);
      return;
    end
    //Display all variables in this function
    $display("Start[%0t]:wbin=%0d, wptr=%0d,wgray_next=%0d,wbin_next=%0d, wq2_rptr_q1=%0d, wq2_rptr=%0d, wfull=%0b,wfull_val=%0b",$time,
             wbin, wptr, wgray_next, wbin_next, wq2_rptr_q1, wq2_rptr, wfull, wfull_val);
    // In DUT: always @(posedge wclk) if (wclk_en && !wfull) mem[waddr] <= wdata;
    waddr = wbin[`ADDR_WIDTH-1:0];  // Current write address
    $display("waddr %0d SB wq2_rptr_q1=%0d, SB wq2_rptr=%0d", waddr, wq2_rptr_q1, wq2_rptr);
    // Check if write happened: winc && !wfull_old
    if (trans.winc && !wfull) begin
      mem[waddr] = trans.wdata;
      write_count++;
      `uvm_info(get_type_name(), $sformatf("[%0t] WRITE: addr=%0d, data=%0d, Memory contents: %p",
                $time, waddr, trans.wdata, mem), UVM_MEDIUM);
    // In DUT: assign wbin_next = wbin + (winc & ~wfull);
    //         always @(posedge wclk) {wbin, wptr} <= {wbin_next, wgray_next};
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
    //Try both ways
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
    $display("End  [%0t]:wbin=%0d, wptr=%0d,wgray_next=%0d,wbin_next=%0d, wq2_rptr_q1=%0d, wq2_rptr=%0d, wfull=%0b,wfull_val=%0b",$time,
             wbin, wptr, wgray_next, wbin_next, wq2_rptr_q1, wq2_rptr, wfull, wfull_val);
   
  endfunction
 
  // READ PROCESSING
  virtual function void write_r(afifo_read_sequence_item trans);
    // Handle reset 
    if (!vif.rrst_n) begin
      rbin = 0;
      rptr = 0;
      rq2_wptr_q1 = 0;
      rq2_wptr = 0;
      rempty = 0;
      `uvm_info(get_type_name(), $sformatf("[%0t] READ DOMAIN RESET", $time), UVM_MEDIUM);
      return;
    end
    //Display all variables in this function
    $display("Start[%0t]:rbin=%0d, rptr=%0d,rgray_next=%0d,rbin_next=%0d, rq2_wptr_q1=%0d, rq2_wptr=%0d, rempty=%0b,rempty_val=%0b",$time,
             rbin, rptr, rgray_next, rbin_next, rq2_wptr_q1, rq2_wptr, rempty, rempty_val);
    // Check if read happened: rinc && !rempty_old
    if (trans.rinc && !rempty) begin
      read_count++;
      `uvm_info(get_type_name(), $sformatf("[%0t] READ: addr=%0d, expected=%0d, actual=%0d, Memory contents: %p",
                $time, raddr, expected_data, trans.rdata, mem), UVM_MEDIUM);
     
    // In DUT: always @(posedge rclk) if(r_en & !rempty) rdata <= mem[raddr]; 
    raddr = rbin[`ADDR_WIDTH-1:0]; 
    expected_data = mem[raddr];
    $display("raddr %0d SB rq2_wptr_q1=%0d, SB rq2_wptr=%0d", raddr, rq2_wptr_q1, rq2_wptr);
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
    //         always @(posedge rclk) {rbin, rptr} <= {rbin_next, rgray_next};
    rbin_next = rbin + (trans.rinc & ~rempty);
    rgray_next = bin2gray(rbin_next);
    $display("read_count:%0d rbin_next=%0d, rgray_next=%0d", read_count, rbin_next, rgray_next);
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
    //Try both ways
    rbin = rbin_next;
    rptr = rgray_next;

    // In DUT: assign rempty_val = (rgray_next == rq2_wptr);
    //         always @(posedge rclk) rempty <= rempty_val;
    rempty_val = (rgray_next == rq2_wptr);
    rempty = rempty_val;
    // In DUT: always @(posedge rclk) {q2, q1} <= {q1, din};
    rq2_wptr = rq2_wptr_q1;
    rq2_wptr_q1 = wptr;
    $display("End  [%0t]:rbin=%0d, rptr=%0d,rgray_next=%0d,rbin_next=%0d, rq2_wptr_q1=%0d, rq2_wptr=%0d, rempty=%0b,rempty_val=%0b",$time,
             rbin, rptr, rgray_next, rbin_next, rq2_wptr_q1, rq2_wptr, rempty, rempty_val);
    
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



