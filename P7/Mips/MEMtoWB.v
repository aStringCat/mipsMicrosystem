`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:08:38 11/07/2024 
// Design Name: 
// Module Name:    MEMtoWB 
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
module MEMtoWB( 
    input wire clk,
    input wire reset,
    input wire Req,
    
    input wire [31:0] MEM_pc,
    input wire [4:0] MEM_rt,
    input wire [4:0] MEM_rd,
    input wire [31:0] MEM_ALUOut,
    input wire [31:0] MEM_memRD,
    input wire [31:0] MEM_CP0Out,
    input wire [1:0] MEM_timeNew,
    input wire [7:0] MEM_RegDst,
    input wire [7:0] MEM_RegSrc,
    input wire MEM_RegWrite,

    output wire [31:0] WB_pc,
    output wire [4:0] WB_rt,
    output wire [4:0] WB_rd,
    output wire [31:0] WB_ALUOut,
    output wire [31:0] WB_memRD,
    output wire [31:0] WB_CP0Out,
    output wire [1:0] WB_timeNew,
    output wire [7:0] WB_RegDst,
    output wire [7:0] WB_RegSrc,
    output wire WB_RegWrite
    );

    reg [31:0] pc;
    reg [4:0] rt;
    reg [4:0] rd;
    reg [31:0] ALUOut;
    reg [31:0] memRD;
    reg [31:0] CP0Out;
    reg [1:0] timeNew;
    reg [7:0] RegDst;
    reg [7:0] RegSrc;
    reg RegWrite;

    always @(posedge clk ) begin
        if (reset || Req) begin
            pc <= 32'h3000;
            rt <= 5'd0;
            rd <= 5'd0;
            ALUOut <= 32'd0;
            memRD <= 32'd0;
            CP0Out <= 32'd0;
            timeNew <= 2'd0;
            RegDst <= 8'd0;
            RegSrc <= 8'd0;
            RegWrite <= 1'd0;
        end else begin
            pc <= MEM_pc;
            rt <= MEM_rt;
            rd <= MEM_rd;
            ALUOut <= MEM_ALUOut;
            memRD <= MEM_memRD;
            CP0Out <= MEM_CP0Out;
            RegDst <= MEM_RegDst;
            RegSrc <= MEM_RegSrc;
            RegWrite <= MEM_RegWrite;
            if (MEM_timeNew) begin
                timeNew <= MEM_timeNew - 2'd1;
            end else begin
                timeNew <= MEM_timeNew;
            end
        end
    end

    assign WB_pc = pc;
    assign WB_rt = rt;
    assign WB_rd = rd;
    assign WB_ALUOut = ALUOut;
    assign WB_memRD = memRD; 
    assign WB_CP0Out = CP0Out;
    assign WB_timeNew = timeNew;
    assign WB_RegDst = RegDst;
    assign WB_RegSrc = RegSrc;
    assign WB_RegWrite = RegWrite;
    
endmodule
