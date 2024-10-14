`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/09/2024 02:06:34 PM
// Design Name: 
// Module Name: InstructionFetchUnit_tb
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


module InstructionFetchUnit_tb();
    reg Clk, Reset; 
    
    wire [31:0] Instruction;
    wire [31:0] PCResult;
    
    InstructionFetchUnit bob(Instruction, PCResult, Reset, Clk);
    
    initial begin
        Clk<= 0;
        forever #10 Clk<= ~Clk;
    end
    
    initial begin
        #100;
        Reset <= 1;
        #20;
        Reset<= 0;
        #1000;
        Reset<= 1; 
        #20; 
        Reset<= 0;
     end
endmodule
