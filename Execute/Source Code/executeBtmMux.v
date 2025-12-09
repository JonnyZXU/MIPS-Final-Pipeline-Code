`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/05/2025 06:59:29 PM
// Design Name: 
// Module Name: executeBtmMux
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


module executeBtmMux(
    output wire [4:0] y,
    input  wire [4:0] a,
    input  wire [4:0] b,
    input  wire       sel
);

    assign y = sel ? a : b;

endmodule