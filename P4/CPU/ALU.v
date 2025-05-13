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
`define Add 8'd0
`define Sub 8'd1
`define Or 8'd2
`define LogicalLeft 8'd3
`define Equal 8'd4 

module ALU(
    input [31:0] Input1,
    input [31:0] Input2,
    input [7:0] ALUOp,
    output [31:0] Output
    );

    reg [31:0] ans;

    always @(*) begin
        case (ALUOp)
            `Add: begin
                ans = Input1 + Input2;
            end
            `Sub: begin
                ans = Input1 - Input2;
            end
            `Or: begin
                ans = Input1 | Input2;
            end
            `LogicalLeft: begin
                ans = Input1 << Input2;
            end
            `Equal: begin
                ans = (Input1 == Input2) ? 32'd1 : 32'd0;
            end
            default: begin
                ans = 32'd0;
            end
        endcase
    end

    assign Output = ans;

endmodule
