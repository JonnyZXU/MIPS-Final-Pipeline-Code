`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/05/2025 07:10:27 PM
// Design Name: 
// Module Name: writeback2to1Mux
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


module writeback2to1Mux(
    input  wire [31:0] a, b,
    input  wire sel,
    output wire [31:0] y
);
    assign y = sel ? b : a;
endmodule
