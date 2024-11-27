`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - ALU32Bit_tb.v
// Description - Test the 'ALU32Bit.v' module.
////////////////////////////////////////////////////////////////////////////////

module ALU32Bit_tb(); 
    reg [5:0] Opcode;   // control bits for ALU operation
    reg [31:0] A, B;	        // inputs
    reg RType;

    wire [31:0] ALUResult;	// answer
    wire Zero;	        // Zero=1 if ALUResult == 0

    ALU32Bit u0(
	.Opcode(Opcode),
	.RType(RType),
	.A(A),
	.B(B),
	.ALUResult(ALUResult),
	.Zero(Zero)
    );

    initial begin
	#10;
	RType = 1;
	Opcode = 6'b100_000;
	A = 5;
	B = -5;
	#10;
	Opcode = 6'b100_000;
	A = 10;
	B = 4;
	#10;
	Opcode = 6'b100_000;
	A = 8;
	B = 2;
	#10;
	Opcode = 6'b100_000;
	A = -5;
	B = -5;
	#10;
	Opcode = 6'b100_010;
	A = 8;
	B = 8;
	#10;
	Opcode = 6'b000_010;
	A = 4;
	B = 8;
	#10;
	Opcode = 6'b100_100;
	A = 6;
	B = 7;
	#10;
	Opcode = 6'b100_101;
	A = 5;
	B = 102;
	#10;
	Opcode = 6'b100_111;
	A = 2;
	B = 43;
	#10;
	Opcode = 6'b100_110;
	A = 4;
	B = 66;
	#10;
	Opcode = 6'b000_000;
	A = 5;
	B = 2;
	#10;
	Opcode = 6'b000_010;
	A = 12;
	B = 4;
	#10;
	Opcode = 6'b101_010;
	A = 321;
	B = 322;
	#10;
	Opcode = 6'b000_011;
	A = 4;
	B = 5;
    end
endmodule
