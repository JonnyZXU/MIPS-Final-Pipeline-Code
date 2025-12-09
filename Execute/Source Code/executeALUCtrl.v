`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/05/2025 06:59:29 PM
// Design Name: 
// Module Name: executeALUCtrl
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


module executeALUCtrl(
    input  wire [5:0] funct,   // instruction[5:0]
    input  wire [1:0] aluop,
    output reg  [2:0] select
);
    // ALUop encoding
    parameter Rtype   = 2'b10;
    parameter LWSW    = 2'b00;   // lw / sw
    parameter BRANCH  = 2'b01;   // beq
    parameter UNKNOWN = 2'b11;

    // ALU control outputs
    parameter ALUadd = 3'b010;
    parameter ALUsub = 3'b110;
    parameter ALUand = 3'b000;
    parameter ALUor  = 3'b001;
    parameter ALUslt = 3'b111;
    parameter ALUx   = 3'b011;   // invalid

    // Funct field values
    parameter FUNCTadd = 6'b100000;
    parameter FUNCTsub = 6'b100010;
    parameter FUNCTand = 6'b100100;
    parameter FUNCTor  = 6'b100101;
    parameter FUNCTslt = 6'b101010;

    initial begin
        select = 3'b000;
    end

    always @* begin
        case (aluop)
            Rtype: begin
                case (funct)
                    FUNCTadd: select = ALUadd;
                    FUNCTsub: select = ALUsub;
                    FUNCTand: select = ALUand;
                    FUNCTor:  select = ALUor;
                    FUNCTslt: select = ALUslt;
                    default:  select = ALUx;
                endcase
            end
            LWSW:   select = ALUadd;  // address calc
            BRANCH: select = ALUsub;  // beq
            UNKNOWN:select = ALUx;
            default:select = ALUx;
        endcase
    end

endmodule