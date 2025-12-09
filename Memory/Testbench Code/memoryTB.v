`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/08/2025 01:11:29 PM
// Design Name: 
// Module Name: memoryTB
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


module memoryTB;
    reg clk;
    reg [31:0] ALUResult, WriteData;
    reg [4:0]  WriteReg;
    reg [1:0]  WBControl;       // {RegWrite, MemToReg}
    reg        MemWrite, MemRead;
    reg        Branch, Zero;

    wire [31:0] ReadData, ALUResult_out;
    wire [4:0]  WriteReg_out;
    wire [1:0]  WBControl_out;
    wire        PCSrc;

    // DUT: adjust name/ports if your module is slightly different
    memoryTop DUT (
        .clk(clk),
        .ALUResult(ALUResult),
        .WriteData(WriteData),
        .WriteReg(WriteReg),
        .WBControl(WBControl),
        .MemWrite(MemWrite),
        .MemRead(MemRead),
        .Branch(Branch),
        .Zero(Zero),
        .ReadData(ReadData),
        .ALUResult_out(ALUResult_out),
        .WriteReg_out(WriteReg_out),
        .WBControl_out(WBControl_out),
        .PCSrc(PCSrc)
    );

    // clock
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        // default values
        ALUResult   = 32'h0000_0000;
        WriteData   = 32'h0000_0000;
        WriteReg    = 5'd0;
        WBControl   = 2'b00;
        MemWrite    = 0;
        MemRead     = 0;
        Branch      = 0;
        Zero        = 0;

        // wait for a couple of clocks
        #12;

        // Test 1: memory read from data.mem[1] (addr 4)
        ALUResult   = 32'h0000_0004;     // address 4 -> word 1
        WriteData   = 32'h1ED4_AA3C;     // should not be written yet
        WriteReg    = 5'd2;
        WBControl   = 2'b01;             // RegWrite=0/1 depends on your encoding, MemToReg=1
        MemWrite    = 0;
        MemRead     = 1;
        Branch      = 0;
        Zero        = 0;

        #15;   // allow time to read

        // Test 2: memory write then read back at same address
        MemWrite    = 1;
        MemRead     = 0;
        WriteData   = 32'h1234_5678;

        #10;   // write on posedge

        MemWrite    = 0;
        MemRead     = 1;

        #15;   // should see 0x12345678 on ReadData

        // Test 3: branch AND gate (PCSrc)
        Branch      = 1;
        Zero        = 1;

        #15;   // PCSrc should go high

        // Test 4: branch not taken
        Zero        = 0;

        #10;

        $finish;
    end
endmodule
