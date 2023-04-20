 /*________________________________________________________________
  |                                                                |
  |  File Name         - reg_unit.v                                |
  |  Created By        - Group 1                                   |
  |  Project/ Course   - CO502                                     |
  |  Institute         - University of peradeniya                  |
  |  Date              - 05.04.2023                                |
  |  Discription       -                                           |
  |________________________________________________________________|
  
  */

 module reg_file(WRITE_DATA, DATA1, DATA2, WRITE_ADDRESS, ADDRESS1, ADDRESS2, WRITE_ENABLE, CLK, RESET);

     //Register array
     reg [31:0] REGISTER[0:31]; // 32 x 32 Register file

     //Port Declarations
     input [31:0] WRITE_DATA;
     input [4:0] ADDRESS1, ADDRESS2, WRITE_ADDRESS;
     input WRITE_ENABLE, CLK, RESET;
     output [31:0] DATA1, DATA2;

     //Variables
     integer count;

     //Register Read
     assign #2 DATA1 = REGISTER[ADDRESS1];   //Read Register file always when the register values changes or when the register outaddress changes
     assign #2 DATA2 = REGISTER[ADDRESS2];


     //Register write
     always @ (posedge CLK)  //Write Register file only on positive clock edges
         begin   
         #1
         if (WRITE_ENABLE & !RESET & WRITE_ADDRESS != 0) //When the write enable = 1 and reset = 0 and write address !=0
             begin
             REGISTER[WRITE_ADDRESS] = WRITE_DATA;
             end
         end

     //Register Reset
     always @ (*) 
         begin
         if (RESET) 
             begin  
             #2 for (count = 0; count < 32; count = count + 1)
             REGISTER[count] = 32'd0;   // Reset all 32  regiters
             end
         end

endmodule