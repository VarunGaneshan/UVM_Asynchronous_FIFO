`uvm_analysis_imp_decl(_write);
`uvm_analysis_imp_decl(_read);

class afifo_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(afifo_scoreboard)
  
  uvm_analysis_imp_write#(afifo_write_sequence_item, afifo_scoreboard) write_port;
  uvm_analysis_imp_read#(afifo_read_sequence_item, afifo_scoreboard) read_port;

  virtual afifo_if vif;
  bit [`DATA_WIDTH-1:0] expected_fifo [$:`FIFO_DEPTH];
  int write_count, read_count;
  int write_read_pass, write_read_fail;
  bit prev_wfull;
  
  function new(string name = "afifo_scoreboard", uvm_component parent);
    super.new(name, parent);
    write_count = 0;
    read_count = 0; 
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    write_port = new("write_port", this);
    read_port = new("read_port", this);
    if(!uvm_config_db#(virtual afifo_if)::get(this, "", "vif", vif)) begin
      `uvm_fatal("NOVIF", "No virtual interface found");
    end
  endfunction
  
  virtual function void write_write(afifo_write_sequence_item trans);
    if(vif.wrst_n == 0) begin
      // Reset condition, clear expected FIFO
      expected_fifo.delete();
      prev_wfull = 0;
      return;
    end
    if (trans.winc && !prev_wfull) begin
        expected_fifo.push_back(trans.wdata);
        write_count++;
        `uvm_info(get_type_name(), $sformatf("[%0t] WRITE: data=%0d, fifo_size=%0d", 
                  $time, trans.wdata, expected_fifo.size()), UVM_MEDIUM);
        prev_wfull=trans.wfull;

    end else if (trans.winc && prev_wfull) begin
        `uvm_info(get_type_name(), $sformatf("[%0t] WRITE BLOCKED: FIFO is full, winc ignored", $time), UVM_MEDIUM);
        prev_wfull=trans.wfull;
    end
  endfunction
  
  virtual function void write_read(afifo_read_sequence_item trans);
    bit [`DATA_WIDTH-1:0] expected_data;
    if(vif.rrst_n == 0) begin
      // Reset condition, clear expected FIFO
      expected_fifo.delete();
      return;
    end
    if (trans.rinc && !trans.rempty) begin
      // Data should be read from FIFO
      if (expected_fifo.size() > 0) begin
            expected_data = expected_fifo.pop_front();
            read_count++;
            `uvm_info(get_type_name(), $sformatf("[%0t] READ: expected_data=%0d, actual_data=%0d, fifo_size=%0d", 
                      $time, expected_data, trans.rdata, expected_fifo.size()), UVM_MEDIUM);
            
            // Check read data
            if (trans.rdata == expected_data) begin
              `uvm_info(get_type_name(), $sformatf("[%0t] DATA CHECK PASS: rdata=%0d matches expected", 
                      $time, trans.rdata), UVM_MEDIUM);
              write_read_pass++;
            end else begin
              `uvm_error(get_type_name(), $sformatf("[%0t] DATA MISMATCH: Expected=%0d, Actual=%0d", 
                        $time, expected_data, trans.rdata));
              write_read_fail++;
            end
      end else begin
          `uvm_error(get_type_name(), $sformatf("[%0t] UNEXPECTED READ: FIFO model is empty but read occurred", $time)); //Never happened in simulation
      end
    end
      else if (trans.rinc && trans.rempty) begin
          `uvm_info(get_type_name(), $sformatf("[%0t] READ BLOCKED: FIFO is empty, rinc ignored", $time), UVM_MEDIUM);
    end
  endfunction
  
  virtual function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    `uvm_info(get_type_name(), $sformatf("SCOREBOARD SUMMARY:"), UVM_LOW);
    `uvm_info(get_type_name(), $sformatf("  Total Writes: %0d", write_count), UVM_LOW);
    `uvm_info(get_type_name(), $sformatf("  Total Reads:  %0d", read_count), UVM_LOW);
    `uvm_info(get_type_name(), $sformatf("  Write/Read Data Checks: Pass=%0d, Fail=%0d", write_read_pass, write_read_fail), UVM_LOW);
  endfunction
  
endclass