`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/04/2024 02:44:00 PM
// Design Name: 
// Module Name: TopModule
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


module TopModule(Reset, Clk);
    //Fetch
    input Reset, Clk; 
    wire [31:0] PC;
    wire [31:0] PCAdderResult;
    wire [31:0] Instruction; 
    wire [31:0] InstructionOut;
    wire ClkOut;
    
    //Decode
    wire [4:0] WriteRegister;
    wire [4:0] RA; //need to assign it with the value of RA constant FIXME
    wire [31:0] WriteData; 
    wire [31:0] ReadData1;
    wire [31:0] ReadData2;
    wire [31:0] Offset;
    wire [31:0] PCEX;
    wire [31:0] SAID;

    //Control Signals: 
    wire RegWriteID;
    wire [5:0]ALUopID;
    wire RegWriteID;
    wire MemWriteID;
    wire MemReadID;
    wire MemToRegID;
    wire RegDstID; 
    wire ALUSrcID;
    wire PCSrcID;
    wire JrAddressID;
    wire JrDataID;
    wire RTypeID;
    wire ShiftMuxID; 
    wire  [1:0] JmuxID, StoreDataID, LoadDataID;
            //Execute phase
    wire [31:0]ReadData1EX, ReadData2EX;
    wire [31:0] OffsetEX;
    wire [4:0] RtEX;
    wire [4:0] RdEX;
    wire [31:0] SAEX;
    wire [25:0] JTargetEX;
    //Control Signals
    wire RegWriteEX;
    wire [5:0]ALUopEX;
    wire RegWriteEX;
    wire MemWriteEX;
    wire MemReadEX;
    wire MemToRegEX;
    wire RegDstEX; 
    wire ALUSrcEX;
    wire PCSrcEX;
    wire JrAddressEX;
    wire JrDataEX;
    wire RTypeEX;
    wire ShiftMuxEX; 
    wire  [1:0] JmuxEX, StoreDataEX, LoadDataEX;
    
    ClkDiv clock(Clk, Reset, ClkOut);
    InstructionMemory instructionMemory(PC, Instruction);
    PCAdder pcAdder(PC, PCAdderResult);
        //Needs PCSrc Mux FIXME
      
    IFID ifid(ClkOut, Reset, PCAdderResult, Instruction, InstructionOut, PCID);
    
    //DECODE PHASE
    
    RegisterFile registerFile(InstructionOut[25:21], InstructionOut[20:16], 
    WriteRegister, WriteData, RegWrite, ClkOut, ReadData1, ReadData2);
    
    SignExtension signExtent_150(InstructionOut[15:0], Offset);
    //SignExtension5Bit signExtent_SA(InstructionOut[10:6], SAID); FIXME
    //MUXES Here
    Controller control(InstructionOut, ALUOpID, RegWriteID, MemWriteID, MemReadID, MemToRegID,
RegDstID, ALUSrcID, LoadDataID, PCSrcID, StoreDataID, JmuxID, JrAddressID, JrDataID, RTypeID, ShiftMuxID);//FIXME
    
    IDEX idex(
    ClkOut, 
    Reset,
    // Data Inputs
    PCID,          
    ReadData1,        
    ReadData2,       
    Offset,   
    InstructionOut[20:16],          
    InstructionOut[15:11],           
    SAID,   
    InstructionOut[25:0],       
    
    // Control Signal Inputs
    ALUOpID,          
    RegWriteID,             
    MemWriteID,             
    MemReadID,              
    MemToRegID,             
    RegDstID,               
    ALUSrcID,               
    LoadDataID,             
    PCSrcID,                
    StoreDataID,            
    JmuxID,                 
    JrAddressID,            
    JrDataID,               
    RTypeID,                
    ShiftMuxID,             
    
    // Data Outputs
    PCEX,         
    ReadData1EX,       
    ReadData2EX,       
    OffsetEX, 
    RtEX,        
    RdEX,      
    SAEX,  
    JTargetEX,
       
    
    // Control Signal Outputs
    ALUOpEX,          
    RegWriteEX,             
    MemWriteEX,             
    MemReadEX,              
    MemToRegEX,             
    RegDstEX,               
    ALUSrcEX,               
    LoadDataEX,             
    PCSrcEX,                
    StoreDataEX,            
    JmuxEX,                 
    JrAddressEX,            
    JrDataEX,               
    RTypeEX,                
    ShiftMuxEX,           
);  

// EXECUTE PHASE

    //missing regdst mux FIXME
    
    
    
    
    
    ALU32Bit alu(Opcode, RType, A, B, ALUResult, Zero)
endmodule
