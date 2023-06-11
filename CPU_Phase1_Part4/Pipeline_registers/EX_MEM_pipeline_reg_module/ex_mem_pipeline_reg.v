 /*______________________________________________________________________________
  |                                                                              |
  |  File Name         -ex_mem_pipeline_reg.v                                    |
  |  Created By        -Group1(E17)                                              |
  |  Project/ Course   -CO502                                                    |
  |  Institute         -University of peradeniya                                 |
  |  Date              -05.04.2023                                               |
  |  Discription       -Pipeline Register                                        |
  |______________________________________________________________________________|
  
*/
module ex_mem_pipeline_reg(
    CLK, 
    RESET,
    BUSYWAIT,
    IN_INSTRUCTION, // INSTRUCTION [11:7]
    IN_ADDR1,
    IN_PC,
    IN_ALU_RESULT, 
    IN_DATA2, 
    IN_IMMEDIATE,
    IN_READ,
    IN_WRITE,
    IN_WB_SEL,
    IN_REG_WRITE_EN,
    OUT_INSTRUCTION,
    OUT_ADDR1,
    OUT_PC,
    OUT_ALU_RESULT,
    OUT_DATA2,
    OUT_IMMEDIATE, 
   
    OUT_READ,
     OUT_WRITE,
    OUT_WB_SEL,
    OUT_REG_WRITE_EN
    );

    //declare the ports
    input [4:0] IN_INSTRUCTION,IN_ADDR1;
    input [1:0] IN_WB_SEL;
    input [2:0] IN_READ;
    input [1:0] IN_WRITE;

    
    input [31:0] IN_PC,
            IN_ALU_RESULT,
            IN_DATA2,
            IN_IMMEDIATE;   
                
    input IN_DATAMEMSEL,
        IN_REG_WRITE_EN,
        CLK, 
        RESET, 
        BUSYWAIT;

    output reg [4:0] OUT_INSTRUCTION,OUT_ADDR1;
    output reg [1:0] OUT_WB_SEL;
    output reg [2:0] OUT_READ;
    output reg [1:0] OUT_WRITE;
    output reg [31:0] OUT_PC,
                    OUT_ALU_RESULT,
                    OUT_DATA2,
                    OUT_IMMEDIATE; 

    output reg OUT_DATAMEMSEL, OUT_REG_WRITE_EN;


    //RESETTING output registers
    always @ (*) begin
        if (RESET) begin
            #1;
            OUT_INSTRUCTION = 5'dx;
            OUT_PC = 32'dx;
            OUT_ALU_RESULT = 32'dx;
            OUT_DATA2 = 32'dx;
            OUT_IMMEDIATE =  32'dx;
            OUT_READ  = 3'dx;
            OUT_WRITE = 2'dx;
            OUT_WB_SEL = 2'bx;
            OUT_REG_WRITE_EN = 1'dx;
            OUT_ADDR1 =5'dx;
        end
    end

    //Writing the input values to the output registers, 
    //when the RESET is low and when the CLOCK is at a positive edge and BUSYWAIT is low 
    always @(posedge CLK)
    begin
        #0
        if (!RESET & !BUSYWAIT) begin
            OUT_INSTRUCTION <= #1 IN_INSTRUCTION;
            OUT_PC <= #1 IN_PC;
            OUT_ALU_RESULT <= #1 IN_ALU_RESULT;
            OUT_DATA2 <= #1 IN_DATA2;
            OUT_IMMEDIATE <= #1  IN_IMMEDIATE;
            OUT_DATAMEMSEL <= #1 IN_DATAMEMSEL;
            OUT_READ <= #1 IN_READ;
            OUT_WRITE <= #1 IN_WRITE;
            OUT_WB_SEL <= #1 IN_WB_SEL;
            OUT_REG_WRITE_EN <= #1 IN_REG_WRITE_EN;
            OUT_ADDR1 <= IN_ADDR1;
        end
    end

endmodule