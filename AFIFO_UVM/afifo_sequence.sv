class afifo_write_sequence extends uvm_sequence #(afifo_write_sequence_item);
  `uvm_object_utils(afifo_write_sequence)
  function new(string name="afifo_write_sequence");
    super.new(name);
  endfunction
 
  virtual task body();
    int count;
    afifo_write_sequence_item item;
    repeat (`NUM_WRITE_TRANS_WR) begin 
      item = afifo_write_sequence_item::type_id::create("write_item");
      start_item(item);
      item.randomize() with {winc == 1;}; 
      `uvm_info(get_type_name(), $sformatf("[%0t] Write Transaction %0d: winc=%0b, wdata=%0d", $time, count, item.winc, item.wdata), UVM_LOW);
      finish_item(item);
      count++;
    end
    repeat (`NUM_WRITE_TRANS_WR-3) begin 
      item = afifo_write_sequence_item::type_id::create("write_item");
      start_item(item);
      item.randomize() with {winc == 0;}; 
      `uvm_info(get_type_name(), $sformatf("[%0t] Write Transaction %0d: winc=%0b, wdata=%0d", $time, count, item.winc, item.wdata), UVM_LOW);
      finish_item(item);
      count++;
    end
    repeat (3) begin 
      item = afifo_write_sequence_item::type_id::create("write_item");
      start_item(item);
      item.randomize() with {winc == 1;}; 
      `uvm_info(get_type_name(), $sformatf("[%0t] Write Transaction %0d: winc=%0b, wdata=%0d", $time, count, item.winc, item.wdata), UVM_LOW);
      finish_item(item);
      count++;
    end
      item = afifo_write_sequence_item::type_id::create("write_item");
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
    repeat (`NUM_READ_TRANS_WR+5) begin
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

class afifo_write_full_sequence extends uvm_sequence #(afifo_write_sequence_item);
  `uvm_object_utils(afifo_write_full_sequence)
  function new(string name="afifo_write_full_sequence");
    super.new(name);
  endfunction
 
  virtual task body();
    int count;
    afifo_write_sequence_item item;
    repeat (`FIFO_DEPTH+2) begin
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
  endtask
endclass

class afifo_read_full_sequence extends uvm_sequence #(afifo_read_sequence_item);
  `uvm_object_utils(afifo_read_full_sequence)
  function new(string name="afifo_read_full_sequence");
    super.new(name);
  endfunction
 
  virtual task body();
    int count;
    afifo_read_sequence_item item;
    repeat (`NUM_READ_LOW_WTR) begin
      item = afifo_read_sequence_item::type_id::create("read_item");
      start_item(item);
      item.randomize() with {rinc == 0;};
      `uvm_info(get_type_name(), $sformatf("[%0t] Read Transaction %0d: rinc=%0b", $time, count, item.rinc), UVM_LOW);
      finish_item(item);
    end
    repeat (`NUM_READ_TRANS_WTR) begin
      start_item(item);
      item.randomize() with {rinc == 1;};
      `uvm_info(get_type_name(), $sformatf("[%0t] Read Transaction %0d: rinc=%0b", $time, count, item.rinc), UVM_LOW);
      finish_item(item);
    end
  endtask
endclass

class afifo_basic_single_wr_sequence extends uvm_sequence #(afifo_write_sequence_item);
  `uvm_object_utils(afifo_basic_single_wr_sequence)
  function new(string name="afifo_basic_single_wr_sequence");
    super.new(name);
  endfunction
 
  virtual task body();
    afifo_write_sequence_item item;
    item = afifo_write_sequence_item::type_id::create("write_item");
    start_item(item);
    item.randomize() with {winc == 1; wdata == 8'hAA;}; 
    `uvm_info(get_type_name(), $sformatf("[%0t] Basic Write: wdata=0x%0h", $time, item.wdata), UVM_LOW);
    finish_item(item);
    start_item(item);
    item.randomize() with {winc == 0;}; 
    finish_item(item);
  endtask
endclass

class afifo_basic_single_rd_sequence extends uvm_sequence #(afifo_read_sequence_item);
  `uvm_object_utils(afifo_basic_single_rd_sequence)
  function new(string name="afifo_basic_single_rd_sequence");
    super.new(name);
  endfunction
 
  virtual task body();
    afifo_read_sequence_item item;
    item = afifo_read_sequence_item::type_id::create("read_item");
    // Wait for data to be available
    repeat(5) begin
      start_item(item);
      item.randomize() with {rinc == 0;};
      finish_item(item);
    end
    start_item(item);
    item.randomize() with {rinc == 1;};
    `uvm_info(get_type_name(), $sformatf("[%0t] Basic Read: rinc=1", $time), UVM_LOW);
    finish_item(item);
    start_item(item);
    item.randomize() with {rinc == 0;};
    finish_item(item);
  endtask
endclass


class afifo_fill_to_full_wr_sequence extends uvm_sequence #(afifo_write_sequence_item);
  `uvm_object_utils(afifo_fill_to_full_wr_sequence)
  function new(string name="afifo_fill_to_full_wr_sequence");
    super.new(name);
  endfunction
 
  virtual task body();
    afifo_write_sequence_item item;
    for(int i = 0; i < `FIFO_DEPTH; i++) begin
      item = afifo_write_sequence_item::type_id::create("write_item");
      start_item(item);
      item.randomize() with {winc == 1; wdata == i[7:0];}; 
      `uvm_info(get_type_name(), $sformatf("[%0t] Fill Write %0d: wdata=0x%0h", $time, i, item.wdata), UVM_LOW);
      finish_item(item);
    end
    item = afifo_write_sequence_item::type_id::create("write_item");
    start_item(item);
    item.randomize() with {winc == 1; wdata == 8'hFF;}; 
    `uvm_info(get_type_name(), $sformatf("[%0t] Overflow Write Attempt: wdata=0x%0h (should be blocked)", $time, item.wdata), UVM_LOW);
    finish_item(item);
    repeat(3) begin
      start_item(item);
      item.randomize() with {winc == 0;}; 
      finish_item(item);
    end
  endtask
endclass

class afifo_fill_idle_rd_sequence extends uvm_sequence #(afifo_read_sequence_item);
  `uvm_object_utils(afifo_fill_idle_rd_sequence)
  function new(string name="afifo_fill_idle_rd_sequence");
    super.new(name);
  endfunction
 
  virtual task body();
    afifo_read_sequence_item item;
    // Keep read idle while FIFO fills
    repeat(`FIFO_DEPTH + 5) begin
      item = afifo_read_sequence_item::type_id::create("read_item");
      start_item(item);
      item.randomize() with {rinc == 0;};
      finish_item(item);
    end
  endtask
endclass

class afifo_empty_after_full_rd_sequence extends uvm_sequence #(afifo_read_sequence_item);
  `uvm_object_utils(afifo_empty_after_full_rd_sequence)
  function new(string name="afifo_empty_after_full_rd_sequence");
    super.new(name);
  endfunction
 
  virtual task body();
    afifo_read_sequence_item item;
    repeat(20) begin
      item = afifo_read_sequence_item::type_id::create("read_item");
      start_item(item);
      item.randomize() with {rinc == 0;};
      finish_item(item);
    end
    for(int i = 0; i < `FIFO_DEPTH; i++) begin
      item = afifo_read_sequence_item::type_id::create("read_item");
      start_item(item);
      item.randomize() with {rinc == 1;};
      `uvm_info(get_type_name(), $sformatf("[%0t] Read %0d: rinc=1", $time, i), UVM_LOW);
      finish_item(item);
    end
    // Attempt read from empty
    item = afifo_read_sequence_item::type_id::create("read_item");
    start_item(item);
    item.randomize() with {rinc == 1;};
    `uvm_info(get_type_name(), $sformatf("[%0t] Underflow Read Attempt (should be blocked)", $time), UVM_LOW);
    finish_item(item);
    repeat(3) begin
      start_item(item);
      item.randomize() with {rinc == 0;};
      finish_item(item);
    end
  endtask
endclass

class afifo_half_fill_wr_sequence extends uvm_sequence #(afifo_write_sequence_item);
  `uvm_object_utils(afifo_half_fill_wr_sequence)
  function new(string name="afifo_half_fill_wr_sequence");
    super.new(name);
  endfunction
 
  virtual task body();
    afifo_write_sequence_item item;
    // Fill to half
    for(int i = 0; i < `FIFO_DEPTH/2; i++) begin
      item = afifo_write_sequence_item::type_id::create("write_item");
      start_item(item);
      item.randomize() with {winc == 1; wdata == (i*2);}; 
      finish_item(item);
    end
    // Continue with simultaneous operations
    repeat(20) begin
      item = afifo_write_sequence_item::type_id::create("write_item");
      start_item(item);
      assert(item.randomize() with {winc dist {1:=70, 0:=30};});
      finish_item(item);
    end
  endtask
endclass

class afifo_simultaneous_rd_sequence extends uvm_sequence #(afifo_read_sequence_item);
  `uvm_object_utils(afifo_simultaneous_rd_sequence)
  function new(string name="afifo_simultaneous_rd_sequence");
    super.new(name);
  endfunction
 
  virtual task body();
    afifo_read_sequence_item item;
    // Wait for half fill
    repeat(10) begin
      item = afifo_read_sequence_item::type_id::create("read_item");
      start_item(item);
      item.randomize() with {rinc == 0;};
      finish_item(item);
    end
    // Simultaneous reads
    repeat(20) begin
      item = afifo_read_sequence_item::type_id::create("read_item");
      start_item(item);
      assert(item.randomize() with {rinc dist {1:=60, 0:=40};});
      finish_item(item);
    end
  endtask
endclass

class afifo_boundary_wr_sequence extends uvm_sequence #(afifo_write_sequence_item);
  `uvm_object_utils(afifo_boundary_wr_sequence)
  function new(string name="afifo_boundary_wr_sequence");
    super.new(name);
  endfunction
 
  virtual task body();
    afifo_write_sequence_item item;
    // Fill completely
    repeat(`FIFO_DEPTH) begin
      item = afifo_write_sequence_item::type_id::create("write_item");
      start_item(item);
      item.randomize() with {winc == 1;}; 
      finish_item(item);
    end
    // Try multiple writes when full
    `uvm_info(get_type_name(), "Testing writes to FULL FIFO (should be ignored)", UVM_MEDIUM);
    repeat(5) begin
      item = afifo_write_sequence_item::type_id::create("write_item");
      start_item(item);
      item.randomize() with {winc == 1; wdata == 8'hEE;}; 
      finish_item(item);
    end
  endtask
endclass

class afifo_boundary_rd_sequence extends uvm_sequence #(afifo_read_sequence_item);
  `uvm_object_utils(afifo_boundary_rd_sequence)
  function new(string name="afifo_boundary_rd_sequence");
    super.new(name);
  endfunction
 
  virtual task body();
    afifo_read_sequence_item item;
    // Try reading from empty
    `uvm_info(get_type_name(), "Testing reads from EMPTY FIFO (should be ignored)", UVM_MEDIUM);
    repeat(5) begin
      item = afifo_read_sequence_item::type_id::create("read_item");
      start_item(item);
      item.randomize() with {rinc == 1;};
      finish_item(item);
    end
    // Wait for writes
    repeat(20) begin
      item = afifo_read_sequence_item::type_id::create("read_item");
      start_item(item);
      item.randomize() with {rinc == 0;};
      finish_item(item);
    end
    // Read all
    repeat(`FIFO_DEPTH) begin
      item = afifo_read_sequence_item::type_id::create("read_item");
      start_item(item);
      item.randomize() with {rinc == 1;};
      finish_item(item);
    end
    // Try reading from empty again
    repeat(5) begin
      item = afifo_read_sequence_item::type_id::create("read_item");
      start_item(item);
      item.randomize() with {rinc == 1;};
      finish_item(item);
    end
  endtask
endclass
