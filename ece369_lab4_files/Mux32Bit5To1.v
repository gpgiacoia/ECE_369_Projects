`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - Mux32Bit5To1.v
// Description - Performs signal multiplexing between 5 32-Bit words.
////////////////////////////////////////////////////////////////////////////////

module Mux32Bit5To1(out, in0, in1, in2, in3, in4, sel);

    output reg [31:0] out;

    input [31:0] in0;
    input [31:0] in1;
    input [31:0] in2;
    input [31:0] in3;
    input [31:0] in4;

    input [2:0] sel;

    always @ (in0, in1, in2, in3, in4, sel) begin
	case (sel)
		3'b000: begin
			out <= in0;
		end
		3'b001: begin
			out <= in1;
		end
		3'b010: begin
			out <= in2;
		end
		3'b011: begin
			out <= in3;
		end
		3'b100: begin
			out <= in4;
		end
	endcase
    end
endmodule
