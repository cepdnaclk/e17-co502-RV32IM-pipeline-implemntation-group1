 /*________________________________________________________________
  |                                                                |
  |  File Name         -bj_detect_tb.v                             |
  |  Created By        -Group  01                                  |
  |  Project/ Course   -CO502                                      |
  |  Institute         -University of peradeniya                   |
  |  Date              -05.04.2023                                 |
  |  Discription       -Test bench for branch detection unit       |
  |________________________________________________________________|
  
  */


`include "../Utilities/macros.v"
`include "../Utilities/encodings_formats.v"
`include "bj_detect.v"

`define DECODE_DELAY #3

module bj_detect_tb;
    
    reg [2:0] BRANCH_JUMP;
    reg [31:0] DATA1,DATA2;

    wire PC_SEL;
    wire debugLt, debugEq;
    
    bj_detect bj_detect_module(BRANCH_JUMP, DATA1, DATA2, PC_SEL);

    initial begin



    $display("============================================================================");
    $display("                   BRANCH DETECTION UNIT TESTING");
    $display("=============================================================================");

     //=====================================
     //          Test 01   BEQ
     //=====================================
     // DATA1 = DATA2 (Branch Taken)

     BRANCH_JUMP = `B_BEQ;
     DATA1 = 32'd10;
     DATA2 = 32'd10;

     `DECODE_DELAY
     `Verify(PC_SEL,1,"Test1-  BEQ (Branch taken)");

        
     //=====================================
     //          Test 02 BEQ 
     //=====================================
     // DATA1 != DATA2 (Branch not Taken)

     BRANCH_JUMP = `B_BEQ;
     DATA1 = 32'd15;
     DATA2 = 32'd10;

     `DECODE_DELAY
     `Verify(PC_SEL,0,"Test2-  BEQ (Branch not taken)");

        
     //=====================================
     //          Test 03 BNE
     //=====================================
        // DATA1 != DATA2 (Branch Taken)

        BRANCH_JUMP = `B_BNE;
        DATA1 = 32'd10;
        DATA2 = 32'd11;

        `DECODE_DELAY
        `Verify(PC_SEL,1,"Test3-  BNE (Branch taken)");

     
     //=====================================
     //           Test 04-BNE
     //=====================================
        // DATA1 = DATA2 (Branch not Taken)
        
        BRANCH_JUMP = `B_BNE;
        DATA1 = 32'd10;
        DATA2 = 32'd10;

        `DECODE_DELAY
        `Verify(PC_SEL,0,"Test4-  BNE (Branch not taken)");

          
     //=====================================
     //            Test 05 -No branch
     //=====================================
        
        BRANCH_JUMP = `B_NO;
        DATA1 = 32'dx;
        DATA2 = 32'dx;

        `DECODE_DELAY
        `Verify(PC_SEL,0,"Test5-  NO branch/jump test");


     //=====================================
     //          Test 06 -J
     //=====================================
        
        BRANCH_JUMP = `B_J;
        DATA1 = 32'dx;
        DATA2 = 32'dx;

        `DECODE_DELAY
        `Verify(PC_SEL,1,"Test6-  J Test");


         
     //=====================================
     //            Test 07-BLT
     //=====================================
        // DATA1 < DATA2 (Branch Taken)
        
        BRANCH_JUMP = `B_BLT;
        DATA1 = 32'd10;
        DATA2 = 32'd15;

        `DECODE_DELAY
        `Verify(PC_SEL,1,"Test7-  BLT (Branch taken)");

          
     //=====================================
     //         Test 08-BLT
     //=====================================
        // DATA1 > DATA2 (Branch not Taken)
        
        BRANCH_JUMP = `B_BLT;
        DATA1 = 32'd15;
        DATA2 = 32'd10;

        `DECODE_DELAY 
        `Verify(PC_SEL,0,"Test8-  BLT (Branch not taken)");

     //=====================================
     //          Test 09
     //=====================================
        // DATA1 = DATA2 (Branch Taken)
        
        BRANCH_JUMP = `B_BLT;
        DATA1 = 32'd10;
        DATA2 = 32'd10;

        `DECODE_DELAY
        `Verify(PC_SEL,0,"Test9-  BLT (Branch taken taken)");
         
     //=====================================
     //            Test 10-BGE
     //=====================================
        // DATA1 > DATA2 (Branch Taken)
        
        BRANCH_JUMP = `B_BGE;
        DATA1 = 32'd15;
        DATA2 = 32'd10;

        `DECODE_DELAY
        `Verify(PC_SEL,1,"Test10- BGE (Branch  taken)");
         
     //=====================================
     //           Test 11-BGE
     //=====================================
        // DATA1 = DATA2 (Branch Taken)
        
        BRANCH_JUMP = `B_BGE;
        DATA1 = 32'd10;
        DATA2 = 32'd10;

        `DECODE_DELAY
        `Verify(PC_SEL,1,"Test11- BGE (Branch  taken)");

     //=====================================
     //           Test 12-BGE
     //=====================================
        // DATA1 < DATA2 (Branch not Taken)
        
        BRANCH_JUMP = `B_BGE;
        DATA1 = 32'd10;
        DATA2 = 32'd15;

        `DECODE_DELAY
        `Verify(PC_SEL,0,"Test12- BGE (Branch not taken)");
         
     //=====================================
     //        Test 13-BLTU
     //=====================================
        // DATA1 < DATA2 (Branch Taken)
        
        BRANCH_JUMP = `B_BLTU;
        DATA1 = 32'h0003;
        DATA2 = 32'h8004;

        `DECODE_DELAY
        `Verify(PC_SEL,1,"Test13- BLTU (Branch  taken)");

     //=====================================
     //        Test 14-BLTU
     //=====================================
        // DATA1 > DATA2 (Branch not Taken)
        
        BRANCH_JUMP = `B_BLTU;
        DATA1 = 32'h8004;
        DATA2 = 32'h0003;

        `DECODE_DELAY
        `Verify(PC_SEL,0,"Test14- BLTU (Branch not taken)");

     //=====================================
     //           Test 15-BLTU
     //=====================================
        // DATA1 = DATA2 (Branch not Taken)
        
        BRANCH_JUMP = `B_BLTU;
        DATA1 = 32'h8004;
        DATA2 = 32'h8004;

        `DECODE_DELAY
        `Verify(PC_SEL,0,"Test15- BLTU (Branch not taken)");
     //=====================================
     //            Test 16-BGEU
     //=====================================
        // DATA1 > DATA2 (Branch Taken)
        
        BRANCH_JUMP = `B_BGEU;
        DATA1 = 32'h8005;
        DATA2 = 32'h8004;

        `DECODE_DELAY
        `Verify(PC_SEL,1,"Test16- BGEU (Branch taken)");

       
     //=====================================
     //          Test 17-BGEU
     //=====================================
        // DATA1 = DATA2 (Branch Taken)
        
        BRANCH_JUMP = `B_BGEU;
        DATA1 = 32'h8005;
        DATA2 = 32'h8005;

        `DECODE_DELAY
        `Verify(PC_SEL,1,"Test17- BGEU (Branch taken)");

     //=====================================
     //            Test 18-BGEU
     //=====================================
        // DATA1 < DATA2 (Branch not Taken)
        
        BRANCH_JUMP = `B_BGEU;
        DATA1 = 32'h8004;
        DATA2 = 32'h8005;

        `DECODE_DELAY
        `Verify(PC_SEL,0,"Test18- BGEU (Branch not taken)");
        
        $display("========================All Test cases Passed !!!==============================");

    
    end

endmodule