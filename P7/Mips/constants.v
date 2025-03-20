`define SPECIAL 6'b000000
`define fADD 6'b100000
`define fSUB 6'b100010
`define fAND 6'b100100
`define fDIV 6'b011010
`define fDIVU 6'b011011
`define fMFHI 6'b010000
`define fMFLO 6'b010010
`define fMTHI 6'b010001
`define fMTLO 6'b010011
`define fMULT 6'b011000
`define fMULTU 6'b011001
`define fOR 6'b100101
`define fNOP 6'b000000
`define fSLT 6'b101010
`define fSLTU 6'b101011
`define fJR 6'b001000
`define fSYSCALL 6'b001100
`define ADDI 6'b001000
`define ANDI 6'b001100
`define ORI 6'b001101
`define LW 6'b100011
`define LH 6'b100001
`define LB 6'b100000
`define SW 6'b101011
`define SH 6'b101001 
`define SB 6'b101000
`define BEQ 6'b000100
`define BNE 6'b000101
`define LUI 6'b001111
`define J 6'b000010
`define JAL 6'b000011
`define COP0 6'b010000
`define MFC0 5'b00000
`define MTC0 5'b00100
`define ERET 6'b011000

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
`define regSrcCP0 8'd3

//NPCOp
`define npcNext 8'd0 
`define npcOffset 8'd1
`define npcInstrIndex 8'd2
`define npcReg 8'd3
`define npcEPC 8'd4

//EXTOp
`define zeroExtend 8'd0
`define signExtend 8'd1
`define upperExtend 8'd2
 
//ALUOp
`define aluNone 8'd0
`define aluAdd 8'd1
`define aluSub 8'd2
`define aluMult 8'd3
`define aluMultU 8'd4
`define aluDiv 8'd5
`define aluDivU 8'd6
`define aluAnd 8'd7
`define aluOr 8'd8
`define aluSetLessThan 8'd9
`define aluSetLessThanUnsigned 8'd10
`define aluAddLoad 8'd11
`define aluAddStore 8'd12
`define aluMfhi 8'd13
`define aluMflo 8'd14
`define aluMthi 8'd15
`define aluMtlo 8'd16

//CMPOp
`define cmpEqual 8'd0
`define cmpUnequal 8'd1

//MemLen
`define MemLenW 8'd0
`define MemLenH 8'd1
`define MemLenB 8'd2

//forward
`define Self 8'd0
`define EX_forward 8'd1
`define MEM_forward 8'd2
`define WB_forward 8'd3

//CP0Addr
`define SRAddr 5'd12
`define CauseAddr 5'd13
`define EPCAddr 5'd14

//ExcCode
`define ExcNone 5'd0
`define Int 5'd0
`define AdEL 5'd4
`define AdES 5'd5
`define Syscall 5'd8
`define RI 5'd10
`define Ov 5'd12

`define YES 1'b1
`define NO 1'b0
 
