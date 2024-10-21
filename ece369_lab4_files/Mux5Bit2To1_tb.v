`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - Mux5Bit2To1_tb.v
// Description - Test the 5-bit 2 to 1 Mux module.
////////////////////////////////////////////////////////////////////////////////
module Mux5Bit2To1_tb();

	reg	[4:0] inA;
	reg	[4:0] inB;
	reg	sel;
    
	wire [4:0]	out;

	Mux5Bit2To1 u0(
        .out(out), 
        .inA(inA), 
        .inB(inB), 
        .sel(sel)
    );

	initial begin

        #100 inA <= 5'b10001; inB <= 5'b10100; sel <= 1'b0;
        #20 $display("sel=%d, out=%d", sel, out);

        #100 inA <= 5'b10001; inB <= 5'b10100; sel <= 1'b1;
        #20 $display("sel=%d, out=%h", sel, out);

        #100 inA <= 5'b10001; inB <= 5'b10100; sel <= 1'b0;
        #20 $display("sel=%d, out=%h", sel, out);

        #100 inA <= 5'b10001; inB <= 5'b10100; sel <= 1'b1;
        #20 $display("sel=%d, out=%h", sel, out);

	end
endmodule
