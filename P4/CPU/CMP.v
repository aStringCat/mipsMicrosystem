`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:40:14 11/05/2024 
// Design Name: 
// Module Name:    BranchJudge 
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

module CMP( 
    input wire [7:0] CMPOp,
    input wire [31:0] CMPInput1,
    input wire [31:0] CMPInput2,
    output wire CMPOut
    );

    reg tmp; 
    always @(*) begin
       case (CMPOp)
            `cmpEqual: begin
                tmp = (CMPInput1 == CMPInput2) ? 1'b1 : 1'b0;       
            end
            default: ;
        endcase 
    end

    assign CMPOut = tmp;

endmodule
