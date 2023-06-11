
 /*________________________________________________________________
  |                                                                |
  |  File Name         -immediate_generate_tb.v                    |
  |  Created By        -Group  01                                  |
  |  Project/ Course   -CO502                                      |
  |  Institute         -University of peradeniya                   |
  |  Date              -05.04.2023                                 |
  |  Discription       -Test bench for immediate_generate_tb.v     |
  |________________________________________________________________|
  
  */
`include "../Utilities/macros.v" 
`include "../Utilities/encodings_formats.v"
`include "immediate_generate.v"

module immediate_generate_tb;

    reg [24:0] IN;            // instruction[31:7] -> 24 bits
    reg [2:0] IMM_SEL;        // immediate select op
    wire [31:0] OUT;      // sign extended 32-bit val

   
    immediate_generate immediate_generate_1(IMM_SEL,IN, OUT );

    initial begin
        
        $dumpfile("immediate_generate_wavedata.vcd");
        $dumpvars(0, immediate_generate_tb);
        
        $display("============================================================================");
        $display("                      IMMEDIATE GENERATION  UNIT TESTING");
        $display("=============================================================================");

        #10
        //=====================================
        //          Test 01 -U type
        //=====================================
        
        
        IN = 25'b10110000001110001000_10100; 
        IMM_SEL = `U_TYPE;
        #1
        `Verify(OUT, 32'b10110000001110001000_000000000000,"U type");

        #5
        //=====================================
        //          Test 01 -J type
        //=====================================
        
        IN = 25'b1_0001101110_1_01001110_01010;
        IMM_SEL = `J_TYPE;
        #1
        `Verify(OUT, 32'b11111111111_01001110_1_0001101110_00,"J type");

        #5
        //=====================================
        //          Test 01 -S type
        //=====================================
        IN = 25'b1010010_01001_10100_010_00101;
        IMM_SEL = `S_TYPE;
        #1
        `Verify(OUT, 32'b11111111111111111111_1010010_00101,"S type");

        #5
         //=====================================
        //          Test 01 -B type
        //=====================================
        IN = 25'b1_010000_11011_10101_110_0101_0;
        IMM_SEL = `B_TYPE;
        #1
        `Verify(OUT, 32'b1111111111111111111_0_010000_0101_00,"B type");
 
        #5
          //=====================================
        //          Test 01 -I_SIGNED type
        //=====================================
        IN = 25'b101001001001_10100_010_00101;
        IMM_SEL = `I_SIGNED_TYPE;
        #1
        `Verify(OUT, 32'b11111111111111111111_101001001001,"I_SIGNED type");


        #5
         //=====================================
        //          Test 01 -I_SHIFT type
        //=====================================
        IN = 25'b1010010_01001_10100_010_00101;
        IMM_SEL = `I_SHIFT_TYPE;
        #1
        `Verify(OUT, 32'b000000000000000000000000000_01001,"I_SHIFT");

        #5
          //=====================================
        //          Test 01 -J type
        //=====================================
        IN = 25'b101001001001_10100_010_00101;
        IMM_SEL = `I_UNSIGNED_TYPE;
        #1
        `Verify(OUT, 32'b00000000000000000000_101001001001,"I_UNSIGNED");
       
        $display("=======================All Test cases Passed !!!=============================");

        $finish;
    end

endmodule