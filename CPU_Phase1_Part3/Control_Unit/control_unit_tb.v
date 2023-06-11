
/*______________________________________________________________________________
  |                                                                              |
  |  File Name         -Control_unit_tb_G1.v                                        |
  |  Created By        -Tharindu Rathnayaka (E/17/286) /Dhushintha R (E/17/064)  |
  |  Project/ Course   -CO502                                                    |
  |  Institute         -University of peradeniya                                 |
  |  Date              -05.04.2023                                               |
  |  Discription       -Control Unit module for RV32IM                                                         |
  |______________________________________________________________________________|
  
  */
/*====== CONTROL SIGNALS=======

 IMM_SEL      -
 ALU_SEL1     -
 ALU_SEL2     -
 ALU_OP       -
 BRANCH       -
 MEM_WRITE    -
 MEM_READ     -
 WB_SELEC     -
 WRITE_EN     -
 ==============================
*/



`include "../Utilities/macros.v"
`include "../Utilities/encodings_formats.v"
`include "control_unit.v"



`define DECODE_DELAY #2

module control_unit_tb;

   
    
    reg [6:0] OPCODE;
    reg [2:0] FUNCT3;
    reg [6:0] FUNCT7;
    
    wire ALU_SEL1, ALU_SEL2, WRITE_EN;
    wire [1:0] WB_SEL,MEM_WRITE;
    wire [4:0] ALU_OP;
    wire [2:0] BRANCH, IMM_SEL;
    wire [2:0] MEM_READ;
    wire CLK,RESET;
    
    control_unit my_control_unit(OPCODE, FUNCT3, FUNCT7,CLK,RESET, IMM_SEL ,ALU_SEL1, ALU_SEL2,ALU_OP, BRANCH, MEM_WRITE,MEM_READ, WB_SEL,WRITE_EN);

    initial begin

    
        //=========================================
        //              TEST CASES
        //=========================================

         $display("==============================================================");
                               $display("Tests start");
        $display("==============================================================");


        // LUI
        $display("================================");
        $display("Test 1 : LUI Control Signal Test");
        $display("================================");
        OPCODE = `LUI_OP;
        FUNCT3 = 3'bxxx;
        FUNCT7 = 7'bxxxxxxx;
        `DECODE_DELAY
        #0;
        `Verify(IMM_SEL,`U_TYPE,"IMM SEL");
        //`Verify(ALU_SEL1,1'bx,"ALU_SEL1");
        //`Verify(ALU_SEL2,1'bx,"ALU_SEL2");
        //`Verify(ALU_OP,5'bxxxxx,"ALU_OP");
        `Verify(WRITE_EN,`EN,"REG_WRITE");
        `Verify(WB_SEL,`IMM_WB,"WB_SEL");
        `Verify(BRANCH,`B_NO,"BRANCH");
        `Verify(MEM_WRITE,`NO_R,"MEM_WRITE");
        `Verify(MEM_READ,`NO_W,"MEME_READ");
        
         

        // AUIPC---------------------------------------
         $display("================================");
         $display("Test 2 : AUIPC Control Signal Test");
         $display("================================");
         OPCODE = `AUIPC_OP;
         FUNCT3 = 3'bxxx;
         FUNCT7 = 7'bxxxxxxx;
         `DECODE_DELAY
         #0;
         `Verify(IMM_SEL,`U_TYPE,"IME_SEL");
         //`Verify(ALU_SEL1,`PC,"ALU_SEL1");
         `Verify(ALU_SEL2,`IMM,"IME_SE2");
         `Verify(ALU_OP,`ADD,"ALU_OP");
         `Verify(WRITE_EN,`EN,"WRITE_EN");
         `Verify(WB_SEL,`ALU,"WB_SEL");
         `Verify(BRANCH,`B_NO,"BRANCH");
         `Verify(MEM_WRITE,`NO_W,"MEM_WRITE");
         `Verify(MEM_READ,`NO_R,"MEM_READ");

        
         // JAL---------------------------------------
         $display("================================");
         $display("Test 3 : JAL Control Signal Test");
         $display("================================");
         OPCODE = `JAL_OP;
         FUNCT3 = 3'bxxx;
         FUNCT7 = 7'bxxxxxxx;
         `DECODE_DELAY
         #0;
          `Verify(IMM_SEL,`J_TYPE,"IME_SEL");
         `Verify(ALU_SEL1,`PC,"ALU_SEL1");
         `Verify(ALU_SEL2,`IMM,"IME_SE2");
         `Verify(ALU_OP,`ADD,"ALU_OP");
         `Verify(WRITE_EN,`EN,"WRITE_EN");
         `Verify(WB_SEL,`PC_4,"WB_SEL");
         `Verify(BRANCH,`B_NO,"BRANCH");
         `Verify(MEM_WRITE,`NO_W,"MEM_WRITE");
         `Verify(MEM_READ,`NO_R,"MEM_READ");

        
    /*
        // JALR
        $display("================================");
        $display("Test 4 : JALR Control Signal Test");
        $display("================================");

        OPCODE = `JALR_OP;
        FUNCT3 = 3'b000;
        FUNCT7 = 7'bxxxxxxx;
        `DECODE_DELAY
        #0;
        `Verify(IMM_SEL,`J_TYPE,"IME_SEL");
         `Verify(ALU_SEL1,`PC,"ALU_SEL1");
         `Verify(ALU_SEL2,`IMM,"IME_SE2");
         `Verify(ALU_OP,`ADD,"ALU_OP");
         `Verify(WRITE_EN,`EN,"WRITE_EN");
         `Verify(WB_SEL,`PC_4,"WB_SEL");
         `Verify(BRANCH,`B_NO,"BRANCH");
         `Verify(MEM_WRITE,`NO_W,"MEM_WRITE");
         `Verify(MEM_READ,`NO_R,"MEM_READ");
        
        
*/
        // BEQ
        $display("================================");
        $display("Test 5 : BEQ Control Signal Test");
        $display("================================");
        OPCODE = `B_TYPE_OP;
        FUNCT3 = 3'b000;
        FUNCT7 = 7'bxxxxxxx;
        `DECODE_DELAY
        #0;
        `Verify(IMM_SEL,`B_TYPE,"IME_SEL");
         `Verify(ALU_SEL1,`PC,"ALU_SEL1");
         `Verify(ALU_SEL2,`IMM,"IME_SE2");
         `Verify(ALU_OP,`ADD,"ALU_OP");
         `Verify(WRITE_EN,`DIS,"WRITE_EN");
        // `Verify(WB_SEL,`PC_4,"WB_SEL");
         `Verify(BRANCH,`B_BEQ,"BRANCH");
         `Verify(MEM_WRITE,`NO_W,"MEM_WRITE");
         `Verify(MEM_READ,`NO_R,"MEM_READ");

        

        // BNE
        $display("================================");
        $display("Test 6 : BNE Control Signal Test");
        $display("================================");
        OPCODE = `B_TYPE_OP;
        FUNCT3 = 3'b001;
        FUNCT7 = 7'bxxxxxxx;
        `DECODE_DELAY
        #0;
       `Verify(IMM_SEL,`B_TYPE,"IME_SEL");
         `Verify(ALU_SEL1,`PC,"ALU_SEL1");
         `Verify(ALU_SEL2,`IMM,"IME_SE2");
         `Verify(ALU_OP,`ADD,"ALU_OP");
         `Verify(WRITE_EN,`DIS,"WRITE_EN");
         //`Verify(WB_SEL,`PC_4,"WB_SEL");
         `Verify(BRANCH,`B_BNE,"BRANCH");
         `Verify(MEM_WRITE,`NO_W,"MEM_WRITE");
         `Verify(MEM_READ,`NO_R,"MEM_READ");

        
        // BLT
        $display("================================");
        $display("Test 7 : BLT Control Signal Test");
        $display("================================");
        OPCODE = `B_TYPE_OP;
        FUNCT3 = 3'b100;
        FUNCT7 = 7'bxxxxxxx;
        `DECODE_DELAY
        #0;
        `Verify(IMM_SEL,`B_TYPE,"IME_SEL");
         `Verify(ALU_SEL1,`PC,"ALU_SEL1");
         `Verify(ALU_SEL2,`IMM,"IME_SE2");
         `Verify(ALU_OP,`ADD,"ALU_OP");
         `Verify(WRITE_EN,`DIS,"WRITE_EN");
        // `Verify(WB_SEL,`PC_4,"WB_SEL");
         `Verify(BRANCH,`B_BLT,"BRANCH");
         `Verify(MEM_WRITE,`NO_W,"MEM_WRITE");
         `Verify(MEM_READ,`NO_R,"MEM_READ");

     

        // BGE
        $display("================================");
        $display("Test 8 : BGE Control Signal Test");
        $display("================================");
        OPCODE = `B_TYPE_OP;
        FUNCT3 = 3'b101;
        FUNCT7 = 7'bxxxxxxx;
        `DECODE_DELAY
        #0;
      `Verify(IMM_SEL,`B_TYPE,"IME_SEL");
         `Verify(ALU_SEL1,`PC,"ALU_SEL1");
         `Verify(ALU_SEL2,`IMM,"IME_SE2");
         `Verify(ALU_OP,`ADD,"ALU_OP");
         `Verify(WRITE_EN,`DIS,"WRITE_EN");
         //`Verify(WB_SEL,`PC_4,"WB_SEL");
         `Verify(BRANCH,`B_BGE,"BRANCH");
         `Verify(MEM_WRITE,`NO_W,"MEM_WRITE");
         `Verify(MEM_READ,`NO_R,"MEM_READ");

        
        

        // BLTU
        $display("================================");
        $display("Test 9 : BLTU Control Signal Test");
        $display("================================");
        OPCODE = `B_TYPE_OP;
        FUNCT3 = 3'b110;
        FUNCT7 = 7'bxxxxxxx;
        `DECODE_DELAY
        #0;
       `Verify(IMM_SEL,`B_TYPE,"IME_SEL");
         `Verify(ALU_SEL1,`PC,"ALU_SEL1");
         `Verify(ALU_SEL2,`IMM,"IME_SE2");
         `Verify(ALU_OP,`ADD,"ALU_OP");
         `Verify(WRITE_EN,`DIS,"WRITE_EN");
        // `Verify(WB_SEL,`PC_4,"WB_SEL");
         `Verify(BRANCH,`B_BLTU,"BRANCH");
         `Verify(MEM_WRITE,`NO_W,"MEM_WRITE");
         `Verify(MEM_READ,`NO_R,"MEM_READ");

      

        // BGEU
        $display("================================");
        $display("Test 10 : BGEU Control Signal Test");
        $display("================================");
        OPCODE = `B_TYPE_OP;
        FUNCT3 = 3'b111;
        FUNCT7 = 7'bxxxxxxx;
        `DECODE_DELAY
        #0;
       `Verify(IMM_SEL,`B_TYPE,"IME_SEL");
         `Verify(ALU_SEL1,`PC,"ALU_SEL1");
         `Verify(ALU_SEL2,`IMM,"IME_SE2");
         `Verify(ALU_OP,`ADD,"ALU_OP");
         `Verify(WRITE_EN,`DIS,"WRITE_EN");
         //`Verify(WB_SEL,`PC_4,"WB_SEL");
         `Verify(BRANCH,`B_BGEU,"BRANCH");
         `Verify(MEM_WRITE,`NO_W,"MEM_WRITE");
         `Verify(MEM_READ,`NO_R,"MEM_READ");

        
        

        // LB
        $display("================================");
        $display("Test 11 : LB Control Signal Test");
        $display("================================");
        OPCODE = `LOAD_OP;
        FUNCT3 = 3'b000;
        FUNCT7 = 7'bxxxxxxx;
        `DECODE_DELAY
        #0;
       `Verify(IMM_SEL,`I_TYPE,"IME_SEL");
         `Verify(ALU_SEL1,`DATA1,"ALU_SEL1");
         `Verify(ALU_SEL2,`IMM,"IME_SE2");
         `Verify(ALU_OP,`ADD,"ALU_OP");
         `Verify(WRITE_EN,`EN,"WRITE_EN");
         `Verify(WB_SEL,`ALU,"WB_SEL");
         `Verify(BRANCH,`B_NO,"BRANCH");
         `Verify(MEM_WRITE,`NO_W,"MEM_WRITE");
         `Verify(MEM_READ,`MR_LB,"MEM_READ");

   
        // LH
        $display("================================");
        $display("Test 12 : LH Control Signal Test");
        $display("================================");
        OPCODE = `LOAD_OP;
        FUNCT3 = 3'b001;
        FUNCT7 = 7'bxxxxxxx;
        `DECODE_DELAY
        #0;
       `Verify(IMM_SEL,`I_TYPE,"IME_SEL");
         `Verify(ALU_SEL1,`DATA1,"ALU_SEL1");
         `Verify(ALU_SEL2,`IMM,"IME_SE2");
         `Verify(ALU_OP,`ADD,"ALU_OP");
         `Verify(WRITE_EN,`EN,"WRITE_EN");
         `Verify(WB_SEL,`ALU,"WB_SEL");
         `Verify(BRANCH,`B_NO,"BRANCH");
         `Verify(MEM_WRITE,`NO_W,"MEM_WRITE");
         `Verify(MEM_READ,`MR_LH,"MEM_READ");

     

        // LW
        $display("================================");
        $display("Test 13 : LW Control Signal Test");
        $display("================================");
        OPCODE = `LOAD_OP;
        FUNCT3 = 3'b010;
        FUNCT7 = 7'bxxxxxxx;
        `DECODE_DELAY
        #0;
       `Verify(IMM_SEL,`I_TYPE,"IME_SEL");
         `Verify(ALU_SEL1,`DATA1,"ALU_SEL1");
         `Verify(ALU_SEL2,`IMM,"IME_SE2");
         `Verify(ALU_OP,`ADD,"ALU_OP");
         `Verify(WRITE_EN,`EN,"WRITE_EN");
         `Verify(WB_SEL,`ALU,"WB_SEL");
         `Verify(BRANCH,`B_NO,"BRANCH");
         `Verify(MEM_WRITE,`NO_W,"MEM_WRITE");
         `Verify(MEM_READ,`MR_LW,"MEM_READ");
  

        // LBU
        $display("================================");
        $display("Test 14 : LBU Control Signal Test");
        $display("================================");
        OPCODE = `LOAD_OP;
        FUNCT3 = 3'b011;
        FUNCT7 = 7'bxxxxxxx;
        `DECODE_DELAY
        #0;
      `Verify(IMM_SEL,`I_TYPE,"IME_SEL");
         `Verify(ALU_SEL1,`DATA1,"ALU_SEL1");
         `Verify(ALU_SEL2,`IMM,"IME_SE2");
         `Verify(ALU_OP,`ADD,"ALU_OP");
         `Verify(WRITE_EN,`EN,"WRITE_EN");
         `Verify(WB_SEL,`ALU,"WB_SEL");
         `Verify(BRANCH,`B_NO,"BRANCH");
         `Verify(MEM_WRITE,`NO_W,"MEM_WRITE");
         `Verify(MEM_READ,`MR_LBU,"MEM_READ");

        
       

        // LHU
        $display("================================");
        $display("Test 15 : LHU Control Signal Test");
        $display("================================");
        OPCODE = `LOAD_OP;
        FUNCT3 = 3'b100;
        FUNCT7 = 7'bxxxxxxx;
        `DECODE_DELAY
        #0;
       `Verify(IMM_SEL,`I_TYPE,"IME_SEL");
         `Verify(ALU_SEL1,`DATA1,"ALU_SEL1");
         `Verify(ALU_SEL2,`IMM,"IME_SE2");
         `Verify(ALU_OP,`ADD,"ALU_OP");
         `Verify(WRITE_EN,`EN,"WRITE_EN");
         `Verify(WB_SEL,`ALU,"WB_SEL");
         `Verify(BRANCH,`B_NO,"BRANCH");
         `Verify(MEM_WRITE,`NO_W,"MEM_WRITE");
         `Verify(MEM_READ,`MR_LHU,"MEM_READ");

     

        // SB
        $display("================================");
        $display("Test 16 : SB Control Signal Test");
        $display("================================");
        OPCODE = `STORE_OP;
        FUNCT3 = 3'b000;
        FUNCT7 = 7'bxxxxxxx;
        `DECODE_DELAY
        #0;
        `Verify(IMM_SEL,`S_TYPE,"IME_SEL");
         `Verify(ALU_SEL1,`DATA1,"ALU_SEL1");
         `Verify(ALU_SEL2,`IMM,"IME_SE2");
         `Verify(ALU_OP,`ADD,"ALU_OP");
         `Verify(WRITE_EN,`DIS,"WRITE_EN");
         `Verify(WB_SEL,`ALU,"WB_SEL");
         `Verify(BRANCH,`B_NO,"BRANCH");
         `Verify(MEM_WRITE,`MW_SB,"MEM_WRITE");
         `Verify(MEM_READ,`NO_R,"MEM_READ");

        
       

        // SH
        $display("================================");
        $display("Test 17 : SH Control Signal Test");
        $display("================================");
        OPCODE = `STORE_OP;
        FUNCT3 = 3'b001;
        FUNCT7 = 7'bxxxxxxx;
        `DECODE_DELAY
        #0;
       `Verify(IMM_SEL,`S_TYPE,"IME_SEL");
         `Verify(ALU_SEL1,`DATA1,"ALU_SEL1");
         `Verify(ALU_SEL2,`IMM,"IME_SE2");
         `Verify(ALU_OP,`ADD,"ALU_OP");
         `Verify(WRITE_EN,`DIS,"WRITE_EN");
         `Verify(WB_SEL,`ALU,"WB_SEL");
         `Verify(BRANCH,`B_NO,"BRANCH");
         `Verify(MEM_WRITE,`MW_SH,"MEM_WRITE");
         `Verify(MEM_READ,`NO_R,"MEM_READ");


        

        // SW
        $display("================================");
        $display("Test 18 : SW Control Signal Test");
        $display("================================");
        OPCODE = `STORE_OP;
        FUNCT3 = 3'b010;
        FUNCT7 = 7'bxxxxxxx;
        `DECODE_DELAY
        #0;
       `Verify(IMM_SEL,`S_TYPE,"IME_SEL");
         `Verify(ALU_SEL1,`DATA1,"ALU_SEL1");
         `Verify(ALU_SEL2,`IMM,"IME_SE2");
         `Verify(ALU_OP,`ADD,"ALU_OP");
         `Verify(WRITE_EN,`DIS,"WRITE_EN");
         `Verify(WB_SEL,`ALU,"WB_SEL");
         `Verify(BRANCH,`B_NO,"BRANCH");
         `Verify(MEM_WRITE,`MW_SW,"MEM_WRITE");
         `Verify(MEM_READ,`NO_R,"MEM_READ");


        

        // ADDI
        $display("================================");
        $display("Test 19 : ADDI Control Signal Test");
        $display("================================");
        OPCODE = `I_TYPE_OP;
        FUNCT3 = 3'b000;
        FUNCT7 = 7'bxxxxxxx;
        `DECODE_DELAY
        #0;
      `Verify(IMM_SEL,`I_TYPE,"IME_SEL");
         `Verify(ALU_SEL1,`DATA1,"ALU_SEL1");
         `Verify(ALU_SEL2,`IMM,"IME_SE2");
         `Verify(ALU_OP,`ADD,"ALU_OP");
         `Verify(WRITE_EN,`EN,"WRITE_EN");
         `Verify(WB_SEL,`ALU,"WB_SEL");
         `Verify(BRANCH,`B_NO,"BRANCH");
         `Verify(MEM_WRITE,`NO_W,"MEM_WRITE");
         `Verify(MEM_READ,`NO_R,"MEM_READ");

        // SLTI
        $display("================================");
        $display("Test 20 : SLTI Control Signal Test");
        $display("================================");
        OPCODE = `I_TYPE_OP;
        FUNCT3 = 3'b010;
        FUNCT7 = 7'bxxxxxxx;
        `DECODE_DELAY
        #0;
        `Verify(IMM_SEL,`I_TYPE,"IME_SEL");
         `Verify(ALU_SEL1,`DATA1,"ALU_SEL1");
         `Verify(ALU_SEL2,`IMM,"IME_SE2");
         `Verify(ALU_OP,`SLT,"ALU_OP");
         `Verify(WRITE_EN,`EN,"WRITE_EN");
         `Verify(WB_SEL,`ALU,"WB_SEL");
         `Verify(BRANCH,`B_NO,"BRANCH");
         `Verify(MEM_WRITE,`NO_W,"MEM_WRITE");
         `Verify(MEM_READ,`NO_R,"MEM_READ");

        // SLTIU
        $display("================================");
        $display("Test 21 : SLTIU Control Signal Test");
        $display("================================");
        OPCODE = `I_TYPE_OP;
        
        FUNCT3 = 3'b011;
        FUNCT7 = 7'bxxxxxxx;
        `DECODE_DELAY
        #0;
       `Verify(IMM_SEL,`I_UNSIGNED_TYPE,"IME_SEL");
         `Verify(ALU_SEL1,`DATA1,"ALU_SEL1");
         `Verify(ALU_SEL2,`IMM,"IME_SE2");
         `Verify(ALU_OP,`SLTU,"ALU_OP");
         `Verify(WRITE_EN,`EN,"WRITE_EN");
         `Verify(WB_SEL,`ALU,"WB_SEL");
         `Verify(BRANCH,`B_NO,"BRANCH");
         `Verify(MEM_WRITE,`NO_W,"MEM_WRITE");
         `Verify(MEM_READ,`NO_R,"MEM_READ");

      
        
        // XORI
        $display("================================");
        $display("Test 22 : XORI Control Signal Test");
        $display("================================");
        OPCODE = `I_TYPE_OP;
        FUNCT3 = 3'b100;
        FUNCT7 = 7'bxxxxxxx;
        `DECODE_DELAY
        #0;
         `Verify(IMM_SEL,`I_TYPE,"IME_SEL");
         `Verify(ALU_SEL1,`DATA1,"ALU_SEL1");
         `Verify(ALU_SEL2,`IMM,"IME_SE2");
         `Verify(ALU_OP,`XOR,"ALU_OP");
         `Verify(WRITE_EN,`EN,"WRITE_EN");
         `Verify(WB_SEL,`ALU,"WB_SEL");
         `Verify(BRANCH,`B_NO,"BRANCH");
         `Verify(MEM_WRITE,`NO_W,"MEM_WRITE");
         `Verify(MEM_READ,`NO_R,"MEM_READ");
        
        
        // ORI
        $display("================================");
        $display("Test 23 : ORI Control Signal Test");
        $display("================================");
        OPCODE = `I_TYPE_OP;
        FUNCT3 = 3'b110;
        FUNCT7 = 7'bxxxxxxx;
        `DECODE_DELAY
        #0;
        `Verify(IMM_SEL,`I_TYPE,"IME_SEL");
         `Verify(ALU_SEL1,`DATA1,"ALU_SEL1");
         `Verify(ALU_SEL2,`IMM,"IME_SE2");
         `Verify(ALU_OP,`OR,"ALU_OP");
         `Verify(WRITE_EN,`EN,"WRITE_EN");
         `Verify(WB_SEL,`ALU,"WB_SEL");
         `Verify(BRANCH,`B_NO,"BRANCH");
         `Verify(MEM_WRITE,`NO_W,"MEM_WRITE");
         `Verify(MEM_READ,`NO_R,"MEM_READ");

    

        // ANDI
        $display("================================");
        $display("Test 24 : ANDI Control Signal Test");
        $display("================================");
        OPCODE = `I_TYPE_OP;
        FUNCT3 = 3'b111;
        FUNCT7 = 7'bxxxxxxx;
        `DECODE_DELAY
        #0;
      `Verify(IMM_SEL,`I_TYPE,"IME_SEL");
         `Verify(ALU_SEL1,`DATA1,"ALU_SEL1");
         `Verify(ALU_SEL2,`IMM,"IME_SE2");
         `Verify(ALU_OP,`AND,"ALU_OP");
         `Verify(WRITE_EN,`EN,"WRITE_EN");
         `Verify(WB_SEL,`ALU,"WB_SEL");
         `Verify(BRANCH,`B_NO,"BRANCH");
         `Verify(MEM_WRITE,`NO_W,"MEM_WRITE");
         `Verify(MEM_READ,`NO_R,"MEM_READ");

        


        // SLLI
        $display("================================");
        $display("Test 25 : SLLI Control Signal Test");
        $display("================================");
        OPCODE = `I_TYPE_OP;
        FUNCT3 = 3'b001;
        FUNCT7 = 7'bxxxxxxx;
        `DECODE_DELAY
        #0;
        `Verify(IMM_SEL,`I_SHIFT_TYPE,"IME_SEL");
         `Verify(ALU_SEL1,`DATA1,"ALU_SEL1");
         `Verify(ALU_SEL2,`IMM,"IME_SE2");
         `Verify(ALU_OP,`SLL,"ALU_OP");
         `Verify(WRITE_EN,`EN,"WRITE_EN");
         `Verify(WB_SEL,`ALU,"WB_SEL");
         `Verify(BRANCH,`B_NO,"BRANCH");
         `Verify(MEM_WRITE,`NO_W,"MEM_WRITE");
         `Verify(MEM_READ,`NO_R,"MEM_READ");
        // SRLI
        $display("================================");
        $display("Test 26 : SRLI Control Signal Test");
        $display("================================");
        OPCODE = `I_TYPE_OP;
        FUNCT3 = 3'b101;
        FUNCT7 = 7'b0000000;
        `DECODE_DELAY
        #0;
       `Verify(IMM_SEL,`I_SHIFT_TYPE,"IME_SEL");
         `Verify(ALU_SEL1,`DATA1,"ALU_SEL1");
         `Verify(ALU_SEL2,`IMM,"IME_SE2");
         `Verify(ALU_OP,`SRL,"ALU_OP");
         `Verify(WRITE_EN,`EN,"WRITE_EN");
         `Verify(WB_SEL,`ALU,"WB_SEL");
         `Verify(BRANCH,`B_NO,"BRANCH");
         `Verify(MEM_WRITE,`NO_W,"MEM_WRITE");
         `Verify(MEM_READ,`NO_R,"MEM_READ");

        
       
        // SRAI
        $display("================================");
        $display("Test 27 : SRAI Control Signal Test");
        $display("================================");
        OPCODE = `I_TYPE_OP;
        FUNCT3 = 3'b101;
        FUNCT7 = 7'b0100000;
        `DECODE_DELAY
        #0;
        `Verify(IMM_SEL,`I_SHIFT_TYPE,"IME_SEL");
         `Verify(ALU_SEL1,`DATA1,"ALU_SEL1");
         `Verify(ALU_SEL2,`IMM,"IME_SE2");
         `Verify(ALU_OP,`SRA,"ALU_OP");
         `Verify(WRITE_EN,`EN,"WRITE_EN");
         `Verify(WB_SEL,`ALU,"WB_SEL");
         `Verify(BRANCH,`B_NO,"BRANCH");
         `Verify(MEM_WRITE,`NO_W,"MEM_WRITE");
         `Verify(MEM_READ,`NO_R,"MEM_READ");
        
       

        // ADD
        $display("================================");
        $display("Test 28 : ADD Control Signal Test");
        $display("================================");
        OPCODE = `R_TYPE_OP;
        FUNCT3 = 3'b000;
        FUNCT7 = 7'b0000000;
        `DECODE_DELAY
        #0;
       `Verify(IMM_SEL,`U_TYPE,"IME_SEL");
         `Verify(ALU_SEL1,`DATA1,"ALU_SEL1");
         `Verify(ALU_SEL2,`DATA2,"IME_SE2");
         `Verify(ALU_OP,`ADD,"ALU_OP");
         `Verify(WRITE_EN,`EN,"WRITE_EN");
         `Verify(WB_SEL,`ALU,"WB_SEL");
         `Verify(BRANCH,`B_NO,"BRANCH");
         `Verify(MEM_WRITE,`NO_W,"MEM_WRITE");
         `Verify(MEM_READ,`NO_R,"MEM_READ");


        // SUB
        $display("================================");
        $display("Test 29 : SUB Control Signal Test");
        $display("================================");
        OPCODE = `R_TYPE_OP;
        FUNCT3 = 3'b000;
        FUNCT7 = 7'b0100000;
        `DECODE_DELAY
        #0;
     `Verify(IMM_SEL,`U_TYPE,"IME_SEL");
         `Verify(ALU_SEL1,`DATA1,"ALU_SEL1");
         `Verify(ALU_SEL2,`DATA2,"IME_SE2");
         `Verify(ALU_OP,`SUB,"ALU_OP");
         `Verify(WRITE_EN,`EN,"WRITE_EN");
         `Verify(WB_SEL,`ALU,"WB_SEL");
         `Verify(BRANCH,`B_NO,"BRANCH");
         `Verify(MEM_WRITE,`NO_W,"MEM_WRITE");
         `Verify(MEM_READ,`NO_R,"MEM_READ");

        // SLL
        $display("================================");
        $display("Test 30 : SLL Control Signal Test");
        $display("================================");
        OPCODE = `R_TYPE_OP;
        FUNCT3 = 3'b001;
        FUNCT7 = 7'b0000000;
        `DECODE_DELAY
        #0;
       `Verify(IMM_SEL,`U_TYPE,"IME_SEL");
         `Verify(ALU_SEL1,`DATA1,"ALU_SEL1");
         `Verify(ALU_SEL2,`DATA2,"IME_SE2");
         `Verify(ALU_OP,`SLL,"ALU_OP");
         `Verify(WRITE_EN,`EN,"WRITE_EN");
         `Verify(WB_SEL,`ALU,"WB_SEL");
         `Verify(BRANCH,`B_NO,"BRANCH");
         `Verify(MEM_WRITE,`NO_W,"MEM_WRITE");
         `Verify(MEM_READ,`NO_R,"MEM_READ");
        
   

        // SLT
        $display("================================");
        $display("Test 31 : SLT Control Signal Test");
        $display("================================");
        OPCODE = `R_TYPE_OP;
        FUNCT3 = 3'b010;
        FUNCT7 = 7'b0000000;
        `DECODE_DELAY
        #0;
    `Verify(IMM_SEL,`U_TYPE,"IME_SEL");
         `Verify(ALU_SEL1,`DATA1,"ALU_SEL1");
         `Verify(ALU_SEL2,`DATA2,"IME_SE2");
         `Verify(ALU_OP,`SLT,"ALU_OP");
         `Verify(WRITE_EN,`EN,"WRITE_EN");
         `Verify(WB_SEL,`ALU,"WB_SEL");
         `Verify(BRANCH,`B_NO,"BRANCH");
         `Verify(MEM_WRITE,`NO_W,"MEM_WRITE");
         `Verify(MEM_READ,`NO_R,"MEM_READ");;


        // SLTU
        $display("================================");
        $display("Test 32 : SLTU Control Signal Test");
        $display("================================");
        OPCODE = `R_TYPE_OP;
        FUNCT3 = 3'b011;
        FUNCT7 = 7'b0000000;
        `DECODE_DELAY
        #0;
        `Verify(IMM_SEL,`U_TYPE,"IME_SEL");
         `Verify(ALU_SEL1,`DATA1,"ALU_SEL1");
         `Verify(ALU_SEL2,`DATA2,"IME_SE2");
         `Verify(ALU_OP,`SLTU,"ALU_OP");
         `Verify(WRITE_EN,`EN,"WRITE_EN");
         `Verify(WB_SEL,`ALU,"WB_SEL");
         `Verify(BRANCH,`B_NO,"BRANCH");
         `Verify(MEM_WRITE,`NO_W,"MEM_WRITE");
         `Verify(MEM_READ,`NO_R,"MEM_READ");
        
        

        // XOR
        $display("================================");
        $display("Test 33 : XOR Control Signal Test");
        $display("================================");
        OPCODE = `R_TYPE_OP;
        FUNCT3 = 3'b100;
        FUNCT7 = 7'b0000000;
        `DECODE_DELAY
        #0;
        `Verify(IMM_SEL,`U_TYPE,"IME_SEL");
         `Verify(ALU_SEL1,`DATA1,"ALU_SEL1");
         `Verify(ALU_SEL2,`DATA2,"IME_SE2");
         `Verify(ALU_OP,`XOR,"ALU_OP");
         `Verify(WRITE_EN,`EN,"WRITE_EN");
         `Verify(WB_SEL,`ALU,"WB_SEL");
         `Verify(BRANCH,`B_NO,"BRANCH");
         `Verify(MEM_WRITE,`NO_W,"MEM_WRITE");
         `Verify(MEM_READ,`NO_R,"MEM_READ");

        

        // SRL
        $display("================================");
        $display("Test 34 : SRL Control Signal Test");
        $display("================================");
        OPCODE = `R_TYPE_OP;
        FUNCT3 = 3'b101;
        FUNCT7 = 7'b0000000;
        `DECODE_DELAY
        #0;
       `Verify(IMM_SEL,`U_TYPE,"IME_SEL");
         `Verify(ALU_SEL1,`DATA1,"ALU_SEL1");
         `Verify(ALU_SEL2,`DATA2,"IME_SE2");
         `Verify(ALU_OP,`SRL,"ALU_OP");
         `Verify(WRITE_EN,`EN,"WRITE_EN");
         `Verify(WB_SEL,`ALU,"WB_SEL");
         `Verify(BRANCH,`B_NO,"BRANCH");
         `Verify(MEM_WRITE,`NO_W,"MEM_WRITE");
         `Verify(MEM_READ,`NO_R,"MEM_READ");

        
        

        // SRA
        $display("================================");
        $display("Test 35 : SRA Control Signal Test");
        $display("================================");
        OPCODE = `R_TYPE_OP;
        FUNCT3 = 3'b001;
        FUNCT7 = 7'b0100000;
        `DECODE_DELAY
        #0;
     `Verify(IMM_SEL,`U_TYPE,"IME_SEL");
         `Verify(ALU_SEL1,`DATA1,"ALU_SEL1");
         `Verify(ALU_SEL2,`DATA2,"IME_SE2");
         `Verify(ALU_OP,`SRA,"ALU_OP");
         `Verify(WRITE_EN,`EN,"WRITE_EN");
         `Verify(WB_SEL,`ALU,"WB_SEL");
         `Verify(BRANCH,`B_NO,"BRANCH");
         `Verify(MEM_WRITE,`NO_W,"MEM_WRITE");
         `Verify(MEM_READ,`NO_R,"MEM_READ");

     

        // OR
        $display("================================");
        $display("Test 36 : OR Control Signal Test");
        $display("================================");
        OPCODE = `R_TYPE_OP;
        FUNCT3 = 3'b110;
        FUNCT7 = 7'b0000000;
        `DECODE_DELAY
        #0;
       `Verify(IMM_SEL,`U_TYPE,"IME_SEL");
         `Verify(ALU_SEL1,`DATA1,"ALU_SEL1");
         `Verify(ALU_SEL2,`DATA2,"IME_SE2");
         `Verify(ALU_OP,`OR,"ALU_OP");
         `Verify(WRITE_EN,`EN,"WRITE_EN");
         `Verify(WB_SEL,`ALU,"WB_SEL");
         `Verify(BRANCH,`B_NO,"BRANCH");
         `Verify(MEM_WRITE,`NO_W,"MEM_WRITE");
         `Verify(MEM_READ,`NO_R,"MEM_READ");

        
        // AND
        $display("================================");
        $display("Test 37 : AND Control Signal Test");
        $display("================================");
        OPCODE = `R_TYPE_OP;
        FUNCT3 = 3'b111;
        FUNCT7 = 7'b0000000;
        `DECODE_DELAY
        #0;
     `Verify(IMM_SEL,`U_TYPE,"IME_SEL");
         `Verify(ALU_SEL1,`DATA1,"ALU_SEL1");
         `Verify(ALU_SEL2,`DATA2,"IME_SE2");
         `Verify(ALU_OP,`AND,"ALU_OP");
         `Verify(WRITE_EN,`EN,"WRITE_EN");
         `Verify(WB_SEL,`ALU,"WB_SEL");
         `Verify(BRANCH,`B_NO,"BRANCH");
         `Verify(MEM_WRITE,`NO_W,"MEM_WRITE");
         `Verify(MEM_READ,`NO_R,"MEM_READ");

        // MUL
        $display("================================");
        $display("Test 38 : MUL Control Signal Test");
        $display("================================");
        OPCODE = `R_TYPE_OP;
        FUNCT3 = 3'b000;
        FUNCT7 = 7'b0111011;
        `DECODE_DELAY
        #0;
       `Verify(IMM_SEL,`U_TYPE,"IME_SEL");
         `Verify(ALU_SEL1,`DATA1,"ALU_SEL1");
         `Verify(ALU_SEL2,`DATA2,"IME_SE2");
         `Verify(ALU_OP,`MUL,"ALU_OP");
         `Verify(WRITE_EN,`EN,"WRITE_EN");
         `Verify(WB_SEL,`ALU,"WB_SEL");
         `Verify(BRANCH,`B_NO,"BRANCH");
         `Verify(MEM_WRITE,`NO_W,"MEM_WRITE");
         `Verify(MEM_READ,`NO_R,"MEM_READ");

    

        // MULH
        $display("================================");
        $display("Test 39 : MULH Control Signal Test");
        $display("================================");
        OPCODE = `R_TYPE_OP;
        FUNCT3 = 3'b001;
        FUNCT7 = 7'b0111011;
        `DECODE_DELAY
      `Verify(IMM_SEL,`U_TYPE,"IME_SEL");
         `Verify(ALU_SEL1,`DATA1,"ALU_SEL1");
         `Verify(ALU_SEL2,`DATA2,"IME_SE2");
         `Verify(ALU_OP,`MULH,"ALU_OP");
         `Verify(WRITE_EN,`EN,"WRITE_EN");
         `Verify(WB_SEL,`ALU,"WB_SEL");
         `Verify(BRANCH,`B_NO,"BRANCH");
         `Verify(MEM_WRITE,`NO_W,"MEM_WRITE");
         `Verify(MEM_READ,`NO_R,"MEM_READ");
      

        // MULHSU
        $display("================================");
        $display("Test 40 : MULHSU Control Signal Test");
        $display("================================");
        OPCODE = `R_TYPE_OP;
        FUNCT3 = 3'b010;
        FUNCT7 = 7'b0111011;
        `DECODE_DELAY
        #0;
      `Verify(IMM_SEL,`U_TYPE,"IME_SEL");
         `Verify(ALU_SEL1,`DATA1,"ALU_SEL1");
         `Verify(ALU_SEL2,`DATA2,"IME_SE2");
         `Verify(ALU_OP,`MULHSU,"ALU_OP");
         `Verify(WRITE_EN,`EN,"WRITE_EN");
         `Verify(WB_SEL,`ALU,"WB_SEL");
         `Verify(BRANCH,`B_NO,"BRANCH");
         `Verify(MEM_WRITE,`NO_W,"MEM_WRITE");
         `Verify(MEM_READ,`NO_R,"MEM_READ");
        
        

        // MULHU
        $display("================================");
        $display("Test 41 : MULHU Control Signal Test");
        $display("================================");
        OPCODE = `R_TYPE_OP;
        FUNCT3 = 3'b011;
        FUNCT7 = 7'b0111011;
        `DECODE_DELAY
      `Verify(IMM_SEL,`U_TYPE,"IME_SEL");
         `Verify(ALU_SEL1,`DATA1,"ALU_SEL1");
         `Verify(ALU_SEL2,`DATA2,"IME_SE2");
         `Verify(ALU_OP,`MULHU,"ALU_OP");
         `Verify(WRITE_EN,`EN,"WRITE_EN");
         `Verify(WB_SEL,`ALU,"WB_SEL");
         `Verify(BRANCH,`B_NO,"BRANCH");
         `Verify(MEM_WRITE,`NO_W,"MEM_WRITE");
         `Verify(MEM_READ,`NO_R,"MEM_READ");
        
        

        // DIV
        $display("================================");
        $display("Test 42 : DIV Control Signal Test");
        $display("================================");
        OPCODE = `R_TYPE_OP;
        FUNCT3 = 3'b100;
        FUNCT7 = 7'b0111011;
        `DECODE_DELAY
        #0;
       `Verify(IMM_SEL,`U_TYPE,"IME_SEL");
         `Verify(ALU_SEL1,`DATA1,"ALU_SEL1");
         `Verify(ALU_SEL2,`DATA2,"IME_SE2");
         `Verify(ALU_OP,`DIV,"ALU_OP");
         `Verify(WRITE_EN,`EN,"WRITE_EN");
         `Verify(WB_SEL,`ALU,"WB_SEL");
         `Verify(BRANCH,`B_NO,"BRANCH");
         `Verify(MEM_WRITE,`NO_W,"MEM_WRITE");
         `Verify(MEM_READ,`NO_R,"MEM_READ");

        
        // REM
        $display("================================");
        $display("Test 43 : REM Control Signal Test");
        $display("================================");
        OPCODE = `R_TYPE_OP;
        FUNCT3 = 3'b101;
        FUNCT7 = 7'b0111011;
        `DECODE_DELAY
        #0;
      `Verify(IMM_SEL,`U_TYPE,"IME_SEL");
         `Verify(ALU_SEL1,`DATA1,"ALU_SEL1");
         `Verify(ALU_SEL2,`DATA2,"IME_SE2");
         `Verify(ALU_OP,`REM,"ALU_OP");
         `Verify(WRITE_EN,`EN,"WRITE_EN");
         `Verify(WB_SEL,`ALU,"WB_SEL");
         `Verify(BRANCH,`B_NO,"BRANCH");
         `Verify(MEM_WRITE,`NO_W,"MEM_WRITE");
         `Verify(MEM_READ,`NO_R,"MEM_READ");

     

        // REMU
        $display("================================");
        $display("Test 44 : REMU Control Signal Test");
        $display("================================");
        OPCODE = `R_TYPE_OP;
        FUNCT3 = 3'b110;
        FUNCT7 = 7'b0111011;
        `DECODE_DELAY
        #0;
       `Verify(IMM_SEL,`U_TYPE,"IME_SEL");
         `Verify(ALU_SEL1,`DATA1,"ALU_SEL1");
         `Verify(ALU_SEL2,`DATA2,"IME_SE2");
         `Verify(ALU_OP,`REMU,"ALU_OP");
         `Verify(WRITE_EN,`EN,"WRITE_EN");
         `Verify(WB_SEL,`ALU,"WB_SEL");
         `Verify(BRANCH,`B_NO,"BRANCH");
         `Verify(MEM_WRITE,`NO_W,"MEM_WRITE");
         `Verify(MEM_READ,`NO_R,"MEM_READ");
        
        $display("========================================================================");
                                $display("All tests passed!");
        $display("======================================================================");
     #100
    $finish;
    end 
   

endmodule