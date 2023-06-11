 /*______________________________________________________________________________
  |                                                                              |
  |  File Name         -data_memory_tb.v                                         |
  |  Created By        -Tharindu Rathnayaka (E/17/286) /Dhushintha R (E/17/064)  |
  |  Project/ Course   -CO502                                                    |
  |  Institute         -University of peradeniya                                 |
  |  Date              -05.04.2023                                               |
  |  Discription       -Test bench for data memory for RV32IM                    |
  |______________________________________________________________________________|
  
  */

`include "data_memory.v"
`include "../Utilities/macros.v"
`include "../Utilities/encodings_formats.v"

module data_memory_tb;

    reg CLK, RESET, READ, WRITE;
    reg [27:0] ADDRESS;
    reg [127:0] WRITEDATA;
    wire [127:0] READDATA;
    wire BUSYWAIT;

    integer j;
    
    data_memory my_data_memory(CLK, RESET, READ, WRITE, ADDRESS, WRITEDATA, READDATA, BUSYWAIT);

    initial begin
        $dumpfile("data_memory_wavedata.vcd");
        $dumpvars(0, data_memory_tb);
        for(j = 0; j < 100; j = j + 1) $dumpvars(0, my_data_memory.MEMMORY[j]);


        CLK = 1'b0;
        RESET = 1'b0;
        #5;
        RESET = 1'b1;
        #5;
        RESET = 1'b0;
        
        WRITE = 1'b1;
        READ = 1'b0;
        ADDRESS = 28'b0000_0000_0000_0000_0000_0000_0000;
        WRITEDATA = 128'hABCD1234_ABCD1234_ABCD1234_ABCD1234;
        #200;


        WRITE = 1'b0;
        READ = 1'b1;
        ADDRESS = 28'b0000_0000_0000_0000_0000_0000_0000;

        #200

        $display("============================================================================");
        $display("                      IMMEDIATE GENERATION  UNIT TESTING");
        $display("=============================================================================");

        `Verify( WRITEDATA,READDATA,"Data memory Read write")
        $display("=======================All Test cases Passed !!!=============================");

        #500;
        $finish;

    end

    // clock genaration.
    always begin
        #4 CLK = ~CLK;
    end

    

endmodule