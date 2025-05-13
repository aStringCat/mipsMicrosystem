`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:23:39 10/29/2024 
// Design Name: 
// Module Name:    IFU 
// Project Name: 
// Target Devices: 
// Tool versions:  
// Description: 
// 
// Dependencies: 
// 
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module IFU(
    input clk, 
    input reset,
    input [31:0] pcIn,
    output [31:0] pcOut,
    output [31:0] Instr
    );

    reg [31:0] PC;
    reg [31:0] IM [0:4095];
    wire [31:0] addr;

    always @(posedge clk) begin
        if (reset) begin
            PC <= 32'h3000;
            $readmemh("code.txt", IM);
        end else begin
            PC <= pcIn;
        end
    end
    assign addr = pcOut - 32'h3000;
    assign pcOut = PC;
    assign Instr = IM[addr[13:2]];
	 
endmodule
