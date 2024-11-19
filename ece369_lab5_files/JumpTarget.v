`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/21/2024 02:27:25 PM
// Design Name: 
// Module Name: JumpTarget
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


module JumpTarget(out, jumpAddr, PC);
    output reg [31:0] out;
    
    input [31:0] PC;
    input [25:0] jumpAddr;
    
    always @ (PC, jumpAddr) begin
        out <= {PC[31:28], jumpAddr, 2'b00};
    end
endmodule
