`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369A - Computer Architecture
// Laboratory 
// Module - InstructionMemory_tb.v
// Description - Test the 'InstructionMemory_tb.v' module.
////////////////////////////////////////////////////////////////////////////////

module InstructionMemory_tb(); 

    wire [31:0] Instruction;

    reg [31:0] Address;

	InstructionMemory u0(
		.Address(Address),
        .Instruction(Instruction)
	);

	initial begin
	   #100;
	   Address<= 0; 
	   #100;
	   Address<= 4; 
	   #100;
	   Address<= 8; 
	   #100;
	   Address <= 12;
	   #100; 
	   Address<= 16;
	   
    /* Please fill in the implementation here... */
	
	end

endmodule

