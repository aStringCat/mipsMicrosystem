`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:03:39 10/29/2024 
// Design Name: 
// Module Name:    DM 
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
module DM(
    input clk,
    input reset,
    input memWE,
    input [31:0] pc,
    input [31:0] memAddr,
    input [31:0] memWD,
    output [31:0] memRD
    );

    reg [31:0] Memory [0:3071];
    integer i;
    always @(posedge clk) begin
        if (reset) begin
            for (i = 0; i < 3072; i = i + 1) begin
                Memory[i] <= 32'h0;
            end
        end else begin
            if (memWE) begin
                Memory[memAddr[13:2]] <= memWD;
                $display("@%h: *%h <= %h", pc, memAddr, memWD);
            end else begin
                Memory[memAddr[13:2]] <= Memory[memAddr[13:2]];
            end
        end
    end

    assign memRD = Memory[memAddr[13:2]];
    
endmodule
