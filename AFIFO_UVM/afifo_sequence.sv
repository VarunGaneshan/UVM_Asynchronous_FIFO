class afifo_write_sequence extends uvm_sequence #(afifo_write_sequence_item);
  `uvm_object_utils(afifo_write_sequence)
  function new(string name="afifo_write_sequence");
    super.new(name);
  endfunction
 
  virtual task body();
    int count;
    afifo_write_sequence_item item;
    repeat (`NUM_WRITE_TRANS) begin 
      item = afifo_write_sequence_item::type_id::create("write_item");
      start_item(item);
      item.randomize() with {winc == 1;}; 
      `uvm_info(get_type_name(), $sformatf("[%0t] Write Transaction %0d: winc=%0b, wdata=%0d", $time, count, item.winc, item.wdata), UVM_LOW);
      finish_item(item);
      count++;
    end
    start_item(item);
    item.randomize() with {winc == 0;}; 
    `uvm_info(get_type_name(), $sformatf("[%0t] Write Transaction %0d: winc=%0b, wdata=%0d", $time, count, item.winc, item.wdata), UVM_LOW);
    finish_item(item);
    start_item(item);
    item.randomize() with {winc == 1;}; 
    `uvm_info(get_type_name(), $sformatf("[%0t] Write Transaction %0d: winc=%0b, wdata=%0d", $time, count, item.winc, item.wdata), UVM_LOW);
    finish_item(item);
    start_item(item);
    item.randomize() with {winc == 0;}; 
    `uvm_info(get_type_name(), $sformatf("[%0t] Write Transaction %0d: winc=%0b, wdata=%0d", $time, count, item.winc, item.wdata), UVM_LOW);
    finish_item(item);
  endtask
endclass

class afifo_read_sequence extends uvm_sequence #(afifo_read_sequence_item);
  `uvm_object_utils(afifo_read_sequence)
  function new(string name="afifo_read_sequence");
    super.new(name);
  endfunction
 
  virtual task body();
    int count;
    afifo_read_sequence_item item;
    repeat (`NUM_READ_TRANS) begin
      item = afifo_read_sequence_item::type_id::create("read_item");
      start_item(item);
      item.randomize() with {rinc == 1;};
      `uvm_info(get_type_name(), $sformatf("[%0t] Read Transaction %0d: rinc=%0b", $time, count, item.rinc), UVM_LOW);
      finish_item(item);
    end
    start_item(item);
    item.randomize() with {rinc == 0;};
    `uvm_info(get_type_name(), $sformatf("[%0t] Read Transaction %0d: rinc=%0b", $time, count, item.rinc), UVM_LOW);
    finish_item(item);
    start_item(item);
    item.randomize() with {rinc == 1;};
    `uvm_info(get_type_name(), $sformatf("[%0t] Read Transaction %0d: rinc=%0b", $time, count, item.rinc), UVM_LOW);
    finish_item(item);
  endtask
endclass
