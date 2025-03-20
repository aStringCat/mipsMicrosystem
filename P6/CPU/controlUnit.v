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
    output reg MdWrite,
    output reg MdRead,
    output reg [7:0] NPCOp,
    output reg [7:0] EXTOp,
    output reg [7:0] ALUOp,
    output reg [7:0] CMPOp,
    output reg [7:0] MemLen
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
                        MdWrite = `NO;
                        MdRead = `NO;
                        NPCOp = `npcNext;
                        ALUOp = `aluAdd;
                    end
                    `fAND: begin
                        rsTimeUse = 2'd1;
                        rtTimeUse = 2'd1;
                        timeNew = 2'd2;
                        RegDst = `regDstRD;
                        ALUSrc = `aluSrcReg;
                        RegSrc = `regSrcALU;
                        RegWrite = `YES;
                        MemWrite = `NO;
                        MdWrite = `NO;
                        MdRead = `NO;
                        NPCOp = `npcNext;
                        ALUOp = `aluAnd;
                    end
                    `fDIV: begin
                        rsTimeUse = 2'd1;
                        rtTimeUse = 2'd1;
                        timeNew = 2'd0;
                        ALUSrc = `aluSrcReg;
                        RegSrc = `regSrcALU;
                        RegWrite = `NO;
                        MemWrite = `NO;
                        MdWrite = `YES;
                        MdRead = `NO;
                        NPCOp = `npcNext;
                        ALUOp = `aluDiv;
                    end
                    `fDIVU: begin
                        rsTimeUse = 2'd1;
                        rtTimeUse = 2'd1;
                        timeNew = 2'd0;
                        ALUSrc = `aluSrcReg;
                        RegSrc = `regSrcALU;
                        RegWrite = `NO;
                        MemWrite = `NO;
                        MdWrite = `YES;
                        MdRead = `NO;
                        NPCOp = `npcNext;
                        ALUOp = `aluDivU;
                    end
                    `fMULT: begin
                        rsTimeUse = 2'd1;
                        rtTimeUse = 2'd1;
                        timeNew = 2'd0;
                        ALUSrc = `aluSrcReg;
                        RegSrc = `regSrcALU;
                        RegWrite = `NO;
                        MemWrite = `NO;
                        MdWrite = `YES;
                        MdRead = `NO;
                        NPCOp = `npcNext;
                        ALUOp = `aluMult;
                    end
                    `fMULTU: begin
                        rsTimeUse = 2'd1;
                        rtTimeUse = 2'd1;
                        timeNew = 2'd0;
                        ALUSrc = `aluSrcReg;
                        RegSrc = `regSrcALU;
                        RegWrite = `NO;
                        MemWrite = `NO;
                        MdWrite = `YES;
                        MdRead = `NO;
                        NPCOp = `npcNext;
                        ALUOp = `aluMultU;
                    end
                    `fMFHI: begin
                        rsTimeUse = 2'd3;
                        rtTimeUse = 2'd3;
                        timeNew = 2'd2;
                        RegDst = `regDstRD;
                        ALUSrc = `aluSrcReg;
                        RegSrc = `regSrcALU;
                        RegWrite = `YES;
                        MemWrite = `NO;
                        MdWrite = `NO;
                        MdRead = `YES;
                        NPCOp = `npcNext;
                        ALUOp = `aluMfhi;
                    end
                    `fMFLO: begin
                        rsTimeUse = 2'd3;
                        rtTimeUse = 2'd3;
                        timeNew = 2'd2;
                        RegDst = `regDstRD;
                        ALUSrc = `aluSrcReg;
                        RegSrc = `regSrcALU;
                        RegWrite = `YES;
                        MemWrite = `NO;
                        MdWrite = `NO;
                        MdRead = `YES;
                        NPCOp = `npcNext;
                        ALUOp = `aluMflo;
                    end
                    `fMTHI: begin
                        rsTimeUse = 2'd1;
                        rtTimeUse = 2'd1;
                        timeNew = 2'd0;
                        ALUSrc = `aluSrcReg;
                        RegSrc = `regSrcALU;
                        RegWrite = `NO;
                        MemWrite = `NO;
                        MdWrite = `YES;
                        MdRead = `NO;
                        NPCOp = `npcNext;
                        ALUOp = `aluMthi;
                    end
                    `fMTLO: begin
                        rsTimeUse = 2'd1;
                        rtTimeUse = 2'd1;
                        timeNew = 2'd0;
                        ALUSrc = `aluSrcReg;
                        RegSrc = `regSrcALU;
                        RegWrite = `NO;
                        MemWrite = `NO;
                        MdWrite = `YES;
                        MdRead = `NO;
                        NPCOp = `npcNext;
                        ALUOp = `aluMtlo;
                    end
                    `fOR: begin
                        rsTimeUse = 2'd1;
                        rtTimeUse = 2'd1;
                        timeNew = 2'd2;
                        RegDst = `regDstRD;
                        ALUSrc = `aluSrcReg;
                        RegSrc = `regSrcALU;
                        RegWrite = `YES;
                        MemWrite = `NO;
                        MdWrite = `NO;
                        MdRead = `NO;
                        NPCOp = `npcNext;
                        ALUOp = `aluOr;
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
                        MdWrite = `NO;
                        MdRead = `NO;
                        NPCOp = `npcNext;
                        ALUOp = `aluLogicalLeft;
                    end
                    `fSLT: begin
                        rsTimeUse = 2'd1;
                        rtTimeUse = 2'd1;
                        timeNew = 2'd2;
                        RegDst = `regDstRD;
                        ALUSrc = `aluSrcReg;
                        RegSrc = `regSrcALU;
                        RegWrite = `YES;
                        MemWrite = `NO;
                        MdWrite = `NO;
                        MdRead = `NO;
                        NPCOp = `npcNext;
                        ALUOp = `aluSetLessThan;
                    end
                    `fSLTU: begin
                        rsTimeUse = 2'd1;
                        rtTimeUse = 2'd1;
                        timeNew = 2'd2;
                        RegDst = `regDstRD;
                        ALUSrc = `aluSrcReg;
                        RegSrc = `regSrcALU;
                        RegWrite = `YES;
                        MemWrite = `NO;
                        MdWrite = `NO;
                        MdRead = `NO;
                        NPCOp = `npcNext;
                        ALUOp = `aluSetLessThanUnsigned;
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
                        MdWrite = `NO;
                        MdRead = `NO;
                        NPCOp = `npcNext;
                        ALUOp = `aluSub;
                    end
                    `fJR: begin
                        rsTimeUse = 2'd0;
                        rtTimeUse = 2'd3;
                        timeNew = 2'd0;
                        RegSrc = `regSrcALU;
                        RegWrite = `NO;
                        MemWrite = `NO;
                        MdWrite = `NO;
                        MdRead = `NO;
                        NPCOp = `npcReg;
                        ALUOp = `aluNone;
                    end
                    default: ;
                endcase
            end 
            `ADDI: begin
                rsTimeUse = 2'd1;
                rtTimeUse = 2'd3;
                timeNew = 2'd2;
                RegDst = `regDstRT;
                ALUSrc = `aluSrcExt;
                RegSrc = `regSrcALU;
                RegWrite = `YES;
                MemWrite = `NO;
                MdWrite = `NO;
                MdRead = `NO;
                NPCOp = `npcNext;
                EXTOp = `signExtend;
                ALUOp = `aluAdd;
            end
            `ANDI: begin
                rsTimeUse = 2'd1;
                rtTimeUse = 2'd3;
                timeNew = 2'd2;
                RegDst = `regDstRT;
                ALUSrc = `aluSrcExt;
                RegSrc = `regSrcALU;
                RegWrite = `YES;
                MemWrite = `NO;
                MdWrite = `NO;
                MdRead = `NO;
                NPCOp = `npcNext;
                EXTOp = `zeroExtend;
                ALUOp = `aluAnd;
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
                MdWrite = `NO;
                MdRead = `NO;
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
                MdWrite = `NO;
                MdRead = `NO;
                NPCOp = `npcNext;
                EXTOp = `signExtend;
                ALUOp = `aluAdd;
                MemLen = `MemLenW;
            end
            `LH: begin
                rsTimeUse = 2'd1;
                rtTimeUse = 2'd3;
                timeNew = 2'd3;
                RegDst = `regDstRT;
                ALUSrc = `aluSrcExt;
                RegSrc = `regSrcMem;
                RegWrite = `YES;
                MemWrite = `NO;
                MdWrite = `NO;
                MdRead = `NO;
                NPCOp = `npcNext;
                EXTOp = `signExtend;
                ALUOp = `aluAdd;
                MemLen = `MemLenH;
            end
            `LB: begin
                rsTimeUse = 2'd1;
                rtTimeUse = 2'd3;
                timeNew = 2'd3;
                RegDst = `regDstRT;
                ALUSrc = `aluSrcExt;
                RegSrc = `regSrcMem;
                RegWrite = `YES;
                MemWrite = `NO;
                MdWrite = `NO;
                MdRead = `NO;
                NPCOp = `npcNext;
                EXTOp = `signExtend;
                ALUOp = `aluAdd;
                MemLen = `MemLenB;
            end
            `SW: begin
                rsTimeUse = 2'd1;
                rtTimeUse = 2'd2;
                timeNew = 2'd0;
                ALUSrc = `aluSrcExt;
                RegSrc = `regSrcALU;
                RegWrite = `NO;
                MemWrite = `YES;
                MdWrite = `NO;
                MdRead = `NO;
                NPCOp = `npcNext;
                EXTOp = `signExtend;
                ALUOp = `aluAdd;
                MemLen = `MemLenW;
            end
            `SH: begin
                rsTimeUse = 2'd1;
                rtTimeUse = 2'd2;
                timeNew = 2'd0;
                ALUSrc = `aluSrcExt;
                RegSrc = `regSrcALU;
                RegWrite = `NO;
                MemWrite = `YES;
                MdWrite = `NO;
                MdRead = `NO;
                NPCOp = `npcNext;
                EXTOp = `signExtend;
                ALUOp = `aluAdd;
                MemLen = `MemLenH;
            end
            `SB: begin
                rsTimeUse = 2'd1;
                rtTimeUse = 2'd2;
                timeNew = 2'd0;
                ALUSrc = `aluSrcExt;
                RegSrc = `regSrcALU;
                RegWrite = `NO;
                MemWrite = `YES;
                MdWrite = `NO;
                MdRead = `NO;
                NPCOp = `npcNext;
                EXTOp = `signExtend;
                ALUOp = `aluAdd;
                MemLen = `MemLenB;
            end
            `BEQ: begin
                rsTimeUse = 2'd0;
                rtTimeUse = 2'd0;
                timeNew = 2'd0;
                RegSrc = `regSrcALU;
                RegWrite = `NO;
                MemWrite = `NO;
                MdWrite = `NO;
                MdRead = `NO;
                NPCOp = `npcOffset;
                EXTOp = `signExtend;
                CMPOp = `cmpEqual;
                ALUOp = `aluNone;
            end 
            `BNE: begin
                rsTimeUse = 2'd0;
                rtTimeUse = 2'd0;
                timeNew = 2'd0;
                RegSrc = `regSrcALU;
                RegWrite = `NO;
                MemWrite = `NO;
                MdWrite = `NO;
                MdRead = `NO;
                NPCOp = `npcOffset;
                EXTOp = `signExtend;
                CMPOp = `cmpUnequal;
                ALUOp = `aluNone;
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
                MdWrite = `NO;
                MdRead = `NO;
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
                MdWrite = `NO;
                MdRead = `NO;
                NPCOp = `npcInstrIndex;
                ALUOp = `aluNone;
            end
            default: ; 
        endcase
    end
    
endmodule
