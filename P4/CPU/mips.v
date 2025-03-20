`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:14:00 10/31/2024 
// Design Name: 
// Module Name:    mips 
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

module mips(
    input wire clk,
    input wire reset
    );

//F 
wire stall;

wire [31:0] IF_pcIn;
wire [31:0] IF_pc;
wire [31:0] IF_Instr;

wire [5:0] IF_op;
wire [5:0] IF_func;
wire [4:0] IF_rs;
wire [4:0] IF_rt;
wire [4:0] IF_rd;
wire [15:0] IF_immediate;
wire [25:0] IF_instrIndex;

//D
wire [31:0] ID_pc;
wire [5:0] ID_op;
wire [5:0] ID_func;
wire [4:0] ID_rs;
wire [4:0] ID_rt;
wire [4:0] ID_rd;
wire [15:0] ID_immediate;
wire [25:0] ID_instrIndex;

wire [1:0] ID_rsTimeUse;
wire [1:0] ID_rtTimeUse;
wire [1:0] ID_timeNew;
wire [7:0] ID_RegDst;
wire [7:0] ID_ALUSrc;
wire [7:0] ID_RegSrc;
wire ID_RegWrite;
wire ID_MemWrite;
wire [7:0] ID_NPCOp;
wire [7:0] ID_EXTOp;
wire [7:0] ID_ALUOp;
wire [7:0] ID_CMPOp;

wire [31:0] ID_regRD1_pre;
wire [31:0] ID_regRD2_pre;
wire [31:0] ID_regRD1;
wire [31:0] ID_regRD2;
wire [31:0] ID_EXTOut;
wire ID_CMPOut;
wire [31:0] ID_pcNext;

//E
wire [31:0] EX_pc;
wire [4:0] EX_rs;
wire [4:0] EX_rt;
wire [4:0] EX_rd;
wire [31:0] EX_regRD1_pre;
wire [31:0] EX_regRD2_pre;
wire [31:0] EX_EXTOut;
wire [1:0] EX_timeNew;
wire [7:0] EX_RegDst;
wire [7:0] EX_ALUSrc;
wire [7:0] EX_RegSrc;
wire EX_RegWrite;
wire EX_MemWrite;
wire [7:0] EX_ALUOp;

wire [31:0] EX_regRD1;
wire [31:0] EX_regRD2;
wire [31:0] ALUInput2;
wire [31:0] EX_ALUOut;

//M
wire [31:0] MEM_pc;
wire [4:0] MEM_rt;
wire [4:0] MEM_rd;
wire [31:0] MEM_ALUOut;
wire [31:0] MEM_regRD2_pre;
wire [1:0] MEM_timeNew;
wire [7:0] MEM_RegDst;
wire [7:0] MEM_RegSrc;
wire MEM_RegWrite;
wire MEM_MemWrite;

wire [31:0] MEM_regRD2;
wire [31:0] MEM_memRD;

//W
wire [31:0] WB_pc;
wire [4:0] WB_rt;
wire [4:0] WB_rd;
wire [31:0] WB_ALUOut;
wire [31:0] WB_memRD;
wire [1:0] WB_timeNew;
wire [7:0] WB_RegDst;
wire [7:0] WB_RegSrc;
wire WB_RegWrite;

wire [4:0] WB_regAW;
wire [31:0] WB_regWD;

//F 

assign IF_pcIn = (stall == `YES) ? IF_pc :
                    (ID_NPCOp != `npcNext) ? ID_pcNext : IF_pc + 32'h4;

hazaedControl hazaedcontrol (
    .ID_rs(ID_rs), 
    .ID_rt(ID_rt), 
    .ID_rsTimeUse(ID_rsTimeUse), 
    .ID_rtTimeUse(ID_rtTimeUse), 
    .EX_pc(EX_pc), 
    .EX_rs(EX_rs), 
    .EX_rt(EX_rt), 
    .EX_rd(EX_rd), 
    .EX_RegDst(EX_RegDst), 
    .EX_RegSrc(EX_RegSrc), 
    .EX_timeNew(EX_timeNew), 
    .EX_RegWrite(EX_RegWrite), 
    .MEM_pc(MEM_pc), 
    .MEM_rt(MEM_rt), 
    .MEM_rd(MEM_rd), 
    .MEM_RegDst(MEM_RegDst), 
    .MEM_RegSrc(MEM_RegSrc), 
    .MEM_timeNew(MEM_timeNew), 
    .MEM_RegWrite(MEM_RegWrite), 
    .WB_pc(WB_pc), 
    .WB_rt(WB_rt), 
    .WB_rd(WB_rd), 
    .WB_RegDst(WB_RegDst), 
    .WB_RegSrc(WB_RegSrc), 
    .WB_timeNew(WB_timeNew), 
    .WB_RegWrite(WB_RegWrite), 
    .ID_regRD1_pre(ID_regRD1_pre), 
    .ID_regRD2_pre(ID_regRD2_pre), 
    .EX_regRD1_pre(EX_regRD1_pre), 
    .EX_regRD2_pre(EX_regRD2_pre), 
    .MEM_regRD2_pre(MEM_regRD2_pre), 
    .EX_ALUOut(EX_ALUOut), 
    .MEM_ALUOut(MEM_ALUOut), 
    .MEM_memRD(MEM_memRD), 
    .WB_ALUOut(WB_ALUOut), 
    .WB_memRD(WB_memRD), 
    .stall(stall), 
    .ID_regRD1(ID_regRD1), 
    .ID_regRD2(ID_regRD2), 
    .EX_regRD1(EX_regRD1), 
    .EX_regRD2(EX_regRD2), 
    .MEM_regRD2(MEM_regRD2)
    );

IFU ifu (
    .clk(clk), 
    .reset(reset), 
    .pcIn(IF_pcIn), 
    .pcOut(IF_pc), 
    .Instr(IF_Instr)
    );

Spiltter spiltter (
    .Instr(IF_Instr),
    .op(IF_op),
    .func(IF_func),
    .rs(IF_rs),
    .rt(IF_rt),
    .rd(IF_rd),
    .immediate(IF_immediate),
    .instrIndex(IF_instrIndex)
    );

IFtoID IftoId (
    .clk(clk), 
    .reset(reset), 
    .stall(stall),
    .IF_pc(IF_pc), 
    .IF_op(IF_op), 
    .IF_func(IF_func), 
    .IF_rs(IF_rs), 
    .IF_rt(IF_rt), 
    .IF_rd(IF_rd), 
    .IF_immediate(IF_immediate), 
    .IF_instrIndex(IF_instrIndex), 
    .ID_pc(ID_pc), 
    .ID_op(ID_op), 
    .ID_func(ID_func), 
    .ID_rs(ID_rs), 
    .ID_rt(ID_rt), 
    .ID_rd(ID_rd), 
    .ID_immediate(ID_immediate), 
    .ID_instrIndex(ID_instrIndex)
    );

//D
controlUnit controlunit (
    .op(ID_op), 
    .func(ID_func), 
    .rsTimeUse(ID_rsTimeUse), 
    .rtTimeUse(ID_rtTimeUse), 
    .timeNew(ID_timeNew),
    .RegDst(ID_RegDst), 
    .ALUSrc(ID_ALUSrc), 
    .RegSrc(ID_RegSrc), 
    .RegWrite(ID_RegWrite), 
    .MemWrite(ID_MemWrite), 
    .NPCOp(ID_NPCOp), 
    .EXTOp(ID_EXTOp), 
    .ALUOp(ID_ALUOp), 
    .CMPOp(ID_CMPOp)
    );

GRF grf (
    .clk(clk), 
    .reset(reset), 
    .regWE(WB_RegWrite), 
    .pc(WB_pc), 
    .regA1(ID_rs), 
    .regA2(ID_rt), 
    .regAW(WB_regAW), 
    .regWD(WB_regWD), 
    .regRD1(ID_regRD1_pre), 
    .regRD2(ID_regRD2_pre)
    );

EXT ext (
    .EXTOp(ID_EXTOp), 
    .In(ID_immediate), 
    .Out(ID_EXTOut)
    );

CMP cmp (
    .CMPOp(ID_CMPOp), 
    .CMPInput1(ID_regRD1), 
    .CMPInput2(ID_regRD2), 
    .CMPOut(ID_CMPOut)
    );

NPC npc (
    .pc(ID_pc), 
    .offset(ID_immediate), 
    .instrIndex(ID_instrIndex), 
    .GRF(ID_regRD1), 
    .NPCOp(ID_NPCOp), 
    .CMPOut(ID_CMPOut), 
    .pcNext(ID_pcNext)
    );

IDtoEX IdtoEx (
    .clk(clk), 
    .reset(reset), 
    .stall(stall), 
    .ID_pc(ID_pc), 
    .ID_rs(ID_rs), 
    .ID_rt(ID_rt), 
    .ID_rd(ID_rd), 
    .ID_regRD1(ID_regRD1), 
    .ID_regRD2(ID_regRD2), 
    .ID_EXTOut(ID_EXTOut), 
    .ID_timeNew(ID_timeNew), 
    .ID_RegDst(ID_RegDst), 
    .ID_ALUSrc(ID_ALUSrc), 
    .ID_RegSrc(ID_RegSrc), 
    .ID_RegWrite(ID_RegWrite), 
    .ID_MemWrite(ID_MemWrite), 
    .ID_ALUOp(ID_ALUOp), 
    .EX_pc(EX_pc), 
    .EX_rs(EX_rs), 
    .EX_rt(EX_rt), 
    .EX_rd(EX_rd), 
    .EX_regRD1_pre(EX_regRD1_pre), 
    .EX_regRD2_pre(EX_regRD2_pre), 
    .EX_EXTOut(EX_EXTOut), 
    .EX_timeNew(EX_timeNew), 
    .EX_RegDst(EX_RegDst), 
    .EX_ALUSrc(EX_ALUSrc), 
    .EX_RegSrc(EX_RegSrc), 
    .EX_RegWrite(EX_RegWrite), 
    .EX_MemWrite(EX_MemWrite), 
    .EX_ALUOp(EX_ALUOp)
    );

//E

assign ALUInput2 = (EX_ALUSrc == `aluSrcReg) ? EX_regRD2 : EX_EXTOut;

ALU alu (
    .ALUInput1(EX_regRD1), 
    .ALUInput2(ALUInput2), 
    .ALUOp(EX_ALUOp), 
    .ALUOut(EX_ALUOut)
    );

EXtoMEM ExtoMem (
    .clk(clk), 
    .reset(reset), 
    .EX_pc(EX_pc), 
    .EX_rt(EX_rt), 
    .EX_rd(EX_rd), 
    .EX_ALUOut(EX_ALUOut), 
    .EX_regRD2(EX_regRD2), 
    .EX_timeNew(EX_timeNew), 
    .EX_RegDst(EX_RegDst), 
    .EX_RegSrc(EX_RegSrc), 
    .EX_RegWrite(EX_RegWrite), 
    .EX_MemWrite(EX_MemWrite), 
    .MEM_pc(MEM_pc), 
    .MEM_rt(MEM_rt), 
    .MEM_rd(MEM_rd), 
    .MEM_ALUOut(MEM_ALUOut), 
    .MEM_regRD2_pre(MEM_regRD2_pre), 
    .MEM_timeNew(MEM_timeNew), 
    .MEM_RegDst(MEM_RegDst), 
    .MEM_RegSrc(MEM_RegSrc), 
    .MEM_RegWrite(MEM_RegWrite), 
    .MEM_MemWrite(MEM_MemWrite)
    );

//M
DM dm (
    .clk(clk), 
    .reset(reset), 
    .memWE(MEM_MemWrite), 
    .pc(MEM_pc), 
    .memAddr(MEM_ALUOut), 
    .memWD(MEM_regRD2), 
    .memRD(MEM_memRD)
    );

MEMtoWB MemtoWb (
    .clk(clk), 
    .reset(reset), 
    .MEM_pc(MEM_pc), 
    .MEM_rt(MEM_rt), 
    .MEM_rd(MEM_rd), 
    .MEM_ALUOut(MEM_ALUOut), 
    .MEM_memRD(MEM_memRD), 
    .MEM_timeNew(MEM_timeNew), 
    .MEM_RegDst(MEM_RegDst), 
    .MEM_RegSrc(MEM_RegSrc), 
    .MEM_RegWrite(MEM_RegWrite), 
    .WB_pc(WB_pc), 
    .WB_rt(WB_rt), 
    .WB_rd(WB_rd), 
    .WB_ALUOut(WB_ALUOut), 
    .WB_memRD(WB_memRD), 
    .WB_timeNew(WB_timeNew), 
    .WB_RegDst(WB_RegDst), 
    .WB_RegSrc(WB_RegSrc), 
    .WB_RegWrite(WB_RegWrite)
    );

//W

assign WB_regAW = (WB_RegDst == `regDstRD) ? WB_rd : 
                    (WB_RegDst == `regDstRT) ? WB_rt :
                    5'd31;

assign WB_regWD = (WB_RegSrc == `regSrcALU) ? WB_ALUOut :
                    (WB_RegSrc == `regSrcMem) ? WB_memRD :
                    WB_pc + 32'h8;

endmodule

