 /*________________________________________________________________
  |                                                                |
  |  File Name         - reg_tb.v                                  |
  |  Created By        - Group 1                                   |
  |  Project/ Course   - CO502                                     |
  |  Institute         - University of peradeniya                  |
  |  Date              - 05.04.2023                                |
  |  Discription       -                                           |
  |________________________________________________________________|
  
  */

`include "macros.v" 
`include "reg_unit.v"

module reg_file_tb;

    // Wire and Register declaration
     reg CLK, RESET, WRITE_ENABLE;
     reg [31:0] WRITE_DATA;
     wire [31:0] DATA1,DATA2;
     reg [4:0] ADDRESS1, ADDRESS2, WRITE_ADDRESS;

     //Setup register file
     reg_file my_reg_file(WRITE_DATA, DATA1, DATA2, WRITE_ADDRESS, ADDRESS1, ADDRESS2, WRITE_ENABLE, CLK, RESET);

     initial begin
         CLK = 1'b0;
         RESET = 1'b0;
         WRITE_DATA = 32'd0;
         ADDRESS1 = 5'd0;
         ADDRESS2= 5'd0;
         WRITE_ADDRESS = 5'd0;
         WRITE_ENABLE = 0;

         $dumpfile("reg_file_wavedata.vcd");
         $dumpvars(0, reg_file_tb);
     
         //Reset the Register file
         #1
         RESET = 1'b1;
         #5
         RESET = 1'b0;

        
         //TEST 1 (Register write and read)------------------------------
         //WRITE 10 to reg 1
        
         WRITE_ADDRESS = 5'd1;
         WRITE_DATA = 32'd10;
         WRITE_ENABLE = 1'b1;

         @(posedge CLK) 
             begin
                // wait for write to happen.
                #3;
                // read value of the address
                ADDRESS1 = 5'd1;
                // wait for read to happen and check value
                #3;
                `assert(DATA1, 32'd10,"TEST1");
                
             end
    
        
         // TEST 2 (Register write and read)------------------------------
         // WRITE 10 to reg 0
        
         WRITE_ADDRESS = 5'd0;
         WRITE_DATA = 32'd10;
         WRITE_ENABLE = 1'b1;

         @(posedge CLK) 
             begin
                // wait for write to happen.
                #3;
                // read value of the address
                ADDRESS2 = 5'd0;
                // wait for read to happen and check value
                #3;
                `assert(DATA2, 32'd0,"TEST2");
            
             end

         
         // TEST 3 (Register Reset)------------------------------
         #1
         RESET = 1'b1;
         #5
         ADDRESS1 = 5'd0;
         #3
         `assert(DATA1, 32'd0,"TEST3");
         RESET = 1'b0;
        
      

         #500
         $finish;
    end

     //Clock Gnerations
     always begin
        #4 CLK = ~CLK;
     end

endmodule