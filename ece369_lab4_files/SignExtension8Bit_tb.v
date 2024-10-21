`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// 
// Module - SignExtension_tb.v
// Description - Test the sign extension module.
////////////////////////////////////////////////////////////////////////////////

module SignExtension8Bit_tb();

    reg	[7:0] in;
    wire [31:0]	out;

    SignExtension8Bit u0(
        .in(in), .out(out)
    );
        
    initial begin

			#100 in <= 8'h04;
			#20 $display("in=%h, out=%h", in, out);

			#100 in <= 8'h70;
			#20 $display("in=%h, out=%h", in, out);

			#100 in <= 8'h90;
			#20 $display("in=%h, out=%h", in, out);
			
			#100 in <= 8'hF0;
			#20 $display("in=%h, out=%h", in, out);
			
	 end

endmodule
