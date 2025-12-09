`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/05/2025 07:07:37 PM
// Design Name: 
// Module Name: memoryWBLatch
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


module memoryWBLatch(
    input  wire        clk,
    // control from MEM stage
    input  wire [1:0]  wb_control_in,     // {RegWrite, MemToReg}
    // from MEM stage
    input  wire [31:0] read_data_in,
    input  wire [31:0] alu_result_in,
    input  wire [4:0]  write_reg_in,

    output reg  [1:0]  wb_control_out,
    output reg  [31:0] read_data_out,
    output reg  [31:0] alu_result_out,
    output reg  [4:0]  write_reg_out
);
    always @(posedge clk) begin
        wb_control_out <= wb_control_in;
        read_data_out  <= read_data_in;
        alu_result_out <= alu_result_in;
        write_reg_out  <= write_reg_in;
    end
endmodule