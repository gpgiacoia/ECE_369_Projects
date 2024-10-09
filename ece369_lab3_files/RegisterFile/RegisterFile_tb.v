`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - RegisterFile.v
// Description - Test the register_file
// Suggested test case - First write arbitrary values into 
// the saved and temporary registers (i.e., register 8 through 25). Then, 2-by-2, 
// read values from these registers.
////////////////////////////////////////////////////////////////////////////////


module RegisterFile_tb();

	reg [4:0] ReadRegister1;
	reg [4:0] ReadRegister2;
	reg	[4:0] WriteRegister;
	reg [31:0] WriteData;
	reg RegWrite;
	reg Clk;

	wire [31:0] ReadData1;
	wire [31:0] ReadData2;


	RegisterFile u0(
		.ReadRegister1(ReadRegister1), 
		.ReadRegister2(ReadRegister2), 
		.WriteRegister(WriteRegister), 
		.WriteData(WriteData), 
		.RegWrite(RegWrite), 
		.Clk(Clk), 
		.ReadData1(ReadData1), 
		.ReadData2(ReadData2)
	);

	initial begin
		Clk <= 1'b0;
		forever #10 Clk <= ~Clk;
	end

	initial begin
	   Clk = 0;
       RegWrite = 0;
       ReadRegister1 = 5'd0;
       ReadRegister2 = 5'd0;
       WriteRegister = 5'd0;
       WriteData = 32'd0;
       #50;
       WriteRegister = 5'd8; // write to register 8
       WriteData = 32'h00000007; 
       RegWrite = 1;
       #50;
       RegWrite = 0;
       ReadRegister1 = 5'd8; // read from register 8
       ReadRegister2 = 5'd10; // read from an empty register
       #50;
       WriteRegister = 5'd10; // write to register 10
       WriteData = 32'h0000000A;
       RegWrite = 1;
       #50;
       RegWrite = 0;
       ReadRegister1 = 5'd8; //read from register 8
       ReadRegister2 = 5'd10; // read from register 10
       #50;
       WriteRegister = 5'd15; // try writing to register 15 without regwrite
       WriteData = 32'h0000000F;
       RegWrite = 0;
       #50;
       ReadRegister1 = 5'd15; // try to read from register 15
	end

endmodule
