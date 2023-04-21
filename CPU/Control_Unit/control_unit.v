
 /*______________________________________________________________________________
  |                                                                              |
  |  File Name         -Control_unit_G1.v                                        |
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

module control_unit (OPCODE,FUNC3,FUNC7,CLK,RESET,IMM_SEL,ALU_SEL1,ALU_SEL2,ALU_OP,BRANCH,MEM_WRITE,MEM_READ,WB_SEL,WRITE_EN);

`define DECODE_DELAY #1 // Decode delay

//Port declarations-------
input [31:0] INSTRUCTION;
input CLK,RESET;
input [6:0] OPCODE,FUNC7;
input [2:0]FUNC3;
output reg ALU_SEL1,ALU_SEL2,WRITE_EN;
output reg[1:0] WB_SEL,MEM_WRITE;
output reg[4:0] ALU_OP;
output reg[2:0] BRANCH,MEM_READ;
output reg [2:0] IMM_SEL;

//wire [6:0] OPCODE;
//wire [2:0] FUNC3;
//wire [6:0] FUNC7;

//assign OPCODE = INSTRUCTION[6:0];
//FUNC3 = INSTRUCTION[14:12];
//assign FUNC7 = INSTRUCTION[31:25];

 // CONTROL SIGNAL GENERATION
 always @(*) begin
     #1
     case(OPCODE)
         // R Type Instructions-----------------
         `R_TYPE_OP: begin
             IMM_SEL      =`U_TYPE;
             ALU_SEL1     =`DATA1;
             ALU_SEL2     =`DATA2;
             BRANCH       =`B_NO;
             MEM_WRITE    =`NO_W;
             MEM_READ     =`NO_R;
             WB_SEL       =`ALU;
             WRITE_EN     =`EN;

             case(FUNC7)
                 7'b0000000: begin
                     case(FUNC3)
                         8'b000: ALU_OP = `ADD;  // ADD
				         8'b001: ALU_OP = `SLL;  // SLL	
				         8'b010: ALU_OP = `SLT;  // SLT
				         8'b011: ALU_OP = `SLTU; // SLTU
                         8'b100: ALU_OP = `XOR;  // XOR
				         8'b101: ALU_OP = `SRL;   // SR
				         8'b110: ALU_OP = `OR;   // OR
				         8'b111: ALU_OP = `AND;  // AND	
                     endcase
                 end

                 7'b0100000: begin
                     case(FUNC3)
                         8'b000: ALU_OP = `SUB;  // SUB
				         8'b001: ALU_OP = `SRA;  // SRA	
				        
                     endcase
                 end
                 7'b0111011: begin
                     case(FUNC3)
                         8'b000: ALU_OP = `MUL;    // MUL
				         8'b001: ALU_OP = `MULH;   // MULH	
				         8'b010: ALU_OP = `MULHSU; // MULHSU
				         8'b011: ALU_OP = `MULHU;  // MULHU
                         8'b100: ALU_OP = `DIV;    // DIV
				         8'b101: ALU_OP = `REM;    // REM
				         8'b110: ALU_OP = `REMU;   // REMU
				         
                     endcase
                 end
             endcase
             end
         // S Type Instructions--------------------------
         `STORE_OP: begin

             IMM_SEL      =`S_TYPE;
             ALU_SEL1     =`DATA1;
             ALU_SEL2     =`IMM;
             BRANCH       =`B_NO;
             MEM_READ     =`NO_R;
             WB_SEL       =`ALU;
             WRITE_EN     =`DIS;
             ALU_OP       =`ADD;
             
             case(FUNC3)
                  3'b000: MEM_WRITE = `MW_SB; //SB
				  3'b001: MEM_WRITE = `MW_SH; //SH
				  3'b010: MEM_WRITE = `MW_SW; //SW		  
                 
             endcase
             end
         //Load Instructions--------------------------
         `LOAD_OP: begin

             IMM_SEL      =`I_TYPE;
             ALU_SEL1     =`DATA1;
             ALU_SEL2     =`IMM;
             BRANCH       =`B_NO;
             MEM_WRITE    =`NO_W;
             WB_SEL       =`ALU;
             WRITE_EN     =`EN;
             ALU_OP       =`ADD;
             
             case(FUNC3)
                  3'b000: MEM_READ = `MR_LB;  // LB
				  3'b001: MEM_READ = `MR_LH;  // LH	
				  3'b010: MEM_READ = `MR_LW;  // LW
				  3'b011: MEM_READ = `MR_LBU; // LBU
                  3'b100: MEM_READ = `MR_LHU; // LHU
				            
             endcase
             end
         // I Type Instructions------------------
         `I_TYPE_OP: begin

            
             ALU_SEL1     =`DATA1;
             ALU_SEL2     =`IMM;
             BRANCH       =`B_NO;
             MEM_WRITE    =`NO_W;
             MEM_READ     =`NO_R;
             WB_SEL       =`ALU;
             WRITE_EN     =`EN;
                     
             case(FUNC7)
                 7'b0000000: begin
                     case(FUNC3)
                         3'b101: {ALU_OP,IMM_SEL}={`SRL,`I_SHIFT_TYPE}; // SRLI
				        
                     endcase
                 end

                 7'b0100000: begin
                     case(FUNC3)
                         3'b101: {ALU_OP,IMM_SEL}={`SRA,`I_SHIFT_TYPE}; // SRAI
				      		        
                     endcase
                 end
                 7'bxxxxxxx: begin
                     case(FUNC3)
                         3'b000: {ALU_OP,IMM_SEL}={`ADD,`I_TYPE}; // ADDI
				         3'b010: {ALU_OP,IMM_SEL}={`SLT,`I_TYPE}; // SLTI
				         3'b011: {ALU_OP,IMM_SEL}={`SLTU,`I_UNSIGNED_TYPE}; // SLTIU
				         3'b100: {ALU_OP,IMM_SEL}={`XOR,`I_TYPE}; // XORI
                         3'b110: {ALU_OP,IMM_SEL}={`OR,`I_TYPE}; // ORI
				         3'b111: {ALU_OP,IMM_SEL}={`AND,`I_TYPE}; // ANDI
				         3'b001: {ALU_OP,IMM_SEL}={`SLL,`I_SHIFT_TYPE}; // SLLI
				        
                     endcase
                 end
                 endcase
             end
         //BRANCH Type Instructions---------------------
         `B_TYPE_OP: begin

             IMM_SEL      =`B_TYPE;
             ALU_SEL1     =`PC;
             ALU_SEL2     =`IMM ;
             MEM_WRITE    =`NO_W;
             MEM_READ     =`NO_R;
             WB_SEL       =`ALU;
             WRITE_EN     =`DIS;
             
             case(FUNC3)
                  3'b000: {ALU_OP,BRANCH} = {`ADD,`B_BEQ}; // BEQ
				  3'b001: {ALU_OP,BRANCH} = {`ADD,`B_BNE}; // BNE	
				  3'b100: {ALU_OP,BRANCH} = {`ADD,`B_BLT}; // BLT
				  3'b101: {ALU_OP,BRANCH} = {`ADD,`B_BGE}; // BGE
                  3'b110: {ALU_OP,BRANCH} = {`ADD,`B_BLTU}; // BLTU
				  3'b111: {ALU_OP,BRANCH} = {`ADD,`B_BGEU}; // BGEU
				           
             endcase
             end    
         // JAL Instruction---------------------
         `JAL_OP : begin

             IMM_SEL      =`J_TYPE;
             ALU_SEL1     =`PC;
             ALU_SEL2     =`IMM ;
             BRANCH       =`B_NO;
             MEM_WRITE    =`NO_W;
             MEM_READ     =`NO_R;
             WB_SEL       =`PC_4;
             WRITE_EN     =`EN;
             ALU_OP       =`ADD;
             
             
             end    
         //JALR Instruction---------------------
         `JALR_OP: begin

             IMM_SEL      =`J_TYPE;
             ALU_SEL1     =`DATA1;
             ALU_SEL2     =`IMM;
             BRANCH       =`B_NO;
             MEM_WRITE    =`NO_W;
             MEM_READ     =`NO_R;
             WB_SEL       =`PC;
             WRITE_EN     =`EN;
             ALU_OP       =`ADD;       
             end    
         //UType (LUI) Instruction----------------
         `LUI_OP: begin

             IMM_SEL      =`U_TYPE;
             ALU_SEL1     =`DATA1;
             ALU_SEL2     =`DATA2;
             BRANCH       =`B_NO;
             MEM_WRITE    =`NO_W;
             MEM_READ     =`NO_R;
             WB_SEL       =`IMM_WB;
             WRITE_EN     =`EN;
             ALU_OP       =`ADD;
             end    
         //U Type (AUIPC) INstruction-------------
         `AUIPC_OP: begin

             IMM_SEL      =`U_TYPE;
             ALU_SEL1     =`DATA1;
             ALU_SEL2     =`IMM;
             BRANCH       =`B_NO;
             MEM_WRITE    =`NO_W;
             MEM_READ     =`NO_R;
             WB_SEL       =`ALU;
             WRITE_EN     =`EN;
            ALU_OP       =`ADD;     
             end    
     endcase
 
  end
			
			
endmodule