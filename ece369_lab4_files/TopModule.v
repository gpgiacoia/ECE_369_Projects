`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/04/2024 02:44:00 PM
// Design Name: 
// Module Name: TopModule
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


module TopModule(Reset, Clk, out7, en_out);
    input Reset, Clk; 
    output [6:0] out7;
    output [7:0] en_out;
    wire [15:0] Instruction; 
    wire [15:0] PCResult; 
    wire ClkOut;
    
    ClkDiv c(Clk, 0, ClkOut);
    InstructionFetchUnit x(Instruction, PCResult, Reset, ClkOut);
    Two4DigitDisplay y(Clk, Instruction, PCResult, out7, en_out);
    
endmodule
