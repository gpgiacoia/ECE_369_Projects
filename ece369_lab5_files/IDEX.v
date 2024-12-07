`timescale 1ns / 1ps



module IDEX (
    input wire Clk, 
    input wire Reset,
    
    // Data Inputs
    input wire [31:0] PCIn,          
    input wire [31:0] RD1In,        
    input wire [31:0] RD2In,       
    input wire [31:0] ImmediateIn,   
    input wire [4:0] rtIn,          
    input wire [4:0] rdIn,           
    input wire [31:0] saIn,   
    input wire [25:0]JTarget,  
    input wire [31:0] PCAdderResultIn, 
    input wire [31:0] InstructionIn,         
    
    
    // Control Signal Inputs
    input wire [5:0] ALUOp,          
    input wire RegWrite,             
    input wire MemWrite,             
    input wire MemRead,              
    input wire MemToReg,             
    input wire RegDst,               
    input wire ALUSrc,               
    input wire [1:0]LoadData,             
    input wire PCSrc,                
    input wire [1:0]StoreData,            
    input wire [1:0]Jmux,                 
    input wire JrAddress,            
    input wire JrData,               
    input wire RType,                
    input wire ShiftMux,    
    
    // Data Outputs
    output reg [31:0] PCAdderResultOut,
    output reg [31:0] PCOut,         
    output reg [31:0] RD1Out,       
    output reg [31:0] RD2Out,       
    output reg [31:0] ImmediateOut, 
    output reg [4:0] rtOut,        
    output reg [4:0] rdOut,      
    output reg [31:0] saOut,  
    output reg [25:0] JTargetOut,
    output reg [31:0] InstructionOut,         

       
    
    // Control Signal Outputs
    output reg [5:0] ALUOpOut,       
    output reg RegWriteOut,          
    output reg MemWriteOut,          
    output reg MemReadOut,           
    output reg MemToRegOut,          
    output reg RegDstOut,            
    output reg ALUSrcOut,            
    output reg [1:0]LoadDataOut,         
    output reg PCSrcOut,             
    output reg [1:0]StoreDataOut,        
    output reg [1:0]JmuxOut,           
    output reg JrAddressOut,      
    output reg JrDataOut,            
    output reg RTypeOut,          
    output reg ShiftMuxOut          
);

always @(posedge Clk or posedge Reset) begin
    if (Reset) begin
        // Reset all data outputs to zero
        PCOut <= 32'b0;
        RD1Out <= 32'b0;
        RD2Out <= 32'b0;
        ImmediateOut <= 32'b0;
        rtOut <= 5'b0;
        rdOut <= 5'b0;
        saOut <= 5'b0;
        JTargetOut<=26'b0;
        PCAdderResultOut<=32'b0;
        InstructionOut<=0;
        
        // Reset all control signal outputs to zero
        ALUOpOut <= 2'b0;
        RegWriteOut <= 1'b0;
        MemWriteOut <= 1'b0;
        MemReadOut <= 1'b0;
        MemToRegOut <= 1'b0;
        RegDstOut <= 1'b0;
        ALUSrcOut <= 1'b0;
        LoadDataOut <= 1'b0;
        PCSrcOut <= 1'b0;
        StoreDataOut <= 1'b0;
        JmuxOut <= 1'b0;
        JrAddressOut <= 1'b0;
        JrDataOut <= 1'b0;
        RTypeOut <= 1'b0;
        ShiftMuxOut <= 1'b0;
    end else begin
        // Latch data inputs to outputs on clock edge
        PCOut <= PCIn;
        RD1Out <= RD1In;
        RD2Out <= RD2In;
        ImmediateOut <= ImmediateIn;
        rtOut <= rtIn;
        rdOut <= rdIn;
        saOut <= saIn;
        JTargetOut<=JTarget;
        PCAdderResultOut<=PCAdderResultIn;
        InstructionOut<= InstructionIn;
        
        // Latch control signal inputs to outputs on clock edge
        ALUOpOut <= ALUOp;
        RegWriteOut <= RegWrite;
        MemWriteOut <= MemWrite;
        MemReadOut <= MemRead;
        MemToRegOut <= MemToReg;
        RegDstOut <= RegDst;
        ALUSrcOut <= ALUSrc;
        LoadDataOut <= LoadData;
        PCSrcOut <= PCSrc;
        StoreDataOut <= StoreData;
        JmuxOut <= Jmux;
        JrAddressOut <= JrAddress;
        JrDataOut <= JrData;
        RTypeOut <= RType;
        ShiftMuxOut <= ShiftMux;
    end
end
endmodule