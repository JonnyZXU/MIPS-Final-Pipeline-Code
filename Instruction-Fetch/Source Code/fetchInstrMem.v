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
        $readmemb("instr.mem", mem);
    end

    always @(*) begin
        instr = mem[word_addr];
    end
        
endmodule