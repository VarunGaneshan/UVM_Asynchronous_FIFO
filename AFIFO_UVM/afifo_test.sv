class afifo_simultaneous_wr_test extends uvm_test;
  `uvm_component_utils(afifo_simultaneous_wr_test)
  afifo_env env;
  afifo_write_sequence write_seq;
  afifo_read_sequence read_seq;

  function new(string name = "afifo_simultaneous_wr_test",uvm_component parent=null);
    super.new(name,parent);
  endfunction : new

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = afifo_env::type_id::create("env", this);
  endfunction

  virtual function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
    uvm_top.print_topology();
  endfunction

  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    phase.raise_objection(this);
    write_seq = afifo_write_sequence::type_id::create("write_seq");
    read_seq = afifo_read_sequence::type_id::create("read_seq");
    fork
      write_seq.start(env.write_agent.sequencer);
      read_seq.start(env.read_agent.sequencer);
    join
    phase.drop_objection(this);
  endtask
endclass

// Write-Then-Read Test 
class afifo_sequential_wr_test extends uvm_test;
  `uvm_component_utils(afifo_sequential_wr_test)
  afifo_env env;
  afifo_write_full_sequence write_seq;
  afifo_read_full_sequence read_seq;

  function new(string name = "afifo_sequential_wr_test",uvm_component parent=null);
    super.new(name,parent);
  endfunction : new

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = afifo_env::type_id::create("env", this);
  endfunction

  virtual function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
    uvm_top.print_topology();
  endfunction

  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    phase.raise_objection(this);

    write_seq = afifo_write_full_sequence::type_id::create("write_seq");
    read_seq = afifo_read_full_sequence::type_id::create("read_seq");
    fork
      write_seq.start(env.write_agent.sequencer);
      read_seq.start(env.read_agent.sequencer);
    join
    `uvm_info(get_type_name(), "Sequential Write-Then-Read Test Completed", UVM_LOW)
    phase.drop_objection(this);
  endtask
endclass


