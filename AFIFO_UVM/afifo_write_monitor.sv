class afifo_write_monitor extends uvm_monitor;
  `uvm_component_utils(afifo_write_monitor)
  virtual afifo_write_if vif;
  uvm_analysis_port#(afifo_write_sequence_item) mon_port;
  afifo_write_sequence_item mon_trans;

  function new(string name="afifo_write_monitor", uvm_component parent=null);
        super.new(name, parent);
        mon_trans = new();
        mon_port = new("mon_port", this);
  endfunction
    
  virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if(!uvm_config_db#(virtual afifo_write_if)::get(this, "", "vif", vif)) begin
        `uvm_fatal("NOVIF", "No virtual interface found");
      end
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    repeat (2) @(vif.write_mon_cb);
    forever begin
      monitor_dut();
      mon_port.write(mon_trans);
      `uvm_info(get_type_name(), $sformatf("[%0t] Captured: winc=%0b, wdata=%0d, wfull=%0b", $time, mon_trans.winc, mon_trans.wdata, mon_trans.wfull), UVM_LOW);
			@(vif.write_mon_cb);
    end
endtask

task monitor_dut();
	  mon_trans.winc = vif.winc;
    mon_trans.wdata = vif.wdata;
    mon_trans.wfull = vif.wfull;
 endtask

endclass    