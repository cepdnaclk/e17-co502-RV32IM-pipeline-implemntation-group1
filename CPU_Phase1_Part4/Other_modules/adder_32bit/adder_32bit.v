 /*______________________________________________________________________________
  |                                                                              |
  |  File Name         -adder_32bit.v                                            |
  |  Created By        -Group1(E17)                                              |
  |  Project/ Course   -CO502                                                    |
  |  Institute         -University of peradeniya                                 |
  |  Date              -05.04.2023                                               |
  |  Discription       -Adder                                                    |
  |______________________________________________________________________________|
  
  */

module adder_32bit(IN1, OUT);

    //declare ports
    input [31:0] IN1;
    output [31:0] OUT;

    //add the input values and assign to output
 
    assign #1 OUT = IN1 + 32'd4;

endmodule