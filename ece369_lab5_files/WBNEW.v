`timescale 1ns / 1ps

module WBNEW(
    input Reset,               // Reset signal
    input Clk,                 // Clock signal
    input wire regwriteIn,      // Input: regWrite control signal
    input wire [31:0] writeDataIn, // Input: data to be written
    input wire [4:0] registerIn,
    input wire [31:0] PCNEWIn,

    output reg regwriteOut,    // Output: regWrite control signal
    output reg [31:0] writeDataOut, // Output: data to be written
    output reg [4:0] registerOut,
    output reg PCNEWOut

    
);

    always @(negedge Clk or posedge Reset) begin
        if (Reset) begin
            // Reset all outputs to zero
            regwriteOut <= 0;
            writeDataOut <= 0;
            registerOut<= 0;
            PCNEWOut<= 0;
        end else begin
            // Pass inputs to outputs
            regwriteOut <= regwriteIn;
            writeDataOut <= writeDataIn;
            registerOut <= registerIn;
            PCNEWOut<=PCNEWIn;
        end
    end

endmodule
