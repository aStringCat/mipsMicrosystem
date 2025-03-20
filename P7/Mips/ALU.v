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
	input wire Req,
    input wire [7:0] ALUOp,
    input wire [4:0] EX_ExcCode_pre,
    output wire [31:0] ALUOut,
    output wire [7:0] busy,
    output wire [4:0] EX_ExcCode
    ); 

    reg [31:0] ans;
    reg Overflow;
    reg [31:0] HI;
    reg [31:0] LO;
    reg [31:0] hi;
    reg [31:0] lo; 
    reg [7:0] Busy;
    reg [4:0] ExcCode;

    always @(*) begin
        case (ALUOp)
            `aluNone: begin
                ans <= 32'h0;
                ExcCode <= EX_ExcCode_pre;
            end
            `aluAdd: begin
                {Overflow,ans} <= {ALUInput1[31],ALUInput1} + {ALUInput2[31],ALUInput2};
                ExcCode <= ((EX_ExcCode_pre == `ExcNone) && (Overflow != ans[31])) ? `Ov : EX_ExcCode_pre;
            end
            `aluSub: begin
                {Overflow,ans} <= {ALUInput1[31],ALUInput1} - {ALUInput2[31],ALUInput2};
                ExcCode <= ((EX_ExcCode_pre == `ExcNone) && (Overflow != ans[31])) ? `Ov : EX_ExcCode_pre;
            end
            `aluAnd: begin
                ans <= ALUInput1 & ALUInput2;
                ExcCode <= EX_ExcCode_pre;
            end
            `aluOr: begin
                ans <= ALUInput1 | ALUInput2;
                ExcCode <= EX_ExcCode_pre;
            end
            `aluSetLessThan: begin
                ans <= ($signed(ALUInput1) < $signed(ALUInput2)) ? 32'h1 : 32'h0;
                ExcCode <= EX_ExcCode_pre;
            end
            `aluSetLessThanUnsigned: begin
                ans <= (ALUInput1 < ALUInput2) ? 32'h1 : 32'h0;
                ExcCode <= EX_ExcCode_pre;
            end
            `aluAddLoad: begin
                {Overflow,ans} <= {ALUInput1[31],ALUInput1} + {ALUInput2[31],ALUInput2};
                ExcCode <= ((EX_ExcCode_pre == `ExcNone) && (Overflow != ans[31])) ? `AdEL : EX_ExcCode_pre;
            end
            `aluAddStore: begin
                {Overflow,ans} <= {ALUInput1[31],ALUInput1} + {ALUInput2[31],ALUInput2};
                ExcCode <= ((EX_ExcCode_pre == `ExcNone) && (Overflow != ans[31])) ? `AdES : EX_ExcCode_pre;
            end
            `aluMfhi: begin
                ans <= HI;
                ExcCode <= EX_ExcCode_pre;
            end
            `aluMflo: begin
                ans <= LO;
                ExcCode <= EX_ExcCode_pre;
            end
            default: begin
                ans <= 32'h0;
                ExcCode <= EX_ExcCode_pre;
            end
        endcase
    end 

    always @(posedge clk ) begin
        if (reset) begin
            HI <= 32'h0;
            LO <= 32'h0;
            Busy <= 8'd0;
        end else if (Req == `NO) begin
            case (ALUOp)
                `aluDiv: begin
                    hi <= $signed(ALUInput1) % $signed(ALUInput2);
                    lo <= $signed(ALUInput1) / $signed(ALUInput2);
                    Busy <= 8'd10;
                end
                `aluDivU: begin
                    hi <= ALUInput1 % ALUInput2;
                    lo <= ALUInput1 / ALUInput2;
                    Busy <= 8'd10;
                end
                `aluMult: begin
                    {hi,lo} <= $signed(ALUInput1) * $signed(ALUInput2);
                    Busy <= 8'd5;
                end
                `aluMultU: begin
                    {hi,lo} <= ALUInput1 * ALUInput2;
                    Busy <= 8'd5;
                end
                `aluMthi: begin
                    HI <= ALUInput1;
                    LO <= LO;
                    hi <= ALUInput1;
                    lo <= lo;
                    Busy <= 8'd0;
                end 
                `aluMtlo: begin
                    HI <= HI;
                    LO <= ALUInput1;
                    hi <= hi;
                    lo <= ALUInput2;
                    Busy <= 8'd0;
                end
                default: begin
                    if (Busy != 8'd0) begin
                        if (Busy == 8'd1) begin
                            HI <= hi;
                            LO <= lo;
                        end else begin
                            HI <= HI;
                            LO <= LO;
                        end
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
    assign EX_ExcCode = ExcCode;

endmodule
