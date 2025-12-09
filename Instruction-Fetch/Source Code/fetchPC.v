`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/05/2025 06:46:41 PM
// Design Name: 
// Module Name: fetchPC
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


module fetchPC(
    output reg [31:0] A,
    input  wire [31:0] in,
    input  wire        CLK,
    input  wire        RST
    );

    always @(posedge CLK) begin
        if (RST)
            A <= 32'h00000000;   // Reset PC to 0
        else
            A <= in;             // Load next PC on rising edge
    end

endmodule