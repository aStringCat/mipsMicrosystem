`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:11:27 11/12/2024 
// Design Name: 
// Module Name:    MemByteEn 
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

module MemByte(
    input wire [1:0] MemA,
    input wire [31:0] ALUOut,
    input wire [31:0] RegRD2,
    input wire [7:0] MemLen,
    input wire MemWrite,
    input wire MemRead,
    input wire Req,
    input wire [4:0] MEM_ExcCode_pre,
    output wire [3:0] MemByteEn,
    output wire [31:0] MemWD,
    output wire [4:0] MEM_ExcCode
    );

    reg [3:0] Byteen;
    reg [31:0] memWd;
    reg [4:0] ExcCode;
    
    always @(*) begin
        if (Req) begin
            Byteen <= 4'b0000;
            memWd <= 32'h0;
            ExcCode <= ExcCode;
        end else if (MEM_ExcCode_pre != `ExcNone) begin
            Byteen <= 4'b0000;
            memWd <= 32'h0;
            ExcCode <= MEM_ExcCode_pre;
        end else if (MemWrite) begin
            case (MemLen)
                `MemLenW: begin
                    if (MemA == 2'b00 && ((ALUOut >= 32'h0000 && ALUOut <= 32'h2FFF) || (ALUOut >= 32'h7F00 && ALUOut <= 32'h7F07) || (ALUOut >= 32'h7F10 && ALUOut <= 32'h7F17) || (ALUOut >= 32'h7F20 && ALUOut <= 32'h7F23))) begin
                        Byteen <= 4'b1111;
                        memWd <= RegRD2;
                        ExcCode <= MEM_ExcCode_pre;
                    end else begin
                        Byteen <= 4'b0000;
                        memWd <= 32'h0;
                        ExcCode <= `AdES;
                    end
                end 
                `MemLenH: begin
                    if (MemA[0] == 1'b0 && (ALUOut >= 32'h0000 && ALUOut <= 32'h2FFF) || (ALUOut >= 32'h7F20 && ALUOut <= 32'h7F23)) begin
                        memWd <= {RegRD2[15:0],RegRD2[15:0]};
                        if (MemA[1] == 1'b0) begin
                            Byteen <= 4'b0011;
                        end else begin
                            Byteen <= 4'b1100;
                        end
                    end else begin
                        Byteen <= 4'b0000;
                        memWd <= 32'h0;
                        ExcCode <= `AdES;
                    end
                end
                `MemLenB: begin
                    if ((ALUOut >= 32'h0000 && ALUOut <= 32'h2FFF) || (ALUOut >= 32'h7F20 && ALUOut <= 32'h7F23)) begin
                        memWd = {RegRD2[7:0],RegRD2[7:0],RegRD2[7:0],RegRD2[7:0]};
                        if (MemA == 2'b00) begin
                            Byteen <= 4'b0001;
                        end else if (MemA == 2'b01) begin
                            Byteen <= 4'b0010;
                        end else if (MemA == 2'b10) begin
                            Byteen <= 4'b0100;
                        end else if (MemA == 2'b11) begin
                            Byteen <= 4'b1000;
                        end
                    end else begin
                        Byteen <= 4'b0000;
                        memWd <= 32'h0;
                        ExcCode <= `AdES;
                    end
                end
                default: ;
            endcase
        end else if (MemRead) begin
            Byteen <= 4'b0000;
            memWd <= 32'h0;
            case (MemLen)
                `MemLenW: begin
                    if (MemA == 2'b00 && ((ALUOut >= 32'h0000 && ALUOut <= 32'h2FFF) || (ALUOut >= 32'h7F00 && ALUOut <= 32'h7F0B) || (ALUOut >= 32'h7F10 && ALUOut <= 32'h7F1B) || (ALUOut >= 32'h7F20 && ALUOut <= 32'h7F23))) begin
                        ExcCode <= MEM_ExcCode_pre;
                    end else begin
                        ExcCode <= `AdEL;
                    end
                end 
                `MemLenH: begin
                    if (MemA[0] == 1'b0 && ((ALUOut >= 32'h0000 && ALUOut <= 32'h2FFF) || (ALUOut >= 32'h7F20 && ALUOut <= 32'h7F23))) begin
                        ExcCode <= MEM_ExcCode_pre;
                    end else begin
                        ExcCode <= `AdEL;
                    end
                end 
                `MemLenB: begin
                    if ((ALUOut >= 32'h0000 && ALUOut <= 32'h2FFF) || (ALUOut >= 32'h7F20 && ALUOut <= 32'h7F23)) begin
                        ExcCode <= MEM_ExcCode_pre;
                    end else begin
                        ExcCode <= `AdEL;
                    end
                end 
                default: ;
            endcase
        end else begin
            Byteen <= 4'b0000;
            memWd <= RegRD2;
            ExcCode <= MEM_ExcCode_pre;
        end
    end

    assign MemByteEn = Byteen;
    assign MemWD = memWd;
    assign MEM_ExcCode = ExcCode;

endmodule
