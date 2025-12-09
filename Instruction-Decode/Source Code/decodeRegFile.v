`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/05/2025 06:53:19 PM
// Design Name: 
// Module Name: decodeRegFile
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


module decodeRegFile(
    input wire clk,
    input wire rst,
    input wire regwrite,
    input wire [4:0] readreg1, // rs
    input wire [4:0] readreg2, // rt
    input wire [4:0] writereg, // rd
    input wire [31:0] writedata,
    output reg [31:0] A_readdat1,
    output reg [31:0] B_readdat2
    );
    
    reg [31:0] REG [0:31];
    
    initial begin
        REG[0] = 'h002300AA; REG[1] = 'h10654321; REG[2] = 'h00100022;
        REG[3] = 'h8C123456; REG[4] = 'h8F123456; REG[5] = 'hAD654321;
        REG[6] = 'h60000066; REG[7] = 'h13012345; REG[8] = 'hAC654321;
        REG[9] = 'h12012345;
    end
    
    always @(posedge clk) begin
        if(rst) begin
            A_readdat1 <= 32'h00000000;
            B_readdat2 <= 32'h00000000;
        end
        else begin
            if(regwrite) begin
                REG[writereg] <= writedata;
            end
            else begin
            A_readdat1 <= REG[readreg1];
            B_readdat2 <= REG[readreg2];
            end
        end
    end
endmodule