`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - DataMemory_tb.v
// Description - Test the 'DataMemory.v' module.
////////////////////////////////////////////////////////////////////////////////

module DataMemory_tb(); 

    reg     [31:0]  Address;
    reg     [31:0]  WriteData;
    reg             Clk;
    reg             MemWrite;
    reg             MemRead;

    wire [31:0] ReadData;

    DataMemory u0(
        .Address(Address), 
        .WriteData(WriteData), 
        .Clk(Clk), 
        .MemWrite(MemWrite), 
        .MemRead(MemRead), 
        .ReadData(ReadData)
    ); 

	initial begin
		Clk <= 1'b0;
		forever #10 Clk <= ~Clk;
	end

	initial begin
       Clk = 0;
       MemWrite = 0;
       MemRead = 0;
       Address = 32'b0;
       WriteData = 32'b0;
       #50;
        WriteData = 32'h00000005; // writing test
        Address = 32'h0000000C;  
        MemWrite = 1;
        MemRead = 0;
        #50;
        MemWrite = 0; //test reading
        MemRead = 1;
        #50;
        WriteData = 32'h00000009; //testing a second write
        Address = 32'h00000010;
        MemWrite = 1;
        MemRead = 0;
        #50;
       	MemWrite = 0; //test reading new adress
        MemRead = 1;
        #50;
        Address = 32'h0000000C; // check read from previous Address
        #50;
        Address = 32'h12345678; // check read from an unwritten adress
        #50;
        MemRead = 0;
        
	end

endmodule

