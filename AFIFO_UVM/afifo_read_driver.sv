class afifo_read_driver extends uvm_driver#(afifo_read_sequence_item);
 `uvm_component_utils(afifo_read_driver)
	virtual afifo_read_if vif;
	afifo_read_sequence_item drv_trans;
	function new(string name,uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
    	if(!uvm_config_db#(virtual afifo_read_if)::get(this,"","vif",vif)) begin
      		`uvm_fatal("NOVIF","No virtual interface found")
    end
  endfunction
  
	virtual task run_phase(uvm_phase phase);
    	super.run_phase(phase);
		@(vif.read_drv_cb);
		forever begin
			seq_item_port.get_next_item(drv_trans);
			drive();
			seq_item_port.item_done();
		end
	endtask

	task drive();
		vif.read_drv_cb.rinc <= drv_trans.rinc;
		`uvm_info(get_type_name(), $sformatf("[%0t] Driver Driving: rinc=%0b", $time, drv_trans.rinc), UVM_LOW);
		@(vif.read_drv_cb);
	endtask
  
endclass

