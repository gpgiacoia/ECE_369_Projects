`timescale 1ns / 1ps

module Hazard_tb();
	reg [31:0] instruction;
	reg [4:0] destEX;
	reg regWriteEX;
	reg [4:0] destMEM;
	reg regWriteMEM;
	wire IDIF;
	wire PCSTOP;
	wire ControlMux;

	Hazard haz(instruction, destEX, regWriteEX, destMEM, regWriteMEM, IDIF, PCSTOP, ControlMux);

	initial begin
		instruction <= 6'b100_011;
		destEX <= 5'b1;
		regWriteEX <= 1'b1;
		destMEM <= 5'b1;
		regWriteMEM <= 1'b1;
		#10;
		// Should stall
		instruction <= 6'b100_011;
		destEX <= 5'b1;
		regWriteEX <= 1'b1;
		destMEM <= 5'b1;
		regWriteMEM <= 1'b1;
	end
endmodule
