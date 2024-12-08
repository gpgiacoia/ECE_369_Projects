`timescale 1ns / 1ps

module DataMemory(
    input [31:0] Address,        // Input Address
    input [31:0] WriteData,      // Data to write into the address
    input Clk,                   // Clock signal
    input MemWrite,              // Memory write control signal
    input MemRead,               // Memory read control signal
    output [31:0] ReadData       // Contents of memory location at Address
); 

    // Memory array of 10,000 32-bit words
    reg [31:0] memory [0:9999];

    // Memory initialization
    initial $readmemh("data_memory.mem", memory);

    // Memory write on positive clock edge
    always @(posedge Clk) begin
        if (MemWrite) 
            memory[Address[31:2]] <= WriteData;
    end

    // Continuous assignment for memory read
    assign ReadData = (MemRead) ? memory[Address[31:2]] : 32'b0;

endmodule
