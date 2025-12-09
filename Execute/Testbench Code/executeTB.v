`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/08/2025 01:11:29 PM
// Design Name: 
// Module Name: executeTB
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


module executeTB;
    // Inputs to executeTop
    reg  [1:0]  wb_ctl;          // WB control from ID/EX
    reg  [2:0]  m_ctl;           // M control from ID/EX: {Branch, MemRead, MemWrite}
    reg         regdst;
    reg         alusrc;
    reg  [1:0]  aluop;
    reg  [31:0] npcout;
    reg  [31:0] rdata1;
    reg  [31:0] rdata2;
    reg  [31:0] s_extendout;
    reg  [4:0]  instrout_2016;
    reg  [4:0]  instrout_1511;
    reg  [5:0]  funct;

    // Outputs from executeTop
    wire [1:0]  wb_ctlout;
    wire        branch;
    wire        memread;
    wire        memwrite;
    wire [31:0] EX_MEM_NPC;
    wire        zero;
    wire [31:0] alu_result;
    wire [31:0] rdata2out;
    wire [4:0]  five_bit_muxout;

    // DUT
    executeTop DUT (
        .wb_ctl        (wb_ctl),
        .m_ctl         (m_ctl),
        .regdst        (regdst),
        .alusrc        (alusrc),
        .aluop         (aluop),
        .npcout        (npcout),
        .rdata1        (rdata1),
        .rdata2        (rdata2),
        .s_extendout   (s_extendout),
        .instrout_2016 (instrout_2016),
        .instrout_1511 (instrout_1511),
        .funct         (funct),

        .wb_ctlout     (wb_ctlout),
        .branch        (branch),
        .memread       (memread),
        .memwrite      (memwrite),
        .EX_MEM_NPC    (EX_MEM_NPC),
        .zero          (zero),
        .alu_result    (alu_result),
        .rdata2out     (rdata2out),
        .five_bit_muxout(five_bit_muxout)
    );

    initial begin
        // Test 1: R-type add (no mem, no branch)
        wb_ctl        = 2'b10;       // e.g. RegWrite=1, MemToReg=0
        m_ctl         = 3'b000;      // {Branch=0, MemRead=0, MemWrite=0}
        npcout        = 32'd100;
        rdata1        = 32'd10;
        rdata2        = 32'd20;
        s_extendout   = 32'd4;       // don't-care for R-type
        instrout_2016 = 5'd5;        // rt
        instrout_1511 = 5'd10;       // rd
        aluop         = 2'b10;       // R-type
        funct         = 6'b100000;   // add
        alusrc        = 0;           // use register (rdata2)
        regdst        = 1;           // choose rd (instr[15:11])

        #10;

        // Test 2: BEQ-style subtract (branch-type ALU op)
        // Here we still keep no mem access, but set Branch bit in m_ctl
        m_ctl         = 3'b100;      // {Branch=1, MemRead=0, MemWrite=0}
        rdata1        = 32'd15;
        rdata2        = 32'd15;
        aluop         = 2'b01;       // typically used for beq (ALU does sub)
        funct         = 6'b100010;   // SUB funct (for completeness)
        alusrc        = 0;
        regdst        = 0;
        s_extendout   = 32'd8;       // pretend this is the branch offset

        #10;

        // Test 3: LW-style add (use immediate as ALU src)
        m_ctl         = 3'b010;      // {Branch=0, MemRead=1, MemWrite=0}
        rdata1        = 32'd1000;    // base register
        s_extendout   = 32'd16;      // offset
        aluop         = 2'b00;       // lw/sw -> add
        alusrc        = 1;           // use sign-extended immediate
        regdst        = 0;           // choose rt

        #10;

        $finish;
    end

endmodule