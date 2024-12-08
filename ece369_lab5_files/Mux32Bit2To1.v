`timescale 1ns / 1ps

module Mux32Bit2To1(
    output [31:0] out,
    input [31:0] inA,
    input [31:0] inB,
    input sel
);
    // Use continuous assignment with ternary operator for faster muxing
    assign out = sel ? inB : inA;

endmodule
