class afifo_read_sequencer extends uvm_sequencer #(afifo_read_sequence_item);
  `uvm_component_utils(afifo_read_sequencer)

  function new(string name="afifo_read_sequencer", uvm_component parent=null);
    super.new(name, parent);
  endfunction

endclass