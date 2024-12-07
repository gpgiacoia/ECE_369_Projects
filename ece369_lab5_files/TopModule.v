`timescale 1ns / 1ps
//Authors: Giuseppe Pongelupe Giacoia, Leo Dickinson, Carson Keegan
//Percentage Effort (33%, 33%, 33%)
module TopModule(Reset, Clk, X, Y);
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
    wire [31:0] PCWB; 
    wire HAZARDPC, HAZARDCONTROL, HAZARDIFID; 
    wire [31:0] PCAdderResultID,PCAdderResultEX,PCAdderResultMEM,PCAdderResultWB;
    (* mark_debug = "true" *) output wire [31:0] X;
    (* mark_debug = "true" *) output wire [31:0] Y;
        wire RegWriteOut;
wire MemWriteOut;
wire MemReadOut;
wire MemToRegOut;
wire RegDstOut;
wire ALUSrcOut;
wire PCSrcOut;
wire JrAddressOut;
wire JrDataOut;
wire RTypeOut;
wire ShiftMuxOut;
wire [5:0] ALUOpOut;
wire [1:0] JmuxOut;
wire [1:0] StoreDataOut;
wire [1:0] LoadDataOut;
wire BRANCHALU;
wire [31:0] FINALINDEX, WIDTH;
wire [31:0] InstructionEX;
wire ALUAFORWARDMUX;
wire ALUBFORWARDMUX; 
wire [31:0] ALUAFINAL;
wire [31:0] ALUBFINAL;
wire [31:0] NewValue;

    // Mark the internal register as debug signal
    assign X = FINALINDEX / WIDTH;
    assign Y = FINALINDEX % WIDTH;
    
    assign ClkOut = Clk;
    HazardALU hazardalu(.Opcode(InstructionOut[31:26]),.rt(InstructionOut[20:16]), .A(ReadData1), .B(ReadData2), .ALUResult(BRANCHALU));
    assign PCSrc = PCSrcID & BRANCHALU;
    JumpTarget jtarget(JTargetResult, InstructionOut[25:0], PCAdderResultID);
    assign ShiftedEX =  Offset << 2;
    assign JumpPCEX = PCAdderResultID + ShiftedEX;

    Mux32Bit2To1 PcSrcMux(JPCValue, PCAdderResult, JumpPCEX, PCSrc);
    Mux32Bit3To1 JmuxMux(PCFinal, JPCValue , ReadData1, JTargetResult, JmuxID);
    ProgramCounter program_counter(.Address(PCFinal), .PCResult(PC), 
    .Reset(Reset), .Clk(ClkOut), .PCSTOP(HAZARDPC));

    InstructionMemory instructionMemory(PC, Instruction);

    PCAdder pcAdder(PC, PCAdderResult);
      
    IFID ifid(.Clk(ClkOut), .Reset(Reset), .PCIn(PC), .InstructionIn(Instruction), .PCADDEDIN(PCAdderResult), .PCADDEDOUT(PCAdderResultID), 
    .InstructionOut(InstructionOut), .PCOut(PCID), .WRITE(HAZARDIFID));

    //DECODE PHASE
    Mux5Bit2To1 JrAddrMux(WriteRegister, RegDestWB, RA, JrAddressWB); 
    Mux32Bit2To1 JrDatamux(WriteData, WriteDataRegWB, PCAdderResultWB, JrDataWB); //FIXME
    
    RegisterFile registerFile(.ReadRegister1(InstructionOut[25:21]), .ReadRegister2(InstructionOut[20:16]), 
    .WriteRegister(WriteRegister), .WriteData(WriteData), .RegWrite(RegWriteWB), .Clk(ClkOut), .ReadData1(ReadData1), .ReadData2(ReadData2), .FINALINDEX(FINALINDEX), .WIDTH(WIDTH));
    
    SignExtension signExtend_150(InstructionOut[15:0], Offset);
    SignExtension5Bit signExtend_SA(InstructionOut[10:6], SAID); 
    
    Hazard hazard(.instruction(InstructionOut),
    .destEX(RegDestEX), 
    .regWriteEX(RegWriteEX), //checks if there can be a problem dest1 or if it is storeword or something silly
    .destMEM(RegDestMEM), //dest from the memory phase. 
    .regWriteMEM(RegWriteMEM), //Checks same as other
    .IDIF(HAZARDIFID), 
    .PCSTOP(HAZARDPC),
    .ControlMux(HAZARDCONTROL));
    
ControlMux controlMUX(
    .RegWriteIn(RegWriteID),
    .MemWriteIn(MemWriteID),
    .MemReadIn(MemReadID),
    .MemToRegIn(MemToRegID),
    .RegDstIn(RegDstID),
    .ALUSrcIn(ALUSrcID),
    .PCSrcIn(PCSrcID),
    .JrAddressIn(JrAddressID),
    .JrDataIn(JrDataID),
    .RTypeIn(RTypeID),
    .ShiftMuxIn(ShiftMuxID),
    .ALUOpIn(ALUOpID),
    .JmuxIn(JmuxID),
    .StoreDataIn(StoreDataID),
    .LoadDataIn(LoadDataID),
    .RegWriteOut(RegWriteOut),        // Connect to output wire
    .MemWriteOut(MemWriteOut),        // Connect to output wire
    .MemReadOut(MemReadOut),          // Connect to output wire
    .MemToRegOut(MemToRegOut),        // Connect to output wire
    .RegDstOut(RegDstOut),            // Connect to output wire
    .ALUSrcOut(ALUSrcOut),            // Connect to output wire
    .PCSrcOut(PCSrcOut),              // Connect to output wire
    .JrAddressOut(JrAddressOut),      // Connect to output wire
    .JrDataOut(JrDataOut),            // Connect to output wire
    .RTypeOut(RTypeOut),              // Connect to output wire
    .ShiftMuxOut(ShiftMuxOut),        // Connect to output wire
    .ALUOpOut(ALUOpOut),              // Connect to output wire
    .JmuxOut(JmuxOut),                // Connect to output wire
    .StoreDataOut(StoreDataOut),      // Connect to output wire
    .LoadDataOut(LoadDataOut),        // Connect to output wire
    .sel(HAZARDCONTROL)                         // Control signal for mux selection
);

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
    
    IDEX idex (
    .Clk(ClkOut),
    .Reset(Reset),
    
    // Data Inputs
    .PCIn(PCID),
    .RD1In(ReadData1),
    .RD2In(ReadData2),
    .ImmediateIn(Offset),
    .rtIn(InstructionOut[20:16]),
    .rdIn(InstructionOut[15:11]),
    .saIn(SAID),
    .JTarget(InstructionOut[25:0]),
    .PCAdderResultIn(PCAdderResultID),
    .InstructionIn(InstructionOut),
    
    // Control Signal Inputs
    .ALUOp(ALUOpOut),
    .RegWrite(RegWriteOut),
    .MemWrite(MemWriteOut),
    .MemRead(MemReadOut),
    .MemToReg(MemToRegOut),
    .RegDst(RegDstOut),
    .ALUSrc(ALUSrcOut),
    .LoadData(LoadDataOut),
    .PCSrc(PCSrcOut),
    .StoreData(StoreDataOut),
    .Jmux(JmuxOut),
    .JrAddress(JrAddressOut),
    .JrData(JrDataOut),
    .RType(RTypeOut),
    .ShiftMux(ShiftMuxOut),

    // Data Outputs
    .PCAdderResultOut(PCAdderResultEX),
    .PCOut(PCEX),
    .RD1Out(ReadData1EX),
    .RD2Out(ReadData2EX),
    .ImmediateOut(OffsetEX),
    .rtOut(RtEX),
    .rdOut(RdEX),
    .saOut(SAEX),
    .JTargetOut(JTargetEX),
    .InstructionOut(InstructionEX),

    // Control Signal Outputs
    .ALUOpOut(ALUOpEX),
    .RegWriteOut(RegWriteEX),
    .MemWriteOut(MemWriteEX),
    .MemReadOut(MemReadEX),
    .MemToRegOut(MemToRegEX),
    .RegDstOut(RegDstEX),
    .ALUSrcOut(ALUSrcEX),
    .LoadDataOut(LoadDataEX),
    .PCSrcOut(PCSrcEX),
    .StoreDataOut(StoreDataEX),
    .JmuxOut(JmuxEX),
    .JrAddressOut(JrAddressEX),
    .JrDataOut(JrDataEX),
    .RTypeOut(RTypeEX),
    .ShiftMuxOut(ShiftMuxEX)
);


// EXECUTE PHASE
    Forward forward(.instruction(InstructionEX),
    .destMEM(RegDestMEM), //dest from the memory phase. 
    .regWriteMEM(RegWriteMEM), //Checks same as other
    .destWB(RegDestWB), //dest from the memory phase. 
    .regWriteWB(RegWriteWB), //Checks same as other
    .ALUAFORWARDMUX(ALUAFORWARDMUX),
    .ALUBFORWARDMUX(ALUBFORWARDMUX),
    .NewValue(NewValue),
    .ALURESULTMEM(ALUResultMEM),
    .ALURESULTWB(WriteDataRegWB) // to account for load words
);
    
    SignExtension storeHalfExtend(ReadData2EX[15:0], StoreHalfEX);
    SignExtension8Bit storeByteExtend(ReadData2EX[7:0], StoreByteEX);
    
    Mux32Bit3To1 writeDataMux(WriteDataEX, ReadData2EX, StoreHalfEX, StoreByteEX, StoreDataEX);
    
    Mux32Bit2To1 AluSrcMux(ALUB, ReadData2EX, OffsetEX, ALUSrcEX);
    Mux32Bit2To1 shiftMux(ALUA, ReadData1EX, SAEX, ShiftMuxEX); //FIXME CONNECT ALUA TO ALU

    Mux32Bit2To1 ForwardAluAMux(ALUAFINAL, ALUA, NewValue, ALUAFORWARDMUX);
    Mux32Bit2To1 ForwardAluBMux(ALUBFINAL, ALUB, NewValue, ALUBFORWARDMUX);
    
    ALU32Bit alu(ALUOpEX, RTypeEX, ALUAFINAL, ALUBFINAL, ALUResultEX, ALUZeroEX);
    
    Mux5Bit2To1 RegDestMux(RegDestEX, RtEX, RdEX, RegDstEX);
    
    EXMEM exmem(
    .Clk(ClkOut),
    .Reset(Reset),
    // Data inputs
    .JTargetIn(JTargetEX),
    .PCAddResultIn(JumpPCEX),      
    .ALUZeroIn(ALUZeroEX),        
    .ALUResultIn(ALUResultEX),       
    .MemWriteIn(WriteDataEX),   
    .RegAddressIn(RegDestEX),          
    .ReadData1(ReadData1EX),
    .PCIn(PCEX),
    // Control inputs
    .RegWrite(RegWriteEX),             
    .MemWrite(MemWriteEX),             
    .MemRead(MemReadEX),              
    .MemToReg(MemToRegEX),             
    .LoadData(LoadDataEX),             
    .PCSrc(PCSrcEX),                
    .Jmux(JmuxEX),                 
    .JrAddress(JrAddressEX),            
    .JrData(JrDataEX),
    .PCAdderResultIn(PCAdderResultEX),
    .PCAdderResultOut(PCAdderResultMEM),
    // Data outputs
    .JTargetOut(JTargetMEM),
    .PCAddResultOut(JumpPCMEM),      
    .ALUZeroOut(ALUZeroMEM),        
    .ALUResultOut(ALUResultMEM),       
    .MemWriteOut(WriteDataMEM),   
    .RegAddressOut(RegDestMEM),          
    .ReadData1Out(RAMEM), 
    .PCOut(PCMEM),

    // Control outputs
    .RegWriteOut(RegWriteMEM),             
    // Renamed to control to avoid name collision
    .MemWriteOutControl(MemWriteMEM),             
    .MemReadOut(MemReadMEM),              
    .MemToRegOut(MemToRegMEM),             
    .LoadDataOut(LoadDataMEM),             
    .PCSrcOut(PCSrcMEM),                
    .JmuxOut(JmuxMEM),                 
    .JrAddressOut(JrAddressMEM),  //Maybe this is a problem? We'll find out soon           
    .JrDataOut(JrDataMEM)

    );
    //assign PCSrc = PCSrcMEM & ALUZeroMEM;
    //JumpTarget jtarget(JTargetResult, JTargetMEM, PCMEM);
    
    //Mux32Bit2To1 PcSrcMux(JPCValue, PCAdderResult, JumpPCMEM, PCSrc);
    //Mux32Bit3To1 JmuxMux(PCFinal,JPCValue , RAMEM, JTargetResult, JmuxMEM);

    DataMemory datamemory(ALUResultMEM, WriteDataMEM, ClkOut, 
    MemWriteMEM, MemReadMEM, ReadDataMEM); 
    
    MEMWB memwb(
    .Clk(ClkOut), 
    .Reset(Reset),
    
    // Data inputs
    .MemReadData(ReadDataMEM),
    .ALUResultIn(ALUResultMEM),
    .RegAddressIn(RegDestMEM),
    .PCIn(PCMEM), 
    
    // Control inputs
    .RegWrite(RegWriteMEM),             
    .MemToReg(MemToRegMEM),             
    .LoadData(LoadDataMEM), 
    .JrAddress(JrAddressMEM),            
    .JrData(JrDataMEM),
     .PCAdderResultIn(PCAdderResultMEM),
    .PCAdderResultOut(PCAdderResultWB),
    
    // Data outputs
    .MemReadDataOut(MemReadWB),
    .ALUResultOut(ALUResultWB),
    .RegAddressOut(RegDestWB),
    .PCOut(PCWB),
    
    // Control outputs
    .RegWriteOut(RegWriteWB),             
    .MemToRegOut(MemToRegWB),             
    .LoadDataOut(LoadDataWB),
    .JrAddressOut(JrAddressWB),            
    .JrDataOut( JrDataWB)  
    );
    
    Mux32Bit2To1 MemRegMux(LWFull, MemReadWB, ALUResultWB, MemToRegWB);
    // Removed Bit, SignExtension is 16 -> 32
    SignExtension loadHalfEX(LWFull[15:0], LWHalf);
    SignExtension8Bit loadByteEX(LWFull[7:0], LWByte);

    
    Mux32Bit3To1 LoadDataMux(WriteDataRegWB, LWFull, LWHalf,LWByte, LoadDataWB);
    
    
endmodule
