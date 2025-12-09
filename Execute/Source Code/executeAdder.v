`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/05/2025 06:59:29 PM
// Design Name: 
// Module Name: executeAdder
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


module executeAdder(
    input  wire [31:0] add_in1,
    input  wire [31:0] add_in2,
    output wire [31:0] add_out
);

    assign add_out = add_in1 + add_in2;

endmodule