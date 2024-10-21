`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/21/2024 03:04:23 PM
// Design Name: 
// Module Name: SignExtension5Bit_tb
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


module SignExtension5Bit_tb();

    reg	[4:0] in;
    wire [31:0]	out;

    SignExtension5Bit u0(
        .in(in), .out(out)
    );
    
    initial begin

			#100 in <= 5'b00001;
			#20 $display("in=%h, out=%h", in, out);

			#100 in <= 5'b00101;
			#20 $display("in=%h, out=%h", in, out);
			
	 end

endmodule
