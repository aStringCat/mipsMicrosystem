`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:31:00 11/06/2024 
// Design Name: 
// Module Name:    IFtoID 
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

module IFtoID(
    input wire clk,
    input wire reset,
    input wire stall,

    input wire [31:0] IF_pc,
    input wire [5:0] IF_op,
    input wire [5:0] IF_func,
    input wire [4:0] IF_rs,
    input wire [4:0] IF_rt,
    input wire [4:0] IF_rd,
    input wire [15:0] IF_immediate,
    input wire [25:0] IF_instrIndex,
    
    output wire [31:0] ID_pc,
    output wire [5:0] ID_op,
    output wire [5:0] ID_func,
    output wire [4:0] ID_rs,
    output wire [4:0] ID_rt,
    output wire [4:0] ID_rd, 
    output wire [15:0] ID_immediate,
    output wire [25:0] ID_instrIndex
    ); 

    reg [31:0] pc;
    reg [5:0] op;
    reg [5:0] func;
    reg [4:0] rs;
    reg [4:0] rt;
    reg [4:0] rd;
    reg [15:0] immediate;
    reg [25:0] instrIndex;

    always @(posedge clk ) begin
        if (reset) begin 
            pc <= 32'h3000;
            op <= 6'd0;
            func <= 6'd0;
            rs <= 5'd0;
            rt <= 5'd0;
            rd <= 5'd0;
            immediate <= 16'd0;
            instrIndex <= 16'd0;
        end else if (stall) begin
            pc <= pc;
            op <= op;
            func <= func;
            rs <= rs;
            rt <= rt;
            rd <= rd;
            immediate <= immediate;
            instrIndex <= instrIndex;
        end else begin
            pc <= IF_pc;
            op <= IF_op;
            func <= IF_func;
            rs <= IF_rs;
            rt <= IF_rt;
            rd <= IF_rd;
            immediate <= IF_immediate;
            instrIndex <= IF_instrIndex;
        end
    end
 
    assign ID_pc = pc;
    assign ID_op = op;
    assign ID_func = func;
    assign ID_rs = rs;
    assign ID_rt = rt;
    assign ID_rd = rd;
    assign ID_immediate = immediate;
    assign ID_instrIndex = instrIndex;

endmodule
