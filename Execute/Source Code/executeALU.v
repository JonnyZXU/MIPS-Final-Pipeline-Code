`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/05/2025 06:59:29 PM
// Design Name: 
// Module Name: executeALU
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


module executeALU(
    input  wire [31:0] a,       // source register
    input  wire [31:0] b,       // second operand (reg or imm)
    input  wire [2:0]  control, // from alu_control
    output reg  [31:0] result,
    output reg         zero
);
    // ALU control encodings
    parameter ALUadd = 3'b010;
    parameter ALUsub = 3'b110;
    parameter ALUand = 3'b000;
    parameter ALUor  = 3'b001;
    parameter ALUslt = 3'b111;

    initial begin
        result = 32'b0;
        zero   = 1'b0;
    end

    always @* begin
        case (control)
            ALUadd: result = a + b;
            ALUsub: result = a - b;
            ALUand: result = a & b;
            ALUor:  result = a | b;
            ALUslt: begin
                if (a[31] != b[31]) 
                    result = (a[31] == 1) ? 32'd1 : 32'd0;
                else 
                    result = (a < b) ? 32'd1 : 32'd0;
            end 
            default: result = 32'bx;
        endcase

        zero = (result == 32'b0);
    end

endmodule