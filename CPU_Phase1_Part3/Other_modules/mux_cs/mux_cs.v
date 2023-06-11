
 /*______________________________________________________________________________
  |                                                                              |
  |  File Name         -mux_4x1-32bit.v                                          |
  |  Created By        -Group1(E17)                                              |
  |  Project/ Course   -CO502                                                    |
  |  Institute         -University of peradeniya                                 |
  |  Date              -05.04.2023                                               |
  |  Discription       -Mux                                                      |
  |______________________________________________________________________________|
  
*/
module mux_cs(IN0, IN1, IN2, IN3,IN4, IN5, IN6, IN7 ,OUT0,OUT1,OUT2,OUT3,OUT4,OUT5,OUT6,OUT7, SELECT);

    //declare the ports
    input  IN0;
    input [1:0] IN1;
    input [2:0] IN2;
    input [1:0] IN3;
    input [2:0] IN4;
    input [4:0] IN5;
    input  IN6;
    input  IN7;
    output reg  OUT0;
    output reg [1:0] OUT1;
    output reg [2:0] OUT2;
    output reg [1:0] OUT3;
    output reg [2:0] OUT4;
    output reg [4:0] OUT5;
    output reg  OUT6;
    output reg  OUT7;
    input SELECT;
   

    
    // assign OUT = (SELECT == 2'b11) ? IN3 : (SELECT == 2'b10) ? IN2 : (SELECT == 2'b01) ? IN1 : IN0;

    always @ (*) begin
        case (SELECT)
            1'b0: 
            begin
                OUT0=IN0;
                OUT1=IN1;
                OUT2=IN2;
                OUT3=IN3;
                OUT4=IN4;
                OUT5=IN5;
                OUT6=IN6;
                OUT7=IN7;
             end
             1'b1:
             begin
                OUT0=1'b0;;
                OUT1=2'b00;;
                OUT3=3'b000;;
                OUT3=2'b00;;
                OUT4=2'b00;;
                OUT5=5'b00000;;
                OUT6=1'b0;;
                OUT7=1'b0;;

             end


           
        endcase
    end

endmodule