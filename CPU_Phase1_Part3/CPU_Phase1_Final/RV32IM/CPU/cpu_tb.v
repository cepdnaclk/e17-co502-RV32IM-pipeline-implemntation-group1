
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

`include "../Data_Memory/data_memory.v"
`include "../Intruction_Memory/instruction_memory.v"
`include "cpu.v"

module cpu_tb;

reg RESET, CLK;
wire INST_MEM_READ, DATA_MEM_BUSYWAIT, DATA_MEM_READ, DATA_MEM_WRITE, INST_MEM_BUSYWAIT;
wire [127:0] INST_MEM_READDATA, DATA_MEM_READDATA, DATA_MEM_WRITEDATA;
wire [27:0] INST_MEM_ADDRESS, DATA_MEM_ADDRESS;

//Initialize Modules  
cpu cpu_1(RESET, CLK, INST_MEM_READDATA, DATA_MEM_READDATA, DATA_MEM_BUSYWAIT,INST_MEM_BUSYWAIT,DATA_MEM_WRITEDATA, INST_MEM_READ, DATA_MEM_READ, DATA_MEM_WRITE, INST_MEM_ADDRESS, DATA_MEM_ADDRESS);

data_memory d_mem(CLK, RESET, DATA_MEM_READ, DATA_MEM_WRITE, DATA_MEM_ADDRESS, DATA_MEM_WRITEDATA, DATA_MEM_READDATA, DATA_MEM_BUSYWAIT);

instruction_memory inst_mem(CLK, INST_MEM_READ, INST_MEM_ADDRESS, INST_MEM_READDATA, INST_MEM_BUSYWAIT);

integer j;
//Dump wave forms
initial begin
    $readmemb("../Intruction_Memory/instr_mem.mem", inst_mem.MEMORY);
    $dumpfile("cpu_pipeline_wavedata.vcd");
    $dumpvars(0, cpu_tb);
    for(j = 0; j < 16; j = j + 1) $dumpvars(0, inst_mem.MEMORY[j]);
    for(j = 0; j < 8; j = j + 1) $dumpvars(0, cpu_1.inst_cache.DATA[j]);
    for(j = 0; j < 32; j = j + 1) $dumpvars(0, cpu_1.reg_file1.REGISTER[j]);
    for(j = 0; j < 8; j = j + 1) $dumpvars(0, cpu_1.data_cache1.DATA[j]);
    for(j = 0; j < 8; j = j + 1) $dumpvars(0, cpu_1.data_cache1.VALID[j]);
    for(j = 0; j < 8; j = j + 1) $dumpvars(0, cpu_1.data_cache1.TAG[j]);
    for(j = 0; j < 8; j = j + 1) $dumpvars(0, cpu_1.data_cache1.DIRTY[j]);

//CPU starts-----------------------------------------------------------
    CLK = 1'b0;
    RESET = 1'b0;
    RESET = 1'b1;  // Stars with Resetting
    #1;
    RESET = 1'b0; 
    
    #5000;
    $finish;
//-----------------------------------------------------------------------
end

// clock genaration.
always begin
    #2 CLK = ~CLK;
end

endmodule