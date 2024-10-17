`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/16/2024 08:34:48 PM
// Design Name: 
// Module Name: Controller_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Controller_tb();
    reg [31:0] Instruction;

    wire RegWrite, MemWrite, MemRead, MemToReg, RegDst, ALUSrc, PCSrc, JrAddress, JrData, RType, ShiftMux; 
    wire [5:0] ALUOp;
    wire [1:0] Jmux, StoreData, LoadData;
    
    Controller C1(Instruction, ALUOp, RegWrite, MemWrite, MemRead, MemToReg,
    RegDst, ALUSrc, LoadData, PCSrc, StoreData, Jmux, JrAddress, JrData, RType, ShiftMux);
    
    initial begin
        #100;
        Instruction <= 32'b00000001001010100100000000100000; // add instruction
        #100;
        Instruction <= 32'b000000_01001_01010_01000_00000_100010; // sub
        #100;
        Instruction <= 32'b011100_01001_01010_01000_00000_011000; // mul
        #100;
        Instruction <= 32'b000000_01001_01010_01000_00000_100100; // and
        #100;
        Instruction <= 32'b000000_01001_01010_01000_00000_100101; // or
        #100;
        Instruction <= 32'b000000_01001_01010_01000_00000_100111; // nor
        #100;
        Instruction <= 32'b000000_01001_01010_01000_00000_100110; // xor
        #100;
        Instruction <= 32'b000000_00000_01001_01000_00100_000000; // sll
        #100;
        Instruction <= 32'b000000_00000_01001_01000_00100_000010; // srl
        #100;
        Instruction <= 32'b000000_01001_01010_01000_00000_101010; // slt
        #100;
        Instruction <= 32'b000000_11111_00000_00000_00000_001000; // jr
        #100;
        Instruction <= 32'b000001_01000_00000_0000000000100000; // bltz
        #100;
        Instruction <= 32'b000001_01000_00001_0000000000100000; // bgez
        #100;
        Instruction <= 32'b000011_00000000001000010001000000; // jal
        #100;
        Instruction <= 32'b001000_01001_01000_0000000000001010; // addi
        #100;
        Instruction <= 32'b001100_01001_01000_0000000000001010; // andi
        #100;
        Instruction <= 32'b001101_01001_01000_0000000000001010; // ori
        #100;
        Instruction <= 32'b001110_01001_01000_0000000000001010; // xori
        #100;
        Instruction <= 32'b001010_01001_01000_0000000000001010; // slti
        #100;
        Instruction <= 32'b100011_01001_01000_0000000000000100; // lw
        #100;
        Instruction <= 32'b101011_01001_01000_0000000000000100; // sw
        #100;
        Instruction <= 32'b101000_01001_01000_0000000000000100; // sb
        #100;
        Instruction <= 32'b100001_01001_01000_0000000000000100; // lh
        #100;
        Instruction <= 32'b100000_01001_01000_0000000000000100; // lb
        #100;
        Instruction <= 32'b101001_01001_01000_0000000000000100; // sh
        #100;
        Instruction <= 32'b000100_01000_01001_0000000000000100; // beq
        #100;
        Instruction <= 32'b000101_01000_01001_0000000000000100; // bne
        #100;
        Instruction <= 32'b000111_01000_00000_0000000000000100; // bgtz
        #100;
        Instruction <= 32'b000110_01000_00000_0000000000000100; // blez
        #100;
        Instruction <= 32'b000010_00000000010000000000000000; // j       
        end
    
    
endmodule
