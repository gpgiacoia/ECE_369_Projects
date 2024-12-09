module MultiCore 
(
	input Reset,
	input Clk,
	output wire [31:0] X,
	output wire [31:0] Y,
	output wire [31:0] SAD
);
	wire [31:0] X1, X2, X3, X4, X5, X6, X7, X8;
	wire [31:0] Y1, Y2, Y3, Y4, Y5, Y6, Y7, Y8;
	wire [31:0] SAD1, SAD2, SAD3, SAD4, SAD5, SAD6, SAD7, SAD8;

	assign X = X4;
	assign Y = Y4;
	assign SAD = SAD4;

	TopModule #(
		.INSTANCE(1),
		.DATA_MEM("data_memory.mem"),
		.INSTRUCTION_MEM("instruction_memory.mem"),
		.STACK_REG(2640)
	) core1 (
		Reset,
		Clk,
		X1,
		Y1,
		SAD1
	);

	TopModule #(
		.INSTANCE(2),
		.DATA_MEM("data_memory2.mem"),
		.INSTRUCTION_MEM("instruction_memory2.mem"),
		.STACK_REG(2636)
	) core2 (
		Reset,
		Clk,
		X2,
		Y2,
		SAD2
	);

	TopModule #(
		.INSTANCE(3),
		.DATA_MEM("data_memory3.mem"),
		.INSTRUCTION_MEM("instruction_memory3.mem"),
		.STACK_REG(2632)
	) core3 (
		Reset,
		Clk,
		X3,
		Y3,
		SAD3
	);

	TopModule #(
		.INSTANCE(4),
		.DATA_MEM("data_memory4.mem"),
		.INSTRUCTION_MEM("instruction_memory4.mem"),
		.STACK_REG(2628)
	) core4 (
		Reset,
		Clk,
		X4,
		Y4,
		SAD4
	);

	TopModule #(
		.INSTANCE(5),
		.DATA_MEM("data_memory5.mem"),
		.INSTRUCTION_MEM("instruction_memory5.mem"),
		.STACK_REG(2624)
	) core5 (
		Reset,
		Clk,
		X5,
		Y5,
		SAD5
	);

	TopModule #(
		.INSTANCE(6),
		.DATA_MEM("data_memory6.mem"),
		.INSTRUCTION_MEM("instruction_memory6.mem"),
		.STACK_REG(2620)
	) core6 (
		Reset,
		Clk,
		X6,
		Y6,
		SAD6
	);

	TopModule #(
		.INSTANCE(7),
		.DATA_MEM("data_memory7.mem"),
		.INSTRUCTION_MEM("instruction_memory7.mem"),
		.STACK_REG(2618)
	) core7 (
		Reset,
		Clk,
		X7,
		Y7,
		SAD7
	);

	TopModule #(
		.INSTANCE(8),
		.DATA_MEM("data_memory8.mem"),
		.INSTRUCTION_MEM("instruction_memory8.mem"),
		.STACK_REG(2614)
	) core8 (
		Reset,
		Clk,
		X8,
		Y8,
		SAD8
	);

endmodule
