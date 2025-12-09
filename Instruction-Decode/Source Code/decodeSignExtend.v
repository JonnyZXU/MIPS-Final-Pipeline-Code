`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/05/2025 06:53:19 PM
// Design Name: 
// Module Name: decodeSignExtend
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


module decodeSignExtend(
    input wire [15:0] immediate,
    output wire [31:0] extended
    );
    
    assign extended = {{16{immediate[15]}}, immediate};
    
endmodule