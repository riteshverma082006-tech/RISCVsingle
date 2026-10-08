# Single-Cycle MIPS Processor (Verilog)

A 32-bit single-cycle MIPS processor written in Verilog, split into one module per file.

## Supported instructions
| Type   | Instructions                      |
|--------|-----------------------------------|
| R-type | `add`, `sub`, `and`, `or`, `xor`, `slt` |
| Memory | `lw`, `sw`                        |
| Branch | `beq`                             |
| Immediate | `addi`                         |
| Jump   | `j`                               |

## Structure
```
src/
  mips_single.v        top level (datapath wiring + next-PC logic)
  control_unit.v       main_decoder + alu_decoder
  main_decoder.v       opcode -> control signals
  alu_decoder.v        alu_op + funct -> ALU control
  alu.v                AND / OR / ADD / XOR / SUB / signed SLT
  register_file.v      32 x 32 registers, $0 = 0
  instruction_memory.v 256-word ROM with the demo program
  data_memory.v        256-word RAM
  pc.v  pc_adder.v  pc_branch.v  sign_extend.v  mux2.v

```

## Demo program
Sums 1..10 and stores the result at `mem[0]` (expected: 55). Edit
`src/instruction_memory.v` to load your own program.

## Run
Requires [Icarus Verilog](https://steveicarus.github.io/iverilog/) (and optionally GTKWave).
```
make sim    # compile and run, prints PASS/FAIL
make wave   # open the waveform
make clean
```
