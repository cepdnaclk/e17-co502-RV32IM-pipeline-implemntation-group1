
 /*______________________________________________________________________________
  |                                                                              |
  |  File Name         -mux_4x1-32bit.v                                          |
  |  Created By        -Group1(E17)                                              |
  |  Project/ Course   -CO502                                                    |
  |  Institute         -University of peradeniya                                 |
  |  Date              -05.04.2023                                               |
  |  Discription       -Mux                                                      |
  |______________________________________________________________________________|
  
*/
module mux_4x1_32bit(IN0, IN1, IN2, IN3, OUT, SELECT);

    //declare the ports
    input [31:0] IN0, IN1, IN2, IN3;
    input [1:0] SELECT;
    output reg [31:0] OUT;

    
    // assign OUT = (SELECT == 2'b11) ? IN3 : (SELECT == 2'b10) ? IN2 : (SELECT == 2'b01) ? IN1 : IN0;

    always @ (*) begin
        case (SELECT)
            2'b11: OUT = IN3;
            2'b10: OUT = IN2;
            2'b01: OUT = IN1;
            default: OUT = IN0;
        endcase
    end

endmodule