`timescale 1ns / 1ps

module TopCore_tb();

    // Testbench signals
    reg Clk;
    reg Reset;
    wire [31:0] X1, Y1, X2, Y2, X3, Y3, X4, Y4, X5, Y5, X6, Y6, X7, Y7, X8, Y8;

    // Instantiate the lower-level modules
    TopModule top_module(
        .Clk(Clk),
        .Reset(Reset),
        .X(X1),  // Connect output X from TopModule to X1
        .Y(Y1)   // Connect output Y from TopModule to Y1
    );
    
    TopModCore2 top_modcore2(
        .Clk(Clk),
        .Reset(Reset),
        .X(X2),  // Connect output X from TopModCore2 to X2
        .Y(Y2)   // Connect output Y from TopModCore2 to Y2
    );
    
    TopModCore3 top_modcore3(
        .Clk(Clk),
        .Reset(Reset),
        .X(X3),  // Connect output X from TopModCore3 to X3
        .Y(Y3)   // Connect output Y from TopModCore3 to Y3
    );
    
    TopModCore4 top_modcore4(
        .Clk(Clk),
        .Reset(Reset),
        .X(X4),  // Connect output X from TopModCore4 to X4
        .Y(Y4)   // Connect output Y from TopModCore4 to Y4
    );
    
    TopModCore5 top_modcore5(
        .Clk(Clk),
        .Reset(Reset),
        .X(X5),  // Connect output X from TopModCore5 to X5
        .Y(Y5)   // Connect output Y from TopModCore5 to Y5
    );
    
    TopModCore6 top_modcore6(
        .Clk(Clk),
        .Reset(Reset),
        .X(X6),  // Connect output X from TopModCore6 to X6
        .Y(Y6)   // Connect output Y from TopModCore6 to Y6
    );
    
    TopModCore7 top_modcore7(
        .Clk(Clk),
        .Reset(Reset),
        .X(X7),  // Connect output X from TopModCore7 to X7
        .Y(Y7)   // Connect output Y from TopModCore7 to Y7
    );
    
    TopModCore8 top_modcore8(
        .Clk(Clk),
        .Reset(Reset),
        .X(X8),  // Connect output X from TopModCore8 to X8
        .Y(Y8)   // Connect output Y from TopModCore8 to Y8
    );
    

    // Instantiate the TopCore module
    TopCore top_modCore(
        .Reset(Reset),
        .Clk(Clk),
        .X1(X1),  // Connect X1 from lower modules
        .Y1(Y1),  // Connect Y1 from lower modules
        .X2(X2),
        .Y2(Y2),
        .X3(X3),
        .Y3(Y3),
        .X4(X4),
        .Y4(Y4),
        .X5(X5),
        .Y5(Y5),
        .X6(X6),
        .Y6(Y6),
        .X7(X7),
        .Y7(Y7),
        .X8(X8),
        .Y8(Y8)
    );

    initial begin
	Clk <= 1'b0;
	forever #10 Clk <= ~Clk;
    end

    // 190 ns per instruction
    // first executes at 10 ns->190 ns
    // second executes at 190 ns->290 ns
    // third at 290 ns->390 ns
    initial begin
	Reset <= 1;
	#50;
	Reset <= 0;
	// #1000;
	// Reset <= 1;
	// #20;
	// Reset <= 0;
    end
endmodule
