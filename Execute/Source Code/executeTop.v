`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/05/2025 06:41:56 PM
// Design Name: 
// Module Name: executeTop
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


module executeTop(
    input  wire [1:0]   wb_ctl,             // from ID/EX latch
    input  wire [2:0]   m_ctl,              // from ID/EX latch
    input  wire         regdst,
    input  wire         alusrc,
    input  wire [1:0]   aluop,
    input  wire [31:0]  npcout,
    input  wire [31:0]  rdata1,
    input  wire [31:0]  rdata2,
    input  wire [31:0]  s_extendout,
    input  wire [4:0]   instrout_2016,
    input  wire [4:0]   instrout_1511,
    input  wire [5:0]   funct,              // funct field from instruction (instr[5:0])

    output wire [1:0]   wb_ctlout,          // to MEM/WB
    output wire         branch,
    output wire         memread,
    output wire         memwrite,
    output wire [31:0]  EX_MEM_NPC,
    output wire         zero,
    output wire [31:0]  alu_result,
    output wire [31:0]  rdata2out,
    output wire [4:0]   five_bit_muxout
);

    // internal wires
    wire [31:0] adder_out;
    wire [31:0] b;
    wire [2:0]  control;
    wire        aluzero;
    wire [31:0] aluout;
    wire [4:0]  muxout;

    // adder: NPC + sign-extended immediate
    executeAdder adder3 (
        .add_in1(npcout),
        .add_in2(s_extendout),
        .add_out(adder_out)
    );

    // bottom mux: choose destination register (rd vs rt)
    executeBtmMux bottom_mux3 (
        .y  (muxout),
        .a  (instrout_1511),
        .b  (instrout_2016),
        .sel(regdst)
    );

    // ALU control: from aluop + funct
    executeALUCtrl alu_control3 (
        .funct (funct),
        .aluop (aluop),
        .select(control)
    );

    // top mux
    executeTopMux top_mux3 (
        .y     (b),
        .a     (s_extendout),
        .b     (rdata2),
        .alusrc(alusrc)
    );

    // ALU
    executeALU alu3 (
        .a      (rdata1),
        .b      (b),
        .control(control),
        .result (aluout),
        .zero   (aluzero)
    );

    // EX/MEM latch
    executeEXMem ex_mem3 (
        .ctlwb_out (wb_ctl),        // inputs from ID/EX stage
        .ctlm_out  (m_ctl),
        .adder_out (adder_out),
        .aluzero   (aluzero),
        .aluout    (aluout),
        .readdat2  (rdata2),
        .muxout    (muxout),

        .wb_ctlout      (wb_ctlout),      // outputs to later stages
        .branch         (branch),
        .memread        (memread),
        .memwrite       (memwrite),
        .add_result     (EX_MEM_NPC),
        .zero           (zero),
        .alu_result     (alu_result),
        .rdata2out      (rdata2out),
        .five_bit_muxout(five_bit_muxout)
    );

endmodule