`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/08/2025 01:11:29 PM
// Design Name: 
// Module Name: writebackTB
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


module writebackTB;

    // Inputs
    reg  [1:0]  wb_control;      // {RegWrite, MemToReg}
    reg  [31:0] mem_read_data;
    reg  [31:0] alu_result;

    // Outputs
    wire [31:0] write_data;
    wire        reg_write;

    // DUT
    writebackTop DUT (
        .wb_control   (wb_control),
        .mem_read_data(mem_read_data),
        .alu_result   (alu_result),
        .write_data   (write_data),
        .reg_write    (reg_write)
    );

    initial begin
        // Initial values
        wb_control    = 2'b00;
        mem_read_data = 32'h0000_0000;
        alu_result    = 32'h0000_0000;

        // Test 1: RegWrite=0, MemToReg=0 to write_data should follow ALU, reg_write=0
        #10;
        alu_result    = 32'hAAAA_AAAA;
        mem_read_data = 32'h1111_1111;
        wb_control    = 2'b00;   // RegWrite=0, MemToReg=0

        // Test 2: RegWrite=1, MemToReg=0 to write_data = ALU, reg_write=1
        #10;
        alu_result    = 32'h1234_5678;
        mem_read_data = 32'hDEAD_BEEF;
        wb_control    = 2'b10;   // RegWrite=1, MemToReg=0

        // Test 3: RegWrite=1, MemToReg=1 to write_data = mem_read_data, reg_write=1
        #10;
        alu_result    = 32'h0000_0000;
        mem_read_data = 32'hCAFEBABE;
        wb_control    = 2'b11;   // RegWrite=1, MemToReg=1

        // Test 4: RegWrite=0, MemToReg=1 to write_data = mem_read_data, reg_write=0
        #10;
        alu_result    = 32'hFFFF_0000;
        mem_read_data = 32'h0000_FFFF;
        wb_control    = 2'b01;   // RegWrite=0, MemToReg=1

        // Hold final values a bit
        #20;

        $finish;
    end

endmodule