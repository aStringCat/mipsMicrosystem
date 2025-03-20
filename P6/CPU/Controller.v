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
`define RD 2'd0
`define RT 2'd1
`define RA 2'd2

//ALUSrc
`define GRFmem 1'b0
`define Imm 1'b1 

//RegSrc
`define ALUOut 2'd0
`define Mem 2'd1
`define PCaddFour 2'd2

//nPC_sel
`define Next 2'd0 
`define Offset 2'd1
`define Instr_index 2'd2 
`define RegtoPC 2'd3

//EXTOp
`define zeroExtend 2'd0
`define signExtend 2'd1
`define upperExtend 2'd2
 
//ALUOp
`define Add 8'd0
`define Sub 8'd1
`define Or 8'd2
`define LogicalLeft 8'd3
`define Equal 8'd4 

`define YES 1'b1
`define NO 1'b0
 

module Controller(
    input [5:0] op,
    input [5:0] func,
    output reg [1:0] RegDst,
    output reg ALUSrc,
    output reg [1:0] RegSrc,
    output reg RegWrite,
    output reg MemWrite,
    output reg [1:0] nPC_sel,
    output reg [1:0] EXTOp,
    output reg [7:0] ALUOp
    );

    always @(*) begin
        case (op)
            `SPECIAL: begin
                case (func)
                    `fADD: begin
                        RegDst = `RD;
                        ALUSrc = `GRFmem;
                        RegSrc = `ALUOut;
                        RegWrite = `YES;
                        MemWrite = `NO;
                        nPC_sel = `Next;
                        EXTOp = `zeroExtend;
                        ALUOp = `Add;
                    end
                    `fSUB: begin
                        RegDst = `RD;
                        ALUSrc = `GRFmem;
                        RegSrc = `ALUOut;
                        RegWrite = `YES;
                        MemWrite = `NO;
                        nPC_sel = `Next;
                        EXTOp = `zeroExtend;
                        ALUOp = `Sub;
                    end
                    `fSLL: begin
                        RegDst = `RD;
                        ALUSrc = `GRFmem;
                        RegSrc = `ALUOut;
                        RegWrite = `YES;
                        MemWrite = `NO;
                        nPC_sel = `Next;
                        EXTOp = `zeroExtend;
                        ALUOp = `LogicalLeft;
                    end
                    `fJR: begin
                        RegDst = `RD;
                        ALUSrc = `GRFmem;
                        RegSrc = `ALUOut;
                        RegWrite = `NO;
                        MemWrite = `NO;
                        nPC_sel = `RegtoPC;
                        EXTOp = `zeroExtend;
                        ALUOp = `Add;
                    end
                    default: ;
                endcase
            end 
            `ORI: begin
                RegDst = `RT;
                ALUSrc = `Imm;
                RegSrc = `ALUOut;
                RegWrite = `YES;
                MemWrite = `NO;
                nPC_sel = `Next;
                EXTOp = `zeroExtend;
                ALUOp = `Or;
            end
            `LW: begin
                RegDst = `RT;
                ALUSrc = `Imm;
                RegSrc = `Mem;
                RegWrite = `YES;
                MemWrite = `NO;
                nPC_sel = `Next;
                EXTOp = `signExtend;
                ALUOp = `Add;
            end
            `SW: begin
                RegDst = `RT;
                ALUSrc = `Imm;
                RegSrc = `ALUOut;
                RegWrite = `NO;
                MemWrite = `YES;
                nPC_sel = `Next;
                EXTOp = `signExtend;
                ALUOp = `Add;
            end
            `BEQ: begin
                RegDst = `RT;
                ALUSrc = `GRFmem;
                RegSrc = `ALUOut;
                RegWrite = `NO;
                MemWrite = `NO;
                nPC_sel = `Offset;
                EXTOp = `signExtend;
                ALUOp = `Equal;
            end
            `LUI: begin
                RegDst = `RT;
                ALUSrc = `Imm;
                RegSrc = `ALUOut;
                RegWrite = `YES;
                MemWrite = `NO;
                nPC_sel = `Next;
                EXTOp = `upperExtend;
                ALUOp = `Add;
            end
            `JAL: begin
                RegDst = `RA;
                ALUSrc = `Imm; 
                RegSrc = `PCaddFour;
                RegWrite = `YES;
                MemWrite = `NO;
                nPC_sel = `Instr_index; 
                EXTOp = `zeroExtend;
                ALUOp = `Add;
            end
            default: ; 
        endcase
    end
    

endmodule
