`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369A - Computer Architecture
// Laboratory  1
// Module - InstructionMemory.v
// Description - 32-Bit wide instruction memory.
//
// INPUT:-
// Address: 32-Bit address input port.
//
// OUTPUT:-
// Instruction: 32-Bit output port.
//
// FUNCTIONALITY:-
// Similar to the DataMemory, this module should also be byte-addressed
// (i.e., ignore bits 0 and 1 of 'Address'). All of the instructions will be 
// hard-coded into the instruction memory, so there is no need to write to the 
// InstructionMemory.  The contents of the InstructionMemory is the machine 
// language program to be run on your MIPS processor.
//
//
//we will store the machine code for a code written in C later. for now initialize 
//each entry to be its index * 3 (memory[i] = i * 3;)
//all you need to do is give an address as input and read the contents of the 
//address on your output port. 
// 
//Using a 32bit address you will index into the memory, output the contents of that specific 
//address. for data memory we are using 1K word of storage space. for the instruction memory 
//you may assume smaller size for practical purpose. you can use 128 words as the size and 
//hardcode the values.  in this case you need 7 bits to index into the memory. 
//
//be careful with the least two significant bits of the 32bit address. those help us index 
//into one of the 4 bytes in a word. therefore you will need to use bit [8-2] of the input address. 


////////////////////////////////////////////////////////////////////////////////

module InstructionMemory(Address, Instruction); 

    input [31:0] Address;        // Input Address 

    output reg [31:0] Instruction;    // Instruction at memory location Address
    
    /* Please fill in the implementation here */
    reg [31:0] memory [127:0];      // 128 words of 32-bit memory
    
    integer i;

    initial begin
        memory[0] <= 32'h00000000;	//	main:	nop
        memory[1] <= 32'h00000000;	//	loop:	nop
        memory[2] <= 32'h00000000;	//		nop
        memory[3] <= 32'h00000000;	//		nop
        memory[4] <= 32'h00000000;	//		nop
        memory[5] <= 32'h00000000;	//		nop
        memory[6] <= 32'h00000000;	//		nop
        memory[7] <= 32'h20090006;	//		addi	$t1, $zero, 6
        memory[8] <= 32'h00000000;	//		nop
        memory[9] <= 32'h00000000;	//		nop
        memory[10] <= 32'h00000000;	//		nop
        memory[11] <= 32'h00000000;	//		nop
        memory[12] <= 32'h00000000;	//		nop
        memory[13] <= 32'h200a000a;	//		addi	$t2, $zero, 10
        memory[14] <= 32'h00000000;	//		nop
        memory[15] <= 32'h00000000;	//		nop
        memory[16] <= 32'h00000000;	//		nop
        memory[17] <= 32'h00000000;	//		nop
        memory[18] <= 32'h00000000;	//		nop
        memory[19] <= 32'h00000000;	//		nop
        memory[20] <= 32'h00000000;	//		nop
        memory[21] <= 32'h00000000;	//		nop
        memory[22] <= 32'h00000000;	//		nop
        memory[23] <= 32'h00000000;	//		nop
        memory[24] <= 32'h00000000;	//		nop
        memory[25] <= 32'h00000000;	//		nop
        memory[26] <= 32'h00000000;	//		nop
        memory[27] <= 32'h00000000;	//		nop
        memory[28] <= 32'h00000000;	//		nop
        memory[29] <= 32'h00000000;	//		nop
        memory[30] <= 32'h00000000;	//		nop
        memory[31] <= 32'h00000000;	//		nop
        memory[32] <= 32'h00000000;	//		nop
        memory[33] <= 32'h00000000;	//		nop
        memory[34] <= 32'h00000000;	//		nop
        memory[35] <= 32'h00000000;	//		nop
        memory[36] <= 32'h00000000;	//		nop
        memory[37] <= 32'h00000000;	//		nop
        memory[38] <= 32'h00000000;	//		nop
        memory[39] <= 32'h00000000;	//		nop
        memory[40] <= 32'h00000000;	//		nop
        memory[41] <= 32'h00000000;	//		nop
        memory[42] <= 32'h00000000;	//		nop
        memory[43] <= 32'h00000000;	//		nop
        memory[44] <= 32'h00000000;	//		nop
        memory[45] <= 32'h00000000;	//		nop
        memory[46] <= 32'h00000000;	//		nop
        memory[47] <= 32'h00000000;	//		nop
        memory[48] <= 32'h00000000;	//		nop
        memory[49] <= 32'h000b60c0;	//		sll	$t4, $t3, 3
        memory[50] <= 32'h00000000;	//		nop
        memory[51] <= 32'h00000000;	//		nop
        memory[52] <= 32'h00000000;	//		nop
        memory[53] <= 32'h00000000;	//		nop
        memory[54] <= 32'h00000000;	//		nop
        memory[55] <= 32'h000c6882;	//		srl	$t5, $t4, 2
        memory[56] <= 32'h00000000;	//		nop
        memory[57] <= 32'h00000000;	//		nop
        memory[58] <= 32'h00000000;	//		nop
        memory[59] <= 32'h00000000;	//		nop
        memory[60] <= 32'h00000000;	//		nop
        memory[61] <= 32'h08000001;	//		j	loop
    end
    always @(Address) begin
        Instruction <= memory[Address[8:2]];
    end

    endmodule
