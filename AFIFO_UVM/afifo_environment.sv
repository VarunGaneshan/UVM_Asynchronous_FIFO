class afifo_env extends uvm_env;
  `uvm_component_utils(afifo_env)
  afifo_write_agent write_agent;
  afifo_read_agent read_agent;
  afifo_scoreboard scoreboard;
  afifo_subscriber subscriber;

  function new(string name="afifo_env",uvm_component parent=null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    write_agent = afifo_write_agent::type_id::create("write_agent", this);
    read_agent = afifo_read_agent::type_id::create("read_agent", this);
    scoreboard = afifo_scoreboard::type_id::create("scoreboard", this);
    subscriber = afifo_subscriber::type_id::create("subscriber", this);
    uvm_config_db #(uvm_active_passive_enum)::set(this,"read_agent","is_active",UVM_ACTIVE);
    uvm_config_db #(uvm_active_passive_enum)::set(this,"write_agent","is_active",UVM_ACTIVE);
  endfunction

  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    write_agent.monitor.mon_port.connect(scoreboard.write_port);
    read_agent.monitor.mon_port.connect(scoreboard.read_port);
    write_agent.monitor.mon_port.connect(subscriber.write_fifo.analysis_export);
    read_agent.monitor.mon_port.connect(subscriber.read_fifo.analysis_export);
  endfunction

endclass


