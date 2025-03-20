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
`default_nettype none

module IFU(
    input wire clk, 
    input wire reset,
    input wire [31:0] pcIn,
    output wire [31:0] pcOut,
    output wire [31:0] Instr
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

    assign pcOut = PC;
    assign addr = pcOut - 32'h3000;
    assign Instr = IM[addr[13:2]];
	 
endmodule
