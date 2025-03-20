`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:53:29 10/29/2024 
// Design Name: 
// Module Name:    Spiltter 
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

module Spiltter(
    input wire [31:0] Instr,
    output wire [5:0] op,
    output wire [5:0] func,
    output wire [4:0] rs,
    output wire [4:0] rt,
    output wire [4:0] rd,
    output wire [15:0] immediate,
    output wire [25:0] instrIndex
    );
	  
    assign op = Instr[31:26];
    assign func = Instr[5:0];
    assign rs = Instr[25:21];
    assign rt = Instr[20:16];
    assign rd = Instr[15:11];
    assign immediate = Instr[15:0];
    assign instrIndex = Instr[25:0];

endmodule
