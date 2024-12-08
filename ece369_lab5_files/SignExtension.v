`timescale 1ns / 1ps

module SignExtension(
    input [15:0] in,
    output [31:0] out
);
    // Concatenate 16 replicated bits of in[15] to the input
    assign out = {{16{in[15]}}, in};

endmodule
