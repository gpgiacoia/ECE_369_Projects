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
    assign RA = 31;
    wire [31:0] WriteData; 
    wire [31:0] ReadData1;
    wire [31:0] ReadData2;
    wire [31:0] Offset;
    wire [31:0] PCID;
    wire [31:0] SAID;

    //Control Signals: 
    wire [5:0]ALUOpID;
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
    wire [31:0] ALUA;
    wire [31:0] ALUResultEX;
    wire ALUZeroEX;
    wire [31:0] ShiftedEX;
    wire [31:0] JumpPCEX;
    wire [4:0] RegDestEX;
    //Control Signals
    wire RegWriteEX;
    wire [5:0]ALUOpEX;
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
    wire [25:0] JTargetMEM;
    wire [31:0] JumpPCMEM;
    wire ALUZeroMEM;
    wire [31:0] ALUResultMEM;
    wire [31:0] WriteDataMEM;
    wire [31:0] RAMEM;
    wire [31:0] PCMEM;
    wire [4:0] RegDestMEM;
    //controller
    wire RegWriteMEM;
    wire MemWriteMEM;
    wire MemWriteMEM;
    wire MemReadMEM;
    wire MemToRegMEM;
    wire PCSrcMEM;
    wire JrAddressMEM;
    wire JrDataMEM;
    wire [1:0] JmuxMEM, LoadDataMEM;
    wire PCSrc;
    wire [31:0] JTargetResult;
    wire [31:0] ReadDataMEM;
    wire [31:0] JPCValue;
    wire [31:0] PCFinal;
        //Writeback stage
    //Wires for wb
    wire [31:0] MemReadWB;
    wire [31:0] ALUResultWB;
    wire RegWriteWB;
    wire MemToRegWB;
    wire [1:0] LoadDataWB;
    wire [4:0] RegDestWB;
    wire [31:0] LWFull, LWHalf, LWByte;
    wire [31:0] WriteDataRegWB;
    wire JrAddressWB, JrDataWB;
    
    // TODO: Uncomment clock, temporary for use in test bench
    // ClkDiv clock(Clk, Reset, ClkOut);
    assign ClkOut = Clk;

    InstructionMemory instructionMemory(PC, Instruction);
    ProgramCounter program_counter(PCFinal, PC, Reset, ClkOut);

    PCAdder pcAdder(PC, PCAdderResult);
      
    IFID ifid(ClkOut, Reset, PCAdderResult, Instruction, InstructionOut, PCID);

    //DECODE PHASE
    Mux5Bit2To1 JrAddrMux(WriteRegister, RegDestWB, RA, JrAddressWB); 
    Mux32Bit2To1 JrDatamux(WriteData, WriteDataRegWB, PCID, JrDataWB); //FIXME
    
    RegisterFile registerFile(InstructionOut[25:21], InstructionOut[20:16], 
    WriteRegister, WriteData, RegWriteWB, ClkOut, ReadData1, ReadData2);
    
    SignExtension signExtend_150(InstructionOut[15:0], Offset);
    SignExtension5Bit signExtend_SA(InstructionOut[10:6], SAID); 
    //MUXES Here
    Controller control(
        InstructionOut,
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
        ShiftMuxID
    );//FIXME
    
    
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
    ShiftMuxEX
);  

// EXECUTE PHASE

    
    SignExtension storeHalfExtend(ReadData2EX[15:0], StoreHalfEX);
    SignExtension8Bit storeByteExtend(ReadData2EX[7:0], StoreByteEX);
    
    Mux32Bit3To1 writeDataMux(WriteDataEX, ReadData2EX, StoreHalfEX, StoreByteEX, StoreDataEX);
    
    Mux32Bit2To1 AluSrcMux(ALUB, ReadData2EX, OffsetEX, ALUSrcEX);
    Mux32Bit2To1 shiftMux(ALUA, ReadData1EX, SAEX, ShiftMuxEX); //FIXME CONNECT ALUA TO ALU
    assign ShiftedEX = OffsetEX<<2;
    assign JumpPCEX = PCEX + ShiftedEX;
    
    ALU32Bit alu(ALUOpEX, RTypeEX, ALUA, ALUB, ALUResultEX, ALUZeroEX);
    
    Mux5Bit2To1 RegDestMux(RegDestEX, RtEX, RdEX, RegDstEX);
    
    EXMEM exmem(
    ClkOut,
    Reset,
    
    // Data inputs
    JTargetEX,
    JumpPCEX, 
    ALUZeroEX,        
    ALUResultEX,       
    WriteDataEX,   
    RegDestEX, // RESULT FROM 5 BIT MUX FIXME         
    ReadData1EX, //Used for JR RA
    PCEX,

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
    RegDestMEM,          
    RAMEM, 
    PCMEM,


    // Control outputs
    RegWriteMEM,
    MemWriteMEM,
    MemReadMEM,
    MemToRegMEM,
    LoadDataMEM,
    PCSrcMEM,
    JmuxMEM,
    JrAddressMEM,
    JrDataMEM
    );
    
    
    assign PCSrc = PCSrcMEM && ALUZeroMEM;
    JumpTarget jtarget(JTargetResult, JTargetMEM, PCMEM);

    Mux32Bit3To1 JmuxMux(JPCValue, JumpPCMEM, RAMEM, JTargetResult, JmuxMEM);
    Mux32Bit2To1 PcSrcMux(PCFinal, PCAdderResult, JPCValue, PCSrc);

    DataMemory datamemory(ALUResultMEM, WriteDataMEM, ClkOut, 
    MemWriteMEM, MemReadMEM, ReadDataMEM); 
    
    MEMWB memwb(
        ClkOut, 
        Reset,
        
        // Data inputs
        ReadDataMEM,
        ALUResultMEM,
        RegDestMEM,
        
        // Control inputs
        RegWriteMEM,             
        MemToRegMEM,             
        LoadDataMEM, 
        JrAddressMEM,            
        JrDataMEM,   
         
        // Data outputs
        MemReadWB, 
        ALUResultWB,
        RegDestWB,
        
        // Control outputs
        RegWriteWB,             
        MemToRegWB,             
        LoadDataWB,
        JrAddressWB,       
        JrDataWB
    );
    
    Mux32Bit2To1 MemRegMux(LWFull, MemReadWB, ALUResultWB, MemToRegWB);
    // Removed Bit, SignExtension is 16 -> 32
    SignExtension loadHalfEx(LWFull[15:0], LWHalf);
    SignExtension8Bit loadByteEx(LWFull[7:0], LWHalf);

    
    Mux32Bit3To1 LoadDataMux(WriteDataRegWB, LWFull, LWHalf,LWByte, LoadDataWB);
    
    
endmodule
