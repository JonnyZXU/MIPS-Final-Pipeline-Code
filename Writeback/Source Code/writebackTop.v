`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/05/2025 06:41:56 PM
// Design Name: 
// Module Name: writebackTop
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


module writebackTop(
    input  wire [1:0]  wb_control,   // {RegWrite, MemToReg}
    input  wire [31:0] mem_read_data,
    input  wire [31:0] alu_result,
    output wire [31:0] write_data,
    output wire        reg_write
);
    wire mem_to_reg = wb_control[0];
    assign reg_write = wb_control[1];

    writeback2to1Mux u_mux (
        .a(alu_result),      // when MemToReg = 0
        .b(mem_read_data),   // when MemToReg = 1
        .sel(mem_to_reg),
        .y(write_data)
    );
endmodule