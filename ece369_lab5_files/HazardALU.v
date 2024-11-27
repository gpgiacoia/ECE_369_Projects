`timescale 1ns / 1ps

module HazardALU(Opcode, rt, A, B, ALUResult);
	input [5:0] Opcode;
	input [4:0] rt;
	input signed [31:0] A, B;

	output reg ALUResult;

	always @(Opcode, A, B) begin
			case(Opcode)
				// REGIMM
				// bgez and bltz
				6'b000_001: begin
				if (rt == 5'b00001)begin 
				    //bgez
					ALUResult <= A >= 0;
					end else begin
					   ALUResult <= A < 0;
					end
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
			endcase
	end
endmodule
