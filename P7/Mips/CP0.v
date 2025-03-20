`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:00:17 11/20/2024 
// Design Name: 
// Module Name:    CP0 
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

`define IM SR[15:10]
`define EXL SR[1]
`define IE SR[0]
`define BD Cause[31]
`define IP Cause[15:10]
`define ExcCode Cause[6:2]

module CP0(
    input wire clk,
    input wire reset,
    input wire en,
    input wire [4:0] CP0Addr,
    input wire [31:0] CP0In,
    input wire [31:0] VPC,
    input wire BDIn,
    input wire [4:0] ExcCodeIn,
    input wire [5:0] HWInt,
    input wire EXLClr,

    output wire [31:0] CP0Out,
    output wire [31:0] EPCOut,
    output wire Req
    );

    reg [31:0] SR;
    reg [31:0] Cause;
    reg [31:0] EPC;

    wire IntReq = (|(HWInt & `IM)) & (`EXL == `NO) & (`IE == `YES);
    wire ExcReq = (ExcCodeIn != `ExcNone) & (`EXL == `NO);
    assign Req = IntReq | ExcReq;

    always @(posedge clk ) begin
        if (reset) begin
            SR <= 32'h0;
            Cause <= 32'h0;
            EPC <= 32'h0;
        end else begin
            if (Req) begin
                `EXL <= `YES;
                `BD <= BDIn;
                `ExcCode <= IntReq ? `Int : ExcCodeIn;
                EPC <= (BDIn == `YES) ? VPC - 32'h4 : VPC;
            end else if (en) begin
                case (CP0Addr)
                    `SRAddr: begin
                        SR <= CP0In;
                    end 
                    `EPCAddr: begin
                        EPC <= CP0In;
                    end
                    default: ; 
                endcase
            end else if (EXLClr) begin
                `EXL <= `NO;
            end else begin
                SR <= SR;
                Cause <= Cause;
                EPC <= EPC;
            end
            `IP <= HWInt;
        end
    end

    assign EPCOut = EPC;
    assign CP0Out = (CP0Addr == `SRAddr) ? SR :
                    (CP0Addr == `CauseAddr) ? Cause :
                    (CP0Addr == `EPCAddr) ? EPC : 32'h0;
endmodule
