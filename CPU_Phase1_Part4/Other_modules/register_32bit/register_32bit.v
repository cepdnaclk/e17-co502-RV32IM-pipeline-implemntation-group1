
 /*______________________________________________________________________________
  |                                                                              |
  |  File Name         -register_32bit.v                                         |
  |  Created By        -Group1(E17)                                              |
  |  Project/ Course   -CO502                                                    |
  |  Institute         -University of peradeniya                                 |
  |  Date              -05.04.2023                                               |
  |  Discription       -Register                                                 |
  |______________________________________________________________________________|
  
*/module register_32bit (IN, OUT, RESET, CLK, BUSYWAIT);

    //declare the ports
    input [31:0] IN;
    input RESET, CLK, BUSYWAIT;
    output reg [31:0] OUT;

    //reset the register to -4 whenever the reset signal changes from low to high
    //resetting has a #1 delay
    always @ (RESET) begin
        if (RESET) #1 OUT = -32'd4;
    end

    
    always @ (posedge CLK) begin
        #1
        if (!RESET & !BUSYWAIT)  OUT = IN;
    end

endmodule