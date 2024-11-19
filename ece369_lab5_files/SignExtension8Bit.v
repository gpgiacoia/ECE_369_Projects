`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/21/2024 01:42:03 PM
// Design Name: 
// Module Name: SignExtension8Bit
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


module SignExtension8Bit(in, out);

    /* A 8-Bit input word */
    input [7:0] in;
    
    /* A 32-Bit output word */
    output reg [31:0] out;
    
    always @ (in) begin
        if (in[7] == 1) begin // Check for negative or positive number
            out <= {24'b111111111111111111111111, in};
        end
        else begin
            out <= {24'b000000000000000000000000, in};
        end
    end
endmodule
