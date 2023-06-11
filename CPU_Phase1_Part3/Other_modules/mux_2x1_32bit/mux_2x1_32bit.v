
 /*______________________________________________________________________________
  |                                                                              |
  |  File Name         -mux_2x1-32bit.v                                          |
  |  Created By        -Group1(E17)                                              |
  |  Project/ Course   -CO502                                                    |
  |  Institute         -University of peradeniya                                 |
  |  Date              -05.04.2023                                               |
  |  Discription       -Instruction cache for RV32IM                             |
  |______________________________________________________________________________|
  
  */module mux_2x1_32bit(IN0, IN1, OUT, SELECT);

    //declare the ports
    input [31:0] IN0, IN1;
    input SELECT;
    output reg [31:0] OUT;


    // assign OUT = (SELECT==1'b1) ? IN1 : IN0;
    
    always @ (*) begin
        case (SELECT)
            1'b1: OUT = IN1;
            default: OUT = IN0;
        endcase
    end

endmodule