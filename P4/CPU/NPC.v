`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:06:56 10/30/2024 
// Design Name: 
// Module Name:    NPC 
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
`define Next 2'd0  
`define Offset 2'd1 
`define Instr_index 2'd2 
`define RegtoPC 2'd3
module NPC(
    input [31:0] pc,
    input [31:0] ALUOut,
    input [15:0] offset,
    input [25:0] instr_index,
    input [31:0] GRF,
    input [1:0] transOp,
    output [31:0] pcNext
    );

    reg [31:0] tmp;
    always @(*) begin
        case (transOp)
            `Next: begin
                tmp = pc + 32'h4;
            end 
            `Offset: begin 
                if (ALUOut == 32'd1) begin
                    tmp = pc + 32'h4 + {{14{offset[15]}},offset,2'b00};
                end else begin
                    tmp = pc + 32'h4;
                end
            end
            `Instr_index: begin
                tmp = {pc[31:28], instr_index, 2'd0};
            end
            `RegtoPC: begin
                tmp = GRF; 
            end
            default: begin
                tmp = 32'h3000;
            end
        endcase
    end

    assign pcNext = tmp;


endmodule
