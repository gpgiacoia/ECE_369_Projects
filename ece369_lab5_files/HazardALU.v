`timescale 1ns / 1ps

module HazardALU(Opcode, RType, A, B, ALUResult);
	input [5:0] Opcode;
	input RType;
	input signed [31:0] A, B;

	output reg ALUResult;

	always @(Opcode, RType, A, B) begin
		if (RType == 1) begin
			// TODO: Should have an action here
		end
		else begin
			case(Opcode)
				// REGIMM
				// bgez
				6'b000_001: begin
					ALUResult <= A >= 0;
				end
				// beq
				6'b000_100: begin
					ALUResult <= A == B;
				end
				// bne
				6'b000_101: begin
					ALUResult <= A != B;
				end
				// bgtz
				6'b000_111: begin
					ALUResult <= A > 0;
				end
				// blez
				6'b000_110: begin
					ALUResult <= A <= 0;
				end
				// bltz
				6'b000_000: begin
					ALUResult <= A < 0;
				end
			endcase
		end
	end
endmodule
