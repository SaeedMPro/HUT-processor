# HUT-processor
A single-cycle MIPS processor -Computer architecture final project-

## Instruction Set Overview

| Instruction | Format | Op-Code | Assembly | Operation |
|-------------|--------|---------|----------|-----------|
| NEG | Y-type | 000 | NEG rA, rB | rA ← 2'S Complement (rB) |
| SBR | Y-type | 001 | SBR rB, Imm | rB(Imm) ← '1' |
| OR | Y-type | 010 | OR rA, rB, Imm | rA ← [rB or Z.F.(Imm)] |
| RJMP | Z-type | 011 | RJMP rA, Imm | PC ← 2*[ PC + rA + S.E.(Imm)] |
| LUI | Z-type | 100 | LUI rA, Imm | rA ← Imm * 128 |
| LDI | Z-type | 101 | LDI rA, Imm | rA ← Mem[2*Z.F.(Imm)] |
| STI | Z-type | 110 | STI rA, Imm | Mem[2*Z.F.(Imm)] ← rA |

## Instruction Formats

- Y-type: Operations involving two registers or a register and an immediate value
- Z-type: Operations involving a register and an immediate value, often used for memory operations or large constant loading

## Data Path
![scheme_datha_path](https://github.com/user-attachments/assets/50812827-b3c8-429c-97c8-3600727d62f6)

## Controller
![scheme_controller](https://github.com/user-attachments/assets/c66c4a03-378a-4031-82d3-081de292c296)

