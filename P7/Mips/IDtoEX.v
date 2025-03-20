`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:31:15 11/06/2024 
// Design Name: 
// Module Name:    IDtoEX 
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
`default_nettype none

module IDtoEX(
    input wire clk,
    input wire reset,
    input wire stall,
    input wire Req,

    input wire [31:0] ID_pc,
    input wire [4:0] ID_rs,
    input wire [4:0] ID_rt,
    input wire [4:0] ID_rd,
    input wire [31:0] ID_regRD1,
    input wire [31:0] ID_regRD2,
    input wire [31:0] ID_EXTOut,
    input wire [1:0] ID_timeNew,
    input wire [7:0] ID_RegDst,
    input wire [7:0] ID_ALUSrc,
    input wire [7:0] ID_RegSrc, 
    input wire ID_RegWrite,
    input wire ID_MemWrite,
    input wire ID_MdWrite,
    input wire ID_CP0Write,
    input wire [7:0] ID_ALUOp,
    input wire [7:0] ID_MemLen,
    input wire ID_EXLClr,
    input wire ID_BD,
    input wire [4:0] ID_ExcCode,

    output wire [31:0] EX_pc,
    output wire [4:0] EX_rs,
    output wire [4:0] EX_rt,
    output wire [4:0] EX_rd,
    output wire [31:0] EX_regRD1_pre,
    output wire [31:0] EX_regRD2_pre,
    output wire [31:0] EX_EXTOut,
    output wire [1:0] EX_timeNew,
    output wire [7:0] EX_RegDst,
    output wire [7:0] EX_ALUSrc,
    output wire [7:0] EX_RegSrc,
    output wire EX_RegWrite,
    output wire EX_MemWrite,
    output wire EX_MdWrite,
    output wire EX_CP0Write,
    output wire [7:0] EX_ALUOp,
    output wire [7:0] EX_MemLen,
    output wire EX_EXLClr,
    output wire EX_BD,
    output wire [4:0] EX_ExcCode_pre
    );

    reg [31:0] pc;
    reg [4:0] rs;
    reg [4:0] rt;
    reg [4:0] rd;
    reg [31:0] regRD1;
    reg [31:0] regRD2;
    reg [31:0] EXTOut;
    reg [1:0] timeNew;
    reg [7:0] RegDst;
    reg [7:0] ALUSrc;
    reg [7:0] RegSrc;
    reg RegWrite;
    reg MemWrite;
    reg MdWrite;
    reg CP0Write;
    reg [7:0] ALUOp;
    reg [7:0] MemLen;
    reg EXLClr;
    reg BD;
    reg [4:0] ExcCode;

    always @(posedge clk ) begin
        if (reset) begin
            pc <= 32'h3000;
            rs <= 5'd0;
            rt <= 5'd0;
            rd <= 5'd0;
            regRD1 <= 32'd0;
            regRD2 <= 32'd0;
            EXTOut <= 32'd0;
            timeNew <= 2'd0;
            RegDst <= 8'd0;
            ALUSrc <= 8'd0;
            RegSrc <= 8'd0;
            RegWrite <= 1'd0;
            MemWrite <= 1'd0;
            MdWrite <= 1'd0;
            CP0Write <= 1'd0;
            ALUOp <= 8'd0;
            MemLen <= 8'd0;
            EXLClr <= 1'd0;
            BD <= 1'd0;
            ExcCode <= 5'd0;
        end else if (Req)begin
            pc <= 32'h4180;
            rs <= 5'd0;
            rt <= 5'd0;
            rd <= 5'd0;
            regRD1 <= 32'd0;
            regRD2 <= 32'd0;
            EXTOut <= 32'd0;
            timeNew <= 2'd0;
            RegDst <= 8'd0;
            ALUSrc <= 8'd0;
            RegSrc <= 8'd0;
            RegWrite <= 1'd0;
            MemWrite <= 1'd0;
            MdWrite <= 1'd0;
            CP0Write <= 1'd0;
            ALUOp <= 8'd0;
            MemLen <= 8'd0;
            EXLClr <= 1'd0;
            BD <= 1'd0;
            ExcCode <= 5'd0;
        end else if (stall)begin
            pc <= ID_pc;
            rs <= 5'd0;
            rt <= 5'd0;
            rd <= 5'd0;
            regRD1 <= 32'd0;
            regRD2 <= 32'd0;
            EXTOut <= 32'd0;
            timeNew <= 2'd0;
            RegDst <= 8'd0;
            ALUSrc <= 8'd0;
            RegSrc <= 8'd0;
            RegWrite <= 1'd0;
            MemWrite <= 1'd0;
            MdWrite <= 1'd0;
            CP0Write <= 1'd0;
            ALUOp <= 8'd0;
            MemLen <= 8'd0;
            EXLClr <= 1'd0;
            BD <= ID_BD;
            ExcCode <= ID_ExcCode;
        end else begin
            pc <= ID_pc;
            rs <= ID_rs;
            rt <= ID_rt;
            rd <= ID_rd;
            regRD1 <= ID_regRD1;
            regRD2 <= ID_regRD2;
            EXTOut <= ID_EXTOut;
            RegDst <= ID_RegDst;
            ALUSrc <= ID_ALUSrc;
            RegSrc <= ID_RegSrc;
            RegWrite <= ID_RegWrite;
            MemWrite <= ID_MemWrite;
            MdWrite <= ID_MdWrite;
            CP0Write <= ID_CP0Write;
            ALUOp <= ID_ALUOp;
            MemLen <= ID_MemLen;
            EXLClr <= ID_EXLClr;
            BD <= ID_BD;
            ExcCode <= ID_ExcCode;
            if (ID_timeNew) begin
                timeNew <= ID_timeNew - 2'd1;
            end else begin
                timeNew <= ID_timeNew;
            end
        end
    end

    assign EX_pc = pc;
    assign EX_rs = rs;
    assign EX_rt = rt;
    assign EX_rd = rd;
    assign EX_regRD1_pre = regRD1;
    assign EX_regRD2_pre = regRD2;
    assign EX_EXTOut = EXTOut;
    assign EX_timeNew = timeNew;
    assign EX_RegDst = RegDst;
    assign EX_ALUSrc = ALUSrc;
    assign EX_RegSrc = RegSrc;
    assign EX_RegWrite = RegWrite;
    assign EX_MemWrite = MemWrite;
    assign EX_MdWrite = MdWrite;
    assign EX_CP0Write = CP0Write;
    assign EX_ALUOp = ALUOp;
    assign EX_MemLen = MemLen;
    assign EX_EXLClr = EXLClr;
    assign EX_BD = BD;
    assign EX_ExcCode_pre = ExcCode;

endmodule
