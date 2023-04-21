 /*________________________________________________________________
  |                                                                |
  |  File Name         -alu_tb.v                                   |
  |  Created By        -Group 01                                   |
  |  Project/ Course   -CO502                                      |
  |  Institute         -University of peradeniya                   |
  |  Date              -05.04.2023                                 |
  |  Discription       - Test Bench for ALU Module                 |
  |________________________________________________________________|
  
  */

`include "../Utilities/macros.v" 
`include "../Utilities/encodings_formats.v"
`include "alu.v"

module alu_tb;

    reg CLK, RESET;
    wire [31:0] RESULT;
    reg [31:0] DATA1, DATA2;
    reg [4:0] SELECT;

    alu myalu(DATA1, DATA2, RESULT, SELECT);
    
    initial begin


         $dumpfile("alu_wavedata.vcd");
         $dumpvars(0, alu_tb);
         #1;
         
         //ALU TEST 1 (ADD Opration)-------------------------------
         //SELECT = 00000 ,DATA1 = 5, DATA2=10, RESULT=15
         $display("[TEST1 - ADD Operation ]");
         SELECT = `ADD;
         DATA1 = 32'd5;
         DATA2 = 32'd10;
         #3
         `Verify(RESULT, 32'd15,"ADD");
       

        
         //ALU TEST 2 (SUB Operation)------------------------------
         // DATA1 = 15, DATA2=10, RESULT =5
         $display("[TEST2 - SUB Operation ]");
         SELECT = `SUB;
         DATA1 = 32'd15;
         DATA2 = 32'd10;
         #3
         `Verify(RESULT, 32'd5,"SUB");
         
    
         //TEST 3 SLL OPeration------------------------------------
         //DATA1 = 25, DATA2=2, RESULT= 100
         $display("[TEST3 - SLL Operation ]");
         SELECT = `SLL;
         DATA1 = 32'd25;
         DATA2 = 32'd2;
         #5
        `Verify(RESULT, 32'd100,"SLL");
        
        
         //AlU TEST 4 (XOR Operation)-----------------------------
         // DATA1 = 25, DATA2=2, RESULT= 15
         $display("[TEST4 - XOR Operation ]");
         SELECT = `XOR;
         DATA1 = 32'd10;
         DATA2 = 32'd5;
         #5
         `Verify(RESULT, 32'd15,"XOR");
    

        
         // ALU TEST 5 (SRL Operation)--------------------------
         //DATA1 = 25, DATA2=2, RESULT should be 15
         $display("[TEST5 - SRL Operation ]");
         SELECT = `SRL;
         DATA1 = 32'd32;
         DATA2 = 32'd2;
         #5
         `Verify(RESULT, 32'd8,"SRL");
        
    
         //ALU TEST 6 (SRA Operation)---------------------------
         //DATA1 = -32, DATA2=2, RESULT should be -4
         $display("[TEST6 - SRA Operation ]");
         SELECT = `SRA;
         DATA1 = 32'sd32;
         DATA2 = 32'd2;
         #5
         `Verify(RESULT, 32'sd8,"SRA");  
  
         // ALU TEST 7 (OR Operation)--------------------------
         // DATA1 = 12, DATA2=5, RESULT should be 13
         $display("[TEST7 - OR Operation ]");
         SELECT = `OR;
         DATA1 = 32'd12;
         DATA2 = 32'd5;
         #5
         `Verify(RESULT, 32'd13,"OR");
         
        
         // ALU TEST 8 (MUL Operation)-------------------------
         //DATA1 = 12, DATA2=5, RESULT = 4
         $display("[TEST8 -MUL Operation ]");
         SELECT = `MUL;
         DATA1 = 32'd4;
         DATA2 = 32'd5;
         #5
         `Verify(RESULT, 32'd20,"MUL");
         
         
         // ALU TEST (MULH Operation)--------------------------
         //DATA1 = 131073, DATA2=131073, RESULT should be 4
         // 100000000000000001 × 100000000000000001 = 0100_00000000000001000000000000000001 (UPPER_LOWER32)
         $display("[TEST9 - MULH Operation ]");
         SELECT = `MULH;
         DATA1 = 32'd131073;
         DATA2 = 32'd131073;
         #5
         `Verify(RESULT, 32'd4,"MULH"); 
        
 
         //ALU TEST 10 (DIV Operation)------------------------
         //DATA1 = 32, DATA2=2, RESULT should be 16
         $display("[TEST10 - DIV Operation ]");
         SELECT = `DIV;
         DATA1 = 32'd32;
         DATA2 = 32'd2;  
         #5
         `Verify(RESULT, 32'd16,"DIV");  
        
  
         //ALU TEST 11 (REM Operation)
         //DATA1 = 32, DATA2=2, RESULT should be 16
         $display("[TEST11 - REM Operation ]");
         SELECT = `REM;
         DATA1 = 32'd31;
         DATA2 = 32'd2; 
         #5
         `Verify(RESULT, 32'd1,"REM");
       
        #500
        $finish;
    end

endmodule