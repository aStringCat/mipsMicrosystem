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

module mips(
    input clk,
    input reset
    );

wire [31:0] pcNext;
wire [31:0] PC;
wire [31:0] Instr;
wire [5:0] op;
wire [5:0] func;
wire [4:0] rs;
wire [4:0] rt;
wire [4:0] rd;
wire [15:0] immediate;
wire [25:0] instr_index;

wire memWE;
wire regWE;
wire [1:0] nPC_sel;
wire [1:0] EXTOp;
wire [7:0] ALUOp;
wire [31:0] regRD1;
wire [31:0] regRD2;
wire [31:0] memRD;
wire [31:0] EXTOut;
wire [31:0] ALUOut;
wire [31:0] regWD;
wire [31:0] ALUInput2;
wire [4:0] regA3;
wire [1:0] RegDst;
wire ALUSrc;
wire [1:0] RegSrc;

assign regA3 = (RegDst == 2'd0) ? rd :
                (RegDst == 2'd1) ? rt :
                5'd31;

assign ALUInput2 = (ALUSrc == 1'b0) ? regRD2 : EXTOut;

assign regWD = (RegSrc == 2'd0) ? ALUOut :
                (RegSrc == 2'd1) ? memRD :
                PC + 32'h4; 

 
IFU ifu(
    .clk(clk),
    .reset(reset),
    .pcIn(pcNext),
    .pcOut(PC),
    .Instr(Instr)
);

Spiltter spiltter(
    .Instr(Instr),
    .op(op),
    .func(func),
    .rs(rs),
    .rt(rt),
    .rd(rd),
    .immediate(immediate),
    .instr_index(instr_index)
);

NPC npc(
    .pc(PC),
    .ALUOut(ALUOut),
    .offset(immediate),
    .instr_index(instr_index),
    .GRF(regRD1),
    .transOp(nPC_sel),
    .pcNext(pcNext)
);

ALU alu(
    .Input1(regRD1),
    .Input2(ALUInput2),
    .ALUOp(ALUOp),
    .Output(ALUOut)
);

DM dm(
    .clk(clk),
    .reset(reset),
    .memWE(memWE),
    .pc(PC),
    .memAddr(ALUOut),
    .memWD(regRD2),
    .memRD(memRD)
);

GRF grf(
    .clk(clk),
    .reset(reset),
    .regWE(regWE),
    .pc(PC),
    .regA1(rs),
    .regA2(rt),
    .regA3(regA3),
    .regWD(regWD),
    .regRD1(regRD1),
    .regRD2(regRD2)
);

EXT ext(
    .EXTOp(EXTOp),
    .In(immediate),
    .Out(EXTOut)
);

Controller controller(
    .op(op),
    .func(func),
    .RegDst(RegDst),
    .ALUSrc(ALUSrc),
    .RegSrc(RegSrc),
    .RegWrite(regWE),
    .MemWrite(memWE),
    .nPC_sel(nPC_sel),
    .EXTOp(EXTOp),
    .ALUOp(ALUOp)
);

endmodule
