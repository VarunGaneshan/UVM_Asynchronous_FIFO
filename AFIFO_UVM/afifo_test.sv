// Basic Write and Read
class afifo_basic_write_read_test extends uvm_test;
  `uvm_component_utils(afifo_basic_write_read_test)
  afifo_env env;
  afifo_basic_single_wr_sequence write_seq;
  afifo_basic_single_rd_sequence read_seq;

  function new(string name = "afifo_basic_write_read_test", uvm_component parent=null);
    super.new(name,parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = afifo_env::type_id::create("env", this);
  endfunction

  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);    
    write_seq = afifo_basic_single_wr_sequence::type_id::create("write_seq");
    read_seq = afifo_basic_single_rd_sequence::type_id::create("read_seq");
    
    fork
      write_seq.start(env.write_agent.sequencer);
      read_seq.start(env.read_agent.sequencer);
    join
    
    #100;
    phase.drop_objection(this);
  endtask
endclass

// Fill to Full
class afifo_fill_to_full_test extends uvm_test;
  `uvm_component_utils(afifo_fill_to_full_test)
  afifo_env env;
  afifo_fill_to_full_wr_sequence write_seq;
  afifo_fill_idle_rd_sequence read_seq;

  function new(string name = "afifo_fill_to_full_test", uvm_component parent=null);
    super.new(name,parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = afifo_env::type_id::create("env", this);
  endfunction

  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    
    write_seq = afifo_fill_to_full_wr_sequence::type_id::create("write_seq");
    read_seq = afifo_fill_idle_rd_sequence::type_id::create("read_seq");
    
    fork
      write_seq.start(env.write_agent.sequencer);
      read_seq.start(env.read_agent.sequencer);
    join
    
    #100;
    phase.drop_objection(this);
  endtask
endclass

// Empty After Full Read
class afifo_empty_after_full_test extends uvm_test;
  `uvm_component_utils(afifo_empty_after_full_test)
  afifo_env env;
  afifo_fill_to_full_wr_sequence write_seq;
  afifo_empty_after_full_rd_sequence read_seq;

  function new(string name = "afifo_empty_after_full_test", uvm_component parent=null);
    super.new(name,parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = afifo_env::type_id::create("env", this);
  endfunction

  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    
    write_seq = afifo_fill_to_full_wr_sequence::type_id::create("write_seq");
    read_seq = afifo_empty_after_full_rd_sequence::type_id::create("read_seq");
    
    fork
      write_seq.start(env.write_agent.sequencer);
      read_seq.start(env.read_agent.sequencer);
    join
    
    #100;
    phase.drop_objection(this);
  endtask
endclass

// Simultaneous Write and Read (Half Full) 
class afifo_simultaneous_half_full_test extends uvm_test;
  `uvm_component_utils(afifo_simultaneous_half_full_test)
  afifo_env env;
  afifo_half_fill_wr_sequence write_seq;
  afifo_simultaneous_rd_sequence read_seq;

  function new(string name = "afifo_simultaneous_half_full_test", uvm_component parent=null);
    super.new(name,parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = afifo_env::type_id::create("env", this);
  endfunction

  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    
    write_seq = afifo_half_fill_wr_sequence::type_id::create("write_seq");
    read_seq = afifo_simultaneous_rd_sequence::type_id::create("read_seq");
    
    fork
      write_seq.start(env.write_agent.sequencer);
      read_seq.start(env.read_agent.sequencer);
    join
    
    #200;
    phase.drop_objection(this);
  endtask
endclass

// Boundary Conditions
class afifo_boundary_test extends uvm_test;
  `uvm_component_utils(afifo_boundary_test)
  afifo_env env;
  afifo_boundary_wr_sequence write_seq;
  afifo_boundary_rd_sequence read_seq;

  function new(string name = "afifo_boundary_test", uvm_component parent=null);
    super.new(name,parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = afifo_env::type_id::create("env", this);
  endfunction

  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    
    write_seq = afifo_boundary_wr_sequence::type_id::create("write_seq");
    read_seq = afifo_boundary_rd_sequence::type_id::create("read_seq");
    
    fork
      write_seq.start(env.write_agent.sequencer);
      read_seq.start(env.read_agent.sequencer);
    join
    
    #200;
    phase.drop_objection(this);
  endtask
endclass

// Read-While-Write Test
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
    phase.drop_objection(this);
  endtask
endclass


