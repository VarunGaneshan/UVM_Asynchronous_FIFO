class afifo_write_agent extends uvm_agent;
  	`uvm_component_utils(afifo_write_agent)
	afifo_write_driver driver;
	afifo_write_sequencer sequencer;
	afifo_write_monitor monitor;

  	function new(string name = "afifo_write_agent", uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(get_is_active() == UVM_ACTIVE)begin
			driver = afifo_write_driver::type_id::create("driver",this);
			sequencer = afifo_write_sequencer::type_id::create("sequencer",this);
		end
		monitor = afifo_write_monitor::type_id::create("monitor",this);
	endfunction

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		if(get_is_active() == UVM_ACTIVE)
			driver.seq_item_port.connect(sequencer.seq_item_export);
	endfunction
endclass
