 /*________________________________________________________________
  |                                                                |
  |  File Name         -alu.v                                      |
  |  Created By        -Group  01                                  |
  |  Project/ Course   -CO502                                      |
  |  Institute         -University of peradeniya                   |
  |  Date              -05.04.2023                                 |
  |  Discription       -ALU module                                 |
  |________________________________________________________________|
  
  */


module alu(DATA1, DATA2,  OPCODE,RESULT);

    //Port declaration
    input [31:0] DATA1, DATA2;
    input [4:0] OPCODE;     
    output reg [31:0] RESULT;
    

    // ALU intermediate results
    wire [31:0] RESULT_ADD,
                RESULT_SLT,
                RESULT_SLTU,
                RESULT_AND,
                RESULT_OR,
                RESULT_XOR,
                RESULT_SLL,
                RESULT_SRL,
                RESULT_SUB,
                RESULT_SRA,
                RESULT_MUL,
                RESULT_MULHU,
                RESULT_MULHSU,
                RESULT_DIV,
                RESULT_DIVU,
                RESULT_REM,
                RESULT_REMU;
    
    wire [63:0] RESULT_MULH;

 
    assign #2 RESULT_ADD = DATA1 + DATA2;       // Addition
    assign #2 RESULT_SUB = DATA1 - DATA2;       // Subtraction

    assign #2 RESULT_SLT  = ($signed(DATA1) < $signed(DATA2)) ? 1'b1 : 1'b0;         // Set less than
    assign #2 RESULT_SLTU = ($unsigned(DATA1) < $unsigned(DATA2)) ? 1'b1 : 1'b0;     // Set less than unsigned
    
    assign #1 RESULT_AND = DATA1 & DATA2;       // Bitwise logical AND
    assign #1 RESULT_OR  = DATA1 | DATA2;       // Bitwise logical OR
    assign #1 RESULT_XOR = DATA1 ^ DATA2;       // Bitwise logical XOR
    assign #2 RESULT_SLL = DATA1 << DATA2;      // Logical Left Shift
    assign #2 RESULT_SRL = DATA1 >> DATA2;      // Logical Right Shift
    assign #2 RESULT_SRA = DATA1 >>> DATA2;     // Arithmetic Right shift
    

    assign #3 RESULT_MUL    = DATA1 * DATA2;                           // Multiplication
    assign #3 RESULT_MULH   = $signed(DATA1) * $signed(DATA2);         // Multiplication High Signed x Signed
    assign #3 RESULT_MULHU  = $unsigned(DATA1) * $unsigned(DATA2);     // Multiplication High Unsigned x Unsigned
    assign #3 RESULT_MULHSU = $signed(DATA1) * $unsigned(DATA2);       // Multiplication High Signed x UnSigned
    

    assign #3 RESULT_DIV  = DATA1 / DATA2;                            // Division
    assign #3 RESULT_DIVU = $unsigned(DATA1) / $unsigned(DATA2);      // Division Unsigned
    assign #3 RESULT_REM  = DATA1 % (DATA2);                          // Remainder
    assign #3 RESULT_REMU = $unsigned(DATA1) % $unsigned(DATA2);      // Remainder Unsigned

    always @(*)
    begin
        case(OPCODE)
            `ADD:    RESULT = RESULT_ADD; 
            `SUB:    RESULT = RESULT_SUB; 
            `SLL:    RESULT = RESULT_SLL; 
            `SLT:    RESULT = RESULT_SLT; 
            `SLTU:   RESULT = RESULT_SLTU; 
            `XOR:    RESULT = RESULT_XOR; 
            `SRL:    RESULT = RESULT_SRL; 
            `SRA:    RESULT = RESULT_SRA; 
            `OR:     RESULT = RESULT_OR; 
            `AND:    RESULT = RESULT_AND; 
            `MUL:    RESULT = RESULT_MUL; 
            `MULH:   RESULT = RESULT_MULH[63:32]; 
            `MULHSU: RESULT = RESULT_MULHU; 
            `MULHU:  RESULT = RESULT_MULHSU; 
            `DIV:    RESULT = RESULT_DIV; 
            `DIVU:   RESULT = RESULT_DIVU; 
            `REM :   RESULT = RESULT_REM; 
            `REMU:   RESULT = RESULT_REMU; 
                
            default:  RESULT = 0 ;  
                                
        endcase
    end

endmodule
