`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:13:05 10/29/2024 
// Design Name: 
// Module Name:    ALU 
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
 
module ALU( 
    input wire [31:0] ALUInput1,
    input wire [31:0] ALUInput2,
    input wire [7:0] ALUOp,
    output wire [31:0] ALUOut
    ); 

    reg [31:0] ans;

    always @(*) begin
        case (ALUOp)
            `aluAdd: begin
                ans = ALUInput1 + ALUInput2;
            end
            `aluSub: begin
                ans = ALUInput1 - ALUInput2;
            end
            `aluOr: begin
                ans = ALUInput1 | ALUInput2;
            end
            `aluLogicalLeft: begin
                ans = ALUInput1 << ALUInput2;
            end
            default: ;
        endcase
    end 

    assign ALUOut = ans;

endmodule
