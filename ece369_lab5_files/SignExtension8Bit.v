`timescale 1ns / 1ps

module SignExtension8Bit(
    input [7:0] in,
    output [31:0] out
);
    // Concatenate 24 replicated bits of in[7] to the input
    assign out = {{24{in[7]}}, in};

endmodule
