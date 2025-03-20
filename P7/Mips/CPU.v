`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:36:02 11/19/2024 
// Design Name: 
// Module Name:    CPU 
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

module CPU(
    input wire clk,
    input wire reset,
    input wire [31:0] i_inst_rdata,
    output wire [31:0] i_inst_addr,
    output wire [31:0] macroscopic_pc,

    input wire [31:0] m_data_rdata,
    output wire [31:0] m_data_addr,
    output wire [31:0] m_data_wdata,
    output wire [3 :0] m_data_byteen,
    output wire [31:0] m_inst_addr,

    output wire w_grf_we,
    output wire [4:0] w_grf_addr,
    output wire [31:0] w_grf_wdata,
    output wire [31:0] w_inst_addr,

    input wire [5:0] HWInt
    );


//----------------F-----------------------// 
wire stall;
wire flush;

wire [31:0] IF_pcIn;
wire [31:0] IF_pc;
wire [31:0] IF_Instr;
wire [4:0] IF_ExcCode;

wire [5:0] IF_op;
wire [5:0] IF_func;
wire [4:0] IF_rs;
wire [4:0] IF_rt;
wire [4:0] IF_rd;
wire [15:0] IF_immediate;
wire [25:0] IF_instrIndex;
wire IF_BD;

//----------------D-----------------------// 
wire [31:0] ID_pc;
wire [5:0] ID_op;
wire [5:0] ID_func;
wire [4:0] ID_rs;
wire [4:0] ID_rt;
wire [4:0] ID_rd;
wire [15:0] ID_immediate;
wire [25:0] ID_instrIndex;
wire ID_BD;
wire [4:0] ID_ExcCode_pre;

wire [1:0] ID_rsTimeUse;
wire [1:0] ID_rtTimeUse;
wire [1:0] ID_timeNew;
wire [7:0] ID_RegDst;
wire [7:0] ID_ALUSrc;
wire [7:0] ID_RegSrc;
wire ID_RegWrite;
wire ID_MemWrite;
wire ID_MdWrite;
wire ID_MdUse;
wire ID_CP0Write;
wire [7:0] ID_NPCOp;
wire [7:0] ID_EXTOp;
wire [7:0] ID_ALUOp;
wire [7:0] ID_CMPOp;
wire [7:0] ID_MemLen;
wire ID_EXLClr;
wire [4:0] ID_ExcCode;

wire [31:0] ID_regRD1_pre;
wire [31:0] ID_regRD2_pre;
wire [31:0] ID_regRD1;
wire [31:0] ID_regRD2;
wire [31:0] ID_EXTOut;
wire ID_CMPOut;
wire [31:0] ID_pcNext;

//----------------E-----------------------// 
wire [7:0] busy;

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
wire EX_MdWrite;
wire EX_CP0Write;
wire [7:0] EX_ALUOp;
wire [7:0] EX_MemLen;
wire EX_EXLClr;
wire EX_BD;
wire [4:0] EX_ExcCode_pre;

wire [31:0] EX_regRD1;
wire [31:0] EX_regRD2;
wire [31:0] ALUInput2;
wire [31:0] EX_ALUOut;
wire [4:0] EX_ExcCode;

//----------------M-----------------------// 
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
wire MEM_CP0Write;
wire [7:0] MEM_MemLen;
wire MEM_EXLClr;
wire MEM_BD;
wire [4:0] MEM_ExcCode_pre;

wire [31:0] MEM_regRD2;
wire [31:0] MEM_memRD;
wire [31:0] MEM_memRD_Word;
wire [3:0] MEM_MemByteEn;
wire [31:0] MEM_MemWD;
wire [4:0] MEM_ExcCode;

// ------- CP0-------//
wire [31:0] MEM_CP0Out;
wire [31:0] MEM_EPCOut;
wire Req;

//----------------W-----------------------// 
wire [31:0] WB_pc;
wire [4:0] WB_rt;
wire [4:0] WB_rd;
wire [31:0] WB_ALUOut;
wire [31:0] WB_memRD;
wire [31:0] WB_CP0Out;
wire [1:0] WB_timeNew;
wire [7:0] WB_RegDst;
wire [7:0] WB_RegSrc;
wire WB_RegWrite;

wire [4:0] WB_regAW;
wire [31:0] WB_regWD;

//-------------------assigns------------//
assign IF_Instr = (IF_ExcCode == `AdEL) ? 32'h0 : i_inst_rdata; 
assign MEM_memRD_Word = m_data_rdata;

assign i_inst_addr = IF_pc;
assign m_data_addr = MEM_ALUOut;
assign m_data_wdata = MEM_MemWD;
assign m_data_byteen = MEM_MemByteEn;
assign m_inst_addr = MEM_pc;
assign w_grf_we = WB_RegWrite;
assign w_grf_addr = WB_regAW;
assign w_grf_wdata = WB_regWD;
assign w_inst_addr = WB_pc;

assign macroscopic_pc = MEM_pc;

//----------------F-----------------------//  

assign IF_pcIn = (Req == `YES) ? 32'h4180 : 
                    (stall == `YES) ? IF_pc :
                    (ID_NPCOp != `npcNext) ? ID_pcNext : IF_pc + 32'h4;

hazaedControl hazaedcontrol (
    .ID_rs(ID_rs), 
    .ID_rt(ID_rt), 
    .ID_rsTimeUse(ID_rsTimeUse), 
    .ID_rtTimeUse(ID_rtTimeUse), 
    .ID_MdUse(ID_MdUse), 
    .ID_NPCOp(ID_NPCOp), 
    .busy(busy), 
    .EX_pc(EX_pc), 
    .EX_rs(EX_rs), 
    .EX_rt(EX_rt), 
    .EX_rd(EX_rd), 
    .EX_RegDst(EX_RegDst), 
    .EX_RegSrc(EX_RegSrc), 
    .EX_timeNew(EX_timeNew), 
    .EX_RegWrite(EX_RegWrite), 
    .EX_MdWrite(EX_MdWrite), 
    .EX_CP0Write(EX_CP0Write), 
    .MEM_pc(MEM_pc), 
    .MEM_rt(MEM_rt), 
    .MEM_rd(MEM_rd), 
    .MEM_RegDst(MEM_RegDst), 
    .MEM_RegSrc(MEM_RegSrc), 
    .MEM_timeNew(MEM_timeNew), 
    .MEM_RegWrite(MEM_RegWrite), 
    .MEM_CP0Write(MEM_CP0Write), 
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
    .MEM_CP0Out(MEM_CP0Out), 
    .WB_ALUOut(WB_ALUOut), 
    .WB_memRD(WB_memRD), 
    .WB_CP0Out(WB_CP0Out), 
    .stall(stall), 
    .ID_regRD1(ID_regRD1), 
    .ID_regRD2(ID_regRD2), 
    .EX_regRD1(EX_regRD1), 
    .EX_regRD2(EX_regRD2), 
    .MEM_regRD2(MEM_regRD2)
    );

RegPC regpc (
    .clk(clk), 
    .reset(reset), 
    .Req(Req),
    .pcIn(IF_pcIn), 
    .pcOut(IF_pc),
    .ExcCode(IF_ExcCode)
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
    .flush(flush), 
    .Req(Req), 
    .IF_pc(IF_pc), 
    .IF_op(IF_op), 
    .IF_func(IF_func), 
    .IF_rs(IF_rs), 
    .IF_rt(IF_rt), 
    .IF_rd(IF_rd), 
    .IF_immediate(IF_immediate), 
    .IF_instrIndex(IF_instrIndex), 
    .IF_BD(IF_BD), 
    .IF_ExcCode(IF_ExcCode), 
    .ID_pc(ID_pc), 
    .ID_op(ID_op), 
    .ID_func(ID_func), 
    .ID_rs(ID_rs), 
    .ID_rt(ID_rt), 
    .ID_rd(ID_rd), 
    .ID_immediate(ID_immediate), 
    .ID_instrIndex(ID_instrIndex), 
    .ID_BD(ID_BD), 
    .ID_ExcCode_pre(ID_ExcCode_pre)
    );

//----------------D-----------------------// 
controlUnit controlunit (
    .op(ID_op), 
    .rs(ID_rs), 
    .func(ID_func),
    .ID_ExcCode_pre(ID_ExcCode_pre),
    .rsTimeUse(ID_rsTimeUse), 
    .rtTimeUse(ID_rtTimeUse), 
    .timeNew(ID_timeNew),
    .RegDst(ID_RegDst), 
    .ALUSrc(ID_ALUSrc), 
    .RegSrc(ID_RegSrc), 
    .RegWrite(ID_RegWrite), 
    .MemWrite(ID_MemWrite), 
    .MdWrite(ID_MdWrite), 
    .MdUse(ID_MdUse), 
    .CP0Write(ID_CP0Write),
    .NPCOp(ID_NPCOp), 
    .EXTOp(ID_EXTOp), 
    .ALUOp(ID_ALUOp), 
    .CMPOp(ID_CMPOp),
    .MemLen(ID_MemLen),
    .EXLClr(ID_EXLClr),
    .ID_ExcCode(ID_ExcCode)
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
    .EPC(MEM_EPCOut),
    .NPCOp(ID_NPCOp), 
    .CMPOut(ID_CMPOut), 
    .pcNext(ID_pcNext),
    .BDIn(IF_BD),
    .flush(flush)
    );

IDtoEX IdtoEx (
    .clk(clk), 
    .reset(reset), 
    .stall(stall), 
    .Req(Req), 
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
    .ID_MdWrite(ID_MdWrite), 
    .ID_CP0Write(ID_CP0Write), 
    .ID_ALUOp(ID_ALUOp), 
    .ID_MemLen(ID_MemLen), 
    .ID_EXLClr(ID_EXLClr), 
    .ID_BD(ID_BD), 
    .ID_ExcCode(ID_ExcCode),
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
    .EX_MdWrite(EX_MdWrite), 
    .EX_CP0Write(EX_CP0Write), 
    .EX_ALUOp(EX_ALUOp), 
    .EX_MemLen(EX_MemLen), 
    .EX_EXLClr(EX_EXLClr), 
    .EX_BD(EX_BD),
    .EX_ExcCode_pre(EX_ExcCode_pre)
    );

//----------------E-----------------------// 

assign ALUInput2 = (EX_ALUSrc == `aluSrcReg) ? EX_regRD2 : 
                    (EX_ALUSrc == `aluSrcExt) ? EX_EXTOut : 32'h0;

ALU alu (
    .clk(clk),
    .reset(reset),
    .ALUInput1(EX_regRD1), 
    .ALUInput2(ALUInput2), 
    .Req(Req),
    .ALUOp(EX_ALUOp), 
    .EX_ExcCode_pre(EX_ExcCode_pre),
    .ALUOut(EX_ALUOut),
    .busy(busy),
    .EX_ExcCode(EX_ExcCode)
    );

EXtoMEM ExtoMem (
    .clk(clk), 
    .reset(reset), 
    .Req(Req), 
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
    .EX_CP0Write(EX_CP0Write), 
    .EX_MemLen(EX_MemLen), 
    .EX_EXLClr(EX_EXLClr), 
    .EX_BD(EX_BD), 
    .EX_ExcCode(EX_ExcCode), 
    .MEM_pc(MEM_pc), 
    .MEM_rt(MEM_rt), 
    .MEM_rd(MEM_rd), 
    .MEM_ALUOut(MEM_ALUOut), 
    .MEM_regRD2_pre(MEM_regRD2_pre), 
    .MEM_timeNew(MEM_timeNew), 
    .MEM_RegDst(MEM_RegDst), 
    .MEM_RegSrc(MEM_RegSrc), 
    .MEM_RegWrite(MEM_RegWrite), 
    .MEM_MemWrite(MEM_MemWrite), 
    .MEM_CP0Write(MEM_CP0Write), 
    .MEM_MemLen(MEM_MemLen), 
    .MEM_EXLClr(MEM_EXLClr), 
    .MEM_BD(MEM_BD), 
    .MEM_ExcCode_pre(MEM_ExcCode_pre)
    );

//----------------M-----------------------// 
CP0 cp0 (
    .clk(clk), 
    .reset(reset), 
    .en(MEM_CP0Write), 
    .CP0Addr(MEM_rd), 
    .CP0In(MEM_regRD2), 
    .VPC(macroscopic_pc), 
    .BDIn(MEM_BD), 
    .ExcCodeIn(MEM_ExcCode), 
    .HWInt(HWInt), 
    .EXLClr(MEM_EXLClr),
    .CP0Out(MEM_CP0Out), 
    .EPCOut(MEM_EPCOut), 
    .Req(Req)
    );

MemByte memByte (
    .MemA(MEM_ALUOut[1:0]), 
    .ALUOut(MEM_ALUOut),
    .RegRD2(MEM_regRD2),
    .MemLen(MEM_MemLen), 
    .MemWrite(MEM_MemWrite), 
    .MemRead(MEM_RegSrc == `regSrcMem),
    .Req(Req),
    .MEM_ExcCode_pre(MEM_ExcCode_pre),
    .MemByteEn(MEM_MemByteEn),
    .MemWD(MEM_MemWD),
    .MEM_ExcCode(MEM_ExcCode)
    );

MemEXT memExt (
    .MemA(MEM_ALUOut[1:0]), 
    .MemLen(MEM_MemLen), 
    .Din(MEM_memRD_Word), 
    .Dout(MEM_memRD)
    );

MEMtoWB MemtoWb (
    .clk(clk), 
    .reset(reset), 
    .Req(Req), 
    .MEM_pc(MEM_pc), 
    .MEM_rt(MEM_rt), 
    .MEM_rd(MEM_rd), 
    .MEM_ALUOut(MEM_ALUOut), 
    .MEM_memRD(MEM_memRD), 
    .MEM_CP0Out(MEM_CP0Out), 
    .MEM_timeNew(MEM_timeNew), 
    .MEM_RegDst(MEM_RegDst), 
    .MEM_RegSrc(MEM_RegSrc), 
    .MEM_RegWrite(MEM_RegWrite), 
    .WB_pc(WB_pc), 
    .WB_rt(WB_rt), 
    .WB_rd(WB_rd), 
    .WB_ALUOut(WB_ALUOut), 
    .WB_memRD(WB_memRD), 
    .WB_CP0Out(WB_CP0Out), 
    .WB_timeNew(WB_timeNew), 
    .WB_RegDst(WB_RegDst), 
    .WB_RegSrc(WB_RegSrc), 
    .WB_RegWrite(WB_RegWrite)
    );
    
//----------------W-----------------------// 

assign WB_regAW = (WB_RegDst == `regDstRD) ? WB_rd : 
                    (WB_RegDst == `regDstRT) ? WB_rt :
                    (WB_RegDst == `regDstRA) ? 5'd31 : 5'b0;

assign WB_regWD = (WB_RegSrc == `regSrcALU) ? WB_ALUOut :
                    (WB_RegSrc == `regSrcMem) ? WB_memRD :
                    (WB_RegSrc == `regSrcPC) ? WB_pc + 32'h8 :
                    (WB_RegSrc == `regSrcCP0) ? WB_CP0Out : 32'h0;


endmodule


