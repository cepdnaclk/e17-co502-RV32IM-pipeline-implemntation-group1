 /*________________________________________________________________
  |                                                                |
  |  File Name         -macros.v                                   |
  |  Created By        -Group 01                                   |
  |  Project/ Course   -CO502                                      |
  |  Institute         -University of peradeniya                   |
  |  Date              -05.04.2023                                 |
  |  Discription       -macros for implemetation of RV32IM         |
  |________________________________________________________________|
  
  */


`define Verify(sig, val,op) \
    if (sig !== val) begin \
        $display("Verification faild for %s [Original value - %b  Generated value %b] ( line %0d)",op, val, sig, `__LINE__); \
        $finish; \
    end \
$display("%s Passed!",op);

