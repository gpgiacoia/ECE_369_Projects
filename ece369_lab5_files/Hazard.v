`timescale 1ns / 1ps

module Hazard(
    input [31:0] instruction,
    input [4:0] destEX,        // Destination register from the execute phase
    input regWriteEX,          // Checks if there's a potential hazard with destEX
    input [4:0] destMEM,       // Destination register from the memory phase
    input regWriteMEM,         // Checks for hazards with destMEM
    input MemReadEX,           // Memory read signal for execute phase
    output reg IDIF,           // ID/IF pipeline stall control
    output reg PCSTOP,         // PC stop control
    output reg ControlMux      // Control signal mux control
);

    // Extract instruction fields
    wire [4:0] rs = instruction[25:21];
    wire [4:0] rt = instruction[20:16];
    wire [5:0] op = instruction[31:26];

    always @(*) begin
        // Default values (no stall)
        PCSTOP <= 0;        // 0 means proceed
        IDIF <= 1;          // 1 means go ahead
        ControlMux <= 0;    // 0 means control signals pass through
        
        // Branch instructions that depend on 'rs'
        if (op == 6'b000_001 || // bgez and bltz
            op == 6'b000_111 || // bgtz
            op == 6'b000_110    // blez
        ) begin
            if ((rs != 0) && ((regWriteEX && rs == destEX) || (regWriteMEM && rs == destMEM))) begin
                PCSTOP <= 1;
                IDIF <= 0;
                ControlMux <= 1;
            end
        end
        // Branch instructions that depend on 'rs' and 'rt'
        else if (op == 6'b000_100 || // beq
                 op == 6'b000_101    // bne
        ) begin
            if (regWriteEX && ((rs == destEX && rs != 0) || (rt == destEX && rt != 0)) || 
                regWriteMEM && ((rs == destMEM && rs != 0) || (rt == destMEM && rt != 0))) begin
                PCSTOP <= 1;
                IDIF <= 0;
                ControlMux <= 1;
            end
        end
        // Load or immediate instructions that depend on 'rs'
        else if (op == 6'b100_011 || // lw
                 op == 6'b100_000 || // lb
                 op == 6'b100_001 || // lh
                 op == 6'b001_000 || // addi
                 op == 6'b001_100 || // andi
                 op == 6'b001_101 || // ori
                 op == 6'b001_110 || // xori
                 op == 6'b001_010    // slti
        ) begin
            if ((rs != 0) && ((regWriteEX && rs == destEX) && MemReadEX)) begin
                PCSTOP <= 1;
                IDIF <= 0;
                ControlMux <= 1;
            end
        end
        // R-type and store instructions
        else if (op == 6'b000_000 || // R-type
                 op == 6'b011_100 || // mul
                 op == 6'b101_011 || // sw
                 op == 6'b101_000 || // sb
                 op == 6'b101_001    // sh
        ) begin
            if (regWriteEX && ((rs == destEX && rs != 0) || (rt == destEX && rt != 0)) && MemReadEX) begin
                PCSTOP <= 1;
                IDIF <= 0;
                ControlMux <= 1;
            end
        end
    end
endmodule
