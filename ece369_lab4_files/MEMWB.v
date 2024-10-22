`timescale 1ns / 1ps

module MEMWB(
    input wire Clk, 
    input wire Reset,
    
    // Data inputs
    input wire [31:0] MemReadData,
    input wire [31:0] ALUResultIn,
    input wire [4:0]  RegAddressIn,
    
    // Control inputs
    input wire RegWrite,             
    input wire MemToReg,             
    input wire [1:0]LoadData, 
    input wire JrAddress,            
    input wire JrData,
            
    
    // Data outputs
    output reg [31:0] MemReadDataOut,
    output reg [31:0] ALUResultOut,
    output reg [4:0]  RegAddressOut,
    
    // Control outputs
    output reg RegWriteOut,             
    output reg MemToRegOut,             
    output reg [1:0] LoadDataOut,
        output reg JrAddressOut,            
    output reg JrDataOut            
    );

    always @(posedge Clk or posedge Reset) begin
        if (Reset) begin
            // Reset all outputs to zero
            MemReadDataOut <= 0;
            ALUResultOut <= 0;
            RegAddressOut <= 0;
            

            // Reset control signals
            RegWriteOut <= 0;
            MemToRegOut <= 0;
            LoadDataOut <= 0;
            JrAddressOut <= 0;
            JrDataOut <= 0;
        end else begin
            // Pass data inputs to outputs
            MemReadDataOut <= MemReadData;
            ALUResultOut <= ALUResultIn;
            RegAddressOut <= RegAddressIn;

            // Pass control signals to outputs
            RegWriteOut <= RegWrite;
            MemToRegOut <= MemToReg;
            LoadDataOut <= LoadData;
            JrDataOut<=JrData;
            JrAddressOut<=JrAddress;
        end
    end

endmodule