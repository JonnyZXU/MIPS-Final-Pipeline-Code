`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/05/2025 06:46:41 PM
// Design Name: 
// Module Name: fetchMux
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


module fetchMux(
    output [31:0]muxout,
    input PCScr,
    input [31:0]muxin1,
    input [31:0]muxin2 
    );
    
    assign muxout = (PCScr) ? muxin2 : muxin1;

endmodule
