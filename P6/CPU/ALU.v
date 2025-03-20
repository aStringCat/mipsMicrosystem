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
    input wire clk,
    input wire reset, 
    input wire [31:0] ALUInput1,
    input wire [31:0] ALUInput2,
    input wire [7:0] ALUOp,
    output wire [31:0] ALUOut,
    output wire [7:0] busy
    ); 

    reg [31:0] ans;
    reg [31:0] HI;
    reg [31:0] LO;
    reg [7:0] Busy;

    always @(*) begin
        case (ALUOp)
            `aluNone: begin
                ans <= 32'h0;
            end
            `aluAdd: begin
                ans <= ALUInput1 + ALUInput2;
            end
            `aluSub: begin
                ans <= ALUInput1 - ALUInput2;
            end
            `aluAnd: begin
                ans <= ALUInput1 & ALUInput2;
            end
            `aluOr: begin
                ans <= ALUInput1 | ALUInput2;
            end
            `aluLogicalLeft: begin
                ans <= ALUInput1 << ALUInput2;
            end
            `aluSetLessThan: begin
                ans <= ($signed(ALUInput1) < $signed(ALUInput2)) ? 32'h1 : 32'h0;
            end
            `aluSetLessThanUnsigned: begin
                ans <= (ALUInput1 < ALUInput2) ? 32'h1 : 32'h0;
            end
            `aluMfhi: begin
                ans <= HI;
            end
            `aluMflo: begin
                ans <= LO;
            end
            default: ;
        endcase
    end 

    always @(posedge clk ) begin
        if (reset) begin
            HI <= 32'h0;
            LO <= 32'h0;
            Busy <= 8'd0;
        end else begin
            case (ALUOp)
                `aluDiv: begin
                    HI <= $signed(ALUInput1) % $signed(ALUInput2);
                    LO <= $signed(ALUInput1) / $signed(ALUInput2);
                    Busy <= 8'd10;
                end
                `aluDivU: begin
                    HI <= ALUInput1 % ALUInput2;
                    LO <= ALUInput1 / ALUInput2;
                    Busy <= 8'd10;
                end
                `aluMult: begin
                    {HI,LO} <= $signed(ALUInput1) * $signed(ALUInput2);
                    Busy <= 8'd5;
                end
                `aluMultU: begin
                    {HI,LO} <= ALUInput1 * ALUInput2;
                    Busy <= 8'd5;
                end
                `aluMthi: begin
                    HI <= ALUInput1;
                    LO <= LO;
                    Busy <= 8'd0;
                end 
                `aluMtlo: begin
                    HI <= HI;
                    LO <= ALUInput1;
                    Busy <= 8'd0;
                end
                default: begin
                    if (Busy) begin
                        Busy <= Busy - 8'd1;
                    end else begin
                        Busy <= Busy;
                    end
                end
            endcase
        end
    end

    assign ALUOut = ans;
    assign busy = Busy;

endmodule
