`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/05/2025 07:07:37 PM
// Design Name: 
// Module Name: memoryData
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


module memoryData(
    input  wire        clk,
                       mem_write,
                       mem_read,
    input  wire [31:0] addr,
    input  wire [31:0] write_data,
    output reg  [31:0] read_data
);
    // 256 words of 32 bits
    reg [31:0] MEM [0:255];
    integer i;

    initial begin
        $readmemb("data.mem", MEM);
    end

    // word address: use bits [9:2] so that addresses 0,4,8,... map to entries 0,1,2,...
    wire [7:0] word_addr = addr[9:2];

    always @(posedge clk) begin
        if (mem_write)
            MEM[word_addr] <= write_data;
    end

    always @* begin
        read_data = mem_read ? MEM[word_addr] : 32'b0;
    end

endmodule