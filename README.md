# Asynchronous FIFO (AFIFO) UVM Verification Project

## 📋 Project Overview

This repository contains a comprehensive **UVM-based verification environment** for an **Asynchronous FIFO** design. The FIFO operates across two independent clock domains (write and read), using Gray code conversion and two-stage synchronizers for safe clock domain crossing.

![My First Board (1)](https://github.com/user-attachments/assets/92dc2c4b-8325-4bf6-9d74-4a3cd35c3032)

### Key Features
- **Dual Clock Domain Operation**: Write clock (100 MHz) and Read clock (50 MHz)
- **8-bit Data Width**: Configurable data bus
- **8 Entry Depth**: FIFO capacity with 3-bit addressing
- **Full/Empty Flags**: Automatic wfull and rempty generation
- **Gray Code Synchronization**: Metastability-safe pointer synchronization
- **UVM Testbench**: Industry-standard verification methodology

---

## 🏗️ Design Specifications

| Parameter | Value | Description |
|-----------|-------|-------------|
| DATA_WIDTH | 8 bits | Width of data bus |
| ADDR_WIDTH | 3 bits | Address width (2^3 = 8 entries) |
| FIFO_DEPTH | 8 | Number of FIFO entries |
| WCLK_PERIOD | 10ns | Write clock period (100 MHz) |
| RCLK_PERIOD | 20ns | Read clock period (50 MHz) |

### Design Modules
- **FIFO.v**: Top-level FIFO wrapper
- **FIFO_memory.v**: Dual-port memory array
- **wptr_full.v**: Write pointer and full flag generation
- **rptr_empty.v**: Read pointer and empty flag generation
- **two_ff_sync.v**: Two-stage synchronizer for clock domain crossing

---

## 📁 Repository Structure

```
afifo/
├── AFIFO_UVM/                    # UVM Testbench Files
│   ├── top.sv                    # Top-level testbench
│   ├── project_configs.sv        # Global parameters and types
│   │
│   ├── afifo_if.sv         # interface
│   │
│   ├── afifo_sequence_item.sv    # Transaction class
│   ├── afifo_sequence.sv         # Write/Read sequences
│   │
│   ├── afifo_write_sequencer.sv  # Write sequencer
│   ├── afifo_read_sequencer.sv   # Read sequencer
│   │
│   ├── afifo_write_driver.sv     # Write domain driver
│   ├── afifo_read_driver.sv      # Read domain driver
│   │
│   ├── afifo_write_monitor.sv    # Write domain monitor
│   ├── afifo_read_monitor.sv     # Read domain monitor
│   │
│   ├── afifo_write_agent.sv      # Write agent
│   ├── afifo_read_agent.sv       # Read agent
│   │
│   ├── afifo_scoreboard.sv       # Reference model & checker
│   ├── afifo_subscriber.sv       # Functional coverage
│   ├── afifo_environment.sv      # UVM environment
│   ├── afifo_test.sv             # Test cases
│   │
│   ├── afifo_assertions.sv       # SystemVerilog assertions
│   ├── afifo_bind.sv             # Assertion bindings
│   │
│   ├── FIFO.v                    # DUT: Top-level FIFO
│   ├── FIFO_memory.v             # DUT: Memory array
│   ├── wptr_full.v               # DUT: Write pointer & full flag
│   ├── rptr_empty.v              # DUT: Read pointer & empty flag
│   ├── two_ff_sync.v             # DUT: Synchronizer
│   │
│   └── FIFO_tb.v                 # Legacy Verilog testbench (reference)
│
├── docs/                         # Documentation
│   ├── FIFO_Verification_Document.md
│   ├── test_plan.md
│   ├── coverage_plan.md
│   └── assertion_plan.md
│
└── README.md                     # This file
```

---

## 🧪 Testbench Architecture

### UVM Component Hierarchy
```
top
 └── afifo_environment
      ├── afifo_write_agent (ACTIVE)
      │    ├── afifo_write_sequencer
      │    ├── afifo_write_driver
      │    └── afifo_write_monitor
      │
      ├── afifo_read_agent (ACTIVE)
      │    ├── afifo_read_sequencer
      │    ├── afifo_read_driver
      │    └── afifo_read_monitor
      │
      ├── afifo_scoreboard (Reference Model + Checker)
      └── afifo_subscriber (Functional Coverage)
```

### Key Features
- **Dual Agent Design**: Separate agents for write and read clock domains
- **Clocking Blocks**: Proper timing control with SystemVerilog clocking blocks
- **Queue-Based Scoreboard**: Reference FIFO model for validation
- **Functional Coverage**: Write/read domain coverage with cross-coverage
- **20+ Assertions**: Continuous protocol and timing monitoring

---

## 📊 Verification Metrics

### Scoreboard Checks
- ✅ Data integrity (write vs. read comparison)
- ✅ wfull flag validation
- ✅ rempty flag validation
- ✅ FIFO ordering (First-In-First-Out)
- ✅ Transaction count tracking

### Functional Coverage
- **Write Domain**: winc, wdata, wfull, cross-coverage
- **Read Domain**: rinc, rdata, rempty, cross-coverage
- **Data Ranges**: Low [0-63], Mid [64-191], High [192-255]

### Assertions
- Signal validity (no X/Z during operation)
- Protocol compliance (no write when full, no read when empty)
- Data validity during transactions
- Flag consistency (never full and empty simultaneously)
- Reset behavior

---

---

## 📚 Documentation

Detailed documentation is available in the `docs/` directory:

- **FIFO_Verification_Document_Complete.docx**: Complete verification report
  - Chapter 1: Project Overview
  - Chapter 2: Testbench Architecture
  - Chapter 3: Verification Results and Analysis
  - Chapter 4: Conclusion
  - Appendices: File structure, parameters, commands

- **test_plan.md**: Detailed test plan and scenarios
- **coverage_plan.md**: Coverage strategy and metrics
- **assertion_plan.md**: Assertion specifications

---

## 📖 References

- IEEE 1800-2012: SystemVerilog Standard
- UVM 1.2 User Guide
- Asynchronous FIFO Design (Clifford Cummings)

---

**Happy Verifying! 🚀**
