`timescale 1ns / 1ps

module MultiCore_tb();
    reg Clk;
    reg Reset;
    wire [31:0] X;
    wire [31:0] Y;

    MultiCore multicore(
	.Clk(Clk),
	.Reset(Reset),
	.X(X),
	.Y(Y)
    );

    initial begin
	Clk <= 1'b0;
	forever #10 Clk <= ~Clk;
    end

    initial begin
	Reset <= 1;
	#50;
	Reset <= 0;
    end
endmodule
