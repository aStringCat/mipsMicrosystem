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
module Spiltter(
    input [31:0] Instr,
    output [5:0] op,
    output [5:0] func,
    output [4:0] rs,
    output [4:0] rt,
    output [4:0] rd,
    output [15:0] immediate,
    output [25:0] instr_index
    );
	 
    assign op = Instr[31:26];
    assign func = Instr[5:0];
    assign rs = Instr[25:21];
    assign rt = Instr[20:16];
    assign rd = Instr[15:11];
    assign immediate = Instr[15:0];
    assign instr_index = Instr[25:0];

endmodule
