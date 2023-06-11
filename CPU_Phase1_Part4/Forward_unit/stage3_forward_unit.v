
 /*______________________________________________________________________________
  |                                                                              |
  |  File Name         -stage3_forward_unit.v                                    |
  |  Created By        -Group1(E17)                                              |
  |  Project/ Course   -CO502                                                    |
  |  Institute         -University of peradeniya                                 |
  |  Date              -05.04.2023                                               |
  |  Discription       -Forwading unit1                                          |
  |______________________________________________________________________________|
  
*/


`timescale 1ns/100ps

module stage3_forward_unit(MEM_WRITE, ADDR1, ADDR2, STAGE_3_ADDR, STAGE_3_REGWRITE_EN, STAGE_4_ADDR, STAGE_4_REGWRITE_EN, OP1_MUX_OUT, OP2_MUX_OUT);

    input [4:0] ADDR1, ADDR2; //declare the inputs

    input [4:0] STAGE_3_ADDR, STAGE_4_ADDR;
    input STAGE_3_REGWRITE_EN, STAGE_4_REGWRITE_EN;
    input MEM_WRITE; //  data memory write enabke signal
    output reg [1:0] OP1_MUX_OUT, OP2_MUX_OUT; // declare the outputs as registers

    always @ (*) // always block to simulate the procedure
    begin
        // The logic flow for the operand 1
        if (STAGE_3_REGWRITE_EN == 1'b1 && STAGE_3_ADDR == ADDR1)
            begin
                // fowarding the data from stage 3
                OP1_MUX_OUT = 2'b01;
            end
        else if (STAGE_4_REGWRITE_EN == 1'b1 && STAGE_4_ADDR == ADDR1)
            begin
                // fowarding the data from stage 4
                OP1_MUX_OUT = 2'b10;
            end
        
        else
            begin
                // no fowarding
                OP1_MUX_OUT = 2'b00;
            end
       
        
        // The logic flow for the operand 1
        if (STAGE_3_REGWRITE_EN == 1'b1 && STAGE_3_ADDR == ADDR2)
            begin
                // fowarding the data from stage 3
                OP2_MUX_OUT = 2'b01;
            end
        else if (STAGE_4_REGWRITE_EN == 1'b1 && STAGE_4_ADDR == ADDR2)
            begin
                // fowarding the data from stage 4
                OP2_MUX_OUT = 2'b10;
            end
      
        else
            begin
                // no fowarding
                OP2_MUX_OUT = 2'b00;
            end

        
    end
    
endmodule