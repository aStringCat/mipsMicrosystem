`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:46:46 11/12/2024 
// Design Name: 
// Module Name:    MemEXT 
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

module MemEXT(
    input wire [1:0] MemA,
    input wire [7:0] MemLen,
    input wire [31:0] Din,
    output wire [31:0] Dout
    );

    reg [31:0] out;

    always @(*) begin
        case (MemLen)
            `MemLenW: begin
                out = Din;
            end 
            `MemLenH: begin
                if (MemA[1] == 1'b0) begin
                    out = {{16{Din[15]}},{Din[15:0]}};
                end else begin
                    out = {{16{Din[31]}},{Din[31:16]}};
                end
            end 
            `MemLenB: begin
                if (MemA == 2'b00) begin
                    out = {{24{Din[7]}},{Din[7:0]}};
                end else if (MemA == 2'b01) begin
                    out = {{24{Din[15]}},{Din[15:8]}};
                end else if (MemA == 2'b10) begin
                    out = {{24{Din[23]}},{Din[23:16]}};
                end else if (MemA == 2'b11) begin
                    out = {{24{Din[31]}},{Din[31:24]}};
                end
            end 
            default: ;
        endcase
    end

    assign Dout = out;

endmodule
