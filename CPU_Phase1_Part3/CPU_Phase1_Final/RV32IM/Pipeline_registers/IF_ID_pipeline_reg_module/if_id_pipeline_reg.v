 /*______________________________________________________________________________
  |                                                                              |
  |  File Name         -if_id_pipeline_reg.v                                    |
  |  Created By        -Group1(E17)                                              |
  |  Project/ Course   -CO502                                                    |
  |  Institute         -University of peradeniya                                 |
  |  Date              -05.04.2023                                               |
  |  Discription       -Pipeline Register                                        |
  |______________________________________________________________________________|
  
*/
module if_id_pipeline_reg( CLK, RESET, BUSYWAIT,IN_INSTRUCTION, IN_PC, OUT_INSTRUCTION, OUT_PC);

    //declare the ports
    input [31:0] IN_INSTRUCTION, IN_PC;
    input CLK, RESET, BUSYWAIT;
    output reg [31:0] OUT_INSTRUCTION, OUT_PC;

    //RESETTING output registers
    always @ (*) begin
        if (RESET) begin
            #1;
            OUT_PC = 32'dx;
            OUT_INSTRUCTION = 32'dx;
        end
    end

    //Writing the input values to the output registers, 
    //when the RESET is low and when the CLOCK is at a positive edge and BUSYWAIT is low 
    always @(posedge CLK)
    begin
        #0;
        if (!BUSYWAIT) begin
            OUT_PC <= IN_PC;
            OUT_INSTRUCTION <= IN_INSTRUCTION;
        end
    end


endmodule