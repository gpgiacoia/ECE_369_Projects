`timescale 1ns / 1ps

module TopModule_tb();
    reg Clk;
    reg Reset;
    wire [31:0] PCDONE;
    wire [31:0] WRITEDATADONE;

    TopModule top_module(
	.Clk(Clk),
	.Reset(Reset),
	.PCDONE(PCDONE),
	.WRITEDATADONE(WRITEDATADONE)
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
