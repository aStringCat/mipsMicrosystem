`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:33:25 11/20/2024 
// Design Name: 
// Module Name:    Bridge 
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

module Bridge(
//----------------CPU----------------------------//
    input wire [31:0] CPU_m_data_addr,
    input wire [31:0] CPU_m_data_wdata,
    input wire [3 :0] CPU_m_data_byteen,
    output wire [31:0] CPU_m_data_rdata,

    output wire [5:0] HWInt,
    
//----------------Timer0----------------------------//
    input wire [31:0] Timer0_Dout,
    input wire Timer0_IRQ,

    output wire [31:2] Timer0_Addr,
    output wire Timer0_WE,
    output wire [31:0] Timer0_Din,


//----------------Timer1----------------------------//
    input wire [31:0] Timer1_Dout,
    input wire Timer1_IRQ,

    output wire [31:2] Timer1_Addr,
    output wire Timer1_WE,
    output wire [31:0] Timer1_Din,


//----------------Peripheral-------------------------//
    input wire interrupt,
    output wire [31:0] m_data_addr, 
    output wire [31:0] m_data_wdata,   
    output wire [3 :0] m_data_byteen,  
    input  wire [31:0] m_data_rdata, 

    output wire [31:0] m_int_addr, 
    output wire [3 :0] m_int_byteen
    );

    
assign CPU_m_data_rdata = (CPU_m_data_addr >= 32'h0000 && CPU_m_data_addr <= 32'h2FFF) ? m_data_rdata :
                            (CPU_m_data_addr >= 32'h7F00 && CPU_m_data_addr <= 32'h7F0B) ? Timer0_Dout :
                            (CPU_m_data_addr >= 32'h7F10 && CPU_m_data_addr <= 32'h7F1B) ? Timer1_Dout : 32'h0;
assign HWInt = {3'b000, interrupt, Timer1_IRQ, Timer0_IRQ};

assign Timer0_Addr = CPU_m_data_addr[31:2];
assign Timer1_Addr = CPU_m_data_addr[31:2];
assign Timer0_Din = CPU_m_data_wdata;
assign Timer1_Din = CPU_m_data_wdata;
assign Timer0_WE = (CPU_m_data_byteen == 4'b1111) & (CPU_m_data_addr >= 32'h7F00 && CPU_m_data_addr <= 32'h7F07);
assign Timer1_WE = (CPU_m_data_byteen == 4'b1111) & (CPU_m_data_addr >= 32'h7F10 && CPU_m_data_addr <= 32'h7F17);

assign m_data_addr = CPU_m_data_addr;
assign m_data_wdata = CPU_m_data_wdata;
assign m_data_byteen = (CPU_m_data_addr >= 32'h0000 && CPU_m_data_addr <= 32'h2FFF) ? CPU_m_data_byteen : 4'h0;

assign m_int_addr = CPU_m_data_addr;
assign m_int_byteen = (CPU_m_data_addr >= 32'h7F20 && CPU_m_data_addr <= 32'h7F23) ? CPU_m_data_byteen : 4'h0;

endmodule
