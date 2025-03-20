`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:14:00 10/31/2024 
// Design Name: 
// Module Name:    mips 
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

module mips(
    input wire clk,
    input wire reset,
    input wire interrupt,
    output wire [31:0] macroscopic_pc,

    output wire [31:0] i_inst_addr,
    input  wire [31:0] i_inst_rdata, 

    output wire [31:0] m_data_addr, 
    input  wire [31:0] m_data_rdata,   
    output wire [31:0] m_data_wdata,   
    output wire [3 :0] m_data_byteen,  

    output wire [31:0] m_int_addr, 
    output wire [3 :0] m_int_byteen,

    output wire [31:0] m_inst_addr, 

    output wire w_grf_we,
    output wire [4 :0] w_grf_addr,
    output wire [31:0] w_grf_wdata,

    output wire [31:0] w_inst_addr

    );

//--------------Wires------------//
wire [31:0] CPU_m_data_rdata;
wire [31:0] CPU_m_data_addr;
wire [31:0] CPU_m_data_wdata;
wire [3 :0] CPU_m_data_byteen;
wire [5:0] HWInt;
wire Req;

wire [31:2] Timer0_Addr;
wire Timer0_WE;
wire [31:0] Timer0_Din;
wire [31:0] Timer0_Dout;
wire Timer0_IRQ;


wire [31:2] Timer1_Addr;
wire Timer1_WE;
wire [31:0] Timer1_Din;
wire [31:0] Timer1_Dout;
wire Timer1_IRQ;

//--------------Modules------------//
CPU cpu (
    .clk(clk), 
    .reset(reset), 
    .i_inst_rdata(i_inst_rdata), 
    .i_inst_addr(i_inst_addr), 
    .macroscopic_pc(macroscopic_pc), 
    .m_data_rdata(CPU_m_data_rdata), 
    .m_data_addr(CPU_m_data_addr), 
    .m_data_wdata(CPU_m_data_wdata), 
    .m_data_byteen(CPU_m_data_byteen), 
    .m_inst_addr(m_inst_addr), 
    .w_grf_we(w_grf_we), 
    .w_grf_addr(w_grf_addr), 
    .w_grf_wdata(w_grf_wdata), 
    .w_inst_addr(w_inst_addr), 
    .HWInt(HWInt) 
    );

Timer timer0 (
    .clk(clk), 
    .reset(reset), 
    .Addr(Timer0_Addr), 
    .WE(Timer0_WE), 
    .Din(Timer0_Din), 
    .Dout(Timer0_Dout), 
    .IRQ(Timer0_IRQ)
    );

Timer timer2 (
    .clk(clk), 
    .reset(reset), 
    .Addr(Timer1_Addr), 
    .WE(Timer1_WE), 
    .Din(Timer1_Din), 
    .Dout(Timer1_Dout), 
    .IRQ(Timer1_IRQ)
    );

Bridge bridge (
    .CPU_m_data_addr(CPU_m_data_addr), 
    .CPU_m_data_wdata(CPU_m_data_wdata), 
    .CPU_m_data_byteen(CPU_m_data_byteen), 
    .CPU_m_data_rdata(CPU_m_data_rdata), 
    .HWInt(HWInt), 
    .Timer0_Dout(Timer0_Dout), 
    .Timer0_IRQ(Timer0_IRQ), 
    .Timer0_Addr(Timer0_Addr), 
    .Timer0_WE(Timer0_WE), 
    .Timer0_Din(Timer0_Din), 
    .Timer1_Dout(Timer1_Dout), 
    .Timer1_IRQ(Timer1_IRQ), 
    .Timer1_Addr(Timer1_Addr), 
    .Timer1_WE(Timer1_WE), 
    .Timer1_Din(Timer1_Din), 
    .interrupt(interrupt), 
    .m_data_addr(m_data_addr), 
    .m_data_wdata(m_data_wdata), 
    .m_data_byteen(m_data_byteen), 
    .m_data_rdata(m_data_rdata), 
    .m_int_addr(m_int_addr), 
    .m_int_byteen(m_int_byteen)
    );

endmodule

