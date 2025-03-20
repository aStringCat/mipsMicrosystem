`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:50:04 10/29/2024 
// Design Name: 
// Module Name:    GRF 
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

module GRF(
    input wire clk,
    input wire reset,
    input wire regWE,
    input wire [31:0] pc,
    input wire [4:0] regA1,
    input wire [4:0] regA2,
    input wire [4:0] regAW,
    input wire [31:0] regWD,
    output wire [31:0] regRD1,
    output wire [31:0] regRD2
    );

    reg [31:0] Register [0:31];
    integer i;
    always @(posedge clk) begin
        if (reset) begin
            for (i = 0; i < 32;i = i + 1) begin
                    Register[i] <= 32'h0;
            end
        end else begin
            if (regWE && regAW) begin
                Register[regAW] <= regWD;
            end else begin
                Register[regAW] <= Register[regAW];
            end
        end
    end

    assign regRD1 = Register[regA1];
    assign regRD2 = Register[regA2];

endmodule
