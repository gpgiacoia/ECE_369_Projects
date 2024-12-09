`timescale 1ns / 1ps

module TopModule_tb();
    reg Clk;
    reg Reset;
    wire [31:0] X;
    wire [31:0] Y;
    wire [31:0] FINALSAD;

    TopModule top_module(
	.Clk(Clk),
	.Reset(Reset),
	.X(X),
	.Y(Y),
	.FINALSAD(FINALSAD)
    );

    initial begin
	Clk <= 1'b0;
	forever #10 Clk <= ~Clk;
    end

    // 190 ns per instruction
    // first executes at 10 ns->190 ns
    // second executes at 190 ns->290 ns
    // third at 290 ns->390 ns
    initial begin
	Reset <= 1;
	#50;
	Reset <= 0;
	// #1000;
	// Reset <= 1;
	// #20;
	// Reset <= 0;
    end
endmodule
