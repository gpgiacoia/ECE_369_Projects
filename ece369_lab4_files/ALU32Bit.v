`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - ALU32Bit.v
// Description - 32-Bit wide arithmetic logic unit (ALU).
//
// INPUTS:-
// ALUControl: N-Bit input control bits to select an ALU operation.
// A: 32-Bit input port A.
// B: 32-Bit input port B.
//
// OUTPUTS:-
// ALUResult: 32-Bit ALU result output.
// ZERO: 1-Bit output flag. 
//
// FUNCTIONALITY:-
// Design a 32-Bit ALU, so that it supports all arithmetic operations 
// needed by the MIPS instructions given in Labs5-8.docx document. 
//   The 'ALUResult' will output the corresponding result of the operation 
//   based on the 32-Bit inputs, 'A', and 'B'. 
//   The 'Zero' flag is high when 'ALUResult' is '0'. 
//   The 'ALUControl' signal should determine the function of the ALU 
//   You need to determine the bitwidth of the ALUControl signal based on the number of 
//   operations needed to support. 
////////////////////////////////////////////////////////////////////////////////

module ALU32Bit(Opcode, RType, A, B, ALUResult, Zero);
	input [5:0] Opcode;
	input RType;
	input signed [31:0] A, B;

	output reg [31:0] ALUResult;	// answer
	output reg Zero;		// Zero=1 if ALUResult == 0


	always @(Opcode or A or B) begin
		if (RType == 1) begin
			case(Opcode)
				// R-Type
				// add
				6'b100_000: begin
					ALUResult = A + B;
				end
				// sub
				6'b100_010: begin
					ALUResult = A - B;
				end
				// and
				6'b100_100: begin
					ALUResult = A & B;
				end
				// or
				6'b100_101: begin
					ALUResult = A | B;
				end
				// nor
				6'b100_111: begin
					ALUResult = ~(A | B);
				end
				// xor
				6'b100_110: begin
					ALUResult = A ^ B;
				end
				// sll
				6'b000_000: begin
					ALUResult = B << A;
				end
				// srl
				6'b000_010: begin
					ALUResult = B >> A;
				end
				// slt
				6'b101_010: begin
					ALUResult = A < B;
				end
				// jal
				6'b000_011: begin
					ALUResult = 32'b0;
				end
			endcase
		end
		else begin
			case(Opcode)
				// addi
				6'b001_000: begin
					ALUResult = A + B;
				end
				// andi
				6'b001_100: begin
					ALUResult = A & B;
				end
				// ori
				6'b001_101: begin
					ALUResult = A | B;
				end
				// xori
				6'b001_110: begin
					ALUResult = A ^ B;
				end
				// slti
				6'b001_010: begin
					ALUResult = A < B;
				end
				// lw, sw, sb, lh, lb, sh
				6'b100_011, 6'b101_011, 6'b101_000,
				6'b100_001, 6'b100_000, 6'b101_001
				: begin
					ALUResult = A + B;
				end
				// REGIMM
				// bgez
				6'b000_001: begin
					ALUResult = A >= 0;
				end
				// beq
				6'b000_100: begin
					ALUResult = A == B;
				end
				// bne
				6'b000_101: begin
					ALUResult = A != B;
				end
				// bgtz
				6'b000_111: begin
					ALUResult = A > 0;
				end
				// blez
				6'b000_110: begin
					ALUResult = A <= 0;
				end
				// bltz
				6'b000_000: begin
					ALUResult = A < 0;
				end
				// j, jr
				6'b000_010, 6'b001_000: begin
					ALUResult = 32'b0;
				end
				// SPECIAL2 prefix: 011_100 
				// mul
				6'b011_100: begin
					ALUResult = A * B;
				end
			endcase
		end
		Zero = ALUResult != 0;
	end


	always @(ALUResult) begin
		if (RType == 1) begin
			case(Opcode)
			// R-Type
			// add
			6'b100_000: begin
				$display("t=%0t - ALU ADD RT: 0b%1b 0x%8h + 0x%8h = 0x%8h", $time, RType, A, B, ALUResult);
			end
			// sub
			6'b100_010: begin
				$display("t=%0t - ALU SUB RT: 0b%1b 0x%8h - 0x%8h = 0x%8h", $time, RType, A, B, ALUResult);
			end
			// and
			6'b100_100: begin
				$display("t=%0t - ALU AND RT: 0b%1b 0x%8h & 0x%8h = 0x%8h", $time, RType, A, B, ALUResult);
			end
			// or
			6'b100_101: begin
			$display("t=%0t - ALU OR RT: 0b%1b 0x%8h | 0x%8h = 0x%8h", $time, RType, A, B, ALUResult);
			end
			// nor
			6'b100_111: begin
				$display("t=%0t - ALU NOR RT: 0b%1b 0x%8h ~| 0x%8h = 0x%8h", $time, RType, A, B, ALUResult);
			end
			// xor
			6'b100_110: begin
				$display("t=%0t - ALU XOR RT: 0b%1b 0x%8h ^ 0x%8h = 0x%8h", $time, RType, A, B, ALUResult);
			end
			// sll
			6'b000_000: begin
				$display("t=%0t - ALU SLL RT: 0b%1b 0x%8h << 0x%8h = 0x%8h", $time, RType, B, A, ALUResult);
			end
			// srl
			6'b000_010: begin
				$display("t=%0t - ALU SRL RT: 0b%1b 0x%8h >> 0x%8h = 0x%8h", $time, RType, B, A, ALUResult);
			end
			// slt
			6'b101_010: begin
				$display("t=%0t - ALU SLT RT: 0b%1b 0x%8h < 0x%8h = 0x%8h", $time, RType, A, B, ALUResult);
			end
			// jal
			6'b000_011: begin
				$display("t=%0t - ALU JAL RT: 0b%1b A: 0x%8h B: 0x%8h R: 0x%8h", $time, RType, A, B, ALUResult);
			end
		endcase
	end
	else begin
		case(Opcode)
			// addi
			6'b001_000: begin
				$display("t=%0t - ALU ADDI RT: 0b%1b 0x%8h + 0x%8h = 0x%8h", $time, RType, A, B, ALUResult);
			end
			// andi
			6'b001_100: begin
				$display("t=%0t - ALU ANDI RT: 0b%1b 0x%8h & 0x%8h = 0x%8h", $time, RType, A, B, ALUResult);
			end
			// ori
			6'b001_101: begin
				$display("t=%0t - ALU ORI RT: 0b%1b 0x%8h | 0x%8h = 0x%8h", $time, RType, A, B, ALUResult);
			end
			// xori
			6'b001_110: begin
				$display("t=%0t - ALU XORI RT: 0b%1b 0x%8h ^ 0x%8h = 0x%8h", $time, RType, A, B, ALUResult);
			end
			// slti
			6'b001_010: begin
				$display("t=%0t - ALU SLTI RT: 0b%1b 0x%8h < 0x%8h = 0x%8h", $time, RType, A, B, ALUResult);
			end
			// lw
			6'b100_011: begin
				$display("t=%0t - ALU LW RT: 0b%1b 0x%8h + 0x%8h = 0x%8h", $time, RType, A, B, ALUResult);
			end
			// sw
			6'b101_011: begin
				$display("t=%0t - ALU SW RT: 0b%1b 0x%8h + 0x%8h = 0x%8h", $time, RType, A, B, ALUResult);
			end
			// sb
			6'b101_000: begin
				$display("t=%0t - ALU SB RT: 0b%1b 0x%8h + 0x%8h = 0x%8h", $time, RType, A, B, ALUResult);
			end
			// lh
			6'b100_001: begin
				$display("t=%0t - ALU LH RT: 0b%1b 0x%8h + 0x%8h = 0x%8h", $time, RType, A, B, ALUResult);
			end
			// lb
			6'b100_000: begin
				$display("t=%0t - ALU LB RT: 0b%1b 0x%8h + 0x%8h = 0x%8h", $time, RType, A, B, ALUResult);
			end
			// sh
			6'b101_001 : begin
				$display("t=%0t - ALU SH RT: 0b%1b 0x%8h + 0x%8h = 0x%8h", $time, RType, A, B, ALUResult);
			end
			// REGIMM
			// bgez
			6'b000_001: begin
				$display("t=%0t - ALU BGEZ RT: 0b%1b 0x%8h >= 0 = 0x%8h", $time, RType, A, ALUResult);
			end
			// beq
			6'b000_100: begin
				$display("t=%0t - ALU BEQ RT: 0b%1b 0x%8h == 0x%8h = 0x%8h", $time, RType, A, B, ALUResult);
			end
			// bne
			6'b000_101: begin
				$display("t=%0t - ALU BNE RT: 0b%1b 0x%8h != 0x%8h = 0x%8h", $time, RType, A, B, ALUResult);
			end
			// bgtz
			6'b000_111: begin
				$display("t=%0t - ALU BGTZ RT: 0b%1b 0x%8h > 0 = 0x%8h", $time, RType, A, ALUResult);
			end
			// blez
			6'b000_110: begin
				$display("t=%0t - ALU BLEZ RT: 0b%1b 0x%8h <= 0 = 0x%8h", $time, RType, A, ALUResult);
			end
			// bltz
			6'b000_000: begin
				$display("t=%0t - ALU BLTZ RT: 0b%1b 0x%8h <= 0 = 0x%8h", $time, RType, A, ALUResult);
			end
			// j, jr
			6'b000_010: begin
				$display("t=%0t - ALU J RT: 0b%1b A: 0x%8h B: 0x%8h R: 0x%8h", $time, RType, A, B, ALUResult);
			end
			6'b001_000: begin
				$display("t=%0t - ALU JR RT: 0b%1b A: 0x%8h B: 0x%8h R: 0x%8h", $time, RType, A, B, ALUResult);
			end
			// SPECIAL2 prefix: 011_100 
			// mul
			6'b011_100: begin
				$display("t=%0t - ALU MUL RT: 0b%1b 0x%8h * 0x%8h = 0x%8h", $time, RType, A, B, ALUResult);
			end
			endcase
		end
	end

	endmodule
