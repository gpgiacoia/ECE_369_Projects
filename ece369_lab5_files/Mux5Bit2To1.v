`timescale 1ns / 1ps

module Mux5Bit2To1(
    output [4:0] out,
    input [4:0] inA,
    input [4:0] inB,
    input sel
);
    // Use continuous assignment for faster and cleaner combinational logic
    assign out = sel ? inB : inA;

endmodule
