class afifo_read_monitor extends uvm_monitor;
  `uvm_component_utils(afifo_read_monitor)
  virtual afifo_read_if vif;
  uvm_analysis_port#(afifo_read_sequence_item) mon_port;
  afifo_read_sequence_item mon_trans;

  function new(string name="afifo_read_monitor", uvm_component parent=null);
        super.new(name, parent);
        mon_trans = new();
        mon_port = new("mon_port", this);
  endfunction
    
  virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if(!uvm_config_db#(virtual afifo_read_if)::get(this, "", "vif", vif)) begin
        `uvm_fatal("NOVIF", "No virtual interface found");
      end
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    repeat (2) @(vif.read_mon_cb);
    forever begin
      monitor_dut();
      mon_port.write(mon_trans);
      `uvm_info(get_type_name(), $sformatf("[%0t] Captured: rinc=%0b, rdata=%0d, rempty=%0b", $time, mon_trans.rinc, mon_trans.rdata, mon_trans.rempty), UVM_LOW);
			@(vif.read_mon_cb);
    end
endtask

task monitor_dut();
	  mon_trans.rinc = vif.rinc;
    mon_trans.rdata = vif.rdata;
    mon_trans.rempty = vif.rempty;
 endtask

endclass    