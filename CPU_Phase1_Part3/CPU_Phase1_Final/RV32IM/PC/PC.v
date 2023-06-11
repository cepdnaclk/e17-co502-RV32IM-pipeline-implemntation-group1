 /*______________________________________________________________________________
  |                                                                              |
  |  File Name         -PC.v                                                     |
  |  Created By        -Group1(E17)                                              |
  |  Project/ Course   -CO502                                                    |
  |  Institute         -University of peradeniya                                 |
  |  Date              -05.04.2023                                               |
  |  Discription       -PC                                                       |
  |______________________________________________________________________________|
  
*/


module PC_UNIT(CLK,RESET,BRANCH_PC,CON_BRANCH,PC_DEC,BUSY_WAIT,PC,PC_4);
	//declaring inputs and outputs
	input [31:0] BRANCH_PC;
	input CLK,RESET,CON_BRANCH,BUSY_WAIT,PC_DEC;
	
	output reg [31:0] PC;
	output reg [31:0] PC_4;
	//declaring wires
	
	reg [31:0] pc_hold;
	initial begin   //initial settings
		pc_hold = 32'b0;//initialy it is zero
		end
	always @(posedge CLK,posedge RESET) begin
		#1
		if(RESET == 1'b0  && BUSY_WAIT ==1'b0 )begin  //normal mood
			pc_hold = pc_hold + 4; 
		end
		if(RESET == 1'b0  && BUSY_WAIT ==1'b0 && PC_DEC ==1'b1 )begin  //load uses data hazards
			pc_hold = pc_hold - 4; 
		end
		
		
		if(RESET == 1'b0 && CON_BRANCH == 1'b1 && BUSY_WAIT ==1'b0) begin
			pc_hold = pc_hold + BRANCH_PC;
		
		end
		
		if(RESET == 1'b1) begin //if the reset happen
		pc_hold = -4; 
		end
		
		#1   //delay to update the pc 
		PC = pc_hold;
		PC_4 = pc_hold + 4;
	end
	


endmodule