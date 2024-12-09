`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/08/2024 06:36:03 PM
// Design Name: 
// Module Name: TopCore
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


module TopCore(Reset, Clk, X1, Y1, X2, Y2, X3, Y3, X4, Y4, X5, Y5, X6, Y6, X7, Y7, X8, Y8);
    
    input Reset, Clk;
    assign ClkOut = Clk;
    input wire [31:0] X1, Y1, X2, Y2, X3, Y3, X4, Y4, X5, Y5, X6, Y6, X7, Y7, X8, Y8;

    TopModule x1(Reset, ClkOut, X1, Y1);
    TopModCore2 x2(Reset, ClkOut, X2, Y2);
    TopModCore3 x3(Reset, ClkOut, X3, Y3);
    TopModCore4 x4(Reset, ClkOut, X4, Y4);
    TopModCore5 x5(Reset, ClkOut, X5, Y5);
    TopModCore6 x6(Reset, ClkOut, X6, Y6);
    TopModCore7 x7(Reset, ClkOut, X7, Y7);
    TopModCore8 x8(Reset, ClkOut, X8, Y8);
    

endmodule