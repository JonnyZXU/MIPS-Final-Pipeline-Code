`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/05/2025 07:07:37 PM
// Design Name: 
// Module Name: memoryANDGate
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


module memoryANDGate(
    input  wire branch,
    input  wire zero,
    output wire pcsrc
);
    assign pcsrc = branch & zero;
endmodule
