`timescale 1ns / 1ps

module TopModule_tb();
    reg Clk;
    reg Reset;
    // wire [6:0] out7;
    // wire [7:0] en_out;

    TopModule top_module(
	.Clk(Clk),
	.Reset(Reset)
	// .out7(out7),
	// .en_out(en_out)
    );

    initial begin
	Clk <= 1'b0;
	forever #10 Clk <= ~Clk;
    end

    initial begin
	#100;
	Reset <= 1;
	#20;
	Reset <= 0;
	// #1000;
	// Reset <= 1;
	// #20;
	// Reset <= 0;
    end
endmodule
