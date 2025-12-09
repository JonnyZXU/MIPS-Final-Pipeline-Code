`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/08/2025 01:11:29 PM
// Design Name: 
// Module Name: fetchTB
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


module fetchTB;
    reg clk = 0;
    reg rst = 0;
    reg ex_mem_pc_src = 0;
    reg [31:0] ex_mem_npc = 32'h0000_0000;

    wire [31:0] if_id_instr;
    wire [31:0] if_id_npc;
    wire [31:0] PC_value;

    // DUT
    fetchTop DUT (
        .clk(clk),
        .rst(rst),
        .ex_mem_pc_src(ex_mem_pc_src),
        .ex_mem_npc(ex_mem_npc),
        .if_id_instr(if_id_instr),
        .if_id_npc(if_id_npc),
        .PC_value(PC_value)
    );

    // 10 ns clock
    always #5 clk = ~clk;

    initial begin
        // hold reset for two rising edges
        rst = 1;
        ex_mem_pc_src = 0;
        ex_mem_npc    = 32'h0000_0000;
        repeat (2) @(posedge clk);
        rst = 0;

        // force PC to 0 with a one cycle redirect
        #1;
        ex_mem_pc_src = 1;
        ex_mem_npc    = 32'h0000_0000;
        @(posedge clk);
    
        // sequential fetch
        ex_mem_pc_src = 0;
        repeat (6) @(posedge clk);
    
        // branch to 0x20 (word 8)
        ex_mem_pc_src = 1;
        ex_mem_npc    = 32'h0000_0020;
        @(posedge clk);
    
        // back to sequential
        ex_mem_pc_src = 0;
        repeat (5) @(posedge clk);
    
        // branch to 0x0C (word 3)
        ex_mem_pc_src = 1;
        ex_mem_npc    = 32'h0000_000C;
        @(posedge clk);
    
        // back to sequential
        ex_mem_pc_src = 0;
        repeat (5) @(posedge clk);
    
        // branch to 0x3C (word 15)
        ex_mem_pc_src = 1;
        ex_mem_npc    = 32'h0000_003C;
        @(posedge clk);
    
        // back to sequential
        ex_mem_pc_src = 0;
        repeat (5) @(posedge clk);
    
        // branch to 0x38 (word 14)
        ex_mem_pc_src = 1;
        ex_mem_npc    = 32'h0000_0008;
        @(posedge clk);
    
        // finish with a few sequential cycles
        ex_mem_pc_src = 0;
        repeat (7) @(posedge clk);

        $finish;
    end
endmodule