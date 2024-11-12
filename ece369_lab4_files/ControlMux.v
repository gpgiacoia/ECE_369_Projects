`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/12/2024 03:58:05 PM
// Design Name: 
// Module Name: ControlMux
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


module ControlMux(RegWriteIn, MemWriteIn, MemReadIn, MemToRegIn, RegDstIn, ALUSrcIn,
PCSrcIn,JrAddressIn, JrDataIn, RTypeIn, ShiftMuxIn, ALUOpIn, JmuxIn, StoreDataIn, LoadDataIn,
RegWriteOut, MemWriteOut, MemReadOut, MemToRegOut, RegDstOut, ALUSrcOut,
PCSrcOut,JrAddressOut, JrDataOut, RTypeOut, ShiftMuxOut, ALUOpOut, JmuxOut, StoreDataOut, LoadDataOut, sel);

    input RegWriteIn, MemWriteIn, MemReadIn, MemToRegIn, RegDstIn, ALUSrcIn,
    PCSrcIn, JrAddressIn, JrDataIn, RTypeIn, ShiftMuxIn, sel;
    input [5:0] ALUOpIn;
    input [1:0] JmuxIn, StoreDataIn, LoadDataIn;
    
    output reg RegWriteOut, MemWriteOut, MemReadOut, MemToRegOut, RegDstOut, ALUSrcOut,
    PCSrcOut, JrAddressOut, JrDataOut, RTypeOut, ShiftMuxOut;
    output reg [5:0] ALUOpOut;
    output reg [1:0] JmuxOut, StoreDataOut, LoadDataOut;
    
    always @(*) begin
        if (sel == 1) begin // set everything to 0
            RegWriteOut <= 0;
            MemWriteOut <= 0;
            MemReadOut <= 0;
            MemToRegOut <= 0;
            RegDstOut <= 0;
            ALUSrcOut <= 0;
            PCSrcOut <= 0;
            JrAddressOut <= 0;
            JrDataOut <= 0;
            RTypeOut <= 0;
            ShiftMuxOut <= 0;
            ALUOpOut <= 0;
            JmuxOut <= 0;
            StoreDataOut <= 0;
            LoadDataOut <= 0;
        end
        
        else begin
            RegWriteOut <= RegWriteIn;
            MemWriteOut <= MemWriteIn;
            MemReadOut <= MemReadIn;
            MemToRegOut <= MemToRegIn;
            RegDstOut <= RegDstIn;
            ALUSrcOut <= ALUSrcIn;
            PCSrcOut <= PCSrcIn;
            JrAddressOut <= JrAddressIn;
            JrDataOut <= JrDataIn;
            RTypeOut <= RTypeIn;
            ShiftMuxOut <= ShiftMuxIn;
            ALUOpOut <= ALUOpIn;
            JmuxOut <= JmuxIn;
            StoreDataOut <= StoreDataIn;
            LoadDataOut <= LoadDataIn;
        end
    end

endmodule
