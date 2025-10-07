`uvm_analysis_imp_decl(_write);
`uvm_analysis_imp_decl(_read);

class afifo_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(afifo_scoreboard)
  
  uvm_analysis_imp_write#(afifo_write_sequence_item, afifo_scoreboard) write_port;
  uvm_analysis_imp_read#(afifo_read_sequence_item, afifo_scoreboard) read_port;

  // FIFO model to track expected behavior
  bit [`DATA_WIDTH-1:0] expected_fifo [$:`FIFO_DEPTH-1];
  int write_count, read_count;
  int max_depth;
  bit expected_full, expected_empty;
  int wfull_pass, wfull_fail;
  int rempty_pass, rempty_fail;
  int write_read_pass, write_read_fail;
  
  function new(string name = "afifo_scoreboard", uvm_component parent);
    super.new(name, parent);
    max_depth = `FIFO_DEPTH;
    expected_empty = 1;
    expected_full = 0;
    write_count = 0;
    read_count = 0; 
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    write_port = new("write_port", this);
    read_port = new("read_port", this);
  endfunction
  
  // Write analysis port implementation
  virtual function void write_write(afifo_write_sequence_item trans);
    if (trans.winc && !trans.wfull) begin
      // Data should be written to FIFO
      expected_fifo.push_back(trans.wdata);
      write_count++;
      
      `uvm_info(get_type_name(), $sformatf("[%0t] WRITE: data=%0d, fifo_size=%0d", 
                $time, trans.wdata, expected_fifo.size()), UVM_MEDIUM);
      
      // Update expected flags
      expected_empty = 0;
      if (expected_fifo.size() >= max_depth) begin
        expected_full = 1;
      end
      
      // Check wfull signal
      if (trans.wfull != expected_full) begin
        `uvm_error(get_type_name(), $sformatf("[%0t] WFULL MISMATCH: Expected=%0b, Actual=%0b, FIFO size=%0d", 
                  $time, expected_full, trans.wfull, expected_fifo.size()));
        wfull_fail++;
      end else begin
        `uvm_info(get_type_name(), $sformatf("[%0t] WFULL CHECK PASS: wfull=%0b", 
                 $time, trans.wfull), UVM_HIGH);
        wfull_pass++;
      end
    end else if (trans.winc && trans.wfull) begin
      `uvm_info(get_type_name(), $sformatf("[%0t] WRITE BLOCKED: FIFO is full, winc ignored", $time), UVM_MEDIUM);
    end
  endfunction
  
  // Read analysis port implementation  
  virtual function void write_read(afifo_read_sequence_item trans);
    bit [`DATA_WIDTH-1:0] expected_data;
    
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
                   $time, trans.rdata), UVM_HIGH);
          write_read_pass++;
        end else begin
          `uvm_error(get_type_name(), $sformatf("[%0t] DATA MISMATCH: Expected=%0d, Actual=%0d", 
                    $time, expected_data, trans.rdata));
          write_read_fail++;
        end
        
        // Update expected flags
        if (expected_fifo.size() == 0) begin
          expected_empty = 1;
        end
        expected_full = 0;
      end else begin
        `uvm_error(get_type_name(), $sformatf("[%0t] UNEXPECTED READ: FIFO model is empty but read occurred", $time));
      end
      
      // Check rempty signal
      if (trans.rempty != expected_empty) begin
        `uvm_error(get_type_name(), $sformatf("[%0t] REMPTY MISMATCH: Expected=%0b, Actual=%0b, FIFO size=%0d", 
                  $time, expected_empty, trans.rempty, expected_fifo.size()));
        rempty_fail++;
      end else begin
        `uvm_info(get_type_name(), $sformatf("[%0t] REMPTY CHECK PASS: rempty=%0b", 
                 $time, trans.rempty), UVM_HIGH);
        rempty_pass++;
      end
    end else if (trans.rinc && trans.rempty) begin
      `uvm_info(get_type_name(), $sformatf("[%0t] READ BLOCKED: FIFO is empty, rinc ignored", $time), UVM_MEDIUM);
    end
  endfunction
  
  virtual function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    `uvm_info(get_type_name(), $sformatf("SCOREBOARD SUMMARY:"), UVM_LOW);
    `uvm_info(get_type_name(), $sformatf("  Total Writes: %0d", write_count), UVM_LOW);
    `uvm_info(get_type_name(), $sformatf("  Total Reads:  %0d", read_count), UVM_LOW);
    `uvm_info(get_type_name(), $sformatf("  WFULL Checks: Pass=%0d, Fail=%0d", wfull_pass, wfull_fail), UVM_LOW);
    `uvm_info(get_type_name(), $sformatf("  REMPTY Checks: Pass=%0d, Fail=%0d", rempty_pass, rempty_fail), UVM_LOW);
    `uvm_info(get_type_name(), $sformatf("  Write/Read Data Checks: Pass=%0d, Fail=%0d", write_read_pass, write_read_fail), UVM_LOW);
  endfunction
  
endclass


