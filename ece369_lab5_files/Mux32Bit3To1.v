`timescale 1ns / 1ps

module Mux32Bit3To1(
    output [31:0] out,
    input [31:0] inA, inB, inC,
    input [1:0] sel
);
    // Use a continuous assignment with a ternary operator
    assign out = (sel == 2'b00) ? inA :
                 (sel == 2'b01) ? inB :
                 (sel == 2'b10) ? inC :
                 32'b0; // Default case for unused select values

endmodule
