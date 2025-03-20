`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:47:32 10/30/2024 
// Design Name: 
// Module Name:    Controller 
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

module controlUnit(
    input wire [5:0] op,
    input wire [5:0] func,
    output reg [1:0] rsTimeUse,
    output reg [1:0] rtTimeUse,
    output reg [1:0] timeNew,
    output reg [7:0] RegDst,
    output reg [7:0] ALUSrc,
    output reg [7:0] RegSrc,
    output reg RegWrite,
    output reg MemWrite,
    output reg [7:0] NPCOp,
    output reg [7:0] EXTOp,
    output reg [7:0] ALUOp,
    output reg [7:0] CMPOp
    );

    always @(*) begin
        case (op)
            `SPECIAL: begin
                case (func)
                    `fADD: begin
                        rsTimeUse = 2'd1;
                        rtTimeUse = 2'd1;
                        timeNew = 2'd2;
                        RegDst = `regDstRD;
                        ALUSrc = `aluSrcReg;
                        RegSrc = `regSrcALU;
                        RegWrite = `YES;
                        MemWrite = `NO;
                        NPCOp = `npcNext;
                        ALUOp = `aluAdd;
                    end
                    `fSUB: begin
                        rsTimeUse = 2'd1;
                        rtTimeUse = 2'd1;
                        timeNew = 2'd2;
                        RegDst = `regDstRD;
                        ALUSrc = `aluSrcReg;
                        RegSrc = `regSrcALU;
                        RegWrite = `YES;
                        MemWrite = `NO;
                        NPCOp = `npcNext;
                        ALUOp = `aluSub;
                    end
                    `fSLL: begin
                        rsTimeUse = 2'd1;
                        rtTimeUse = 2'd1;
                        timeNew = 2'd2;
                        RegDst = `regDstRD;
                        ALUSrc = `aluSrcReg;
                        RegSrc = `regSrcALU;
                        RegWrite = `YES;
                        MemWrite = `NO;
                        NPCOp = `npcNext;
                        ALUOp = `aluLogicalLeft;
                    end
                    `fJR: begin
                        rsTimeUse = 2'd0;
                        rtTimeUse = 2'd3;
                        timeNew = 2'd0;
                        RegWrite = `NO;
                        MemWrite = `NO;
                        NPCOp = `npcReg;
                    end
                    default: ;
                endcase
            end 
            `ORI: begin
                rsTimeUse = 2'd1;
                rtTimeUse = 2'd3;
                timeNew = 2'd2;
                RegDst = `regDstRT;
                ALUSrc = `aluSrcExt;
                RegSrc = `regSrcALU;
                RegWrite = `YES;
                MemWrite = `NO;
                NPCOp = `npcNext;
                EXTOp = `zeroExtend;
                ALUOp = `aluOr;
            end
            `LW: begin
                rsTimeUse = 2'd1;
                rtTimeUse = 2'd3;
                timeNew = 2'd3;
                RegDst = `regDstRT;
                ALUSrc = `aluSrcExt;
                RegSrc = `regSrcMem;
                RegWrite = `YES;
                MemWrite = `NO;
                NPCOp = `npcNext;
                EXTOp = `signExtend;
                ALUOp = `aluAdd;
            end
            `SW: begin
                rsTimeUse = 2'd1;
                rtTimeUse = 2'd2;
                timeNew = 2'd0;
                ALUSrc = `aluSrcExt;
                RegWrite = `NO;
                MemWrite = `YES;
                NPCOp = `npcNext;
                EXTOp = `signExtend;
                ALUOp = `aluAdd;
            end
            `BEQ: begin
                rsTimeUse = 2'd0;
                rtTimeUse = 2'd0;
                timeNew = 2'd0;
                RegWrite = `NO;
                MemWrite = `NO;
                NPCOp = `npcOffset;
                EXTOp = `signExtend;
                CMPOp = `cmpEqual;
            end 
            `LUI: begin
                rsTimeUse = 2'd1;
                rtTimeUse = 2'd3;
                timeNew = 2'd2;
                RegDst = `regDstRT;
                ALUSrc = `aluSrcExt;
                RegSrc = `regSrcALU;
                RegWrite = `YES;
                MemWrite = `NO;
                NPCOp = `npcNext;
                EXTOp = `upperExtend;
                ALUOp = `aluAdd;
            end
            `JAL: begin
                rsTimeUse = 2'd3;
                rtTimeUse = 2'd3;
                timeNew = 2'd0;
                RegDst = `regDstRA;
                RegSrc = `regSrcPC;
                RegWrite = `YES;
                MemWrite = `NO;
                NPCOp = `npcInstrIndex;
            end
            default: ; 
        endcase
    end
    

endmodule
