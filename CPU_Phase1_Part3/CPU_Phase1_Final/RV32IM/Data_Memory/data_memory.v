 /*______________________________________________________________________________
  |                                                                              |
  |  File Name         -Data memory.v                                            |
  |  Created By        -Tharindu Rathnayaka (E/17/286) /Dhushintha R (E/17/064)  |
  |  Project/ Course   -CO502                                                    |
  |  Institute         -University of peradeniya                                 |
  |  Date              -05.04.2023                                               |
  |  Discription       -Data memory for RV32IM                           |
  |______________________________________________________________________________|
  
  */

module data_memory(CLK, RESET, READ, WRITE, ADDRESS, WRITE_DATA, READ_DATA, BUSYWAIT);

input				CLK;
input           	RESET;
input           	READ;
input           	WRITE;
input[27:0]      	ADDRESS;
input[127:0]     	WRITE_DATA;
output reg [127:0]	READ_DATA;
output reg      	BUSYWAIT;

`define READ_DELAY  #1
`define WRITE_DELAY #1

//Declare memory array 524288-bits
//512kB
reg [7:0] MEMMORY [524287:0];

integer i;

//Detecting an incoming memory access
reg READ_ACCESS, WRITE_ACCESS;

always @(*)
begin

	BUSYWAIT = (READ || WRITE)? 1 : 0;
	READ_ACCESS = (READ && !WRITE)? 1 : 0;
	WRITE_ACCESS = (!READ && WRITE)? 1 : 0;
end

//Reading & writing
always @(posedge CLK)
begin
	if(READ_ACCESS)
	begin
		READ_DATA[7:0]       = `READ_DELAY MEMMORY[{ADDRESS,4'b0000}];
		READ_DATA[15:8]      = `READ_DELAY MEMMORY[{ADDRESS,4'b0001}];
		READ_DATA[23:16]     = `READ_DELAY MEMMORY[{ADDRESS,4'b0010}];
		READ_DATA[31:24]     = `READ_DELAY MEMMORY[{ADDRESS,4'b0011}];
        READ_DATA[39:32]     = `READ_DELAY MEMMORY[{ADDRESS,4'b0100}];
		READ_DATA[47:40]     = `READ_DELAY MEMMORY[{ADDRESS,4'b0101}];
		READ_DATA[55:48]     = `READ_DELAY MEMMORY[{ADDRESS,4'b0110}];
		READ_DATA[63:56]     = `READ_DELAY MEMMORY[{ADDRESS,4'b0111}];
        READ_DATA[71:64]     = `READ_DELAY MEMMORY[{ADDRESS,4'b1000}];
		READ_DATA[79:72]     = `READ_DELAY MEMMORY[{ADDRESS,4'b1001}];
		READ_DATA[87:80]     = `READ_DELAY MEMMORY[{ADDRESS,4'b1010}];
		READ_DATA[95:88]     = `READ_DELAY MEMMORY[{ADDRESS,4'b1011}];
        READ_DATA[103:96]    = `READ_DELAY MEMMORY[{ADDRESS,4'b1100}];
		READ_DATA[111:104]   = `READ_DELAY MEMMORY[{ADDRESS,4'b1101}];
		READ_DATA[119:112]   = `READ_DELAY MEMMORY[{ADDRESS,4'b1110}];
		READ_DATA[127:120]   = `READ_DELAY MEMMORY[{ADDRESS,4'b1111}];
		BUSYWAIT = 0;
		READ_ACCESS = 0;
	end
	if(WRITE_ACCESS)
	begin
        MEMMORY[{ADDRESS,4'b0000}] = `WRITE_DELAY WRITE_DATA[7:0];
		MEMMORY[{ADDRESS,4'b0001}] = `WRITE_DELAY WRITE_DATA[15:8];
		MEMMORY[{ADDRESS,4'b0010}] = `WRITE_DELAY WRITE_DATA[23:16];
		MEMMORY[{ADDRESS,4'b0011}] = `WRITE_DELAY WRITE_DATA[31:24];
        MEMMORY[{ADDRESS,4'b0100}] = `WRITE_DELAY WRITE_DATA[39:32];
		MEMMORY[{ADDRESS,4'b0101}] = `WRITE_DELAY WRITE_DATA[47:40];
		MEMMORY[{ADDRESS,4'b0110}] = `WRITE_DELAY WRITE_DATA[55:48];
		MEMMORY[{ADDRESS,4'b0111}] = `WRITE_DELAY WRITE_DATA[63:56];
        MEMMORY[{ADDRESS,4'b1000}] = `WRITE_DELAY WRITE_DATA[71:64];
		MEMMORY[{ADDRESS,4'b1001}] = `WRITE_DELAY WRITE_DATA[79:72];
		MEMMORY[{ADDRESS,4'b1010}] = `WRITE_DELAY WRITE_DATA[87:80];
		MEMMORY[{ADDRESS,4'b1011}] = `WRITE_DELAY WRITE_DATA[95:88];
        MEMMORY[{ADDRESS,4'b1100}] = `WRITE_DELAY WRITE_DATA[103:96];
		MEMMORY[{ADDRESS,4'b1101}] = `WRITE_DELAY WRITE_DATA[111:104];
		MEMMORY[{ADDRESS,4'b1110}] = `WRITE_DELAY WRITE_DATA[119:112];
		MEMMORY[{ADDRESS,4'b1111}] = `WRITE_DELAY WRITE_DATA[127:120];
		BUSYWAIT = 0;
		WRITE_ACCESS = 0;
	end
end

//Reset memory
always @(posedge RESET)
begin
    if (RESET)
    begin
        for (i=0;i<524288; i=i+1)
            MEMMORY[i] = 8'b0;
        
        BUSYWAIT = 0;
		READ_ACCESS = 0;
		WRITE_ACCESS = 0;
    end
end

endmodule