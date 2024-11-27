`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - Mux32Bit5To1_tb.v
// Description - Test the 32-bit 5 to 1 Mux module.
////////////////////////////////////////////////////////////////////////////////
module Mux32Bit5To1_tb();

	reg [31:0] in0;
	reg [31:0] in1;
	reg [31:0] in2;
	reg [31:0] in3;
	reg [31:0] in4;
	reg [2:0] sel;

	wire [31:0] out;

	Mux32Bit5To1 u0(
			.out(out), 
			.inA(inA), 
			.inB(inB), 
			.sel(sel)
       );

	initial begin

	#100 in0 <= 32'h00000000; in1 <= 32'h00000010; in2 <= 32'h00000020; in3 <= 32'h00000030; in4 <= 32'h00000040;
	sel <= 3'b000;
	#20 $display("sel=%h, out=%h", sel, out);

	#100 in0 <= 32'h00000000; in1 <= 32'h00000010; in2 <= 32'h00000020; in3 <= 32'h00000030; in4 <= 32'h00000040;
	sel <= 3'b001;
	#20 $display("sel=%h, out=%h", sel, out);

	#100 in0 <= 32'h00000000; in1 <= 32'h00000010; in2 <= 32'h00000020; in3 <= 32'h00000030; in4 <= 32'h00000040;
	sel <= 3'b010;
	#20 $display("sel=%h, out=%h", sel, out);

	#100 in0 <= 32'h00000000; in1 <= 32'h00000010; in2 <= 32'h00000020; in3 <= 32'h00000030; in4 <= 32'h00000040;
	sel <= 3'b011;
	#20 $display("sel=%h, out=%h", sel, out);

	#100 in0 <= 32'h00000000; in1 <= 32'h00000010; in2 <= 32'h00000020; in3 <= 32'h00000030; in4 <= 32'h00000040;
	sel <= 3'b100;
	#20 $display("sel=%h, out=%h", sel, out);

	end
endmodule
