`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Name and Percent effort: Giuseppe Pongelupe Giacoia (33%), Leo Dickinson (33%), Carson Keegan (33%)
//////////////////////////////////////////////////////////////////////////////////


module TopTopModule(Reset, Clk, out7, en_out);
    input Reset, Clk; 
    output [6:0] out7;
    output [7:0] en_out;
    wire [31:0] WriteData; 
    wire [31:0] PCResult; 
    wire ClkOut;
    
    ClkDiv c(Clk, 0, ClkOut);
    TopModule x(Reset, ClkOut, PCResult, WriteData);
    Two4DigitDisplay y(Clk, WriteData[15:0], PCResult[15:0], out7, en_out);
endmodule
