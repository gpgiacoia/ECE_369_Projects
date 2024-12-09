module MultiCore 
(
	input Reset,
	input Clk,
	output wire [31:0] X,
	output wire [31:0] Y 
);
	wire [31:0] X1, X2, X3, X4, X5, X6, X7, X8;
	wire [31:0] Y1, Y2, Y3, Y4, Y5, Y6, Y7, Y8;

	TopModule #(
		.DATA_MEM("data_memory.mem"),
		.INSTRUCTION_MEM("instruction_memory.mem"),
		.STACK_REG(5000)
	) core1 (
		Reset,
		Clk,
		X1,
		Y1
	);

	TopModule #(
		.DATA_MEM("data_memory2.mem"),
		.INSTRUCTION_MEM("instruction_memory2.mem"),
		.STACK_REG(2000)
	) core2 (
		Reset,
		Clk,
		X2,
		Y2
	);

	TopModule #(
		.DATA_MEM("data_memory3.mem"),
		.INSTRUCTION_MEM("instruction_memory3.mem"),
		.STACK_REG(2000)
	) core3 (
		Reset,
		Clk,
		X3,
		Y3
	);

	TopModule #(
		.DATA_MEM("data_memory4.mem"),
		.INSTRUCTION_MEM("instruction_memory4.mem"),
		.STACK_REG(2000)
	) core4 (
		Reset,
		Clk,
		X4,
		Y4
	);

	TopModule #(
		.DATA_MEM("data_memory5.mem"),
		.INSTRUCTION_MEM("instruction_memory5.mem"),
		.STACK_REG(2000)
	) core5 (
		Reset,
		Clk,
		X5,
		Y5
	);

	TopModule #(
		.DATA_MEM("data_memory6.mem"),
		.INSTRUCTION_MEM("instruction_memory6.mem"),
		.STACK_REG(2000)
	) core6 (
		Reset,
		Clk,
		X6,
		Y6
	);

	TopModule #(
		.DATA_MEM("data_memory7.mem"),
		.INSTRUCTION_MEM("instruction_memory7.mem"),
		.STACK_REG(2000)
	) core7 (
		Reset,
		Clk,
		X7,
		Y7
	);

	TopModule #(
		.DATA_MEM("data_memory8.mem"),
		.INSTRUCTION_MEM("instruction_memory8.mem"),
		.STACK_REG(2000)
	) core8 (
		Reset,
		Clk,
		X8,
		Y8
	);

endmodule
