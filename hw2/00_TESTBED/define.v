// opcode definition
`define OP_ADD  1
`define OP_SUB  2
`define OP_ADDI 3
`define OP_LW   4
`define OP_SW   5
`define OP_AND  6
`define OP_OR   7
`define OP_NOR  8
`define OP_BEQ  9
`define OP_BNE  10
`define OP_SLT  11
`define OP_EOF  12

// MIPS status definition
`define R_TYPE_SUCCESS 0
`define I_TYPE_SUCCESS 1
`define MIPS_OVERFLOW 2
`define MIPS_END 3
