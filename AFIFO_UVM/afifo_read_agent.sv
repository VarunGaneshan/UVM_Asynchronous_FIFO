class afifo_read_agent extends uvm_agent;
  	`uvm_component_utils(afifo_read_agent)
	afifo_read_driver driver;
	afifo_read_sequencer sequencer;
	afifo_read_monitor monitor;

  	function new(string name = "afifo_read_agent", uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(get_is_active() == UVM_ACTIVE)begin
			driver = afifo_read_driver::type_id::create("driver",this);
			sequencer = afifo_read_sequencer::type_id::create("sequencer",this);
		end
		monitor = afifo_read_monitor::type_id::create("monitor",this);
	endfunction

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		if(get_is_active() == UVM_ACTIVE)
			driver.seq_item_port.connect(sequencer.seq_item_export);
	endfunction
endclass
