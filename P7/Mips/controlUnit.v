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
    input wire [4:0] rs,
    input wire [5:0] func,
    input wire [4:0] ID_ExcCode_pre,
    
    output reg [1:0] rsTimeUse,
    output reg [1:0] rtTimeUse,
    output reg [1:0] timeNew,
    output reg [7:0] RegDst,
    output reg [7:0] ALUSrc,
    output reg [7:0] RegSrc,
    output reg RegWrite,
    output reg MemWrite,
    output reg MdWrite,
    output reg MdUse,
    output reg CP0Write,
    output reg [7:0] NPCOp,
    output reg [7:0] EXTOp,
    output reg [7:0] ALUOp,
    output reg [7:0] CMPOp,
    output reg [7:0] MemLen,
    output reg EXLClr,
    output reg [4:0] ID_ExcCode
    );

    always @(*) begin
        case (op)
            `SPECIAL: begin
                case (func)
                    `fADD: begin
                        rsTimeUse <= 2'd1;
                        rtTimeUse <= 2'd1;
                        timeNew <= 2'd2;
                        RegDst <= `regDstRD;
                        ALUSrc <= `aluSrcReg;
                        RegSrc <= `regSrcALU;
                        RegWrite <= `YES;
                        MemWrite <= `NO;
                        MdWrite <= `NO;
                        MdUse <= `NO;
                        CP0Write <= `NO;
                        NPCOp <= `npcNext;
                        ALUOp <= `aluAdd;
                        EXLClr <= `NO;
                        ID_ExcCode <= ID_ExcCode_pre;
                    end
                    `fSUB: begin
                        rsTimeUse <= 2'd1;
                        rtTimeUse <= 2'd1;
                        timeNew <= 2'd2;
                        RegDst <= `regDstRD;
                        ALUSrc <= `aluSrcReg;
                        RegSrc <= `regSrcALU;
                        RegWrite <= `YES;
                        MemWrite <= `NO;
                        MdWrite <= `NO;
                        MdUse <= `NO;
                        CP0Write <= `NO;
                        NPCOp <= `npcNext;
                        ALUOp <= `aluSub;
                        EXLClr <= `NO;
                        ID_ExcCode <= ID_ExcCode_pre;
                    end
                    `fAND: begin
                        rsTimeUse <= 2'd1;
                        rtTimeUse <= 2'd1;
                        timeNew <= 2'd2;
                        RegDst <= `regDstRD;
                        ALUSrc <= `aluSrcReg;
                        RegSrc <= `regSrcALU;
                        RegWrite <= `YES;
                        MemWrite <= `NO;
                        MdWrite <= `NO;
                        MdUse <= `NO;
                        CP0Write <= `NO;
                        NPCOp <= `npcNext;
                        ALUOp <= `aluAnd;
                        EXLClr <= `NO;
                        ID_ExcCode <= ID_ExcCode_pre;
                    end
                    `fDIV: begin
                        rsTimeUse <= 2'd1;
                        rtTimeUse <= 2'd1;
                        timeNew <= 2'd0;
                        ALUSrc <= `aluSrcReg;
                        RegWrite <= `NO;
                        MemWrite <= `NO;
                        MdWrite <= `YES;
                        MdUse <= `YES;
                        CP0Write <= `NO;
                        NPCOp <= `npcNext;
                        ALUOp <= `aluDiv;
                        EXLClr <= `NO;
                        ID_ExcCode <= ID_ExcCode_pre;
                    end
                    `fDIVU: begin
                        rsTimeUse <= 2'd1;
                        rtTimeUse <= 2'd1;
                        timeNew <= 2'd0;
                        ALUSrc <= `aluSrcReg;
                        RegWrite <= `NO;
                        MemWrite <= `NO;
                        MdWrite <= `YES;
                        MdUse <= `YES;
                        CP0Write <= `NO;
                        NPCOp <= `npcNext;
                        ALUOp <= `aluDivU;
                        EXLClr <= `NO;
                        ID_ExcCode <= ID_ExcCode_pre;
                    end
                    `fMULT: begin
                        rsTimeUse <= 2'd1;
                        rtTimeUse <= 2'd1;
                        timeNew <= 2'd0;
                        ALUSrc <= `aluSrcReg;
                        RegWrite <= `NO;
                        MemWrite <= `NO;
                        MdWrite <= `YES;
                        MdUse <= `YES;
                        CP0Write <= `NO;
                        NPCOp <= `npcNext;
                        ALUOp <= `aluMult;
                        EXLClr <= `NO;
                        ID_ExcCode <= ID_ExcCode_pre;
                    end
                    `fMULTU: begin
                        rsTimeUse <= 2'd1;
                        rtTimeUse <= 2'd1;
                        timeNew <= 2'd0;
                        ALUSrc <= `aluSrcReg;
                        RegWrite <= `NO;
                        MemWrite <= `NO;
                        MdWrite <= `YES;
                        MdUse <= `YES;
                        CP0Write <= `NO;
                        NPCOp <= `npcNext;
                        ALUOp <= `aluMultU;
                        EXLClr <= `NO;
                        ID_ExcCode <= ID_ExcCode_pre;
                    end
                    `fMFHI: begin
                        rsTimeUse <= 2'd3;
                        rtTimeUse <= 2'd3;
                        timeNew <= 2'd2;
                        RegDst <= `regDstRD;
                        ALUSrc <= `aluSrcReg;
                        RegSrc <= `regSrcALU;
                        RegWrite <= `YES;
                        MemWrite <= `NO;
                        MdWrite <= `NO;
                        MdUse <= `YES;
                        CP0Write <= `NO;
                        NPCOp <= `npcNext;
                        ALUOp <= `aluMfhi;
                        EXLClr <= `NO;
                        ID_ExcCode <= ID_ExcCode_pre;
                    end
                    `fMFLO: begin
                        rsTimeUse <= 2'd3;
                        rtTimeUse <= 2'd3;
                        timeNew <= 2'd2;
                        RegDst <= `regDstRD;
                        ALUSrc <= `aluSrcReg;
                        RegSrc <= `regSrcALU;
                        RegWrite <= `YES;
                        MemWrite <= `NO;
                        MdWrite <= `NO;
                        MdUse <= `YES;
                        CP0Write <= `NO;
                        NPCOp <= `npcNext;
                        ALUOp <= `aluMflo;
                        EXLClr <= `NO;
                        ID_ExcCode <= ID_ExcCode_pre;
                    end
                    `fMTHI: begin
                        rsTimeUse <= 2'd1;
                        rtTimeUse <= 2'd1;
                        timeNew <= 2'd0;
                        ALUSrc <= `aluSrcReg;
                        RegWrite <= `NO;
                        MemWrite <= `NO;
                        MdWrite <= `YES;
                        MdUse <= `YES;
                        CP0Write <= `NO;
                        NPCOp <= `npcNext;
                        ALUOp <= `aluMthi;
                        EXLClr <= `NO;
                        ID_ExcCode <= ID_ExcCode_pre;
                    end
                    `fMTLO: begin
                        rsTimeUse <= 2'd1;
                        rtTimeUse <= 2'd1;
                        timeNew <= 2'd0;
                        ALUSrc <= `aluSrcReg;
                        RegWrite <= `NO;
                        MemWrite <= `NO;
                        MdWrite <= `YES;
                        MdUse <= `YES;
                        CP0Write <= `NO;
                        NPCOp <= `npcNext;
                        ALUOp <= `aluMtlo;
                        EXLClr <= `NO;
                        ID_ExcCode <= ID_ExcCode_pre;
                    end
                    `fOR: begin
                        rsTimeUse <= 2'd1;
                        rtTimeUse <= 2'd1;
                        timeNew <= 2'd2;
                        RegDst <= `regDstRD;
                        ALUSrc <= `aluSrcReg;
                        RegSrc <= `regSrcALU;
                        RegWrite <= `YES;
                        MemWrite <= `NO;
                        MdWrite <= `NO;
                        MdUse <= `NO;
                        CP0Write <= `NO;
                        NPCOp <= `npcNext;
                        ALUOp <= `aluOr;
                        EXLClr <= `NO;
                        ID_ExcCode <= ID_ExcCode_pre;
                    end
                    `fNOP: begin
                        rsTimeUse <= 2'd3;
                        rtTimeUse <= 2'd3;
                        timeNew <= 2'd3;
                        RegWrite <= `NO;
                        MemWrite <= `NO;
                        MdWrite <= `NO;
                        MdUse <= `NO;
                        CP0Write <= `NO;
                        NPCOp <= `npcNext;
                        ALUOp <= `aluNone;
                        EXLClr <= `NO;
                        ID_ExcCode <= ID_ExcCode_pre;
                    end
                    `fSLT: begin
                        rsTimeUse <= 2'd1;
                        rtTimeUse <= 2'd1;
                        timeNew <= 2'd2;
                        RegDst <= `regDstRD;
                        ALUSrc <= `aluSrcReg;
                        RegSrc <= `regSrcALU;
                        RegWrite <= `YES;
                        MemWrite <= `NO;
                        MdWrite <= `NO;
                        MdUse <= `NO;
                        CP0Write <= `NO;
                        NPCOp <= `npcNext;
                        ALUOp <= `aluSetLessThan;
                        EXLClr <= `NO;
                        ID_ExcCode <= ID_ExcCode_pre;
                    end
                    `fSLTU: begin
                        rsTimeUse <= 2'd1;
                        rtTimeUse <= 2'd1;
                        timeNew <= 2'd2;
                        RegDst <= `regDstRD;
                        ALUSrc <= `aluSrcReg;
                        RegSrc <= `regSrcALU;
                        RegWrite <= `YES;
                        MemWrite <= `NO;
                        MdWrite <= `NO;
                        MdUse <= `NO;
                        CP0Write <= `NO;
                        NPCOp <= `npcNext;
                        ALUOp <= `aluSetLessThanUnsigned;
                        EXLClr <= `NO;
                        ID_ExcCode <= ID_ExcCode_pre;
                    end
                    `fJR: begin
                        rsTimeUse <= 2'd0;
                        rtTimeUse <= 2'd3;
                        timeNew <= 2'd0;
                        RegWrite <= `NO;
                        MemWrite <= `NO;
                        MdWrite <= `NO;
                        MdUse <= `NO;
                        CP0Write <= `NO;
                        NPCOp <= `npcReg;
                        ALUOp <= `aluNone;
                        EXLClr <= `NO;
                        ID_ExcCode <= ID_ExcCode_pre;
                    end
                    `fSYSCALL: begin
                        rsTimeUse <= 2'd3;
                        rtTimeUse <= 2'd3;
                        timeNew <= 2'd0;
                        RegWrite <= `NO;
                        MemWrite <= `NO;
                        MdWrite <= `NO;
                        MdUse <= `NO;
                        CP0Write <= `NO;
                        NPCOp <= `npcNext;
                        ALUOp <= `aluNone;
                        EXLClr <= `NO;
                        ID_ExcCode <= (ID_ExcCode_pre != `ExcNone) ? ID_ExcCode_pre : `Syscall;
                    end
                    default: begin
                        rsTimeUse <= 2'd3;
                        rtTimeUse <= 2'd3;
                        timeNew <= 2'd3;
                        RegWrite <= `NO;
                        MemWrite <= `NO;
                        MdWrite <= `NO;
                        MdUse <= `NO;
                        CP0Write <= `NO;
                        NPCOp <= `npcNext;
                        ALUOp <= `aluNone;
                        EXLClr <= `NO;
                        ID_ExcCode <= (ID_ExcCode_pre != `ExcNone) ? ID_ExcCode_pre : `RI;
                    end
                endcase
			end
            `COP0: begin
                if (func == `ERET) begin
                    rsTimeUse <= 2'd3;
                    rtTimeUse <= 2'd3;
                    timeNew <= 2'd0;
                    RegWrite <= `NO;
                    MemWrite <= `NO;
                    MdWrite <= `NO;
                    MdUse <= `NO;
                    CP0Write <= `NO;
                    NPCOp <= `npcEPC;
                    ALUOp <= `aluNone;
                    EXLClr <= `YES;
                    ID_ExcCode <= ID_ExcCode_pre;
                end else if (rs == `MFC0) begin
                    rsTimeUse <= 2'd3;
                    rtTimeUse <= 2'd3;
                    timeNew <= 2'd3;
                    RegDst <= `regDstRT;
                    RegSrc <= `regSrcCP0;
                    RegWrite <= `YES;
                    MemWrite <= `NO;
                    MdWrite <= `NO;
                    MdUse <= `NO;
                    CP0Write <= `NO;
                    NPCOp <= `npcNext;
                    ALUOp <= `aluNone;
                    EXLClr <= `NO;
                    ID_ExcCode <= ID_ExcCode_pre;
                end else if (rs == `MTC0) begin
                    rsTimeUse <= 2'd3;
                    rtTimeUse <= 2'd2;
                    timeNew <= 2'd0;
                    RegWrite <= `NO;
                    MemWrite <= `NO;
                    MdWrite <= `NO;
                    MdUse <= `NO;
                    CP0Write <= `YES;
                    NPCOp <= `npcNext;
                    ALUOp <= `aluNone;
                    EXLClr <= `NO;
                    ID_ExcCode <= ID_ExcCode_pre;
                end else begin
                    rsTimeUse <= 2'd3;
                    rtTimeUse <= 2'd3;
                    timeNew <= 2'd3;
                    RegWrite <= `NO;
                    MemWrite <= `NO;
                    MdWrite <= `NO;
                    MdUse <= `NO;
                    CP0Write <= `NO;
                    NPCOp <= `npcNext;
                    ALUOp <= `aluNone;
                    EXLClr <= `NO;
                    ID_ExcCode <= (ID_ExcCode_pre != `ExcNone) ? ID_ExcCode_pre : `RI;
                end
            end
            `ADDI: begin
                rsTimeUse <= 2'd1;
                rtTimeUse <= 2'd3;
                timeNew <= 2'd2;
                RegDst <= `regDstRT;
                ALUSrc <= `aluSrcExt;
                RegSrc <= `regSrcALU;
                RegWrite <= `YES;
                MemWrite <= `NO;
                MdWrite <= `NO;
                MdUse <= `NO;
                CP0Write <= `NO;
                NPCOp <= `npcNext;
                EXTOp <= `signExtend;
                ALUOp <= `aluAdd;
                EXLClr <= `NO;
                ID_ExcCode <= ID_ExcCode_pre;
            end
            `ANDI: begin
                rsTimeUse <= 2'd1;
                rtTimeUse <= 2'd3;
                timeNew <= 2'd2;
                RegDst <= `regDstRT;
                ALUSrc <= `aluSrcExt;
                RegSrc <= `regSrcALU;
                RegWrite <= `YES;
                MemWrite <= `NO;
                MdWrite <= `NO;
                MdUse <= `NO;
                CP0Write <= `NO;
                NPCOp <= `npcNext;
                EXTOp <= `zeroExtend;
                ALUOp <= `aluAnd;
                EXLClr <= `NO;
                ID_ExcCode <= ID_ExcCode_pre;
            end
            `ORI: begin
                rsTimeUse <= 2'd1;
                rtTimeUse <= 2'd3;
                timeNew <= 2'd2;
                RegDst <= `regDstRT;
                ALUSrc <= `aluSrcExt;
                RegSrc <= `regSrcALU;
                RegWrite <= `YES;
                MemWrite <= `NO;
                MdWrite <= `NO;
                MdUse <= `NO;
                CP0Write <= `NO;
                NPCOp <= `npcNext;
                EXTOp <= `zeroExtend;
                ALUOp <= `aluOr;
                EXLClr <= `NO;
                ID_ExcCode <= ID_ExcCode_pre;
            end
            `LW: begin
                rsTimeUse <= 2'd1;
                rtTimeUse <= 2'd3;
                timeNew <= 2'd3;
                RegDst <= `regDstRT;
                ALUSrc <= `aluSrcExt;
                RegSrc <= `regSrcMem;
                RegWrite <= `YES;
                MemWrite <= `NO;
                MdWrite <= `NO;
                MdUse <= `NO;
                CP0Write <= `NO;
                NPCOp <= `npcNext;
                EXTOp <= `signExtend;
                ALUOp <= `aluAddLoad;
                MemLen <= `MemLenW;
                EXLClr <= `NO;
                ID_ExcCode <= ID_ExcCode_pre;
            end
            `LH: begin
                rsTimeUse <= 2'd1;
                rtTimeUse <= 2'd3;
                timeNew <= 2'd3;
                RegDst <= `regDstRT;
                ALUSrc <= `aluSrcExt;
                RegSrc <= `regSrcMem;
                RegWrite <= `YES;
                MemWrite <= `NO;
                MdWrite <= `NO;
                MdUse <= `NO;
                CP0Write <= `NO;
                NPCOp <= `npcNext;
                EXTOp <= `signExtend;
                ALUOp <= `aluAddLoad;
                MemLen <= `MemLenH;
                EXLClr <= `NO;
                ID_ExcCode <= ID_ExcCode_pre;
            end
            `LB: begin
                rsTimeUse <= 2'd1;
                rtTimeUse <= 2'd3;
                timeNew <= 2'd3;
                RegDst <= `regDstRT;
                ALUSrc <= `aluSrcExt;
                RegSrc <= `regSrcMem;
                RegWrite <= `YES;
                MemWrite <= `NO;
                MdWrite <= `NO;
                MdUse <= `NO;
                CP0Write <= `NO;
                NPCOp <= `npcNext;
                EXTOp <= `signExtend;
                ALUOp <= `aluAddLoad;
                MemLen <= `MemLenB;
                EXLClr <= `NO;
                ID_ExcCode <= ID_ExcCode_pre;
            end
            `SW: begin
                rsTimeUse <= 2'd1;
                rtTimeUse <= 2'd2;
                timeNew <= 2'd0;
                ALUSrc <= `aluSrcExt;
                RegWrite <= `NO;
                MemWrite <= `YES;
                MdWrite <= `NO;
                MdUse <= `NO;
                CP0Write <= `NO;
                NPCOp <= `npcNext;
                EXTOp <= `signExtend;
                ALUOp <= `aluAddStore;
                MemLen <= `MemLenW;
                EXLClr <= `NO;
                ID_ExcCode <= ID_ExcCode_pre;
            end
            `SH: begin
                rsTimeUse <= 2'd1;
                rtTimeUse <= 2'd2;
                timeNew <= 2'd0;
                ALUSrc <= `aluSrcExt;
                RegWrite <= `NO;
                MemWrite <= `YES;
                MdWrite <= `NO;
                MdUse <= `NO;
                CP0Write <= `NO;
                NPCOp <= `npcNext;
                EXTOp <= `signExtend;
                ALUOp <= `aluAddStore;
                MemLen <= `MemLenH;
                EXLClr <= `NO;
                ID_ExcCode <= ID_ExcCode_pre;
            end
            `SB: begin
                rsTimeUse <= 2'd1;
                rtTimeUse <= 2'd2;
                timeNew <= 2'd0;
                ALUSrc <= `aluSrcExt;
                RegWrite <= `NO;
                MemWrite <= `YES;
                MdWrite <= `NO;
                MdUse <= `NO;
                CP0Write <= `NO;
                NPCOp <= `npcNext;
                EXTOp <= `signExtend;
                ALUOp <= `aluAddStore;
                MemLen <= `MemLenB;
                EXLClr <= `NO;
                ID_ExcCode <= ID_ExcCode_pre;
            end
            `BEQ: begin
                rsTimeUse <= 2'd0;
                rtTimeUse <= 2'd0;
                timeNew <= 2'd0;
                RegWrite <= `NO;
                MemWrite <= `NO;
                MdWrite <= `NO;
                MdUse <= `NO;
                CP0Write <= `NO;
                NPCOp <= `npcOffset;
                EXTOp <= `signExtend;
                CMPOp <= `cmpEqual;
                ALUOp <= `aluNone;
                EXLClr <= `NO;
                ID_ExcCode <= ID_ExcCode_pre;
            end 
            `BNE: begin
                rsTimeUse <= 2'd0;
                rtTimeUse <= 2'd0;
                timeNew <= 2'd0;
                RegWrite <= `NO;
                MemWrite <= `NO;
                MdWrite <= `NO;
                MdUse <= `NO;
                CP0Write <= `NO;
                NPCOp <= `npcOffset;
                EXTOp <= `signExtend;
                CMPOp <= `cmpUnequal;
                ALUOp <= `aluNone;
                EXLClr <= `NO;
                ID_ExcCode <= ID_ExcCode_pre;
            end 
            `LUI: begin
                rsTimeUse <= 2'd1;
                rtTimeUse <= 2'd3;
                timeNew <= 2'd2;
                RegDst <= `regDstRT;
                ALUSrc <= `aluSrcExt;
                RegSrc <= `regSrcALU;
                RegWrite <= `YES;
                MemWrite <= `NO;
                MdWrite <= `NO;
                MdUse <= `NO;
                CP0Write <= `NO;
                NPCOp <= `npcNext;
                EXTOp <= `upperExtend;
                ALUOp <= `aluAdd;
                EXLClr <= `NO;
                ID_ExcCode <= ID_ExcCode_pre;
            end
            `J: begin
                rsTimeUse <= 2'd3;
                rtTimeUse <= 2'd3;
                timeNew <= 2'd0;
                RegWrite <= `NO;
                MemWrite <= `NO;
                MdWrite <= `NO;
                MdUse <= `NO;
                CP0Write <= `NO;
                NPCOp <= `npcInstrIndex;
                ALUOp <= `aluNone;
                EXLClr <= `NO; 
                ID_ExcCode <= ID_ExcCode_pre;
            end
            `JAL: begin
                rsTimeUse <= 2'd3;
                rtTimeUse <= 2'd3;
                timeNew <= 2'd0;
                RegDst <= `regDstRA;
                RegSrc <= `regSrcPC;
                RegWrite <= `YES;
                MemWrite <= `NO;
                MdWrite <= `NO;
                MdUse <= `NO;
                CP0Write <= `NO;
                NPCOp <= `npcInstrIndex;
                ALUOp <= `aluNone;
                EXLClr <= `NO; 
                ID_ExcCode <= ID_ExcCode_pre;
            end
            default:begin
                rsTimeUse <= 2'd3;
                rtTimeUse <= 2'd3;
                timeNew <= 2'd3;
                RegWrite <= `NO;
                MemWrite <= `NO;
                MdWrite <= `NO;
                MdUse <= `NO;
                CP0Write <= `NO;
                NPCOp <= `npcNext;
                ALUOp <= `aluNone;
                EXLClr <= `NO; 
                ID_ExcCode <= (ID_ExcCode_pre != `ExcNone) ? ID_ExcCode_pre : `RI;
            end 
        endcase
    end
    
endmodule
