`include "data_cache.v"
`include "../Data_Memory/data_memory.v"
`include "../Utilities/macros.v"
`include "../Utilities/encodings_formats.v"

module data_cache_tb;

reg CLK, RESET;
reg[3:0] READ_WRITE;
reg[2:0] READ;
reg[1:0] WRITE;
reg [31:0] WRITEDATA, ADDRESS;
wire BUSYWAIT, MEM_BUSYWAIT, MEM_READ, MEM_WRITE;
wire [127:0] MEM_READDATA, MEM_WRITEDATA;
wire [27:0] MEM_ADDRESS;
wire [31:0] READDATA;

data_cache my_data_cache(CLK, RESET, BUSYWAIT, READ,WRITE, WRITEDATA, READDATA, ADDRESS, MEM_BUSYWAIT,MEM_READ, MEM_WRITE, MEM_READDATA, MEM_WRITEDATA, MEM_ADDRESS);

data_memory my_data_memory(CLK, RESET, MEM_READ, MEM_WRITE, MEM_ADDRESS, MEM_WRITEDATA, MEM_READDATA, MEM_BUSYWAIT);

integer j;

initial begin
    $dumpfile("data_cache_wavedata.vcd");
    $dumpvars(0, data_cache_tb);
    for(j = 0; j < 16; j = j + 1) $dumpvars(0, my_data_cache.DATA[j]);
    for(j = 0; j < 16; j = j + 1) $dumpvars(0, my_data_cache.TAG[j]);
    for(j = 0; j < 16; j = j + 1) $dumpvars(0, my_data_cache.DIRTY[j]);
    for(j = 0; j < 16; j = j + 1) $dumpvars(0, my_data_cache.VALID[j]);
    for(j = 0; j < 32; j = j + 1) $dumpvars(0, my_data_memory.MEMMORY[j]);

    CLK = 1'b1;
    #1;
    RESET = 1'b0;
    #1;
    RESET = 1'b1;
    #1;
    RESET = 1'b0;

    #10
    WRITE = 2'b11; 
    ADDRESS = 32'h00000000;
    WRITEDATA = 32'b11000000000000010000000000000011;
    
    #300
    READ = 3'b011; 
    ADDRESS = 32'h00000000;

    #300
    $display("============================================================================");
    $display("                   DATA CACHE UNIT TESTING");
    $display("=============================================================================");
    `Verify(WRITEDATA,READDATA,"Data cache testing");

    $display("========================All Test cases Passed !!!==============================");
    #500;
    $finish;

    end

    // clock genaration.
    always begin
        #4 CLK = ~CLK;
    end
    
endmodule