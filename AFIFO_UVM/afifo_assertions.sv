interface afifo_assertions (
  input logic wclk,
  input logic rclk,
  input logic wrst_n,
  input logic rrst_n,
  input logic [`DATA_WIDTH-1:0] wdata,
  input logic [`DATA_WIDTH-1:0] rdata,
  input logic winc,
  input logic rinc,
  input logic wfull,
  input logic rempty
);

  property wclk_valid_check;
    @(posedge wclk) !$isunknown(wclk);
  endproperty
  assert_wclk_valid: assert property (wclk_valid_check)
    else $error("[ASSERTION] Write clock signal is unknown at time %0t", $time);

  property rclk_valid_check;
    @(posedge rclk) !$isunknown(rclk);
  endproperty
  assert_rclk_valid: assert property (rclk_valid_check)
    else $error("[ASSERTION] Read clock signal is unknown at time %0t", $time);

  property wrst_n_valid_check;
    @(posedge wclk) !$isunknown(wrst_n);
  endproperty
  assert_wrst_n_valid: assert property (wrst_n_valid_check)
    else $error("[ASSERTION] Write reset signal is unknown at time %0t", $time);

  property rrst_n_valid_check;
    @(posedge rclk) !$isunknown(rrst_n);
  endproperty
  assert_rrst_n_valid: assert property (rrst_n_valid_check)
    else $error("[ASSERTION] Read reset signal is unknown at time %0t", $time);

  property wdata_valid_during_write;
    @(posedge wclk) disable iff (!wrst_n) (winc && !wfull) |-> !$isunknown(wdata);
  endproperty
  assert_wdata_valid: assert property (wdata_valid_during_write)
    else $error("[ASSERTION] Write data is unknown during valid write at time %0t", $time);

  property wfull_never_unknown;
    @(posedge wclk) disable iff (!wrst_n) !$isunknown(wfull);
  endproperty
  assert_wfull_valid: assert property (wfull_never_unknown)
    else $error("[ASSERTION] Write full signal is unknown at time %0t", $time);

  property rempty_never_unknown;
    @(posedge rclk) disable iff (!rrst_n) !$isunknown(rempty);
  endproperty
  assert_rempty_valid: assert property (rempty_never_unknown)
    else $error("[ASSERTION] Read empty signal is unknown at time %0t", $time);

  property no_write_when_full;
    @(posedge wclk) disable iff (!wrst_n) wfull |-> ##1 !winc;
  endproperty
  assert_no_write_when_full: assert property (no_write_when_full)
    else $warning("[ASSERTION] Write attempted when FIFO is full at time %0t", $time);

  property no_read_when_empty;
    @(posedge rclk) disable iff (!rrst_n) rempty |-> ##1 !rinc;
  endproperty
  assert_no_read_when_empty: assert property (no_read_when_empty)
    else $warning("[ASSERTION] Read attempted when FIFO is empty at time %0t", $time);

  property winc_valid_check;
    @(posedge wclk) disable iff (!wrst_n) !$isunknown(winc);
  endproperty
  assert_winc_valid: assert property (winc_valid_check)
    else $error("[ASSERTION] Write increment signal is unknown at time %0t", $time);

  property rinc_valid_check;
    @(posedge rclk) disable iff (!rrst_n) !$isunknown(rinc);
  endproperty
  assert_rinc_valid: assert property (rinc_valid_check)
    else $error("[ASSERTION] Read increment signal is unknown at time %0t", $time);

  property wfull_reset_behavior;
    @(posedge wclk) !wrst_n |-> ##1 !wfull;
  endproperty
  assert_wfull_reset: assert property (wfull_reset_behavior)
    else $error("[ASSERTION] Write full not cleared after reset at time %0t", $time);

  property rempty_reset_behavior;
    @(posedge rclk) !rrst_n |-> ##1 rempty;
  endproperty
  assert_rempty_reset: assert property (rempty_reset_behavior)
    else $error("[ASSERTION] Read empty not set after reset at time %0t", $time);

  property rdata_valid_during_read;
    @(posedge rclk) disable iff (!rrst_n) (rinc && !rempty) |-> ##1 !$isunknown(rdata);
  endproperty
  assert_rdata_valid: assert property (rdata_valid_during_read)
    else $error("[ASSERTION] Read data is unknown during valid read at time %0t", $time);

  property never_full_and_empty;
    @(posedge wclk) disable iff (!wrst_n) !(wfull && rempty);
  endproperty
  assert_never_full_and_empty: assert property (never_full_and_empty)
    else $error("[ASSERTION] FIFO cannot be both full and empty at time %0t", $time);

  property rempty_clears_on_write_to_empty;
    @(posedge wclk) disable iff (!wrst_n) rempty && winc && !wfull |-> ##[1:6] !rempty;
  endproperty
  assert_rempty_clears: assert property (rempty_clears_on_write_to_empty)
    else $warning("[ASSERTION] Read empty flag should clear when writing to empty FIFO at time %0t", $time);

  property eventually_not_full_after_reads;
    @(posedge rclk) disable iff (!rrst_n) wfull && rinc && !rempty |-> ##[1:20] !wfull;
  endproperty
  assert_eventually_not_full: assert property (eventually_not_full_after_reads)
    else $warning("[ASSERTION] FIFO should eventually become not full after reads at time %0t", $time);
endinterface
