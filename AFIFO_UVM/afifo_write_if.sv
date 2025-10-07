interface afifo_write_if(input bit wclk, wrst_n);  
	logic [`DATA_WIDTH-1:0] wdata;
  logic wfull;
  logic winc;

  clocking write_drv_cb @(posedge wclk);
    output winc;
    output wdata;
  endclocking

  clocking write_mon_cb @(posedge wclk);
    input winc;
    input wdata;
    input wfull;
  endclocking
  
endinterface
