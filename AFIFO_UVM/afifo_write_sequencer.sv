class afifo_write_sequencer extends uvm_sequencer #(afifo_write_sequence_item);
  `uvm_component_utils(afifo_write_sequencer)

  function new(string name="afifo_write_sequencer", uvm_component parent=null);
    super.new(name, parent);
  endfunction

endclass