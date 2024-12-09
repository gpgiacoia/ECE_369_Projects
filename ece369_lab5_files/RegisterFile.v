`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Student(s) Name and Last Name: Carson Keegan, Giuseppe Pongelupe, Leo Dickinson
//
// Module Name: RegisterFile
// Description: Implements a register file with 32 32-bit wide registers.
//////////////////////////////////////////////////////////////////////////////////

module RegisterFile #(
    parameter INSTANCE = 0,
    parameter STACK_REG = 39996
) (
    input [4:0] ReadRegister1, ReadRegister2, WriteRegister,
    input [31:0] WriteData,
    input RegWrite, Clk,
    output [31:0] WIDTH, FINALINDEX, MINSAD,
    output reg [31:0] ReadData1, ReadData2
);

    reg [31:0] registers [31:0];

    // Initialize the zero, global pointer, and stack pointer
    initial begin
        registers[27] = INSTANCE;
        registers[0] = 32'h0;           // $zero is always 0
        registers[28] = 32'h10008000;   // $gp (global pointer)
        registers[29] = STACK_REG;          // $sp (stack pointer)
    end

    // Assign values for WIDTH and FINALINDEX
    assign WIDTH = registers[9];      // register $9
    assign FINALINDEX = registers[11]; // register $11
    assign MINSAD = registers[22];

    // Read data from registers
    always @(*) begin
        ReadData1 = registers[ReadRegister1];
        ReadData2 = registers[ReadRegister2];
    end

    // Write to register file on rising edge of clock if RegWrite is enabled
    always @ (posedge Clk) begin
        if (RegWrite && WriteRegister != 5'b00000) begin
            registers[WriteRegister] <= WriteData; // Write data to register (non-blocking)
        end
    end

endmodule
