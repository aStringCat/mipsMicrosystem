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
    input wire [31:0] RegRD2,
    input wire [7:0] MemLen,
    input wire MemWrite,
    output wire [3:0] MemByteEn,
    output wire [31:0] MemWD
    );

    reg [3:0] Byteen;
    reg [31:0] memWd;
    
    always @(*) begin
        if (MemWrite) begin
            case (MemLen)
                `MemLenW: begin
                    Byteen = 4'b1111;
                    memWd = RegRD2;
                end 
                `MemLenH: begin
                    memWd = {RegRD2[15:0],RegRD2[15:0]};
                    if (MemA[1] == 1'b0) begin
                        Byteen = 4'b0011;
                    end else begin
                        Byteen = 4'b1100;
                    end
                end
                `MemLenB: begin
                    memWd = {RegRD2[7:0],RegRD2[7:0],RegRD2[7:0],RegRD2[7:0]};
                    if (MemA == 2'b00) begin
                        Byteen = 4'b0001;
                    end else if (MemA == 2'b01) begin
                        Byteen = 4'b0010;
                    end else if (MemA == 2'b10) begin
                        Byteen = 4'b0100;
                    end else if (MemA == 2'b11) begin
                        Byteen = 4'b1000;
                    end
                end
                default: ;
            endcase
        end else begin
            Byteen = 4'b0000;
            memWd = RegRD2;
        end
    end

    assign MemByteEn = Byteen;
    assign MemWD = memWd;

endmodule
