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
`include "constants.v"
`default_nettype none
 
module NPC(
    input wire [31:0] pc,
    input wire [15:0] offset,
    input wire [25:0] instrIndex,
    input wire [31:0] GRF,
    input wire [31:0] EPC,
    input wire [7:0] NPCOp,
    input wire CMPOut,
    output wire [31:0] pcNext,
    output wire BDIn,
    output wire flush
    );

    reg [31:0] tmp;
    reg BD;
	reg Flush;

    always @(*) begin
        case (NPCOp)
            `npcNext: begin
                tmp <= pc + 32'h4;
                BD <= `NO;
                Flush <= `NO;
            end 
            `npcOffset: begin 
                if (CMPOut) begin
                    tmp <= pc + 32'h4 + {{14{offset[15]}},offset,2'b00};
                end else begin
                    tmp <= pc + 32'h8;
                end
                BD <= `YES;
                Flush <= `NO;
            end
            `npcInstrIndex: begin
                tmp <= {pc[31:28], instrIndex, 2'd0};
                BD <= `YES;
                Flush <= `NO;
            end
            `npcReg: begin
                tmp <= GRF;
                BD <= `YES; 
                Flush <= `NO;
            end
            `npcEPC: begin
                tmp <= EPC;
                BD <= `NO;
                Flush <= `YES;
            end
            default: ;
        endcase
    end

    assign pcNext = tmp;
    assign BDIn = BD;
	assign flush = Flush;
	 
endmodule
