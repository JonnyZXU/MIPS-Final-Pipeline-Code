`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/05/2025 06:59:29 PM
// Design Name: 
// Module Name: executeEXMem
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


module executeEXMem(
    input  wire [1:0]  ctlwb_out,
    input  wire [2:0]  ctlm_out,
    input  wire [31:0] adder_out,
    input  wire        aluzero,
    input  wire [31:0] aluout,
    input  wire [31:0] readdat2,
    input  wire [4:0]  muxout,

    output reg  [1:0]  wb_ctlout,
    output reg         branch,
    output reg         memread,
    output reg         memwrite,
    output reg  [31:0] add_result,
    output reg         zero,
    output reg  [31:0] alu_result,
    output reg  [31:0] rdata2out,
    output reg  [4:0]  five_bit_muxout
);

    initial begin
        wb_ctlout       = 2'b00;
        branch          = 1'b0;
        memread         = 1'b0;
        memwrite        = 1'b0;
        add_result      = 32'b0;
        zero            = 1'b0;
        alu_result      = 32'b0;
        rdata2out       = 32'b0;
        five_bit_muxout = 5'b0;
    end

    // For the lab this is combinational; later you could make it clocked.
    always @* begin
        wb_ctlout       = ctlwb_out;
        branch          = ctlm_out[2];
        memread         = ctlm_out[1];
        memwrite        = ctlm_out[0];

        add_result      = adder_out;
        zero            = aluzero;
        alu_result      = aluout;
        rdata2out       = readdat2;
        five_bit_muxout = muxout;
    end

endmodule