 /*______________________________________________________________________________
  |                                                                              |
  |  File Name         -id_ex_pipeline_reg.v                                     |
  |  Created By        -Group1(E17)                                              |
  |  Project/ Course   -CO502                                                    |
  |  Institute         -University of peradeniya                                 |
  |  Date              -05.04.2023                                               |
  |  Discription       -Pipeline Register                                        |
  |______________________________________________________________________________|
  
*/

module id_ex_pipeline_reg(
    CLK, 
    RESET,
    BUSYWAIT,
    IN_INSTRUCTION, // INSTRUCTION [11:7]
     IN_R_ADDR1,
    IN_R_ADDR2,
    IN_PC,
    IN_DATA1, 
    IN_DATA2, 
    IN_IMMEDIATE,
    IN_DATA1ALUSEL,
    IN_DATA2ALUSEL,
    IN_ALU_OP,
    IN_BRANCH_JUMP,
    IN_MEM_READ,
    IN_MEM_WRITE,
    IN_WB_SEL,
    IN_REG_WRITE_EN,
    OUT_INSTRUCTION,
    OUT_R_ADDR1,
    OUT_R_ADDR2,
    OUT_PC,
    OUT_DATA1,
    OUT_DATA2,
    OUT_IMMEDIATE, 
    OUT_DATA1ALUSEL,
    OUT_DATA2ALUSEL,
    OUT_ALU_OP,
    OUT_BRANCH_JUMP,
    OUT_MEM_READ,
    OUT_MEM_WRITE,
    OUT_WB_SEL,
    OUT_REG_WRITE_EN
   
    );

    //declare the ports
    input [4:0] IN_ALU_OP, IN_INSTRUCTION,IN_R_ADDR1,IN_R_ADDR2;
    input [2:0] IN_BRANCH_JUMP;
    input [1:0] IN_WB_SEL ;
    input [2:0] IN_MEM_READ;
    input [1:0] IN_MEM_WRITE;
    input IN_DATA1ALUSEL, IN_DATA2ALUSEL;
    input [31:0] IN_PC,
            IN_DATA1,
            IN_DATA2,
            IN_IMMEDIATE;   
                
    input IN_REG_WRITE_EN,
        CLK, 
        RESET, 
        BUSYWAIT;

    output reg [4:0] OUT_ALU_OP, OUT_INSTRUCTION;
    output reg [2:0] OUT_BRANCH_JUMP;
    output reg [1:0] OUT_WB_SEL,  OUT_DATA1BJSEL, OUT_DATA2BJSEL;
    output reg OUT_DATA1ALUSEL, OUT_DATA2ALUSEL;
    output reg [2:0] OUT_MEM_READ;
    output reg [1:0] OUT_MEM_WRITE;
     output reg [4:0] OUT_R_ADDR1,OUT_R_ADDR2;

 
    output reg [31:0] OUT_PC,
                    OUT_DATA1,
                    OUT_DATA2,
                    OUT_IMMEDIATE; 

    output reg OUT_REG_WRITE_EN;

    //RESETTING output registers
    always @ (*) begin
        if (RESET) begin
            #1;
            OUT_INSTRUCTION = 5'dx;
            OUT_PC = 32'dx;
            OUT_DATA1 = 32'dx;
            OUT_DATA2 = 32'dx;
            OUT_IMMEDIATE =  32'dx;
            OUT_DATA1ALUSEL = 1'dx;
           
            OUT_DATA2ALUSEL = 1'dx;
            OUT_ALU_OP = 4'dx;
            OUT_BRANCH_JUMP = 3'dx;
            OUT_MEM_READ  = 3'dx;
            OUT_MEM_WRITE = 2'dx;
            OUT_WB_SEL = 2'dx;
            OUT_REG_WRITE_EN = 1'dx;
            OUT_R_ADDR1  =5'dx;
            OUT_R_ADDR2  =5'dx;
        end
    end

    //Writing the input values to the output registers, 
    //when the RESET is low and when the CLOCK is at a positive edge and BUSYWAIT is low 
    always @(posedge CLK)
    begin
        #0;
        if (!BUSYWAIT) begin
            OUT_INSTRUCTION <= IN_INSTRUCTION;
            OUT_PC <= IN_PC;
            OUT_DATA1 <= IN_DATA1;
            OUT_DATA2 <= IN_DATA2;
            OUT_IMMEDIATE <=  IN_IMMEDIATE;
            OUT_DATA1ALUSEL <= IN_DATA1ALUSEL;
            OUT_DATA2ALUSEL <= IN_DATA2ALUSEL;
             OUT_R_ADDR1  <= IN_R_ADDR1;
            OUT_R_ADDR2  <= IN_R_ADDR2;
            OUT_ALU_OP <= IN_ALU_OP;
            OUT_BRANCH_JUMP <= IN_BRANCH_JUMP;
            OUT_MEM_READ  <= IN_MEM_READ;
            OUT_MEM_WRITE <= IN_MEM_WRITE;
            OUT_WB_SEL <= IN_WB_SEL;
            OUT_REG_WRITE_EN <= IN_REG_WRITE_EN;
        end
    end

endmodule