`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/21/2024 03:02:11 PM
// Design Name: 
// Module Name: SignExtension5Bit
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


module SignExtension5Bit(in, out);
    /* A 5-Bit input word */
    input [4:0] in;
    
    /* A 32-Bit output word */
    output reg [31:0] out;
    
    always @ (in) begin
        if (in[4] == 1) begin // Check for negative or positive number
            out <= {27'b111111111111111111111111111, in};
        end
        else begin
            out <= {27'b000000000000000000000000000, in};
        end
    end
endmodule
