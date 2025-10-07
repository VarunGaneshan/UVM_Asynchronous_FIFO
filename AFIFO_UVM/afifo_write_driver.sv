class afifo_write_driver extends uvm_driver#(afifo_write_sequence_item);
 `uvm_component_utils(afifo_write_driver)
	virtual afifo_if vif;
	afifo_write_sequence_item drv_trans;
	function new(string name,uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
    	if(!uvm_config_db#(virtual afifo_if)::get(this,"","vif",vif)) begin
      		`uvm_fatal("NOVIF","No virtual interface found")
    end
  endfunction
  
	virtual task run_phase(uvm_phase phase);
    	super.run_phase(phase);
		@(vif.write_drv_cb);
		forever begin
			seq_item_port.get_next_item(drv_trans);
			drive();
			seq_item_port.item_done();
		end
	endtask

	task drive();
		vif.write_drv_cb.wdata <= drv_trans.wdata;
		vif.write_drv_cb.winc  <= drv_trans.winc;
		`uvm_info(get_type_name(), $sformatf("[%0t] Driver Driving: winc=%0b, wdata=%0d", $time, drv_trans.winc, drv_trans.wdata), UVM_LOW);
		@(vif.write_drv_cb);
	endtask
  
endclass

