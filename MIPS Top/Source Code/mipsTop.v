`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/05/2025 06:42:35 PM
// Design Name: 
// Module Name: mipsTop
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


module mipsTop(
    input  wire        clk,
    input  wire        rst,
    output wire [31:0] PC          // expose PC for debugging
);

    // IF/ID wires
    wire [31:0] if_id_instr;
    wire [31:0] if_id_npc;
    wire [31:0] pc_value;

    // ID/EX wires
    wire [1:0]  id_ex_wb;
    wire [2:0]  id_ex_mem;              // {Branch, MemRead, MemWrite}
    wire [3:0]  id_ex_execute;          // {RegDst, ALUSrc, ALUOp[1:0]}
    wire [31:0] id_ex_npc;
    wire [31:0] id_ex_readdat1;
    wire [31:0] id_ex_readdat2;
    wire [31:0] id_ex_sign_ext;
    wire [4:0]  id_ex_instr_bits_20_16;
    wire [4:0]  id_ex_instr_bits_15_11;

    // extra: latch funct bits into an ID/EX-style register
    reg  [5:0]  id_ex_funct;

    // EX/MEM outputs from executeTop
    wire [1:0]  ex_wb_ctlout;
    wire        ex_branch;
    wire        ex_memread;
    wire        ex_memwrite;
    wire [31:0] ex_EX_MEM_NPC;
    wire        ex_zero;
    wire [31:0] ex_alu_result;
    wire [31:0] ex_rdata2out;
    wire [4:0]  ex_five_bit_muxout;

    // MEM stage wires
    wire [31:0] mem_read_data;
    wire [31:0] mem_alu_result_out;
    wire [4:0]  mem_write_reg_out;
    wire [1:0]  mem_wb_control_out;
    wire        pc_src;

    // WB stage wires
    wire [31:0] wb_write_data;
    wire        wb_reg_write;

    // expose PC for debug
    assign PC = pc_value;

    //======================================
    // IF stage
    //======================================
    fetchTop u_fetch (
        .clk          (clk),
        .rst          (rst),
        .ex_mem_pc_src(pc_src),         // from MEM stage
        .ex_mem_npc   (ex_EX_MEM_NPC),  // branch target from EX/MEM
        .if_id_instr  (if_id_instr),
        .if_id_npc    (if_id_npc),
        .PC_value     (pc_value)
    );

    //======================================
    // ID stage
    //======================================

    // latch funct bits (instr[5:0]) into a small ID/EX register
    always @(posedge clk or posedge rst) begin
        if (rst)
            id_ex_funct <= 6'b0;
        else
            id_ex_funct <= if_id_instr[5:0];
    end

    // write-back register index comes from MEM/WB latch
    wire [4:0] wb_write_reg_location;
    assign wb_write_reg_location = mem_write_reg_out;

    decodeTop u_decode (
        .clk                    (clk),
        .rst                    (rst),
        .wb_reg_write           (wb_reg_write),
        .wb_write_reg_location  (wb_write_reg_location),
        .mem_wb_write_data      (wb_write_data),
        .if_id_instr            (if_id_instr),
        .if_id_npc              (if_id_npc),

        .id_ex_wb               (id_ex_wb),
        .id_ex_mem              (id_ex_mem),
        .id_ex_execute          (id_ex_execute),
        .id_ex_npc              (id_ex_npc),
        .id_ex_readdat1         (id_ex_readdat1),
        .id_ex_readdat2         (id_ex_readdat2),
        .id_ex_sign_ext         (id_ex_sign_ext),
        .id_ex_instr_bits_20_16 (id_ex_instr_bits_20_16),
        .id_ex_instr_bits_15_11 (id_ex_instr_bits_15_11)
    );

    //======================================
    // EX stage
    //======================================

    // decode EX control bits from id_ex_execute
    wire        ex_regdst = id_ex_execute[3];
    wire        ex_alusrc = id_ex_execute[2];
    wire [1:0]  ex_alu_op = id_ex_execute[1:0];

    executeTop u_execute (
        .wb_ctl        (id_ex_wb),
        .m_ctl         (id_ex_mem),              // {Branch, MemRead, MemWrite}
        .regdst        (ex_regdst),
        .alusrc        (ex_alusrc),
        .aluop         (ex_alu_op),

        .npcout        (id_ex_npc),
        .rdata1        (id_ex_readdat1),
        .rdata2        (id_ex_readdat2),
        .s_extendout   (id_ex_sign_ext),
        .instrout_2016 (id_ex_instr_bits_20_16),
        .instrout_1511 (id_ex_instr_bits_15_11),
        .funct         (id_ex_funct),

        .wb_ctlout     (ex_wb_ctlout),
        .branch        (ex_branch),
        .memread       (ex_memread),
        .memwrite      (ex_memwrite),
        .EX_MEM_NPC    (ex_EX_MEM_NPC),
        .zero          (ex_zero),
        .alu_result    (ex_alu_result),
        .rdata2out     (ex_rdata2out),
        .five_bit_muxout(ex_five_bit_muxout)
    );

    //======================================
    // MEM stage
    //======================================
    memoryTop u_memory (
        .clk           (clk),
        .ALUResult     (ex_alu_result),
        .WriteData     (ex_rdata2out),
        .WriteReg      (ex_five_bit_muxout),
        .WBControl     (ex_wb_ctlout),
        .MemWrite      (ex_memwrite),
        .MemRead       (ex_memread),
        .Branch        (ex_branch),
        .Zero          (ex_zero),

        .ReadData      (mem_read_data),
        .ALUResult_out (mem_alu_result_out),
        .WriteReg_out  (mem_write_reg_out),
        .WBControl_out (mem_wb_control_out),
        .PCSrc         (pc_src)
    );

    //======================================
    // WB stage
    //======================================
    writebackTop u_writeback (
        .wb_control   (mem_wb_control_out),   // {RegWrite, MemToReg}
        .mem_read_data(mem_read_data),
        .alu_result   (mem_alu_result_out),
        .write_data   (wb_write_data),
        .reg_write    (wb_reg_write)
    );

endmodule