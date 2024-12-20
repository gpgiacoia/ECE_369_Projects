`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/16/2024 03:36:56 PM
// Design Name: 
// Module Name: IFID
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


module IFID(Clk, Reset, PCIn, PCADDEDIN, PCADDEDOUT, InstructionIn, InstructionOut, PCOut, WRITE);
    input [31:0] PCIn; 
    input[31:0] PCADDEDIN;
    input [31:0] InstructionIn; 
    input Clk, Reset, WRITE;
    output reg [31:0] InstructionOut;
    output reg [31:0] PCOut;
    output reg [31:0] PCADDEDOUT;
    
    always @(posedge Clk) begin
    if (Reset) begin
        PCOut <= 0;         
        InstructionOut <= 32'b0;  
        PCADDEDOUT<= 32'b0;   
    end else if(WRITE == 1) begin
        PCOut <= PCIn;        
        InstructionOut <= InstructionIn;  
        PCADDEDOUT<=PCADDEDIN;
    end
end


    
endmodule
