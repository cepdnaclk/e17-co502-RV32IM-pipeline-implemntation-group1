 /*______________________________________________________________________________
  |                                                                              |
  |  File Name         -cpu.v                                                    |
  |  Created By        -Group1(E17)                                              |
  |  Project/ Course   -CO502                                                    |
  |  Institute         -University of peradeniya                                 |
  |  Date              -05.04.2023                                               |
  |  Discription       -cpu                                                      |
  |______________________________________________________________________________|
  
*/
`include "../Other_modules/mux_2x1_32bit/mux_2x1_32bit.v"
`include "../Other_modules/mux_4x1_32bit/mux_4x1_32bit.v"
`include "../Other_modules/mux_3x1_32bit/mux_3x1_32bit.v"
`include "../Other_modules/register_32bit/register_32bit.v"
`include "../Other_modules/mux_cs/mux_cs.v"
`include "../Other_modules/adder_32bit/adder_32bit.v"
`include "../Instruction_Memory_chache/instruction_cache.v"
`include "../Register_file/reg_file.v"
`include "../Control_Unit/control_unit.v"
`include "../Immediate_gen_module/immediate_generate.v"
`include "../ALU/alu.v"
`include "../Branch_module/bj_detect.v"
`include "../Data_memory_cache/data_cache.v"
`include "../Pipeline_registers/EX_MEM_pipeline_reg_module/ex_mem_pipeline_reg.v"
`include "../Pipeline_registers/ID_EX_pipeline_reg_module/id_ex_pipeline_reg.v"
`include "../Pipeline_registers/IF_ID_pipeline_reg_module/if_id_pipeline_reg.v"
`include "../Pipeline_registers/MEM_WB_pipeline_reg_module/mem_wb_pipeline_reg.v"
`include "../PC/PC.v"
`include "../Forward_unit/stage3_forward_unit.v"
`include "../Forward_unit/stage4_forward_unit.v"
`include "../Hazards_detection unit/hazards_dectc.v"
`include "../Pipeline_flush/pipeline_flush.v"



module cpu (RESET, CLK, INST_MEM_READDATA, DATA_MEM_READDATA,DATA_MEM_BUSYWAIT,INST_MEM_BUSYWAIT, DATA_MEM_WRITEDATA, INST_MEM_READ, DATA_MEM_READ, DATA_MEM_WRITE, INST_MEM_ADDRESS, DATA_MEM_ADDRESS );

input RESET, CLK, INST_MEM_BUSYWAIT, DATA_MEM_BUSYWAIT;
input [127:0] INST_MEM_READDATA, DATA_MEM_READDATA;
output [127:0] DATA_MEM_WRITEDATA;
output INST_MEM_READ, DATA_MEM_READ, DATA_MEM_WRITE,BUSYWAIT;
output [27:0] INST_MEM_ADDRESS, DATA_MEM_ADDRESS;


/*===============================================
              INITIAL CONNECTION
  ===============================================
*/
  or OR_21(BUSYWAIT,INST_BUSYWAIT,DATA_BUSYWAIT);




/*=============================================================================================
                                      STAGE 1 INSTRUCTION FETCHING
  ============================================================================================= 
*/

//Inputs_datapath -BRANCH_OFFSET ,BRANCH_SIG
//Inputs_datapath -INSTRUCTION_IFID,PC_4_IFID

//Inputs - CLK,RESET,BRANCH_OFFSET ,BRANCH_SIG , INST_MEM_BUSYWAIT
//Outputs- INSTRUCTION,PC_4,INST_MEM_READDATA,INST_BUSYWAIT,INST_MEM_ADDRESS,INST_MEM_READ,INSTRUCTION_IFID,PC_4_IFID

//  WIRES
//PC unit
wire [31:0] PC,PC_4;

//Instruction cache
wire INST_BUSYWAIT;
wire[31:0]INSTRUCTION;

//Pipeline Reg
wire[31:0]INSTRUCTION_IFID;
wire [31:0]PC_IFID;
  
//CONNECTIONS
PC_UNIT PC_UNIT1(CLK,RESET,ALU_RESULT,PC_SELECT,PC_REG_WRITE,BUSYWAIT,PC,PC_4);

instruction_cache inst_cache(CLK, RESET, INST_MEM_READDATA, INST_MEM_BUSYWAIT,PC ,INSTRUCTION, INST_BUSYWAIT,INST_MEM_ADDRESS,INST_MEM_READ);

if_id_pipeline_reg if_id_reg(CLK, (RESET || F_PREG1) ,BUSYWAIT,INSTRUCTION,PC,INSTRUCTION_IFID,PC_IFID);

//=============================================================================================


/*=============================================================================================
                          STAGE 2 -INSTRUCTION DECODING AND REGISTER READ
  ============================================================================================= 
*/

//Inputs_datapath -REG_WRITE_DATA,REG_WRITE_ADDRESS_MEMWB,WRITE_ENABLE_MEMWB
//Inputs_datapath -DATA1,DATA2

//Inputs - 
//Outputs- 

//WIRES
//Hazards Detection unit
  wire FL_REG_WRITE,PC_REG_WRITE,MUX2_SEL;

//Pipeine flush
wire F_PREG1,F_PREG2,F_PREG3;

//Reg file
wire[31:0]DATA1,DATA2;

//Contrl unit
wire [31:0]IMMEDIATE;
wire [2:0]IMM_SEL;
wire ALU_SEL1;
wire ALU_SEL2;
wire [4:0]ALU_OP;
wire [2:0]BRANCH;
wire [1:0]MEM_WRITE;
wire [2:0]MEM_READ;
wire [1:0]WB_SEL;
wire WRITE_EN;

//Mux5

wire ALU_SEL1_M5O;
wire ALU_SEL2_M5O;
wire [4:0]ALU_OP_M5O;
wire [2:0]BRANCH_M5O;
wire [1:0]MEM_WRITE_M5O;
wire [2:0]MEM_READ_M5O;
wire [1:0]WB_SEL_M5O;
wire WRITE_EN_M5O;


//Pipeline reg
wire [31:0]IMMEDIATE_IDEX;
wire [2:0]IMM_SEL_IDEX;
wire ALU_SEL1_IDEX;
wire ALU_SEL2_IDEX;
wire [4:0]ALU_OP_IDEX;
wire [2:0]BRANCH_IDEX;
wire [1:0]MEM_WRITE_IDEX;
wire [2:0]MEM_READ_IDEX;
wire [1:0]WB_SEL_IDEX;
wire WRITE_EN_IDEX;
wire [4:0]INSTRUCTION_R1_IDEX;
wire [4:0]INSTRUCTION_R2_IDEX;

//Immidete gen 
wire [31:0]PC_IDEX;
wire[4:0] INSTRUCTION_IDEX;
wire[31:0]DATA1_IDEX,DATA2_IDEX;

//Conections

hazards_dection hazards_dection1(INSTRUCTION_IFID[19:15],INSTRUCTION_IFID[24:20],INSTRUCTION_IDEX[11:7],MEM_READ_IDEX,FL_REG_WRITE,PC_REG_WRITE,MUX2_SEL);

pipeline_flush pipeline_flush1(FL_REG_WRITE,PREG_FLUSH,F_PREG1,F_PREG2,F_PREG3);

reg_file reg_file1(CLK,RESET,REG_WRITE_DATA,INSTRUCTION_WBREG,INSTRUCTION_IFID[19:15],INSTRUCTION_IFID[24:20],WRITE_ENABLE_MEMWB,DATA1,DATA2);

control_unit control_unit1(CLK,RESET,INSTRUCTION_IFID[6:0],INSTRUCTION_IFID[14:12],INSTRUCTION_IFID[31:25],IMM_SEL,ALU_SEL1,ALU_SEL2,ALU_OP,BRANCH,MEM_WRITE,MEM_READ,WB_SEL,WRITE_EN);

mux_cs mux_cs1(WRITE_EN,WB_SEL,MEM_READ,MEM_WRITE,BRANCH,ALU_OP,ALU_SEL1,ALU_SEL2,WRITE_EN_M5O,WB_SEL_M5O,MEM_READ_M5O,MEM_WRITE_M5O,BRANCH_M5O,ALU_OP_M5O,ALU_SEL1_M5O,ALU_SEL2_M5O,MUX2_SEL);

immediate_generate immediate_generate1(IMM_SEL,INSTRUCTION_IFID[31:7],IMMEDIATE);

id_ex_pipeline_reg id_ex_reg(
  CLK, (RESET || F_PREG2),BUSYWAIT,
  INSTRUCTION_IFID[11:7],INSTRUCTION_IFID[19:15],INSTRUCTION_IFID[24:20],PC_IFID,DATA1,DATA2,IMMEDIATE,ALU_SEL1_M5O,ALU_SEL2_M5O,ALU_OP_M5O,BRANCH_M5O,MEM_READ_M5O,MEM_WRITE_M5O,WB_SEL_M5O,WRITE_EN_M5O,
  INSTRUCTION_IDEX,INSTRUCTION_R1_IDEX,INSTRUCTION_R2_IDEX,PC_IDEX,DATA1_IDEX,DATA2_IDEX,IMMEDIATE_IDEX,ALU_SEL1_IDEX,ALU_SEL2_IDEX,ALU_OP_IDEX,BRANCH_IDEX,MEM_READ_IDEX,MEM_WRITE_IDEX,WB_SEL_IDEX,WRITE_EN_IDEX
  );

//=============================================================================================



/*=============================================================================================
                                   STAGE 3- EXICUTION
  ============================================================================================= 
*/
//WIRES
//Mux6
wire [31:0] MUX6_OUT;

//Mux5
wire [31:0]MUX5_OUT;

//Mux3
wire [31:0] MUX3_OUT;

//Mux4
wire [31:0]MUX4_OUT;

//ALU
wire[31:0]ALU_RESULT
;
//BJ unit
wire PC_SELECT,PREG_FLUSH;

// Pipeline reg
wire [4:0]INSTRUCTION_EXMEM;
wire[31:0] PC_EXMEM,ALU_RESULT_EXMEM;
wire [31:0]DATA2_EXMEM;
wire [31:0]IMMEDIATE_EXMEM;
wire[2:0] MEM_READ_EXMEM;
wire [1:0]MEM_WRITE_EXMEM;
wire[1:0] WB_SEL_EXMEM;
wire WRITE_EN_EXMEM;
wire [4:0]INSTRUCTION_R2_EXMEM;
  
//Forwading unit
wire [1:0]MUX3_SEL,MUX4_SEL;

//CONNECTIONS

mux_3x1_32bit mux_3(DATA1_IDEX,REG_WRITE_DATA,ALU_RESULT_EXMEM,MUX3_OUT,MUX3_SEL);
mux_3x1_32bit mux_4(DATA2_IDEX,REG_WRITE_DATA,ALU_RESULT_EXMEM,MUX4_OUT,MUX4_SEL);


mux_2x1_32bit mux_6(MUX3_OUT,PC_4,MUX6_OUT,ALU_SEL1_IDEX);
mux_2x1_32bit mux_5(MUX4_OUT,IMMEDIATE_IDEX,MUX5_OUT,ALU_SEL2_IDEX);

alu alu1(MUX6_OUT,MUX5_OUT,ALU_OP_IDEX,ALU_RESULT);

bj_detect bj_detect(BRANCH_IDEX,MUX6_OUT,MUX5_OUT,PC_SELECT,PREG_FLUSH);


ex_mem_pipeline_reg ex_mem_reg(
  CLK, RESET,BUSYWAIT,
  INSTRUCTION_IDEX,INSTRUCTION_R2_IDEX,PC_IDEX,ALU_RESULT,DATA2_IDEX,IMMEDIATE_IDEX,MEM_READ_IDEX,MEM_WRITE_IDEX,WB_SEL_IDEX,WRITE_EN_IDEX,
  INSTRUCTION_EXMEM,INSTRUCTION_R2_EXMEM,PC_EXMEM,ALU_RESULT_EXMEM,DATA2_EXMEM,IMMEDIATE_EXMEM,MEM_READ_EXMEM,MEM_WRITE_EXMEM,WB_SEL_EXMEM,WRITE_EN_EXMEM
  
);

stage3_forward_unit forward_unit1(MEM_READ_IDEX,INSTRUCTION_R1_IDEX,INSTRUCTION_R2_IDEX,INSTRUCTION_EXMEM,WRITE_EN_EXMEM,INSTRUCTION_WBREG,WRITE_EN_WBREG,MUX3_SEL,MUX4_SEL);

//==========================================================================================================================



/*========================================================================================================================
                                      STAGE 4- DATA MEMEORY READ/WRITE
  ======================================================================================================================== 
*/
//WIRES
//Adder
wire [31:0]PC_42;

//Mux7
wire [31:0]MUX7_OUT;


wire [31:0]MEM_READDATA;

//Data cache
wire[4:0]INSTRUCTION_WBREG;
wire [31:0]PC_42_WBREG;
wire[31:0] ALU_RESULT_WBREG;
wire[31:0] IMMEDIATE_WBREG;
wire [31:0]MEM_READDATA_WBREG;
wire[1:0] WB_SEL_WBREG;
wire WRITE_EN_WBREG;
wire [2:0]MEM_READ_WBREG;

//Forwading2
wire MUX7_SEL;

//CONNECTIONS
 
adder_32bit adder_32bit(PC_EXMEM,PC_42);


mux_2x1_32bit mux_7(DATA2_EXMEM,MEM_READDATA_WBREG,MUX7_OUT,MUX7_OUT);

data_cache data_cache1(  CLK, RESET,MEM_READ_EXMEM,MEM_WRITE_EXMEM,MUX7_OUT,ALU_RESULT_EXMEM,DATA_MEM_READDATA,MEM_READDATA,DATA_MEM_BUSYWAIT,
DATA_MEM_READ,DATA_MEM_WRITE,DATA_MEM_WRITEDATA,DATA_MEM_ADDRESS,DATA_BUSYWAIT);

mem_wb_pipeline_reg mem_wb_reg(
CLK, RESET,BUSYWAIT,
INSTRUCTION_EXMEM,PC_42,ALU_RESULT_EXMEM,IMMEDIATE_EXMEM,MEM_READDATA,WB_SEL_EXMEM,WRITE_EN_EXMEM,MEM_READ_EXMEM,
INSTRUCTION_WBREG,PC_42_WBREG,ALU_RESULT_WBREG,IMMEDIATE_WBREG,MEM_READDATA_WBREG,WB_SEL_WBREG,WRITE_EN_WBREG,MEM_READ_WBREG);

stage4_forward_unit forwading_onit2(INSTRUCTION_R2_EXMEM,INSTRUCTION_WBREG,MEM_WRITE_EXMEM,MEM_READ_WBREG,MUX7_SEL);
//=====================================================================================================================================



/*=====================================================================================================================================
                                           STAGE 5 WRITE BACK
  ===================================================================================================================================== 
*/

//wIRES 
wire [31:0]REG_WRITE_DATA;

//CONNECTIONS
mux_4x1_32bit mux8(ALU_RESULT_WBREG,MEM_READDATA_WBREG,IMMEDIATE_WBREG,PC_42_WBREG,REG_WRITE_DATA,WB_SEL_WBREG);


endmodule
//==========================================================================================================================================