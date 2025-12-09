`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/05/2025 06:41:56 PM
// Design Name: 
// Module Name: fetchTop
// Project Name: MIPS Pipeline
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


module fetchTop(
    input              clk,
    input              rst,
    input              ex_mem_pc_src,        // 0 = sequential (PC+4), 1 = branch_target
    input      [31:0]  ex_mem_npc,           // external next-PC when branching
    output     [31:0]  if_id_instr,          // latched instruction (to ID)
    output     [31:0]  if_id_npc,            // latched PC+4 (to ID)
    output     [31:0]  PC_value              // current PC (for visibility)
    );

    // Internal wires
    wire [31:0] pc_q;          // output of PC register
    wire [31:0] pc_plus4;      // PC + 4 (one word)
    wire [31:0] next_pc;       // selected by mux
    wire [31:0] instr_data;    // instrmem output

    // PC register (now includes reset)
    fetchPC u_pc (
        .A   (pc_q),
        .in  (next_pc),
        .CLK (clk),
        .RST (rst)
    );

    // Instruction memory
    fetchInstrMem u_imem (
        .instr (instr_data),
        .addr  (pc_q),
        .CLK   (clk)
    );

    // adder: PC + 4
    fetchAdder u_adder (
        .addout (pc_plus4),
        .in1    (pc_q),
        .in2    (32'd4)
    );

    // Next-PC MUX
    fetchMux u_mux (
        .muxout (next_pc),
        .PCScr  (ex_mem_pc_src),
        .muxin1 (pc_plus4),
        .muxin2 (ex_mem_npc)
    );

    // IF/ID latch 
    fetchLatch u_ifid (
        .out1 (if_id_instr),
        .out2 (if_id_npc),
        .in1  (instr_data),
        .in2  (pc_plus4),
        .CLK  (clk),
        .RST  (rst)
    );

    // For visibility in the TB
    assign PC_value = pc_q;

endmodule
