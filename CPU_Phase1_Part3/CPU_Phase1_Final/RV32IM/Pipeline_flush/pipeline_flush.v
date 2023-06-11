
`timescale 1ns/100ps

 /*______________________________________________________________________________
  |                                                                              |
  |  File Name         -pipeline_flush.v                                         |
  |  Created By        -Group1(E17)                                              |
  |  Project/ Course   -CO502                                                    |
  |  Institute         -University of peradeniya                                 |
  |  Date              -05.04.2023                                               |
  |  Discription       -Pipeline flush                                           |
  |______________________________________________________________________________|
  
*/

module pipeline_flush(SIG_HAZARDS_D ,SIG_BJ,P_REG1,P_REG2,P_REG_3);

    input SIG_HAZARDS_D,SIG_BJ;
    
    output reg P_REG1,P_REG2,P_REG_3;

    always @ (*) 
    begin
    
        if (SIG_HAZARDS_D ==1'b1 && SIG_BJ==1'b0 )
            begin

             
                P_REG1 =1'b1;
                P_REG2=1'b0;
                P_REG_3=1'b0;
            
                
            end

        
        else if (SIG_HAZARDS_D ==1'b0 && SIG_BJ==1'b1 )
            begin
                P_REG1 =1'b1;
                P_REG2=1'b1;
                P_REG_3=1'b0;
                
            end
        else
            begin
                P_REG1 =1'b0;
                P_REG2=1'b0;
                P_REG_3=1'b0;
             end
        
               
    end
    
endmodule