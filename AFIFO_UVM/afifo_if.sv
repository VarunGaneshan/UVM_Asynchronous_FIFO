interface afifo_if(input bit wclk, input bit rclk, input bit wrst_n, input bit rrst_n);  
  // Write domain signals
  logic [`DATA_WIDTH-1:0] wdata;
  logic wfull;
  logic winc;
  
  // Read domain signals
  logic [`DATA_WIDTH-1:0] rdata;
  logic rempty;
  logic rinc;

  // Write domain clocking blocks
  clocking write_drv_cb @(posedge wclk);
    output winc;
    output wdata;
  endclocking

  clocking write_mon_cb @(posedge wclk);
    input winc;
    input wdata;
    input wfull;
  endclocking
  
  // Read domain clocking blocks
  clocking read_drv_cb @(posedge rclk);
    output rinc;
  endclocking

  clocking read_mon_cb @(posedge rclk);
    input rinc;
    input rdata;
    input rempty;
  endclocking

endinterface
