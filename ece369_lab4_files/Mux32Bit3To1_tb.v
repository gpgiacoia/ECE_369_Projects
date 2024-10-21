`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/21/2024 02:08:38 PM
// Design Name: 
// Module Name: Mux32Bit3To1_tb
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


module Mux32Bit3To1_tb();
    reg	[31:0] inA;
	reg	[31:0] inB;
	reg [31:0] inC;
	reg	[1:0] sel;
    
	wire [31:0]	out;

	Mux32Bit3To1 u0(
        .out(out), 
        .inA(inA), 
        .inB(inB),
        .inC(inC), 
        .sel(sel)
    );
        
	initial begin

        #100 inA <= 32'h00000001; inB <= 32'h00000002; inC <= 32'h00000003; sel <= 2'b00;
        #20 $display("sel=%h, out=%h", sel, out);

        #100 inA <= 32'h00000001; inB <= 32'h00000002; inC <= 32'h00000003; sel <= 2'b01;
        #20 $display("sel=%h, out=%h", sel, out);
        
        #100 inA <= 32'h00000001; inB <= 32'h00000002; inC <= 32'h00000003; sel <= 2'b10;
        #20 $display("sel=%h, out=%h", sel, out);
        
        #100 inA <= 32'hF0000001; inB <= 32'hF0000002; inC <= 32'hF0000003; sel <= 2'b00;
        #20 $display("sel=%h, out=%h", sel, out);

        #100 inA <= 32'hF0000001; inB <= 32'hF0000002; inC <= 32'hF0000003; sel <= 2'b01;
        #20 $display("sel=%h, out=%h", sel, out);
        
        #100 inA <= 32'hF0000001; inB <= 32'hF0000002; inC <= 32'hF0000003; sel <= 2'b10;
        #20 $display("sel=%h, out=%h", sel, out);
        
	end
endmodule
