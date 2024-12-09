module MEMWB(
    input Clk, 
    input Reset,
    
    // Data inputs
    input wire [31:0] WriteDataIn,
    input wire [4:0] RegAddressIn,
    input wire [31:0] PCIn,
    
    // Control inputs
    input wire RegWrite,
                    
    // Data outputs
    output reg [31:0] WriteDataOut,
    output reg [4:0] RegAddressOut,
    output reg [31:0] PCOut,
    
    // Control outputs
    output reg RegWriteOut
);

// On reset or clock edge, update outputs
always @(posedge Clk or posedge Reset) begin
    if (Reset) begin
        // Reset all outputs to 0
        WriteDataOut <= 32'b0;
        RegAddressOut <= 5'b0;
        PCOut <= 32'b0;
        RegWriteOut <= 1'b0;
    end else begin
        // Transfer inputs to outputs
        WriteDataOut <= WriteDataIn;
        RegAddressOut <= RegAddressIn;
        PCOut <= PCIn;
        RegWriteOut<= RegWrite;
    end
end

endmodule
