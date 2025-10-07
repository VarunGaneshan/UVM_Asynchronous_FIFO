class afifo_write_sequence_item extends uvm_sequence_item;
  rand logic [`DATA_WIDTH-1:0] wdata;
  rand logic winc;
  logic wfull;

  function new(string name="afifo_write_sequence_item");
    super.new(name);
  endfunction

  `uvm_object_utils_begin(afifo_write_sequence_item)
    `uvm_field_int(wdata, UVM_ALL_ON)
    `uvm_field_int(winc, UVM_ALL_ON)
    `uvm_field_int(wfull, UVM_ALL_ON)
  `uvm_object_utils_end
endclass

class afifo_read_sequence_item extends uvm_sequence_item;
  rand logic rinc;
  logic rempty;
  logic [`DATA_WIDTH-1:0] rdata;

  function new(string name="afifo_read_sequence_item");
    super.new(name);
  endfunction

  `uvm_object_utils_begin(afifo_read_sequence_item)
    `uvm_field_int(rinc, UVM_ALL_ON)
    `uvm_field_int(rempty, UVM_ALL_ON)
    `uvm_field_int(rdata, UVM_ALL_ON)
  `uvm_object_utils_end
  
endclass

