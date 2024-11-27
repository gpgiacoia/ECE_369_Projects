`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/21/2024 02:48:46 PM
// Design Name: 
// Module Name: JumpTarget_tb
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


module JumpTarget_tb();
    reg [31:0] PC;
    reg [25:0] jumpAddr;
    wire [31:0] out;
    
    JumpTarget j1(out, jumpAddr, PC);
    
    initial begin
        #100
        PC <= 0;
        jumpAddr <= 0;
        
        #100
        PC <= 32'b11110110100111110001010101010101;
        jumpAddr <= 26'b00000000000000000000000011;
    end
endmodule
