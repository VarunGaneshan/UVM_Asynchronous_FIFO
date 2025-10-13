`timescale 1ns/1ns

import uvm_pkg::*;
`include "uvm_macros.svh"
`include "project_configs.sv"
`include "afifo_if.sv"
`include "FIFO.v"
  `include "afifo_sequence_item.sv"
  `include "afifo_sequence.sv"
  `include "afifo_read_sequencer.sv"
  `include "afifo_write_sequencer.sv"
  `include "afifo_read_driver.sv"
  `include "afifo_write_driver.sv"
  `include "afifo_read_monitor.sv"
  `include "afifo_write_monitor.sv"
  `include "afifo_read_agent.sv"
  `include "afifo_write_agent.sv"
  `include "afifo_scoreboard_new.sv"
  `include "afifo_subscriber.sv"
  `include "afifo_bind.sv"
  `include "afifo_assertions.sv"
  `include "afifo_environment.sv"
  `include "afifo_test.sv"

module top;
  bit wclk, rclk, wrst_n, rrst_n;
  
  initial wclk = 1'b0;
  always #(`WCLK_PERIOD/2) wclk = ~ wclk;
  initial rclk = 1'b0;
  always #(`RCLK_PERIOD/2) rclk = ~ rclk;

  initial begin
    rrst_n = 1'b1; 
    #10 rrst_n = 1'b0; 
    #20 rrst_n = 1'b1;
  end
  initial begin
    wrst_n = 1'b1; 
    #5 wrst_n = 1'b0; 
    #10 wrst_n = 1'b1;
  end

  afifo_if intf(wclk, rclk, wrst_n, rrst_n);

  FIFO #(`DATA_WIDTH, `ADDR_WIDTH) dut ( .wclk(intf.wclk),
             .wrst_n(intf.wrst_n),
             .rclk(intf.rclk),
             .rrst_n(intf.rrst_n),
             .wdata(intf.wdata),
             .rdata(intf.rdata),
             .wfull(intf.wfull),
             .rempty(intf.rempty),
             .winc(intf.winc),
             .rinc(intf.rinc) );

  initial begin
    uvm_config_db#(virtual afifo_if)::set(null,"uvm_test_top.env.read_agent.driver","vif",intf);
    uvm_config_db#(virtual afifo_if)::set(null,"uvm_test_top.env.write_agent.driver","vif",intf);
    uvm_config_db#(virtual afifo_if)::set(null,"uvm_test_top.env.read_agent.monitor","vif",intf);
    uvm_config_db#(virtual afifo_if)::set(null,"uvm_test_top.env.write_agent.monitor","vif",intf);
    uvm_config_db#(virtual afifo_if)::set(null,"uvm_test_top.env.scoreboard","vif",intf);
  end
  
  initial begin
    run_test();
    #1000;
    $display("Simulation Finished");
    $finish;
  end

  initial begin
    $dumpfile("afifo.vcd");
    $dumpvars(0, dut); 
  end
endmodule