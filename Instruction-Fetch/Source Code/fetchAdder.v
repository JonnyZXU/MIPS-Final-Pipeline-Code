`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/05/2025 06:46:41 PM
// Design Name: 
// Module Name: fetchAdder
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


module fetchAdder(
    output [31:0]addout,
    input [31:0]in1,
    input [31:0]in2 
    );

    assign addout = in1 + in2;

endmodule
