/*______________________________________________________________________________
  |                                                                              |
  |  File Name         -instruction_memory.v                                        |
  |  Created By        -Tharindu Rathnayaka (E/17/286) /Dhushintha R (E/17/064)  |
  |  Project/ Course   -CO502                                                    |
  |  Institute         -University of peradeniya                                 |
  |  Date              -05.04.2023                                               |
  |  Discription       -Instruction memory for RV32IM                                                         |
  |______________________________________________________________________________|
  
  */


module instruction_memory(CLK, READ, ADDRESS, READ_DATA, BUSYWAIT);

`define MEM_READ_DELAY #40

input                CLK;
input                READ;
input[27:0]          ADDRESS;
output reg [127:0]   READ_DATA;
output reg           BUSYWAIT;

reg READ_ACCESS;

reg [7:0] MEMORY [0:1023];


//Detecting an incoming memory access
always @(READ)
begin
    BUSYWAIT = (READ)? 1 : 0;
    READ_ACCESS = (READ)? 1 : 0;
end

//Reading
always @(posedge CLK)
begin
    if(READ_ACCESS)
    begin
        READ_DATA[7:0]     = `MEM_READ_DELAY MEMORY[{ADDRESS,4'b0000}];
        READ_DATA[15:8]    = `MEM_READ_DELAY MEMORY[{ADDRESS,4'b0001}];
        READ_DATA[23:16]   = `MEM_READ_DELAY MEMORY[{ADDRESS,4'b0010}];
        READ_DATA[31:24]   = `MEM_READ_DELAY MEMORY[{ADDRESS,4'b0011}];
        READ_DATA[39:32]   = `MEM_READ_DELAY MEMORY[{ADDRESS,4'b0100}];
        READ_DATA[47:40]   = `MEM_READ_DELAY MEMORY[{ADDRESS,4'b0101}];
        READ_DATA[55:48]   = `MEM_READ_DELAY MEMORY[{ADDRESS,4'b0110}];
        READ_DATA[63:56]   = `MEM_READ_DELAY MEMORY[{ADDRESS,4'b0111}];
        READ_DATA[71:64]   = `MEM_READ_DELAY MEMORY[{ADDRESS,4'b1000}];
        READ_DATA[79:72]   = `MEM_READ_DELAY MEMORY[{ADDRESS,4'b1001}];
        READ_DATA[87:80]   = `MEM_READ_DELAY MEMORY[{ADDRESS,4'b1010}];
        READ_DATA[95:88]   = `MEM_READ_DELAY MEMORY[{ADDRESS,4'b1011}];
        READ_DATA[103:96]  = `MEM_READ_DELAY MEMORY[{ADDRESS,4'b1100}];
        READ_DATA[111:104] = `MEM_READ_DELAY MEMORY[{ADDRESS,4'b1101}];
        READ_DATA[119:112] = `MEM_READ_DELAY MEMORY[{ADDRESS,4'b1110}];
        READ_DATA[127:120] = `MEM_READ_DELAY MEMORY[{ADDRESS,4'b1111}];
        BUSYWAIT = 0;
        READ_ACCESS = 0;
    end
end
 
endmodule