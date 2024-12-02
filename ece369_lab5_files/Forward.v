`timescale 1ns / 1ps


module Forward(
    input [5:0] OPMEM,
    input [5:0] OPWB,
    input [5:0] OPEX, 
    input regWriteEX, //checks if there can be a problem dest1 or if it is storeword or something silly
    input regWriteMEM, //Checks same as other
    input [4:0] DESTEX, 
    input [4:0] DESTMEM, 
    input [4:0] DESTWB,
    
    output reg ALUAMUX,
    output reg ALUBMUX,
    output reg DATAMEMWRITE,
    output reg DATAMEMADDRESS
    );
    
endmodule
