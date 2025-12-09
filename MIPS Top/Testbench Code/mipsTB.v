`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/05/2025 07:29:47 PM
// Design Name: 
// Module Name: mipsTB
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


module mipsTB;

    reg         clk;
    reg         rst;
    wire [31:0] PC;

    // DUT
    mipsTop uut (
        .clk(clk),
        .rst(rst),
        .PC(PC)
    );

    // clock: 10 ns period
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // main stimulus
    initial begin

        rst = 1;
        #20;          // hold reset for 2 cycles
        rst = 0;

        #200 $finish;
    end

endmodule
