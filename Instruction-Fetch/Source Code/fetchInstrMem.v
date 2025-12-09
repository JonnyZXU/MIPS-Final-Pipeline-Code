`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/05/2025 06:46:41 PM
// Design Name: 
// Module Name: fetchInstrMem
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


module fetchInstrMem(
    output reg [31:0]instr,
    input wire [31:0]addr,
    input CLK 
    );
    
    reg [31:0] mem [0:255];
    wire [7:0] word_addr = addr[9:2];

    integer i;
    initial begin
        for (i = 0; i < 256; i = i + 1) mem[i] = 32'h00000000;
        mem[0] = 32'h8C220004; mem[1] = 32'h00441820; mem[2] = 32'hAC230008;
        mem[3] = 32'h10600002; mem[4] = 32'h00631820; mem[5] = 32'h00000000;
        mem[6] = 32'h00000000; mem[7] = 32'h00000000; mem[8] = 32'h00000000;
        mem[9] = 32'h00000000;
    end

    always @(*) begin
        instr = mem[word_addr];
    end
        
endmodule