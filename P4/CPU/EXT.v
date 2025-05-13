`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:22:31 10/29/2024 
// Design Name: 
// Module Name:    EXT 
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
`define zeroExtend 2'd0
`define signExtend 2'd1
`define upperExtend 2'd2
 
module EXT(
    input [1:0] EXTOp,
    input [15:0] In,
    output [31:0] Out
    );
    
    reg [31:0] tmp;
 
    always @(*) begin
        case (EXTOp)
            `zeroExtend: begin
                tmp = {16'h0,{In}};
            end
            `signExtend: begin
                tmp = {{16{In[15]}},{In}};
            end
            `upperExtend: begin
                tmp = {{In},16'h0};
            end
            default: begin
                tmp = 32'h0;
            end
        endcase
    end

    assign Out = tmp;

endmodule
