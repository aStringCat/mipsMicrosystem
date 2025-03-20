`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:26:05 11/12/2024 
// Design Name: 
// Module Name:    RegPC 
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

module RegPC(
    input wire clk, 
    input wire reset,
    input wire [31:0] pcIn,
    output wire [31:0] pcOut
    );

    reg [31:0] PC;

    always @(posedge clk) begin
        if (reset) begin
            PC <= 32'h3000;
        end else begin
            PC <= pcIn;
        end
    end

    assign pcOut = PC;

endmodule
