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
module GRF(
    input clk,
    input reset,
    input regWE,
    input [31:0] pc,
    input [4:0] regA1,
    input [4:0] regA2,
    input [4:0] regA3,
    input [31:0] regWD,
    output [31:0] regRD1,
    output [31:0] regRD2
    );

    reg [31:0] Register [0:31];
    integer i;
    always @(posedge clk) begin
        if (reset) begin
            for (i = 0; i < 32;i = i + 1) begin
                Register[i] <= 32'h0;
            end
        end else begin
            if (regWE && regA3) begin
                Register[regA3] <= regWD;
                $display("@%h: $%d <= %h", pc, regA3, regWD);
            end else begin
                Register[regA3] <= Register[regA3];
            end
        end
    end

    assign regRD1 = Register[regA1];
    assign regRD2 = Register[regA2];

endmodule
