class afifo_subscriber extends uvm_component;
  `uvm_component_utils(afifo_subscriber)
  
  afifo_write_sequence_item write_trans;
  afifo_read_sequence_item read_trans;
  real write_cov, read_cov;
  
  uvm_tlm_analysis_fifo #(afifo_write_sequence_item) write_fifo;
  uvm_tlm_analysis_fifo #(afifo_read_sequence_item) read_fifo;

  covergroup write_cov_grp;
    WINC: coverpoint write_trans.winc {
      bins winc_low = {0};
      bins winc_high = {1};
    }
    
    WDATA: coverpoint write_trans.wdata {
      bins data_low = {[0:63]};
      bins data_mid = {[64:191]};
      bins data_high = {[192:255]};
    }
    
    WFULL: coverpoint write_trans.wfull {
      bins not_full = {0};
      bins full = {1};
    }
    
    WINC_X_WFULL: cross WINC, WFULL {
      bins write_when_not_full = binsof(WINC.winc_high) && binsof(WFULL.not_full);
      bins write_when_full = binsof(WINC.winc_high) && binsof(WFULL.full);
      ignore_bins no_write_when_not_full = binsof(WINC.winc_low) && binsof(WFULL.not_full);
      ignore_bins no_write_when_full = binsof(WINC.winc_low) && binsof(WFULL.full);
    }
  endgroup
   
  covergroup read_cov_grp;
    RINC: coverpoint read_trans.rinc {
      bins rinc_low = {0};
      bins rinc_high = {1};
    }
    
    RDATA: coverpoint read_trans.rdata {
      bins data_low = {[0:63]};
      bins data_mid = {[64:191]};
      bins data_high = {[192:255]};
    }
    
    REMPTY: coverpoint read_trans.rempty {
      bins not_empty = {0};
      bins empty = {1};
    }
    
    RINC_X_REMPTY: cross RINC, REMPTY {
      bins read_when_not_empty = binsof(RINC.rinc_high) && binsof(REMPTY.not_empty);
      bins read_when_empty = binsof(RINC.rinc_high) && binsof(REMPTY.empty);
      ignore_bins no_read_when_not_empty = binsof(RINC.rinc_low) && binsof(REMPTY.not_empty);
      ignore_bins no_read_when_empty = binsof(RINC.rinc_low) && binsof(REMPTY.empty);
    }
  endgroup

  function new(string name = "afifo_subscriber", uvm_component parent=null);
    super.new(name, parent);
    write_cov_grp = new();
    read_cov_grp = new();
    write_fifo = new("write_fifo", this);
    read_fifo = new("read_fifo", this);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    
    fork
      // Write coverage collection
      forever begin
        write_fifo.get(write_trans);
        write_cov_grp.sample();
        `uvm_info(get_type_name(), $sformatf("[%0t] Write Coverage: winc=%0b, wdata=0x%0h, wfull=%0b", 
                 $time, write_trans.winc, write_trans.wdata, write_trans.wfull), UVM_HIGH);
      end
      
      // Read coverage collection
      forever begin
        read_fifo.get(read_trans);
        read_cov_grp.sample();
        `uvm_info(get_type_name(), $sformatf("[%0t] Read Coverage: rinc=%0b, rdata=0x%0h, rempty=%0b", 
                 $time, read_trans.rinc, read_trans.rdata, read_trans.rempty), UVM_HIGH);
      end
    join
  endtask

  virtual function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    write_cov = write_cov_grp.get_coverage();
    read_cov = read_cov_grp.get_coverage();
    
    `uvm_info(get_type_name(), $sformatf("COVERAGE SUMMARY:"), UVM_LOW);
    `uvm_info(get_type_name(), $sformatf("  Write Coverage: %.2f%%", write_cov), UVM_LOW);
    `uvm_info(get_type_name(), $sformatf("  Read Coverage:  %.2f%%", read_cov), UVM_LOW);
    `uvm_info(get_type_name(), $sformatf("  Overall Coverage: %.2f%%", (write_cov + read_cov)/2), UVM_LOW);
  endfunction

endclass
