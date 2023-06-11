

 /*______________________________________________________________________________
  |                                                                              |
  |  File Name         -stage4_forward_unit.v                                    |
  |  Created By        -Group1(E17)                                              |
  |  Project/ Course   -CO502                                                    |
  |  Institute         -University of peradeniya                                 |
  |  Date              -05.04.2023                                               |
  |  Discription       -Forwading unit2                                          |
  |______________________________________________________________________________|
  
*/

`timescale 1ns/100ps

module stage4_forward_unit(REG_READ_ADDR2_S3, STAGE4_REG_ADDR , STAGE_3_MEM_WRITE, STAGE_4_MEM_READ, MUX_OUT);

    input [4:0] REG_READ_ADDR2_S3, STAGE4_REG_ADDR; //declare the inputs
    input [31:0] STAGE_3_DATA;
    input STAGE_3_MEM_WRITE, STAGE_4_MEM_READ;
    output reg MUX_OUT;

    always @ (*) // always block to simulate the procedure
    begin
        // The logic flow for the mux
        if (STAGE_4_MEM_READ == 1'b1 && STAGE_3_MEM_WRITE == 1'b1)
            begin
                // if stage 3 and stage 4 use same address foward the stage 4 memory read
                if (REG_READ_ADDR2_S3 == STAGE4_REG_ADDR) 
                    MUX_OUT = 1'b1;
                //else no change
                else
                    MUX_OUT = 1'b0;
            end
        else
            MUX_OUT = 1'b0;
    end
    
endmodule