`timescale 1ns / 1ps

//NOTE need to change placeholder names and corresponding signals for each instruction

module Controller(Instruction, ALUOp, RegWrite, MemWrite, MemRead, MemToReg,
RegDst, ALUSrc, LoadData, PCSrc, StoreData, Jmux, JrAddress, JrData, RType, ShiftMux);

    input [31:0] Instruction;
    
    output reg RegWrite, MemWrite, MemRead, MemToReg, RegDst, ALUSrc,
    PCSrc, JrAddress, JrData, RType, ShiftMux;
    
    output reg [5:0] ALUOp;
    output reg [1:0] Jmux, StoreData, LoadData;
    
    always @(Instruction) begin
        if (Instruction[31:26] == 6'b000000) begin // if the instruction is RType
            RType <= 1;

            case(Instruction[5:0])
                6'b100_000: begin // add Instruction
                    ALUOp <= 6'b100_000;
                    RegWrite <= 1;
                    MemWrite <= 0;
                    MemRead <= 0;
                    MemToReg <= 1;
                    RegDst <= 1;
                    ALUSrc <= 0;
                    LoadData <= 0;
                    PCSrc <= 0;
                    StoreData <= 0;
                    Jmux <= 0;
                    JrAddress <= 0;
                    JrData <= 0;
                    ShiftMux <= 0;
                    
                end
                
                6'b100_010: begin // sub Instruction
                    ALUOp <= 6'b100_010;
                    RegWrite <= 1;
                    MemWrite <= 0;
                    MemRead <= 0;
                    MemToReg <= 1;
                    RegDst <= 1;
                    ALUSrc <= 0;
                    LoadData <= 0;
                    PCSrc <= 0;
                    StoreData <= 0;
                    Jmux <= 0;
                    JrAddress <= 0;
                    JrData <= 0;
                    ShiftMux <= 0;
                    
                end
                
                6'b100_100: begin // and Instruction
                    ALUOp <= 6'b100_100;
                    RegWrite <= 1;
                    MemWrite <= 0;
                    MemRead <= 0;
                    MemToReg <= 1;
                    RegDst <= 1;
                    ALUSrc <= 0;
                    LoadData <= 0;
                    PCSrc <= 0;
                    StoreData <= 0;
                    Jmux <= 0;
                    JrAddress <= 0;
                    JrData <= 0;
                    ShiftMux <= 0;
                    
                end
                
                6'b100_101: begin // or Instruction
                    ALUOp <= 6'b100_101;
                    RegWrite <= 1;
                    MemWrite <= 0;
                    MemRead <= 0;
                    MemToReg <= 1;
                    RegDst <= 1;
                    ALUSrc <= 0;
                    LoadData <= 0;
                    PCSrc <= 0;
                    StoreData <= 0;
                    Jmux <= 0;
                    JrAddress <= 0;
                    JrData <= 0;
                    ShiftMux <= 0;
                    
                end     
                
                6'b100_111: begin // nor Instruction
                    ALUOp <= 6'b100_111;
                    RegWrite <= 1;
                    MemWrite <= 0;
                    MemRead <= 0;
                    MemToReg <= 1;
                    RegDst <= 1;
                    ALUSrc <= 0;
                    LoadData <= 0;
                    PCSrc <= 0;
                    StoreData <= 0;
                    Jmux <= 0;
                    JrAddress <= 0;
                    JrData <= 0;
                    ShiftMux <= 0;
                    
                end     
                
                6'b100_110: begin // xor Instruction
                    ALUOp <= 6'b100_110;
                    RegWrite <= 1;
                    MemWrite <= 0;
                    MemRead <= 0;
                    MemToReg <= 1;
                    RegDst <= 1;
                    ALUSrc <= 0;
                    LoadData <= 0;
                    PCSrc <= 0;
                    StoreData <= 0;
                    Jmux <= 0;
                    JrAddress <= 0;
                    JrData <= 0;
                    ShiftMux <= 0;
                    
                end      
                
                6'b000_000: begin // sll Instruction
                    ALUOp <= 6'b000_000;
                    RegWrite <= 1;
                    MemWrite <= 0;
                    MemRead <= 0;
                    MemToReg <= 1;
                    RegDst <= 1;
                    ALUSrc <= 0;
                    LoadData <= 0;
                    PCSrc <= 0;
                    StoreData <= 0;
                    Jmux <= 0;
                    JrAddress <= 0;
                    JrData <= 0;
                    ShiftMux <= 1;
                    
                end
                
                6'b000_010: begin // srl Instruction
                    ALUOp <= 6'b000_010;
                    RegWrite <= 1;
                    MemWrite <= 0;
                    MemRead <= 0;
                    MemToReg <= 1;
                    RegDst <= 1;
                    ALUSrc <= 0;
                    LoadData <= 0;
                    PCSrc <= 0;
                    StoreData <= 0;
                    Jmux <= 0;
                    JrAddress <= 0;
                    JrData <= 0;
                    ShiftMux <= 1;
                    
                end
                
                6'b101_010: begin // slt Instruction
                    ALUOp <= 6'b101_010;
                    RegWrite <= 1;
                    MemWrite <= 0;
                    MemRead <= 0;
                    MemToReg <= 1;
                    RegDst <= 1;
                    ALUSrc <= 0;
                    LoadData <= 0;
                    PCSrc <= 0;
                    StoreData <= 0;
                    Jmux <= 0;
                    JrAddress <= 0;
                    JrData <= 0;
                    ShiftMux <= 0;
                    
                end
                
                6'b001_000: begin //  jr Instruction
                    ALUOp <= 6'b001_000;
                    RegWrite <= 0;
                    MemWrite <= 0;
                    MemRead <= 0;
                    MemToReg <= 0;
                    RegDst <= 0;
                    ALUSrc <= 0;
                    LoadData <= 0;
                    PCSrc <= 1;
                    StoreData <= 0;
                    Jmux <= 1;
                    JrAddress <= 1;
                    JrData <= 1;
                    ShiftMux <= 0;
                    
                end
                
                default begin // undefined Instruction, create a bubble, all signals are 0
                    ALUOp <= 6'b111_111;
                    RegWrite <= 0;
                    MemWrite <= 0;
                    MemRead <= 0;
                    MemToReg <= 0;
                    RegDst <= 0;
                    ALUSrc <= 0;
                    LoadData <= 0;
                    PCSrc <= 0;
                    StoreData <= 0;
                    Jmux <= 0;
                    JrAddress <= 0;
                    JrData <= 0;
                    ShiftMux <= 0;
                    
                end
            endcase
        end
        
        else if (Instruction[31:26] == 6'b000001) begin // for bgez and bltz Instructions
            RType <= 0;
            
            case(Instruction[20:16])
                5'b00000: begin // bltz Instruction
                    ALUOp <= 6'b000_000;
                    RegWrite <= 0;
                    MemWrite <= 0;
                    MemRead <= 0;
                    MemToReg <= 0;
                    RegDst <= 0;
                    ALUSrc <= 0;
                    LoadData <= 0;
                    PCSrc <= 1;
                    StoreData <= 0;
                    Jmux <= 0;
                    JrAddress <= 0;
                    JrData <= 0;
                    ShiftMux <= 0;
                    
                end
                
                5'b00001: begin // bgez Instruction
                    ALUOp <= 6'b000_001; // not sure what to assign for now
                    RegWrite <= 0;
                    MemWrite <= 0;
                    MemRead <= 0;
                    MemToReg <= 0;
                    RegDst <= 0;
                    ALUSrc <= 0;
                    LoadData <= 0;
                    PCSrc <= 1;
                    StoreData <= 0;
                    Jmux <= 0;
                    JrAddress <= 0;
                    JrData <= 0;
                    ShiftMux <= 0;
                    
                end
                
                default begin // undefined Instruction, create a bubble, all signals are 0
                    ALUOp <= 6'b111_111;
                    RegWrite <= 0;
                    MemWrite <= 0;
                    MemRead <= 0;
                    MemToReg <= 0;
                    RegDst <= 0;
                    ALUSrc <= 0;
                    LoadData <= 0;
                    PCSrc <= 0;
                    StoreData <= 0;
                    Jmux <= 0;
                    JrAddress <= 0;
                    JrData <= 0;
                    ShiftMux <= 0;
                    
                end
            endcase
        end
        else if (Instruction[31:26] == 6'b011100) begin // for bgez and bltz Instructions
           RType <= 0;
           case(Instruction[5:0])
                6'b000_010: begin // mul Instruction
                    ALUOp <= 6'b011_100;
                    RegWrite <= 1;
                    MemWrite <= 0;
                    MemRead <= 0;
                    MemToReg <= 1;
                    RegDst <= 1;
                    ALUSrc <= 0;
                    LoadData <= 0;
                    PCSrc <= 0;
                    StoreData <= 0;
                    Jmux <= 0;
                    JrAddress <= 0;
                    JrData <= 0;
                    ShiftMux <= 0; 
                end
                endcase
        end
        else begin // if the Instruction is not RType
            RType <= 0;
            
            case(Instruction[31:26])                
                6'b000_011: begin // jal Instruction
                    ALUOp <= 6'b000_011;
                    RegWrite <= 1;
                    MemWrite <= 0;
                    MemRead <= 0;
                    MemToReg <= 0;
                    RegDst <= 0;
                    ALUSrc <= 0;
                    LoadData <= 0;
                    PCSrc <= 1;
                    StoreData <= 0;
                    Jmux <= 2;
                    JrAddress <= 1;
                    JrData <= 1;
                    ShiftMux <= 0;
                    
                end
                
                6'b001_000: begin // addi Instruction
                    ALUOp <= 6'b001_000;
                    RegWrite <= 1;
                    MemWrite <= 0;
                    MemRead <= 0;
                    MemToReg <= 1;
                    RegDst <= 0;
                    ALUSrc <= 1;
                    LoadData <= 0;
                    PCSrc <= 0;
                    StoreData <= 0;
                    Jmux <= 0;
                    JrAddress <= 0;
                    JrData <= 0;
                    ShiftMux <= 0;
                    
                end
                
                6'b001_100: begin // andi Instruction
                    ALUOp <= 6'b001_100;
                    RegWrite <= 1;
                    MemWrite <= 0;
                    MemRead <= 0;
                    MemToReg <= 1;
                    RegDst <= 0;
                    ALUSrc <= 1;
                    LoadData <= 0;
                    PCSrc <= 0;
                    StoreData <= 0;
                    Jmux <= 0;
                    JrAddress <= 0;
                    JrData <= 0;
                    ShiftMux <= 0;
                    
                end
                
                6'b001_101: begin // ori Instruction
                    ALUOp <= 6'b001_101;
                    RegWrite <= 1;
                    MemWrite <= 0;
                    MemRead <= 0;
                    MemToReg <= 1;
                    RegDst <= 0;
                    ALUSrc <= 1;
                    LoadData <= 0;
                    PCSrc <= 0;
                    StoreData <= 0;
                    Jmux <= 0;
                    JrAddress <= 0;
                    JrData <= 0;
                    ShiftMux <= 0;
                    
                end
                
                6'b001_110: begin // xori Instruction
                    ALUOp <= 6'b001_110;
                    RegWrite <= 1;
                    MemWrite <= 0;
                    MemRead <= 0;
                    MemToReg <= 1;
                    RegDst <= 0;
                    ALUSrc <= 1;
                    LoadData <= 0;
                    PCSrc <= 0;
                    StoreData <= 0;
                    Jmux <= 0;
                    JrAddress <= 0;
                    JrData <= 0;
                    ShiftMux <= 0;
                    
                end
                
                6'b001_010: begin // slti Instruction
                    ALUOp <= 6'b001_010;
                    RegWrite <= 1;
                    MemWrite <= 0;
                    MemRead <= 0;
                    MemToReg <= 1;
                    RegDst <= 0;
                    ALUSrc <= 1;
                    LoadData <= 0;
                    PCSrc <= 0;
                    StoreData <= 0;
                    Jmux <= 0;
                    JrAddress <= 0;
                    JrData <= 0;
                    ShiftMux <= 0;
                    
                end
                
                6'b100_011: begin // lw Instruction
                    ALUOp <= 6'b100_011;
                    RegWrite <= 1;
                    MemWrite <= 0;
                    MemRead <= 1;
                    MemToReg <= 0;
                    RegDst <= 0;
                    ALUSrc <= 1;
                    LoadData <= 0;
                    PCSrc <= 0;
                    StoreData <= 0;
                    Jmux <= 0;
                    JrAddress <= 0;
                    JrData <= 0;
                    ShiftMux <= 0;
                    
                end
                
                6'b101_011: begin //  sw Instruction
                    ALUOp <= 6'b101_011;
                    RegWrite <= 0;
                    MemWrite <= 1;
                    MemRead <= 0;
                    MemToReg <= 0;
                    RegDst <= 0;
                    ALUSrc <= 1;
                    LoadData <= 0;
                    PCSrc <= 0;
                    StoreData <= 0;
                    Jmux <= 0;
                    JrAddress <= 0;
                    JrData <= 0;
                    ShiftMux <= 0;
                    
                end
                
                6'b101_000: begin // sb Instruction
                    ALUOp <= 6'b101_000;
                    RegWrite <= 0;
                    MemWrite <= 1;
                    MemRead <= 0;
                    MemToReg <= 0;
                    RegDst <= 0;
                    ALUSrc <= 1;
                    LoadData <= 0;
                    PCSrc <= 0;
                    StoreData <= 2;
                    Jmux <= 0;
                    JrAddress <= 0;
                    JrData <= 0;
                    ShiftMux <= 0;
                    
                end
                
                6'b100_001: begin // lh Instruction
                    ALUOp <= 6'b100_001;
                    RegWrite <= 1;
                    MemWrite <= 0;
                    MemRead <= 1;
                    MemToReg <= 0;
                    RegDst <= 0;
                    ALUSrc <= 1;
                    LoadData <= 1;
                    PCSrc <= 0;
                    StoreData <= 0;
                    Jmux <= 0;
                    JrAddress <= 0;
                    JrData <= 0;
                    ShiftMux <= 0;
                    
                end
                
                6'b100_000: begin // lb Instruction
                    ALUOp <= 6'b100_000;
                    RegWrite <= 1;
                    MemWrite <= 0;
                    MemRead <= 1;
                    MemToReg <= 0;
                    RegDst <= 0;
                    ALUSrc <= 1;
                    LoadData <= 2;
                    PCSrc <= 0;
                    StoreData <= 0;
                    Jmux <= 0;
                    JrAddress <= 0;
                    JrData <= 0;
                    ShiftMux <= 0;
                    
                end
                
                6'b101_001: begin // sh Instruction
                    ALUOp <= 6'b101_001;
                    RegWrite <= 0;
                    MemWrite <= 1;
                    MemRead <= 0;
                    MemToReg <= 0;
                    RegDst <= 0;
                    ALUSrc <= 1;
                    LoadData <= 0;
                    PCSrc <= 0;
                    StoreData <= 1;
                    Jmux <= 0;
                    JrAddress <= 0;
                    JrData <= 0;
                    ShiftMux <= 0;
                    
                end
                
                6'b000_100: begin // beq Instruction
                    ALUOp <= 6'b000_100;
                    RegWrite <= 0;
                    MemWrite <= 0;
                    MemRead <= 0;
                    MemToReg <= 0;
                    RegDst <= 0;
                    ALUSrc <= 0;
                    LoadData <= 0;
                    PCSrc <= 1;
                    StoreData <= 0;
                    Jmux <= 0;
                    JrAddress <= 0;
                    JrData <= 0;
                    ShiftMux <= 0;
                    
                end
                
                6'b000_101: begin // bne Instruction
                    ALUOp <= 6'b000_101;
                    RegWrite <= 0;
                    MemWrite <= 0;
                    MemRead <= 0;
                    MemToReg <= 0;
                    RegDst <= 0;
                    ALUSrc <= 0;
                    LoadData <= 0;
                    PCSrc <= 1;
                    StoreData <= 0;
                    Jmux <= 0;
                    JrAddress <= 0;
                    JrData <= 0;
                    ShiftMux <= 0;
                    
                end
                
                6'b000_111: begin //  bgtz Instruction
                    ALUOp <= 6'b000_111;
                    RegWrite <= 0;
                    MemWrite <= 0;
                    MemRead <= 0;
                    MemToReg <= 0;
                    RegDst <= 0;
                    ALUSrc <= 0;
                    LoadData <= 0;
                    PCSrc <= 1;
                    StoreData <= 0;
                    Jmux <= 0;
                    JrAddress <= 0;
                    JrData <= 0;
                    ShiftMux <= 0;
                    
                end
                
                6'b000_110: begin // blez Instruction
                    ALUOp <= 6'b000_110;
                    RegWrite <= 0;
                    MemWrite <= 0;
                    MemRead <= 0;
                    MemToReg <= 0;
                    RegDst <= 0;
                    ALUSrc <= 0;
                    LoadData <= 0;
                    PCSrc <= 1;
                    StoreData <= 0;
                    Jmux <= 0;
                    JrAddress <= 0;
                    JrData <= 0;
                    ShiftMux <= 0;
                    
                end
                
                6'b000_010: begin // j Instruction
                    ALUOp <= 6'b000_010;
                    RegWrite <= 0;
                    MemWrite <= 0;
                    MemRead <= 0;
                    MemToReg <= 0;
                    RegDst <= 0;
                    ALUSrc <= 0;
                    LoadData <= 0;
                    PCSrc <= 1;
                    StoreData <= 0;
                    Jmux <= 2;
                    JrAddress <= 0;
                    JrData <= 0;
                    ShiftMux <= 0;
                    
                end 
                
                default begin // undefined Instruction, create a bubble, all signals are 0
                    ALUOp <= 6'b111_111;
                    RegWrite <= 0;
                    MemWrite <= 0;
                    MemRead <= 0;
                    MemToReg <= 0;
                    RegDst <= 0;
                    ALUSrc <= 0;
                    LoadData <= 0;
                    PCSrc <= 0;
                    StoreData <= 0;
                    Jmux <= 0;
                    JrAddress <= 0;
                    JrData <= 0;
                    ShiftMux <= 0;
                    
                end
            endcase
        end
    end
endmodule
