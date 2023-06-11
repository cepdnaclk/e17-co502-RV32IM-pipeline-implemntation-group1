
`timescale 1ns/100ps

 /*______________________________________________________________________________
  |                                                                              |
  |  File Name         -hazards_detect.v                                         |
  |  Created By        -Group1(E17)                                              |
  |  Project/ Course   -CO502                                                    |
  |  Institute         -University of peradeniya                                 |
  |  Date              -05.04.2023                                               |
  |  Discription       -Pipeline Register                                        |
  |______________________________________________________________________________|
  
*/

module hazards_dection(ADDR1,ADDR2,ADDR_S3,MEM_READ_S3,FL_REG_WRITE,PC_REG_WRITE,MUX_OUT);

    input [4:0]ADDR1,ADDR2,ADDR_S3;
    input[2:0] MEM_READ_S3;
    output reg MUX_OUT,FL_REG_WRITE,PC_REG_WRITE;

    always @ (*) 
    begin
    
        if (MEM_READ_S3 != 3'b000)
            begin
            
                if (ADDR1 == ADDR_S3 || ADDR2 == ADDR_S3 ) 
                    begin
                    MUX_OUT = 1'b1;
                    FL_REG_WRITE= 1'b1;
                    PC_REG_WRITE= 1'b1;
                    end
                else
                    begin
                    MUX_OUT = 1'b0;
                    FL_REG_WRITE= 1'b0;
                    PC_REG_WRITE= 1'b0;
                    end
            end    
        else
               begin
               MUX_OUT = 1'b0;
               FL_REG_WRITE= 1'b0;
               PC_REG_WRITE= 1'b0;
               end
    end
    
endmodule