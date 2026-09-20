# Computer Architecture in Verilog
A university **team project by Qossay Assi and Rami** exploring a 16-bit processor datapath.

## Components
The source contains an ALU, control unit, eight-register file, instruction and data memories, instruction decoder, program counter, immediate extension and multiplexers. `rtl/design.v` is the top-level `design2` module generated from the original graphical design.

## Simulation
The original project used a graphical HDL design environment. A portable starting command, with Icarus Verilog installed, is:
```bash
iverilog -g2012 -s tb_design2 -o simulation rtl/*.v
vvp simulation
```
Select `tb_design2` explicitly: several files include independent component testbench modules.

## Validation
The command above has **not been executed** in the preparation environment, which had no HDL simulator. The integration testbench generates a clock and stops after 2000 time units; it has no self-checking assertions. No claim of full instruction-set correctness, synthesis success or FPGA deployment is made.

## Source provenance
RTL and testbenches are retained from the team archive. Generated simulator libraries, workstation paths and build caches are excluded. The generated top-level source is retained because it connects the components. Detailed division of team responsibilities has not been documented.

[Qossay Assi](https://www.linkedin.com/in/qossay-assi/)
