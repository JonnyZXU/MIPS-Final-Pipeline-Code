`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/05/2025 06:41:56 PM
// Design Name: 
// Module Name: memoryTop
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


module memoryTop(
    input  wire        clk,
    // inputs from EX/MEM latch
    input  wire [31:0] ALUResult,
    input  wire [31:0] WriteData,
    input  wire [4:0]  WriteReg,
    input  wire [1:0]  WBControl,   // {RegWrite, MemToReg}
    input  wire        MemWrite,
    input  wire        MemRead,
    input  wire        Branch,
    input  wire        Zero,
    // outputs to MEM/WB latch and IF stage
    output wire [31:0] ReadData,
    output wire [31:0] ALUResult_out,
    output wire [4:0]  WriteReg_out,
    output wire [1:0]  WBControl_out,
    output wire        PCSrc
);
    
    wire [31:0] read_data_mem;
    
    // AND gate for branch decision
    memoryANDGate u_and (
        .branch(Branch),
        .zero(Zero),
        .pcsrc(PCSrc)
    );

    // Data memory
    memoryData u_dmem (
        .clk(clk),
        .addr(ALUResult),
        .write_data(WriteData),
        .mem_write(MemWrite),
        .mem_read(MemRead),
        .read_data(read_data_mem)
    );

    // MEM/WB pipeline latch
    memoryWBLatch u_mem_wb (
        .clk(clk),
        .wb_control_in(WBControl),
        .read_data_in(read_data_mem),
        .alu_result_in(ALUResult),
        .write_reg_in(WriteReg),
        .wb_control_out(WBControl_out),
        .read_data_out(ReadData),
        .alu_result_out(ALUResult_out),
        .write_reg_out(WriteReg_out)
    );

endmodule