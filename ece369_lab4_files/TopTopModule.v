`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/28/2024 02:26:47 PM
// Design Name: 
// Module Name: TopTopModule
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
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
