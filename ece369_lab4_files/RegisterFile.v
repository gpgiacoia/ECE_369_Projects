`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
//
//
// Student(s) Name and Last Name: Carson Keegan, Giuseppe Pongelupe, Leo Dickinson
//
//
// Module - register_file.v
// Description - Implements a register file with 32 32-Bit wide registers.
//
// 
// INPUTS:-
// ReadRegister1: 5-Bit address to select a register to be read through 32-Bit 
//                output port 'ReadRegister1'.
// ReadRegister2: 5-Bit address to select a register to be read through 32-Bit 
//                output port 'ReadRegister2'.
// WriteRegister: 5-Bit address to select a register to be written through 32-Bit
//                input port 'WriteRegister'.
// WriteData: 32-Bit write input port.
// RegWrite: 1-Bit control input signal.
//
// OUTPUTS:-
// ReadData1: 32-Bit registered output. 
// ReadData2: 32-Bit registered output. 
//
// FUNCTIONALITY:-
// 'ReadRegister1' and 'ReadRegister2' are two 5-bit addresses to read two 
// registers simultaneously. The two 32-bit data sets are available on ports 
// 'ReadData1' and 'ReadData2', respectively. 'ReadData1' and 'ReadData2' are 
// registered outputs (output of register file is written into these registers 
// at the falling edge of the clock). You can view it as if outputs of registers
// specified by ReadRegister1 and ReadRegister2 are written into output 
// registers ReadData1 and ReadData2 at the falling edge of the clock. 
//
// 'RegWrite' signal is high during the rising edge of the clock if the input 
// data is to be written into the register file. The contents of the register 
// specified by address 'WriteRegister' in the register file are modified at the 
// rising edge of the clock if 'RegWrite' signal is high. The D-flip flops in 
// the register file are positive-edge (rising-edge) triggered. (You have to use 
// this information to generate the write-clock properly.) 
//
// NOTE:-
// We will design the register file such that the contents of registers do not 
// change for a pre-specified time before the falling edge of the clock arrives 
// to allow for data multiplexing and setup time.
////////////////////////////////////////////////////////////////////////////////

module RegisterFile(ReadRegister1, ReadRegister2, WriteRegister, WriteData, RegWrite, Clk, ReadData1, ReadData2);
    input [4:0] ReadRegister1;
    input [4:0] ReadRegister2;
    input [4:0] WriteRegister;
    input [31:0] WriteData;
    input RegWrite;
    input Clk;
    
    output reg [31:0] ReadData1;
    output reg [31:0] ReadData2;
    
    reg [31:0] registers [31:0];

    integer i;
    
    // Ensure register $zero (registers[0]) is always zero
    initial begin
        registers[0] = 32'h0;
        registers[28] = 32'h10008000;
        registers[29] = 32'h3e8;

        $monitor("t=%0t - REG r0 = 0x%8h", $time, registers[0]);
        $monitor("t=%0t - REG at = 0x%8h", $time, registers[1]);
        $monitor("t=%0t - REG v0 = 0x%8h", $time, registers[2]);
        $monitor("t=%0t - REG v1 = 0x%8h", $time, registers[3]);
        $monitor("t=%0t - REG a0 = 0x%8h", $time, registers[4]);
        $monitor("t=%0t - REG a1 = 0x%8h", $time, registers[5]);
        $monitor("t=%0t - REG a2 = 0x%8h", $time, registers[6]);
        $monitor("t=%0t - REG a3 = 0x%8h", $time, registers[7]);
        $monitor("t=%0t - REG t0 = 0x%8h", $time, registers[8]);
        $monitor("t=%0t - REG t1 = 0x%8h", $time, registers[9]);
        $monitor("t=%0t - REG t2 = 0x%8h", $time, registers[10]);
        $monitor("t=%0t - REG t3 = 0x%8h", $time, registers[11]);
        $monitor("t=%0t - REG t4 = 0x%8h", $time, registers[12]);
        $monitor("t=%0t - REG t5 = 0x%8h", $time, registers[13]);
        $monitor("t=%0t - REG t6 = 0x%8h", $time, registers[14]);
        $monitor("t=%0t - REG t7 = 0x%8h", $time, registers[15]);
        $monitor("t=%0t - REG s0 = 0x%8h", $time, registers[16]);
        $monitor("t=%0t - REG s1 = 0x%8h", $time, registers[17]);
        $monitor("t=%0t - REG s2 = 0x%8h", $time, registers[18]);
        $monitor("t=%0t - REG s3 = 0x%8h", $time, registers[19]);
        $monitor("t=%0t - REG s4 = 0x%8h", $time, registers[20]);
        $monitor("t=%0t - REG s5 = 0x%8h", $time, registers[21]);
        $monitor("t=%0t - REG s6 = 0x%8h", $time, registers[22]);
        $monitor("t=%0t - REG s7 = 0x%8h", $time, registers[23]);
        $monitor("t=%0t - REG t8 = 0x%8h", $time, registers[24]);
        $monitor("t=%0t - REG t9 = 0x%8h", $time, registers[25]);
        $monitor("t=%0t - REG k0 = 0x%8h", $time, registers[26]);
        $monitor("t=%0t - REG k1 = 0x%8h", $time, registers[27]);
        $monitor("t=%0t - REG gp = 0x%8h", $time, registers[28]);
        $monitor("t=%0t - REG sp = 0x%8h", $time, registers[29]);
        $monitor("t=%0t - REG s8 = 0x%8h", $time, registers[30]);
        $monitor("t=%0t - REG ra = 0x%8h", $time, registers[31]);
    end
    
    always @ (negedge Clk) begin
        ReadData1 <= registers[ReadRegister1];
        ReadData2 <= registers[ReadRegister2];
    end
    
    always @ (posedge Clk) begin
        if (RegWrite == 1 && WriteRegister != 5'b00000) begin // Prevent writing to register 0
            registers[WriteRegister] = WriteData;
        end
    end

endmodule
