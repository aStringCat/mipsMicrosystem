`define SPECIAL 6'b000000
`define fADD 6'b100000
`define fSUB 6'b100010
`define fSLL 6'b000000
`define fJR 6'b001000
`define ORI 6'b001101
`define LW 6'b100011
`define SW 6'b101011
`define BEQ 6'b000100
`define LUI 6'b001111
`define JAL 6'b000011

//RegDst
`define regDstRD 8'd0
`define regDstRT 8'd1
`define regDstRA 8'd2

//ALUSrc
`define aluSrcReg 8'b0
`define aluSrcExt 8'b1 

//RegSrc
`define regSrcALU 8'd0
`define regSrcMem 8'd1
`define regSrcPC 8'd2

//NPCOp
`define npcNext 8'd0 
`define npcOffset 8'd1
`define npcInstrIndex 8'd2
`define npcReg 8'd3

//EXTOp
`define zeroExtend 8'd0
`define signExtend 8'd1
`define upperExtend 8'd2
 
//ALUOp
`define aluAdd 8'd0
`define aluSub 8'd1
`define aluOr 8'd2
`define aluLogicalLeft 8'd3

//CMPOp
`define cmpEqual 8'd0

//forward
`define Self 8'd0
`define EX_forward 8'd1
`define MEM_forward 8'd2
`define WB_forward 8'd3

`define YES 1'b1
`define NO 1'b0
 
