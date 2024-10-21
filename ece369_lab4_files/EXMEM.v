`timescale 1ns / 1ps

module EXMEM(
    input wire Clk,
    input wire Reset,
    
    // Data inputs
    input wire [25:0] JTargetIn,
    input wire [31:0] PCAddResultIn,      
    input wire ALUZeroIn,        
    input wire [31:0] ALUResultIn,       
    input wire [31:0] MemWriteIn,   
    input wire [4:0] RegAddressIn,          
    input wire [31:0] ReadData1,

    // Control inputs
    input wire RegWrite,             
    input wire MemWrite,             
    input wire MemRead,              
    input wire MemToReg,             
    input wire [1:0]LoadData,             
    input wire PCSrc,                
    input wire [1:0]Jmux,                 
    input wire JrAddress,            
    input wire JrData,
    // Data outputs
    output reg [25:0] JTargetOut,
    output reg [31:0] PCAddResultOut,      
    output reg ALUZeroOut,        
    output reg [31:0] ALUResultOut,       
    output reg [31:0] MemWriteOut,   
    output reg [4:0] RegAddressOut,          
    output reg [31:0] ReadData1Out, 

    // Control outputs
    output reg RegWriteOut,             
    output reg MemWriteOut,             
    output reg MemReadOut,              
    output reg MemToRegOut,             
    output reg [1:0]LoadDataOut,             
    output reg PCSrcOut,                
    output reg [1:0]JmuxOut,                 
    output reg JrAddressOut,  //Maybe this is a problem? We'll find out soon           
    output reg JrDataOut
    );

    always @(posedge Clk or posedge Reset) begin
        if (Reset) begin
            // Reset all outputs to zero
            JTargetOut <= 0;
            PCAddResultOut <= 0;
            ALUZeroOut <= 0;
            ALUResultOut <= 0;
            MemWriteOut <= 0;
            RegAddressOut <= 0;
            ReadData1Out<=0;
            
            // Reset control signals
            RegWriteOut <= 0;
            MemWriteOut <= 0;
            MemReadOut <= 0;
            MemToRegOut <= 0;
            LoadDataOut <= 0;
            PCSrcOut <= 0;
            JmuxOut <= 0;
            JrAddressOut <= 0;
            JrDataOut <= 0;
        end else begin
            // Pass data inputs to outputs
            JTargetOut <= JTargetIn;
            PCAddResultOut <= PCAddResultIn;
            ALUZeroOut <= ALUZeroIn;
            ALUResultOut <= ALUResultIn;
            MemWriteOut <= MemWriteIn;
            RegAddressOut <= RegAddressIn;
            ReadData1Out<=ReadData1;

            // Pass control signals to outputs
            RegWriteOut <= RegWrite;
            MemWriteOut <= MemWrite;
            MemReadOut <= MemRead;
            MemToRegOut <= MemToReg;
            LoadDataOut <= LoadData;
            PCSrcOut <= PCSrc;
            JmuxOut <= Jmux;
            JrAddressOut <= JrAddress;
            JrDataOut <= JrData;
        end
    end

endmodule
