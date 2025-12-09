`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/05/2025 06:46:41 PM
// Design Name: 
// Module Name: fetchLatch
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


module fetchLatch(
    output reg [31:0] out1,
    output reg [31:0] out2,
    input  wire [31:0] in1,
    input  wire [31:0] in2,
    input  wire        CLK,
    input  wire        RST
    );

    always @(posedge CLK) begin
        if (RST) begin
            out1 <= 32'h00000000;
            out2 <= 32'h00000000;
        end
        else begin
            out1 <= in1;
            out2 <= in2;
        end
    end
endmodule