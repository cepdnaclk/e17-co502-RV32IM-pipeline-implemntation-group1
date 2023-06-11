 /*________________________________________________________________
  |                                                                |
  |  File Name         -Encoding formats.v                         |
  |  Created By        -Group 01                                   |
  |  Project/ Course   -CO502                                      |
  |  Institute         -University of peradeniya                   |
  |  Date              -05.04.2023                                 |
  |  Discription       - Encoding formats              |
  |________________________________________________________________|
  
  */


// OPCODES
`define LUI_OP 7'b0110111
`define AUIPC_OP 7'b0010111
`define JAL_OP 7'b1101111
`define JALR_OP 7'b1100111
`define B_TYPE_OP 7'b1100011
`define LOAD_OP 7'b0000011
`define STORE_OP 7'b0100011
`define I_TYPE_OP 7'b0010011
`define R_TYPE_OP 7'b0110011



// OP1SEL
`define DATA1 1'b0
`define PC 1'b1

// OP2SEL
`define DATA2 1'b0
`define IMM 1'b1

// REG_WRITE_EN
`define EN 1'b0
`define DIS 1'b1

// WB_SEL
`define ALU 2'b00
`define MEM 2'b01
`define IMM_WB 2'b10
`define PC_4 2'b11

// ALU_OP
`define ADD 5'b00000
`define SUB 5'b00010
`define SLL 5'b00100
`define SLT 5'b01000
`define SLTU 5'b01100
`define XOR 5'b10000
`define SRL 5'b10100
`define SRA 5'b10110
`define OR 5'b11000
`define AND 5'b11100
`define MUL 5'b00001
`define MULH 5'b00101
`define MULHSU 5'b01001
`define MULHU 5'b01101
`define DIV 5'b10001
`define DIVU 5'b10101
`define REM 5'b11001
`define REMU 5'b11101

// BRANCH_JUMP
`define B_BEQ 3'b000
`define B_BNE 3'b001
`define B_NO 3'b010
`define B_J 3'b011
`define B_BLT 3'b100
`define B_BGE 3'b101
`define B_BLTU 3'b110
`define B_BGEU 3'b111

// IMM_SEL
`define U_TYPE 3'b000
`define J_TYPE 3'b001
`define S_TYPE 3'b010
`define B_TYPE 3'b011
`define I_TYPE 3'b100
`define I_SIGNED_TYPE 3'b100
`define I_SHIFT_TYPE 3'b101
`define I_UNSIGNED_TYPE 3'b111

// MEM_READ
`define NO_R 3'b000
`define MR_LB 3'b001
`define MR_LH 3'b010
`define MR_LW 3'b011
`define MR_LBU 3'b100
`define MR_LHU 3'b101

//MEM_WRITE
`define NO_W 2'b00
`define MW_SB 2'b01
`define MW_SH 2'b10
`define MW_SW 2'b11