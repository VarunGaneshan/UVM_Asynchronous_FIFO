interface afifo_read_if(input bit rclk, rrst_n);  
	logic [`DATA_WIDTH-1:0] rdata;
  logic rempty;
  logic rinc;

  clocking read_drv_cb @(posedge rclk);
    output rinc;
  endclocking

  clocking read_mon_cb @(posedge rclk);
    input rinc;
    input rdata;
    input rempty;
  endclocking

endinterface
