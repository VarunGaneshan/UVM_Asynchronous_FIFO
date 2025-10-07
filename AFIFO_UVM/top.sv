`timescale 1ns/1ns

import uvm_pkg::*;
`include "uvm_macros.svh"
`include "project_configs.sv"
`include "afifo_write_if.sv"
`include "afifo_read_if.sv"
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
  `include "afifo_scoreboard.sv"
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

  afifo_read_if read_intf(rclk, rrst_n);
  afifo_write_if write_intf(wclk, wrst_n);

  FIFO #(`DATA_WIDTH, `ADDR_WIDTH) dut ( .wclk(write_intf.wclk),
             .wrst_n(write_intf.wrst_n),
             .rclk(read_intf.rclk),
             .rrst_n(read_intf.rrst_n),
             .wdata(write_intf.wdata),
             .rdata(read_intf.rdata),
             .wfull(write_intf.wfull),
             .rempty(read_intf.rempty),
             .winc(write_intf.winc),
             .rinc(read_intf.rinc) );

  initial begin
    uvm_config_db#(virtual afifo_read_if)::set(null,"uvm_test_top.env.read_agent.driver","vif",read_intf);
    uvm_config_db#(virtual afifo_write_if)::set(null,"uvm_test_top.env.write_agent.driver","vif",write_intf);
    uvm_config_db#(virtual afifo_read_if)::set(null,"uvm_test_top.env.read_agent.monitor","vif",read_intf);
    uvm_config_db#(virtual afifo_write_if)::set(null,"uvm_test_top.env.write_agent.monitor","vif",write_intf);
  end
  
  initial begin
    run_test("afifo_simultaneous_wr_test");
    #1000;
    $display("Simulation Finished");
    $finish;
  end
endmodule