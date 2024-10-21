`timescale 1ns / 1ps



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
    wire [31:0] PCID;
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
    wire [31:0] PCEX;
    wire [4:0] RtEX;
    wire [4:0] RdEX;
    wire [31:0] SAEX;
    wire [25:0] JTargetEX;
    wire [31:0] StoreHalfEX;
    wire [31:0] StoreByteEX;
    wire [31:0] WriteDataEX;
    wire [31:0] TempEX;
    wire [31:0] ALUB;
    wire [31:0] ALUResultEX;
    wire ALUZeroEX;
    wire [31:0]  ShiftedEX;
    wire [31:0] JumpPCEX;
    //Control Signals
    wire RegWriteEX;
    wire [5:0]ALUopEX;
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
        //Memory stuff
    //data
    wire [25:0] JTargetMem;
    wire [31:0] JumpPCMEM;
    wire ALUZeroMEM;
    wire [31:0] ALUResultMEM;
    wire [31:0] WriteDataMEM;
    wire [31:0] RAMEM;
    //controller
    wire RegWriteMEM;
    wire MemWriteMEM;
    wire MemReadMEM;
    wire MemToRegMEM;
    wire PCSrcMEM;
    wire JrAddressMEM;
    wire JrDataMEM;
    wire  [1:0] JmuxMEM, LoadDataMEM;
    
    
    ClkDiv clock(Clk, Reset, ClkOut);
    InstructionMemory instructionMemory(PC, Instruction);
    PCAdder pcAdder(PC, PCAdderResult);
        //Needs PCSrc Mux FIXME
      
    IFID ifid(ClkOut, Reset, PCAdderResult, Instruction, InstructionOut, PCID);
    
    //DECODE PHASE
    
    RegisterFile registerFile(InstructionOut[25:21], InstructionOut[20:16], 
    WriteRegister, WriteData, RegWrite, ClkOut, ReadData1, ReadData2);
    
    SignExtension signExtent_150(InstructionOut[15:0], Offset);
    SignExtension5Bit signExtent_SA(InstructionOut[10:6], SAID); 
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
    
    SignExtension storeHalfExtent(ReadData2EX[15:0], StoreHalfEX);
    SignExtension storeByteExtent(ReadData2EX[7:0], StoreByteEX);
    
    Mux32Bit3To1 writeDataMux(WriteDataEX, ReadData2EX, StoreHalfEX, StoreByteEX, StoreDataEX);
    
    Mux32Bit2To1 AluSrcMux(TempEX, ReadData2EX, OffsetEX, ALUSrcEX);
    Mux32Bit2To1 shiftMux(ALUB, TempEX, SAEX, ShiftMuxEX);
    assign ShiftedEX = OffsetEX<<2;
    assign JumpPCEX = PCEX + ShiftedEX;
    
    ALU32Bit alu(ALUOpEX, RTypeEX, ReadData1EX, ALUB, ALUResultEX, ALUZeroEX);
    
    EXMEM(
    Clk,
    Reset,
    
    // Data inputs
    JTargetEX,
    JumpPCEX, 
    ALUZero,        
    ALUResultEX,       
    WriteDataEX,   
    input wire [4:0] RegAddressIn, // RESULT FROM 5 BIT MUX FIXME         
    ReadData1EX, //Used for JR RA

    // Control inputs
    RegWriteEX,             
    MemWriteEX,             
    MemReadEX,              
    MemToRegEX,             
    LoadDataEX,             
    PCSrcEX,                
    JmuxEX,                 
    JrAddressEX,            
    JrDataEX,

    // Data outputs
    JTargetMEM,
    JumpPCMEM, 
    ALUZeroMEM,        
    ALUResultMEM,       
    WriteDataMEM,   
    output reg [4:0] RegAddressOut,          
    RAMEM, 

    // Control outputs
    RegWriteMEM,             
    MemWriteMEM,             
    MemReadMEM,            
    MemToRegMEM,             
    LoadDataMEM,            
    PCSrcMEM,            
    JmuxMEM,         
    JrAddressMEM,            
    JrDataMEM,
    );
    
endmodule
