`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/05/2025 06:59:29 PM
// Design Name: 
// Module Name: executeTopMux
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


module executeTopMux(
    output wire [31:0] y,
    input  wire [31:0] a,    // s_extend (immediate)
    input  wire [31:0] b,    // rdata2 (rt)
    input  wire        alusrc
);

    assign y = alusrc ? a : b;

endmodule