`timescale 1ns / 1ps


module ProgramCounter(Address, PCResult, Reset, Clk, PCSTOP);
    input [31:0] Address;
    input Reset, Clk, PCSTOP;

    output reg [31:0] PCResult;

    always @(negedge Clk) begin
        if(Reset == 1)begin
            PCResult <= 32'b0;
        end
        else if(PCSTOP != 1)begin
            PCResult <= Address;
        end
    end

endmodule

