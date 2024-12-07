`timescale 1ns / 1ps


module Forward(
    input [31:0] instruction,
    input [4:0] destMEM, //dest from the execute phase
    input regWriteMEM, //checks if there can be a problem dest1 or if it is storeword or something silly
    input [4:0] destWB, //dest from the memory phase. 
    input regWriteWB, //Checks same as other
    input [31:0] ALURESULTMEM,
    input [31:0] ALURESULTWB,
    output reg ALUAFORWARDMUX, 
    output reg ALUBFORWARDMUX,
    output reg [31:0] NewValue
    );

    wire [4:0] rs = instruction[25:21];
    wire [4:0] rt = instruction[20:16];
    wire [5:0] op = instruction[31:26];

    always @(*) begin
        ALUAFORWARDMUX<= 0; //0 meaning stop = false so go ahead
        ALUBFORWARDMUX<= 0; //one meaning go ahead
        if (op == 6'b100_011 || //lw
            op == 6'b100_000 || //lb
            op == 6'b100_001 || //lh
            op == 6'b001_000 ||//addi
            op == 6'b001_100 ||//andi
            op == 6'b001_101 ||//ori
            op == 6'b001_110 ||//xori
            op == 6'b001_010 //slti

            ) begin
                if((rs!=0) && ((regWriteMEM && rs == destMEM) || (regWriteWB && rs == destWB))) begin //STALL FIXME 
                    ALUAFORWARDMUX<= 1; 
                    if(regWriteMEM && rs == destMEM) begin
                        NewValue<=ALURESULTMEM;
                    end
                    else begin
                        NewValue<=ALURESULTWB;
                    end
                    //if writeback is the value that amtches rs
                    //newvalue = aluresultwb
                    //else we know it must be mem so 
                    //new value = aluresultinMEM
                end
            end
        else if(op == 6'b000_000 ||
                op == 6'b011100 //mul
                ) begin
                if((rs!=0) && ((regWriteMEM && rs == destMEM) || (regWriteWB && rs == destWB))) begin //STALL FIXME 
                    ALUAFORWARDMUX<= 1; 
                    if(regWriteMEM && rs == destMEM) begin
                        NewValue<=ALURESULTMEM;
                    end
                    else begin
                        NewValue<=ALURESULTWB;
                    end
                end
                
                if((rt!=0) && ((regWriteMEM && rt == destMEM) || (regWriteWB && rt == destWB))) begin //STALL FIXME 
                    ALUBFORWARDMUX<= 1; 
                    if(regWriteMEM && rt == destMEM) begin
                        NewValue<=ALURESULTMEM;
                    end
                    else begin
                        NewValue<=ALURESULTWB;
                    end
                end
            end
    end
endmodule
