# UVM_INFO afifo_sequence.sv(14) @ 5: uvm_test_top.env.write_agent.sequencer@@write_seq [afifo_write_sequence] [5] Write Transaction 0: winc=1, wdata=210
# UVM_INFO afifo_write_driver.sv(33) @ 5: uvm_test_top.env.write_agent.driver [afifo_write_driver] [5] Driver Driving: winc=1, wdata=210
# UVM_INFO afifo_sequence.sv(38) @ 10: uvm_test_top.env.read_agent.sequencer@@read_seq [afifo_read_sequence] [10] Read Transaction 0: rinc=1
# UVM_INFO afifo_read_driver.sv(32) @ 10: uvm_test_top.env.read_agent.driver [afifo_read_driver] [10] Driver Driving: rinc=1
# UVM_INFO afifo_scoreboard.sv(41) @ 15: uvm_test_top.env.scoreboard [afifo_scoreboard] [15] WRITE: data=210, fifo_size=1
# UVM_INFO afifo_write_monitor.sv(29) @ 15: uvm_test_top.env.write_agent.monitor [afifo_write_monitor] [15] Captured: winc=1, wdata=210, wfull=0
# UVM_INFO afifo_sequence.sv(14) @ 15: uvm_test_top.env.write_agent.sequencer@@write_seq [afifo_write_sequence] [15] Write Transaction 1: winc=1, wdata=133
# UVM_INFO afifo_write_driver.sv(33) @ 15: uvm_test_top.env.write_agent.driver [afifo_write_driver] [15] Driver Driving: winc=1, wdata=133
# UVM_INFO afifo_scoreboard.sv(41) @ 25: uvm_test_top.env.scoreboard [afifo_scoreboard] [25] WRITE: data=133, fifo_size=2
# UVM_INFO afifo_write_monitor.sv(29) @ 25: uvm_test_top.env.write_agent.monitor [afifo_write_monitor] [25] Captured: winc=1, wdata=133, wfull=0
# UVM_INFO afifo_sequence.sv(14) @ 25: uvm_test_top.env.write_agent.sequencer@@write_seq [afifo_write_sequence] [25] Write Transaction 2: winc=1, wdata=79
# UVM_INFO afifo_write_driver.sv(33) @ 25: uvm_test_top.env.write_agent.driver [afifo_write_driver] [25] Driver Driving: winc=1, wdata=79
# UVM_INFO afifo_scoreboard.sv(109) @ 30: uvm_test_top.env.scoreboard [afifo_scoreboard] [30] READ BLOCKED: FIFO is empty, rinc ignored
# UVM_INFO afifo_read_monitor.sv(29) @ 30: uvm_test_top.env.read_agent.monitor [afifo_read_monitor] [30] Captured: rinc=1, rdata=210, rempty=1
# UVM_INFO afifo_sequence.sv(38) @ 30: uvm_test_top.env.read_agent.sequencer@@read_seq [afifo_read_sequence] [30] Read Transaction 0: rinc=1
# UVM_INFO afifo_read_driver.sv(32) @ 30: uvm_test_top.env.read_agent.driver [afifo_read_driver] [30] Driver Driving: rinc=1
# UVM_INFO afifo_scoreboard.sv(41) @ 35: uvm_test_top.env.scoreboard [afifo_scoreboard] [35] WRITE: data=79, fifo_size=3
# UVM_INFO afifo_write_monitor.sv(29) @ 35: uvm_test_top.env.write_agent.monitor [afifo_write_monitor] [35] Captured: winc=1, wdata=79, wfull=0
# UVM_INFO afifo_sequence.sv(14) @ 35: uvm_test_top.env.write_agent.sequencer@@write_seq [afifo_write_sequence] [35] Write Transaction 3: winc=1, wdata=17
# UVM_INFO afifo_write_driver.sv(33) @ 35: uvm_test_top.env.write_agent.driver [afifo_write_driver] [35] Driver Driving: winc=1, wdata=17
# UVM_INFO afifo_scoreboard.sv(41) @ 45: uvm_test_top.env.scoreboard [afifo_scoreboard] [45] WRITE: data=17, fifo_size=4
# UVM_INFO afifo_write_monitor.sv(29) @ 45: uvm_test_top.env.write_agent.monitor [afifo_write_monitor] [45] Captured: winc=1, wdata=17, wfull=0
# UVM_INFO afifo_sequence.sv(14) @ 45: uvm_test_top.env.write_agent.sequencer@@write_seq [afifo_write_sequence] [45] Write Transaction 4: winc=1, wdata=220
# UVM_INFO afifo_write_driver.sv(33) @ 45: uvm_test_top.env.write_agent.driver [afifo_write_driver] [45] Driver Driving: winc=1, wdata=220
# UVM_INFO afifo_scoreboard.sv(109) @ 50: uvm_test_top.env.scoreboard [afifo_scoreboard] [50] READ BLOCKED: FIFO is empty, rinc ignored
# UVM_INFO afifo_read_monitor.sv(29) @ 50: uvm_test_top.env.read_agent.monitor [afifo_read_monitor] [50] Captured: rinc=1, rdata=210, rempty=1
# UVM_INFO afifo_sequence.sv(38) @ 50: uvm_test_top.env.read_agent.sequencer@@read_seq [afifo_read_sequence] [50] Read Transaction 0: rinc=1
# UVM_INFO afifo_read_driver.sv(32) @ 50: uvm_test_top.env.read_agent.driver [afifo_read_driver] [50] Driver Driving: rinc=1
# ** Warning: [ASSERTION] Read attempted when FIFO is empty at time 50
#    Time: 50 ns Started: 30 ns  Scope: top.dut.afifo_assert_inst.assert_no_read_when_empty File: afifo_assertions.sv Line: 66 Expr: ~rinc
# UVM_INFO afifo_scoreboard.sv(41) @ 55: uvm_test_top.env.scoreboard [afifo_scoreboard] [55] WRITE: data=220, fifo_size=5
# UVM_INFO afifo_write_monitor.sv(29) @ 55: uvm_test_top.env.write_agent.monitor [afifo_write_monitor] [55] Captured: winc=1, wdata=220, wfull=0
# UVM_INFO afifo_sequence.sv(14) @ 55: uvm_test_top.env.write_agent.sequencer@@write_seq [afifo_write_sequence] [55] Write Transaction 5: winc=1, wdata=120
# UVM_INFO afifo_write_driver.sv(33) @ 55: uvm_test_top.env.write_agent.driver [afifo_write_driver] [55] Driver Driving: winc=1, wdata=120
# UVM_INFO afifo_scoreboard.sv(41) @ 65: uvm_test_top.env.scoreboard [afifo_scoreboard] [65] WRITE: data=120, fifo_size=6
# UVM_INFO afifo_write_monitor.sv(29) @ 65: uvm_test_top.env.write_agent.monitor [afifo_write_monitor] [65] Captured: winc=1, wdata=120, wfull=0
# UVM_INFO afifo_sequence.sv(14) @ 65: uvm_test_top.env.write_agent.sequencer@@write_seq [afifo_write_sequence] [65] Write Transaction 6: winc=1, wdata=246
# UVM_INFO afifo_write_driver.sv(33) @ 65: uvm_test_top.env.write_agent.driver [afifo_write_driver] [65] Driver Driving: winc=1, wdata=246
# UVM_INFO afifo_scoreboard.sv(75) @ 70: uvm_test_top.env.scoreboard [afifo_scoreboard] [70] READ: expected_data=210, actual_data=210, fifo_size=5
# UVM_INFO afifo_read_monitor.sv(29) @ 70: uvm_test_top.env.read_agent.monitor [afifo_read_monitor] [70] Captured: rinc=1, rdata=210, rempty=0
# UVM_INFO afifo_sequence.sv(38) @ 70: uvm_test_top.env.read_agent.sequencer@@read_seq [afifo_read_sequence] [70] Read Transaction 0: rinc=1
# UVM_INFO afifo_read_driver.sv(32) @ 70: uvm_test_top.env.read_agent.driver [afifo_read_driver] [70] Driver Driving: rinc=1
# ** Warning: [ASSERTION] Read attempted when FIFO is empty at time 70
#    Time: 70 ns Started: 50 ns  Scope: top.dut.afifo_assert_inst.assert_no_read_when_empty File: afifo_assertions.sv Line: 66 Expr: ~rinc
# UVM_INFO afifo_scoreboard.sv(41) @ 75: uvm_test_top.env.scoreboard [afifo_scoreboard] [75] WRITE: data=246, fifo_size=6
# UVM_INFO afifo_write_monitor.sv(29) @ 75: uvm_test_top.env.write_agent.monitor [afifo_write_monitor] [75] Captured: winc=1, wdata=246, wfull=0
# UVM_INFO afifo_sequence.sv(14) @ 75: uvm_test_top.env.write_agent.sequencer@@write_seq [afifo_write_sequence] [75] Write Transaction 7: winc=1, wdata=246
# UVM_INFO afifo_write_driver.sv(33) @ 75: uvm_test_top.env.write_agent.driver [afifo_write_driver] [75] Driver Driving: winc=1, wdata=246
# UVM_INFO afifo_scoreboard.sv(41) @ 85: uvm_test_top.env.scoreboard [afifo_scoreboard] [85] WRITE: data=246, fifo_size=7
# UVM_INFO afifo_write_monitor.sv(29) @ 85: uvm_test_top.env.write_agent.monitor [afifo_write_monitor] [85] Captured: winc=1, wdata=246, wfull=0
# UVM_INFO afifo_sequence.sv(14) @ 85: uvm_test_top.env.write_agent.sequencer@@write_seq [afifo_write_sequence] [85] Write Transaction 8: winc=1, wdata=154
# UVM_INFO afifo_write_driver.sv(33) @ 85: uvm_test_top.env.write_agent.driver [afifo_write_driver] [85] Driver Driving: winc=1, wdata=154
# UVM_INFO afifo_scoreboard.sv(75) @ 90: uvm_test_top.env.scoreboard [afifo_scoreboard] [90] READ: expected_data=133, actual_data=133, fifo_size=6
# UVM_INFO afifo_read_monitor.sv(29) @ 90: uvm_test_top.env.read_agent.monitor [afifo_read_monitor] [90] Captured: rinc=1, rdata=133, rempty=0
# UVM_INFO afifo_sequence.sv(38) @ 90: uvm_test_top.env.read_agent.sequencer@@read_seq [afifo_read_sequence] [90] Read Transaction 0: rinc=1
# UVM_INFO afifo_read_driver.sv(32) @ 90: uvm_test_top.env.read_agent.driver [afifo_read_driver] [90] Driver Driving: rinc=1
# ** Warning: [ASSERTION] Read attempted when FIFO is empty at time 90
#    Time: 90 ns Started: 70 ns  Scope: top.dut.afifo_assert_inst.assert_no_read_when_empty File: afifo_assertions.sv Line: 66 Expr: ~rinc
# UVM_INFO afifo_scoreboard.sv(41) @ 95: uvm_test_top.env.scoreboard [afifo_scoreboard] [95] WRITE: data=154, fifo_size=7
# UVM_INFO afifo_write_monitor.sv(29) @ 95: uvm_test_top.env.write_agent.monitor [afifo_write_monitor] [95] Captured: winc=1, wdata=154, wfull=0
# UVM_INFO afifo_sequence.sv(14) @ 95: uvm_test_top.env.write_agent.sequencer@@write_seq [afifo_write_sequence] [95] Write Transaction 9: winc=1, wdata=156
# UVM_INFO afifo_write_driver.sv(33) @ 95: uvm_test_top.env.write_agent.driver [afifo_write_driver] [95] Driver Driving: winc=1, wdata=156
# UVM_INFO afifo_scoreboard.sv(41) @ 105: uvm_test_top.env.scoreboard [afifo_scoreboard] [105] WRITE: data=156, fifo_size=8
# UVM_INFO afifo_write_monitor.sv(29) @ 105: uvm_test_top.env.write_agent.monitor [afifo_write_monitor] [105] Captured: winc=1, wdata=156, wfull=0
# UVM_INFO afifo_sequence.sv(14) @ 105: uvm_test_top.env.write_agent.sequencer@@write_seq [afifo_write_sequence] [105] Write Transaction 10: winc=1, wdata=95
# UVM_INFO afifo_write_driver.sv(33) @ 105: uvm_test_top.env.write_agent.driver [afifo_write_driver] [105] Driver Driving: winc=1, wdata=95
# UVM_INFO afifo_scoreboard.sv(75) @ 110: uvm_test_top.env.scoreboard [afifo_scoreboard] [110] READ: expected_data=79, actual_data=79, fifo_size=7
# UVM_INFO afifo_read_monitor.sv(29) @ 110: uvm_test_top.env.read_agent.monitor [afifo_read_monitor] [110] Captured: rinc=1, rdata=79, rempty=0
# UVM_INFO afifo_sequence.sv(38) @ 110: uvm_test_top.env.read_agent.sequencer@@read_seq [afifo_read_sequence] [110] Read Transaction 0: rinc=1
# UVM_INFO afifo_read_driver.sv(32) @ 110: uvm_test_top.env.read_agent.driver [afifo_read_driver] [110] Driver Driving: rinc=1
# UVM_INFO afifo_scoreboard.sv(41) @ 115: uvm_test_top.env.scoreboard [afifo_scoreboard] [115] WRITE: data=95, fifo_size=8
# UVM_INFO afifo_write_monitor.sv(29) @ 115: uvm_test_top.env.write_agent.monitor [afifo_write_monitor] [115] Captured: winc=1, wdata=95, wfull=0
# UVM_INFO afifo_sequence.sv(14) @ 115: uvm_test_top.env.write_agent.sequencer@@write_seq [afifo_write_sequence] [115] Write Transaction 11: winc=1, wdata=255
# UVM_INFO afifo_write_driver.sv(33) @ 115: uvm_test_top.env.write_agent.driver [afifo_write_driver] [115] Driver Driving: winc=1, wdata=255
# UVM_INFO afifo_scoreboard.sv(41) @ 125: uvm_test_top.env.scoreboard [afifo_scoreboard] [125] WRITE: data=255, fifo_size=9
# UVM_INFO afifo_write_monitor.sv(29) @ 125: uvm_test_top.env.write_agent.monitor [afifo_write_monitor] [125] Captured: winc=1, wdata=255, wfull=0
# UVM_INFO afifo_sequence.sv(14) @ 125: uvm_test_top.env.write_agent.sequencer@@write_seq [afifo_write_sequence] [125] Write Transaction 12: winc=1, wdata=7
# UVM_INFO afifo_write_driver.sv(33) @ 125: uvm_test_top.env.write_agent.driver [afifo_write_driver] [125] Driver Driving: winc=1, wdata=7
# UVM_INFO afifo_scoreboard.sv(75) @ 130: uvm_test_top.env.scoreboard [afifo_scoreboard] [130] READ: expected_data=17, actual_data=17, fifo_size=8
# UVM_INFO afifo_read_monitor.sv(29) @ 130: uvm_test_top.env.read_agent.monitor [afifo_read_monitor] [130] Captured: rinc=1, rdata=17, rempty=0
# UVM_INFO afifo_sequence.sv(38) @ 130: uvm_test_top.env.read_agent.sequencer@@read_seq [afifo_read_sequence] [130] Read Transaction 0: rinc=1
# UVM_INFO afifo_read_driver.sv(32) @ 130: uvm_test_top.env.read_agent.driver [afifo_read_driver] [130] Driver Driving: rinc=1
# UVM_INFO afifo_scoreboard.sv(41) @ 135: uvm_test_top.env.scoreboard [afifo_scoreboard] [135] WRITE: data=7, fifo_size=9
# UVM_INFO afifo_write_monitor.sv(29) @ 135: uvm_test_top.env.write_agent.monitor [afifo_write_monitor] [135] Captured: winc=1, wdata=7, wfull=0
# UVM_INFO afifo_sequence.sv(14) @ 135: uvm_test_top.env.write_agent.sequencer@@write_seq [afifo_write_sequence] [135] Write Transaction 13: winc=1, wdata=60
# UVM_INFO afifo_write_driver.sv(33) @ 135: uvm_test_top.env.write_agent.driver [afifo_write_driver] [135] Driver Driving: winc=1, wdata=60
# UVM_INFO afifo_scoreboard.sv(41) @ 145: uvm_test_top.env.scoreboard [afifo_scoreboard] [145] WRITE: data=60, fifo_size=10
# UVM_INFO afifo_write_monitor.sv(29) @ 145: uvm_test_top.env.write_agent.monitor [afifo_write_monitor] [145] Captured: winc=1, wdata=60, wfull=0
# UVM_INFO afifo_sequence.sv(14) @ 145: uvm_test_top.env.write_agent.sequencer@@write_seq [afifo_write_sequence] [145] Write Transaction 14: winc=1, wdata=165
# UVM_INFO afifo_write_driver.sv(33) @ 145: uvm_test_top.env.write_agent.driver [afifo_write_driver] [145] Driver Driving: winc=1, wdata=165
# UVM_INFO afifo_scoreboard.sv(75) @ 150: uvm_test_top.env.scoreboard [afifo_scoreboard] [150] READ: expected_data=220, actual_data=220, fifo_size=9
# UVM_INFO afifo_read_monitor.sv(29) @ 150: uvm_test_top.env.read_agent.monitor [afifo_read_monitor] [150] Captured: rinc=1, rdata=220, rempty=0
# UVM_INFO afifo_sequence.sv(38) @ 150: uvm_test_top.env.read_agent.sequencer@@read_seq [afifo_read_sequence] [150] Read Transaction 0: rinc=1
# UVM_INFO afifo_read_driver.sv(32) @ 150: uvm_test_top.env.read_agent.driver [afifo_read_driver] [150] Driver Driving: rinc=1
# UVM_INFO afifo_scoreboard.sv(41) @ 155: uvm_test_top.env.scoreboard [afifo_scoreboard] [155] WRITE: data=165, fifo_size=10
# UVM_INFO afifo_write_monitor.sv(29) @ 155: uvm_test_top.env.write_agent.monitor [afifo_write_monitor] [155] Captured: winc=1, wdata=165, wfull=0
# UVM_INFO afifo_sequence.sv(14) @ 155: uvm_test_top.env.write_agent.sequencer@@write_seq [afifo_write_sequence] [155] Write Transaction 15: winc=1, wdata=66
# UVM_INFO afifo_write_driver.sv(33) @ 155: uvm_test_top.env.write_agent.driver [afifo_write_driver] [155] Driver Driving: winc=1, wdata=66
# UVM_INFO afifo_scoreboard.sv(41) @ 165: uvm_test_top.env.scoreboard [afifo_scoreboard] [165] WRITE: data=66, fifo_size=11
# UVM_INFO afifo_write_monitor.sv(29) @ 165: uvm_test_top.env.write_agent.monitor [afifo_write_monitor] [165] Captured: winc=1, wdata=66, wfull=0
# UVM_INFO afifo_sequence.sv(14) @ 165: uvm_test_top.env.write_agent.sequencer@@write_seq [afifo_write_sequence] [165] Write Transaction 16: winc=1, wdata=151
# UVM_INFO afifo_write_driver.sv(33) @ 165: uvm_test_top.env.write_agent.driver [afifo_write_driver] [165] Driver Driving: winc=1, wdata=151
# UVM_INFO afifo_scoreboard.sv(75) @ 170: uvm_test_top.env.scoreboard [afifo_scoreboard] [170] READ: expected_data=120, actual_data=120, fifo_size=10
# UVM_INFO afifo_read_monitor.sv(29) @ 170: uvm_test_top.env.read_agent.monitor [afifo_read_monitor] [170] Captured: rinc=1, rdata=120, rempty=0
# UVM_INFO afifo_sequence.sv(38) @ 170: uvm_test_top.env.read_agent.sequencer@@read_seq [afifo_read_sequence] [170] Read Transaction 0: rinc=1
# UVM_INFO afifo_read_driver.sv(32) @ 170: uvm_test_top.env.read_agent.driver [afifo_read_driver] [170] Driver Driving: rinc=1
# UVM_INFO afifo_scoreboard.sv(41) @ 175: uvm_test_top.env.scoreboard [afifo_scoreboard] [175] WRITE: data=151, fifo_size=11
# UVM_INFO afifo_write_monitor.sv(29) @ 175: uvm_test_top.env.write_agent.monitor [afifo_write_monitor] [175] Captured: winc=1, wdata=151, wfull=0
# UVM_INFO afifo_sequence.sv(14) @ 175: uvm_test_top.env.write_agent.sequencer@@write_seq [afifo_write_sequence] [175] Write Transaction 17: winc=1, wdata=190
# UVM_INFO afifo_write_driver.sv(33) @ 175: uvm_test_top.env.write_agent.driver [afifo_write_driver] [175] Driver Driving: winc=1, wdata=190
# UVM_INFO afifo_scoreboard.sv(41) @ 185: uvm_test_top.env.scoreboard [afifo_scoreboard] [185] WRITE: data=190, fifo_size=12
# UVM_INFO afifo_write_monitor.sv(29) @ 185: uvm_test_top.env.write_agent.monitor [afifo_write_monitor] [185] Captured: winc=1, wdata=190, wfull=0
# UVM_INFO afifo_sequence.sv(14) @ 185: uvm_test_top.env.write_agent.sequencer@@write_seq [afifo_write_sequence] [185] Write Transaction 18: winc=1, wdata=13
# UVM_INFO afifo_write_driver.sv(33) @ 185: uvm_test_top.env.write_agent.driver [afifo_write_driver] [185] Driver Driving: winc=1, wdata=13
# UVM_INFO afifo_scoreboard.sv(75) @ 190: uvm_test_top.env.scoreboard [afifo_scoreboard] [190] READ: expected_data=246, actual_data=246, fifo_size=11
# UVM_INFO afifo_read_monitor.sv(29) @ 190: uvm_test_top.env.read_agent.monitor [afifo_read_monitor] [190] Captured: rinc=1, rdata=246, rempty=0
# UVM_INFO afifo_sequence.sv(38) @ 190: uvm_test_top.env.read_agent.sequencer@@read_seq [afifo_read_sequence] [190] Read Transaction 0: rinc=1
# UVM_INFO afifo_read_driver.sv(32) @ 190: uvm_test_top.env.read_agent.driver [afifo_read_driver] [190] Driver Driving: rinc=1
# UVM_INFO afifo_scoreboard.sv(41) @ 195: uvm_test_top.env.scoreboard [afifo_scoreboard] [195] WRITE: data=13, fifo_size=12
# UVM_INFO afifo_write_monitor.sv(29) @ 195: uvm_test_top.env.write_agent.monitor [afifo_write_monitor] [195] Captured: winc=1, wdata=13, wfull=0
# UVM_INFO afifo_sequence.sv(14) @ 195: uvm_test_top.env.write_agent.sequencer@@write_seq [afifo_write_sequence] [195] Write Transaction 19: winc=1, wdata=17
# UVM_INFO afifo_write_driver.sv(33) @ 195: uvm_test_top.env.write_agent.driver [afifo_write_driver] [195] Driver Driving: winc=1, wdata=17
# UVM_INFO afifo_scoreboard.sv(41) @ 205: uvm_test_top.env.scoreboard [afifo_scoreboard] [205] WRITE: data=17, fifo_size=13
# UVM_INFO afifo_write_monitor.sv(29) @ 205: uvm_test_top.env.write_agent.monitor [afifo_write_monitor] [205] Captured: winc=1, wdata=17, wfull=0
# UVM_INFO afifo_sequence.sv(14) @ 205: uvm_test_top.env.write_agent.sequencer@@write_seq [afifo_write_sequence] [205] Write Transaction 20: winc=1, wdata=43
# UVM_INFO afifo_write_driver.sv(33) @ 205: uvm_test_top.env.write_agent.driver [afifo_write_driver] [205] Driver Driving: winc=1, wdata=43
# UVM_INFO afifo_scoreboard.sv(75) @ 210: uvm_test_top.env.scoreboard [afifo_scoreboard] [210] READ: expected_data=246, actual_data=246, fifo_size=12
# UVM_INFO afifo_read_monitor.sv(29) @ 210: uvm_test_top.env.read_agent.monitor [afifo_read_monitor] [210] Captured: rinc=1, rdata=246, rempty=0
# UVM_INFO afifo_sequence.sv(38) @ 210: uvm_test_top.env.read_agent.sequencer@@read_seq [afifo_read_sequence] [210] Read Transaction 0: rinc=1
# UVM_INFO afifo_read_driver.sv(32) @ 210: uvm_test_top.env.read_agent.driver [afifo_read_driver] [210] Driver Driving: rinc=1
# UVM_INFO afifo_scoreboard.sv(41) @ 215: uvm_test_top.env.scoreboard [afifo_scoreboard] [215] WRITE: data=43, fifo_size=13
# UVM_INFO afifo_write_monitor.sv(29) @ 215: uvm_test_top.env.write_agent.monitor [afifo_write_monitor] [215] Captured: winc=1, wdata=43, wfull=0
# UVM_INFO afifo_sequence.sv(14) @ 215: uvm_test_top.env.write_agent.sequencer@@write_seq [afifo_write_sequence] [215] Write Transaction 21: winc=1, wdata=178
# UVM_INFO afifo_write_driver.sv(33) @ 215: uvm_test_top.env.write_agent.driver [afifo_write_driver] [215] Driver Driving: winc=1, wdata=178
# UVM_INFO afifo_scoreboard.sv(61) @ 225: uvm_test_top.env.scoreboard [afifo_scoreboard] [225] WRITE BLOCKED: FIFO is full, winc ignored
# UVM_INFO afifo_write_monitor.sv(29) @ 225: uvm_test_top.env.write_agent.monitor [afifo_write_monitor] [225] Captured: winc=1, wdata=178, wfull=1
# UVM_INFO afifo_sequence.sv(14) @ 225: uvm_test_top.env.write_agent.sequencer@@write_seq [afifo_write_sequence] [225] Write Transaction 22: winc=1, wdata=113
# UVM_INFO afifo_write_driver.sv(33) @ 225: uvm_test_top.env.write_agent.driver [afifo_write_driver] [225] Driver Driving: winc=1, wdata=113
# UVM_INFO afifo_scoreboard.sv(75) @ 230: uvm_test_top.env.scoreboard [afifo_scoreboard] [230] READ: expected_data=154, actual_data=154, fifo_size=12
# UVM_INFO afifo_read_monitor.sv(29) @ 230: uvm_test_top.env.read_agent.monitor [afifo_read_monitor] [230] Captured: rinc=1, rdata=154, rempty=0
# UVM_INFO afifo_sequence.sv(38) @ 230: uvm_test_top.env.read_agent.sequencer@@read_seq [afifo_read_sequence] [230] Read Transaction 0: rinc=1
# UVM_INFO afifo_read_driver.sv(32) @ 230: uvm_test_top.env.read_agent.driver [afifo_read_driver] [230] Driver Driving: rinc=1
# UVM_INFO afifo_scoreboard.sv(41) @ 235: uvm_test_top.env.scoreboard [afifo_scoreboard] [235] WRITE: data=113, fifo_size=13
# UVM_INFO afifo_write_monitor.sv(29) @ 235: uvm_test_top.env.write_agent.monitor [afifo_write_monitor] [235] Captured: winc=1, wdata=113, wfull=0
# UVM_INFO afifo_sequence.sv(14) @ 235: uvm_test_top.env.write_agent.sequencer@@write_seq [afifo_write_sequence] [235] Write Transaction 23: winc=1, wdata=142
# UVM_INFO afifo_write_driver.sv(33) @ 235: uvm_test_top.env.write_agent.driver [afifo_write_driver] [235] Driver Driving: winc=1, wdata=142
# UVM_INFO afifo_scoreboard.sv(61) @ 245: uvm_test_top.env.scoreboard [afifo_scoreboard] [245] WRITE BLOCKED: FIFO is full, winc ignored
# UVM_INFO afifo_write_monitor.sv(29) @ 245: uvm_test_top.env.write_agent.monitor [afifo_write_monitor] [245] Captured: winc=1, wdata=142, wfull=1
# UVM_INFO afifo_sequence.sv(20) @ 245: uvm_test_top.env.write_agent.sequencer@@write_seq [afifo_write_sequence] [245] Write Transaction 24: winc=0, wdata=103
# UVM_INFO afifo_write_driver.sv(33) @ 245: uvm_test_top.env.write_agent.driver [afifo_write_driver] [245] Driver Driving: winc=0, wdata=103
# ** Warning: [ASSERTION] Write attempted when FIFO is full at time 245
#    Time: 245 ns Started: 235 ns  Scope: top.dut.afifo_assert_inst.assert_no_write_when_full File: afifo_assertions.sv Line: 60 Expr: ~winc
# UVM_INFO afifo_scoreboard.sv(75) @ 250: uvm_test_top.env.scoreboard [afifo_scoreboard] [250] READ: expected_data=156, actual_data=156, fifo_size=12
# UVM_INFO afifo_read_monitor.sv(29) @ 250: uvm_test_top.env.read_agent.monitor [afifo_read_monitor] [250] Captured: rinc=1, rdata=156, rempty=0
# UVM_INFO afifo_sequence.sv(38) @ 250: uvm_test_top.env.read_agent.sequencer@@read_seq [afifo_read_sequence] [250] Read Transaction 0: rinc=1
# UVM_INFO afifo_read_driver.sv(32) @ 250: uvm_test_top.env.read_agent.driver [afifo_read_driver] [250] Driver Driving: rinc=1
# UVM_INFO afifo_write_monitor.sv(29) @ 255: uvm_test_top.env.write_agent.monitor [afifo_write_monitor] [255] Captured: winc=0, wdata=103, wfull=0
# UVM_INFO afifo_write_monitor.sv(29) @ 265: uvm_test_top.env.write_agent.monitor [afifo_write_monitor] [265] Captured: winc=0, wdata=103, wfull=0
# UVM_INFO afifo_scoreboard.sv(75) @ 270: uvm_test_top.env.scoreboard [afifo_scoreboard] [270] READ: expected_data=95, actual_data=95, fifo_size=11
# UVM_INFO afifo_read_monitor.sv(29) @ 270: uvm_test_top.env.read_agent.monitor [afifo_read_monitor] [270] Captured: rinc=1, rdata=95, rempty=0
# UVM_INFO afifo_sequence.sv(38) @ 270: uvm_test_top.env.read_agent.sequencer@@read_seq [afifo_read_sequence] [270] Read Transaction 0: rinc=1
# UVM_INFO afifo_read_driver.sv(32) @ 270: uvm_test_top.env.read_agent.driver [afifo_read_driver] [270] Driver Driving: rinc=1
# UVM_INFO afifo_write_monitor.sv(29) @ 275: uvm_test_top.env.write_agent.monitor [afifo_write_monitor] [275] Captured: winc=0, wdata=103, wfull=0
# UVM_INFO afifo_write_monitor.sv(29) @ 285: uvm_test_top.env.write_agent.monitor [afifo_write_monitor] [285] Captured: winc=0, wdata=103, wfull=0
# UVM_INFO afifo_scoreboard.sv(75) @ 290: uvm_test_top.env.scoreboard [afifo_scoreboard] [290] READ: expected_data=255, actual_data=255, fifo_size=10
# UVM_INFO afifo_read_monitor.sv(29) @ 290: uvm_test_top.env.read_agent.monitor [afifo_read_monitor] [290] Captured: rinc=1, rdata=255, rempty=0
# UVM_INFO afifo_sequence.sv(38) @ 290: uvm_test_top.env.read_agent.sequencer@@read_seq [afifo_read_sequence] [290] Read Transaction 0: rinc=1
# UVM_INFO afifo_read_driver.sv(32) @ 290: uvm_test_top.env.read_agent.driver [afifo_read_driver] [290] Driver Driving: rinc=1
# UVM_INFO afifo_write_monitor.sv(29) @ 295: uvm_test_top.env.write_agent.monitor [afifo_write_monitor] [295] Captured: winc=0, wdata=103, wfull=0
# UVM_INFO afifo_write_monitor.sv(29) @ 305: uvm_test_top.env.write_agent.monitor [afifo_write_monitor] [305] Captured: winc=0, wdata=103, wfull=0
# UVM_INFO afifo_scoreboard.sv(75) @ 310: uvm_test_top.env.scoreboard [afifo_scoreboard] [310] READ: expected_data=7, actual_data=7, fifo_size=9
# UVM_INFO afifo_read_monitor.sv(29) @ 310: uvm_test_top.env.read_agent.monitor [afifo_read_monitor] [310] Captured: rinc=1, rdata=7, rempty=0
# UVM_INFO afifo_sequence.sv(38) @ 310: uvm_test_top.env.read_agent.sequencer@@read_seq [afifo_read_sequence] [310] Read Transaction 0: rinc=1
# UVM_INFO afifo_read_driver.sv(32) @ 310: uvm_test_top.env.read_agent.driver [afifo_read_driver] [310] Driver Driving: rinc=1
# UVM_INFO afifo_write_monitor.sv(29) @ 315: uvm_test_top.env.write_agent.monitor [afifo_write_monitor] [315] Captured: winc=0, wdata=103, wfull=0
# UVM_INFO afifo_write_monitor.sv(29) @ 325: uvm_test_top.env.write_agent.monitor [afifo_write_monitor] [325] Captured: winc=0, wdata=103, wfull=0
# UVM_INFO afifo_scoreboard.sv(75) @ 330: uvm_test_top.env.scoreboard [afifo_scoreboard] [330] READ: expected_data=60, actual_data=60, fifo_size=8
# UVM_INFO afifo_read_monitor.sv(29) @ 330: uvm_test_top.env.read_agent.monitor [afifo_read_monitor] [330] Captured: rinc=1, rdata=60, rempty=0
# UVM_INFO afifo_sequence.sv(43) @ 330: uvm_test_top.env.read_agent.sequencer@@read_seq [afifo_read_sequence] [330] Read Transaction 0: rinc=0
# UVM_INFO afifo_read_driver.sv(32) @ 330: uvm_test_top.env.read_agent.driver [afifo_read_driver] [330] Driver Driving: rinc=0
# UVM_INFO afifo_write_monitor.sv(29) @ 335: uvm_test_top.env.write_agent.monitor [afifo_write_monitor] [335] Captured: winc=0, wdata=103, wfull=0
# UVM_INFO afifo_write_monitor.sv(29) @ 345: uvm_test_top.env.write_agent.monitor [afifo_write_monitor] [345] Captured: winc=0, wdata=103, wfull=0
# UVM_INFO afifo_read_monitor.sv(29) @ 350: uvm_test_top.env.read_agent.monitor [afifo_read_monitor] [350] Captured: rinc=0, rdata=60, rempty=0
# UVM_INFO verilog_src/uvm-1.1d/src/base/uvm_objection.svh(1267) @ 350: reporter [TEST_DONE] 'run' phase is ready to proceed to the 'extract' phase
# UVM_INFO afifo_scoreboard.sv(115) @ 350: uvm_test_top.env.scoreboard [afifo_scoreboard] SCOREBOARD SUMMARY:
# UVM_INFO afifo_scoreboard.sv(116) @ 350: uvm_test_top.env.scoreboard [afifo_scoreboard]   Total Writes: 22
# UVM_INFO afifo_scoreboard.sv(117) @ 350: uvm_test_top.env.scoreboard [afifo_scoreboard]   Total Reads:  14
# UVM_INFO afifo_scoreboard.sv(118) @ 350: uvm_test_top.env.scoreboard [afifo_scoreboard]   WFULL Checks: Pass=22, Fail=0
# UVM_INFO afifo_scoreboard.sv(119) @ 350: uvm_test_top.env.scoreboard [afifo_scoreboard]   REMPTY Checks: Pass=14, Fail=0
# UVM_INFO afifo_scoreboard.sv(120) @ 350: uvm_test_top.env.scoreboard [afifo_scoreboard]   Write/Read Data Checks: Pass=14, Fail=0
# UVM_INFO afifo_subscriber.sv(100) @ 350: uvm_test_top.env.subscriber [afifo_subscriber] COVERAGE SUMMARY:
# UVM_INFO afifo_subscriber.sv(101) @ 350: uvm_test_top.env.subscriber [afifo_subscriber]   Write Coverage: 100.00%
# UVM_INFO afifo_subscriber.sv(102) @ 350: uvm_test_top.env.subscriber [afifo_subscriber]   Read Coverage:  100.00%
# UVM_INFO afifo_subscriber.sv(103) @ 350: uvm_test_top.env.subscriber [afifo_subscriber]   Overall Coverage: 100.00%