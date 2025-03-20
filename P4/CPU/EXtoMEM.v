`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:31:32 11/06/2024 
// Design Name: 
// Module Name:    EXtoMEM 
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
module EXtoMEM(
    input wire clk,
    input wire reset,
    
    input wire [31:0] EX_pc,
    input wire [4:0] EX_rt,
    input wire [4:0] EX_rd,
    input wire [31:0] EX_ALUOut,
    input wire [31:0] EX_regRD2,
    input wire [1:0] EX_timeNew,
    input wire [7:0] EX_RegDst,
    input wire [7:0] EX_RegSrc,
    input wire EX_RegWrite,
    input wire EX_MemWrite,

    output wire [31:0] MEM_pc,
    output wire [4:0] MEM_rt,
    output wire [4:0] MEM_rd,
    output wire [31:0] MEM_ALUOut,
    output wire [31:0] MEM_regRD2_pre,
    output wire [1:0] MEM_timeNew,
    output wire [7:0] MEM_RegDst,
    output wire [7:0] MEM_RegSrc,
    output wire MEM_RegWrite,
    output wire MEM_MemWrite
    );

    reg [31:0] pc;
    reg [4:0] rt;
    reg [4:0] rd;
    reg [31:0] ALUOut;
    reg [31:0] regRD2;
    reg [1:0] timeNew;
    reg [7:0] RegDst;
    reg [7:0] RegSrc;
    reg RegWrite;
    reg MemWrite;

    always @(posedge clk ) begin
        if (reset) begin
            pc <= 32'h3000;
            rt <= 5'd0;
            rd <= 5'd0;
            ALUOut <= 32'd0;
            regRD2 <= 32'd0;
            timeNew <= 2'd0;
            RegDst <= 8'd0;
            RegSrc <= 8'd0;
            RegWrite <= 1'd0;
            MemWrite <= 1'd0;
        end else begin
            pc <= EX_pc;
            rt <= EX_rt;
            rd <= EX_rd;
            ALUOut <= EX_ALUOut;
            regRD2 <= EX_regRD2;
            timeNew <= EX_timeNew;
            RegDst <= EX_RegDst;
            RegSrc <= EX_RegSrc;
            RegWrite <= EX_RegWrite;
            MemWrite <= EX_MemWrite;
            if (EX_timeNew) begin
                timeNew <= EX_timeNew - 2'd1;
            end else begin
                timeNew <= EX_timeNew;
            end
        end
    end

    assign MEM_pc = pc;
    assign MEM_rt = rt;
    assign MEM_rd = rd;
    assign MEM_ALUOut = ALUOut;
    assign MEM_regRD2_pre = regRD2;  
    assign MEM_timeNew = timeNew;
    assign MEM_RegDst = RegDst;
    assign MEM_RegSrc = RegSrc;
    assign MEM_RegWrite = RegWrite;
    assign MEM_MemWrite = MemWrite;

endmodule
