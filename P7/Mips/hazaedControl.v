`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:04:26 11/07/2024 
// Design Name: 
// Module Name:    hazaedControl 
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

module hazaedControl(
    input wire [4:0] ID_rs,
    input wire [4:0] ID_rt,
    input wire [1:0] ID_rsTimeUse,
    input wire [1:0] ID_rtTimeUse,
    input wire ID_MdUse,
    input wire [7:0] ID_NPCOp,
    input wire [7:0] busy, 

    input wire [31:0] EX_pc,
    input wire [4:0] EX_rs,
    input wire [4:0] EX_rt,
    input wire [4:0] EX_rd,
    input wire [7:0] EX_RegDst,
    input wire [7:0] EX_RegSrc,
    input wire [1:0] EX_timeNew,
    input wire EX_RegWrite, 
    input wire EX_MdWrite,
    input wire EX_CP0Write,

    input wire [31:0] MEM_pc,
    input wire [4:0] MEM_rt,
    input wire [4:0] MEM_rd,
    input wire [7:0] MEM_RegDst,
    input wire [7:0] MEM_RegSrc,
    input wire [1:0] MEM_timeNew,
    input wire MEM_RegWrite,
    input wire MEM_CP0Write,

    input wire [31:0] WB_pc,
    input wire [4:0] WB_rt,
    input wire [4:0] WB_rd,
    input wire [7:0] WB_RegDst,
    input wire [7:0] WB_RegSrc,
    input wire [1:0] WB_timeNew,
    input wire WB_RegWrite,

    input wire [31:0] ID_regRD1_pre,
    input wire [31:0] ID_regRD2_pre,
    input wire [31:0] EX_regRD1_pre,
    input wire [31:0] EX_regRD2_pre,
    input wire [31:0] MEM_regRD2_pre,
    input wire [31:0] EX_ALUOut,
    input wire [31:0] MEM_ALUOut,
    input wire [31:0] MEM_memRD,
    input wire [31:0] MEM_CP0Out,
    input wire [31:0] WB_ALUOut,
    input wire [31:0] WB_memRD,
    input wire [31:0] WB_CP0Out,

    output wire stall,
    output wire [31:0] ID_regRD1,
    output wire [31:0] ID_regRD2,
    output wire [31:0] EX_regRD1,
    output wire [31:0] EX_regRD2,
    output wire [31:0] MEM_regRD2

    );

    wire [4:0] EX_regAW = (EX_RegDst == `regDstRD) ? EX_rd : 
                            (EX_RegDst == `regDstRT) ? EX_rt :
                            (EX_RegDst == `regDstRA) ? 5'd31 : 5'd0;

    wire [31:0] EX_regWD = (EX_RegSrc == `regSrcALU) ? EX_ALUOut :
                            (EX_RegSrc == `regSrcMem) ? 32'h0 :
                            (EX_RegSrc == `regSrcPC) ? EX_pc + 32'h8 :
                            (EX_RegSrc == `regSrcCP0) ? 32'h0 : 32'h0;

    wire [4:0] MEM_regAW = (MEM_RegDst == `regDstRD) ? MEM_rd : 
                            (MEM_RegDst == `regDstRT) ? MEM_rt :
                            (MEM_RegDst == `regDstRA) ? 5'd31 : 5'd0;

    wire [31:0] MEM_regWD = (MEM_RegSrc == `regSrcALU) ? MEM_ALUOut :
                            (MEM_RegSrc == `regSrcMem) ? MEM_memRD :
                            (MEM_RegSrc == `regSrcPC) ? MEM_pc + 32'h8 :
                            (MEM_RegSrc == `regSrcCP0) ? MEM_CP0Out : 32'h0;

    wire [4:0] WB_regAW = (WB_RegDst == `regDstRD) ? WB_rd : 
                            (WB_RegDst == `regDstRT) ? WB_rt :
                            (WB_RegDst == `regDstRA) ? 5'd31 : 5'd0;

    wire [31:0] WB_regWD = (WB_RegSrc == `regSrcALU) ? WB_ALUOut :
                            (WB_RegSrc == `regSrcMem) ?WB_memRD :
                            (WB_RegSrc == `regSrcPC) ? WB_pc + 32'h8 :
                            (WB_RegSrc == `regSrcCP0) ? WB_CP0Out : 32'h0;
                            
    //stall
    wire Stall_RS1_E2 = (ID_rsTimeUse == 2'd1) & (EX_timeNew == 2'd2) & (ID_rs == EX_regAW) & (ID_rs != 5'd0) & EX_RegWrite;									 
    wire Stall_RS0_E2 = (ID_rsTimeUse == 2'd0) & (EX_timeNew == 2'd2) & (ID_rs == EX_regAW) & (ID_rs != 5'd0) & EX_RegWrite;
    wire Stall_RS0_E1 = (ID_rsTimeUse == 2'd0) & (EX_timeNew == 2'd1) & (ID_rs == EX_regAW) & (ID_rs != 5'd0) & EX_RegWrite;
    wire Stall_RS0_M1 = (ID_rsTimeUse == 2'd0) & (MEM_timeNew == 2'd1) & (ID_rs == MEM_regAW) & (ID_rs != 5'd0) & MEM_RegWrite;
    
    wire Stall_RT1_E2 = (ID_rtTimeUse == 2'd1) & (EX_timeNew == 2'd2) & (ID_rt == EX_regAW) & (ID_rt != 5'd0) & EX_RegWrite;
    wire Stall_RT0_E2 = (ID_rtTimeUse == 2'd0) & (EX_timeNew == 2'd2) & (ID_rt == EX_regAW) & (ID_rt != 5'd0) & EX_RegWrite;
    wire Stall_RT0_E1 = (ID_rtTimeUse == 2'd0) & (EX_timeNew == 2'd1) & (ID_rt == EX_regAW) & (ID_rt != 5'd0) & EX_RegWrite;
    wire Stall_RT0_M1 = (ID_rtTimeUse == 2'd0) & (MEM_timeNew == 2'd1) & (ID_rt == MEM_regAW) & (ID_rt != 5'd0) & MEM_RegWrite;

    wire Stall_RS = Stall_RS1_E2 | Stall_RS0_E2 | Stall_RS0_E1 | Stall_RS0_M1 ;
    wire Stall_RT = Stall_RT1_E2 | Stall_RT0_E2 | Stall_RT0_E1 | Stall_RT0_M1 ;

    wire Stall_MD = (EX_MdWrite == `YES || busy > 8'b0) & (ID_MdUse == `YES);

    wire Stall_Eret = (ID_NPCOp == `npcEPC) & ((EX_CP0Write == `YES & EX_rd == `EPCAddr) | (MEM_CP0Write == `YES & MEM_rd == `EPCAddr));

    assign stall = Stall_RS | Stall_RT | Stall_MD | Stall_Eret;

    //forward
    wire [7:0] ID_F_regRD1 = ((ID_rs == EX_regAW) && (ID_rs != 5'd0) && EX_RegWrite && (EX_timeNew == 2'd0)) ? `EX_forward :
                            ((ID_rs == MEM_regAW) && (ID_rs != 5'd0)  && MEM_RegWrite && (MEM_timeNew == 2'd0)) ? `MEM_forward :
                            ((ID_rs == WB_regAW) && (ID_rs != 5'd0)  && WB_RegWrite && (WB_timeNew == 2'd0)) ? `WB_forward : `Self;
                            
    assign ID_regRD1 = (ID_F_regRD1 == `Self) ? ID_regRD1_pre : 
                        (ID_F_regRD1 == `EX_forward) ? EX_regWD :
                        (ID_F_regRD1 == `MEM_forward) ?  MEM_regWD : 
                        (ID_F_regRD1 == `WB_forward) ? WB_regWD : 32'h0;

    wire [7:0] ID_F_regRD2 = ((ID_rt == EX_regAW) && (ID_rt != 5'd0) && EX_RegWrite && (EX_timeNew == 2'd0)) ? `EX_forward :
                            ((ID_rt == MEM_regAW) && (ID_rt != 5'd0) && MEM_RegWrite && (MEM_timeNew == 2'd0)) ? `MEM_forward :
                            ((ID_rt == WB_regAW) && (ID_rt != 5'd0) && WB_RegWrite && (WB_timeNew == 2'd0)) ? `WB_forward : `Self;

    assign ID_regRD2 = (ID_F_regRD2 == `Self) ? ID_regRD2_pre : 
                        (ID_F_regRD2 == `EX_forward) ? EX_regWD :
                        (ID_F_regRD2 == `MEM_forward) ?  MEM_regWD : 
                        (ID_F_regRD2 == `WB_forward) ? WB_regWD : 32'h0;

    wire [7:0] EX_F_regRD1 = ((EX_rs == MEM_regAW) && (EX_rs != 5'd0) && MEM_RegWrite && (MEM_timeNew == 2'd0)) ? `MEM_forward :
                            ((EX_rs == WB_regAW) && (EX_rs != 5'd0) && WB_RegWrite && (WB_timeNew == 2'd0)) ? `WB_forward : `Self;

    assign EX_regRD1 = (EX_F_regRD1 == `Self) ? EX_regRD1_pre : 
                        (EX_F_regRD1 == `MEM_forward) ?  MEM_regWD : 
                        (EX_F_regRD1 == `WB_forward) ? WB_regWD : 32'h0;

    wire [7:0] EX_F_regRD2 = ((EX_rt == MEM_regAW) && (EX_rt != 5'd0)  && MEM_RegWrite && (MEM_timeNew == 2'd0)) ? `MEM_forward :
                            ((EX_rt == WB_regAW) && (EX_rt != 5'd0) && WB_RegWrite && (WB_timeNew == 2'd0)) ? `WB_forward : `Self;
                            
    assign EX_regRD2 = (EX_F_regRD2 == `Self) ? EX_regRD2_pre : 
                        (EX_F_regRD2 == `MEM_forward) ?  MEM_regWD : 
                        (EX_F_regRD2 == `WB_forward) ? WB_regWD : 32'h0;

    wire [7:0] MEM_F_regRD2 = ((MEM_rt == WB_regAW) && (MEM_rt != 5'd0) && WB_RegWrite && (WB_timeNew == 2'd0)) ? `WB_forward : `Self;
                            
    assign MEM_regRD2 = (MEM_F_regRD2 == `Self) ? MEM_regRD2_pre : 
                        (MEM_F_regRD2 == `WB_forward) ? WB_regWD : 32'h0;

endmodule
