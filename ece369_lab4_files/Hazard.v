`timescale 1ns / 1ps


module Hazard(
    input [31:0] instruction,
    input [4:0] destEX, //dest from the execute phase
    input regWriteEX, //checks if there can be a problem dest1 or if it is storeword or something silly
    input [4:0] destMEM, //dest from the memory phase. 
    input regWriteMEM, //Checks same as other
    output reg IDIF, 
    output reg PCSTOP,
    output reg ControlMux);

    
    //check for dependencies for arithmetic instructions. 
    //if R type check for dest equals to rt or rs, 
    //if I type check for dest equals to rs
    //For arithmetic operations will stall for 3 cycles

    
    //now we have to check for lw rd, offset(base) dependency with base
    
    //Change JTarget and other branching operations to decode
    //find a way to see if the 
    wire [4:0] rs = instruction[25:21];
    wire [4:0] rt = instruction[20:16];
    wire [5:0] op = instruction[31:26];

    
    always @(*) begin
        PCSTOP<= 0; //0 meaning stop = false so go ahead
        IDIF<= 1; //one meaning go ahead
        ControlMux<= 0; //meaning control signals go ahead, not reset all to 0
        //PROBLEM FIXME: THERE COULD BE ACCIDENTAL DEPENDENCIES, IF IMMEDIATE TYPE RT IS FOUND TO BE THE SAME AS BEFORE, SHOULD NOT BE DEPENDENCY
        if (op == 6'b101_011 || //sw
            op == 6'b100_011 || //lw
            op == 6'b101_000 || //sb
            op == 6'b101_001 ||// sh
            op == 6'b100_000 || //lb
            op == 6'b100_001 || //lh
            op == 6'b001_000 ||//addi
            op == 6'b001_100 ||//andi
            op == 6'b001_101 ||//ori
            op == 6'b001_110 ||//xori
            op == 6'b001_010 ||//slti
            op == 6'b000_001 || //bgez and bltz
            op == 6'b000_111 ||//bgtz
            op == 6'b000_110 //blez
            ) begin
                if((rs!=0) && ((regWriteEX && rs == destEX) || (regWriteMEM && rs == destMEM))) begin //STALL FIXME 
                    PCSTOP<= 1; 
                    IDIF<= 0;
                    ControlMux<= 1;
                end
            end
        else if(op == 6'b000_000 ||
                op == 6'b000_100 ||//beq 
                op == 6'b000_101 ||//bne
                op == 6'b000_010 //mul
                ) begin
                if(regWriteEX && ((rs == destEX && rs !=0) || (rt == destEX && rt!=0)) 
                || (regWriteMEM && ((rs == destMEM && rs!=0) || (rt == destMEM && rt!=0)))) begin  
                    PCSTOP<= 1; 
                    IDIF<= 0;
                    ControlMux<= 1;
                end
            end
    end
endmodule
