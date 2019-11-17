// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (lin64) Build 2405991 Thu Dec  6 23:36:41 MST 2018
// Date        : Sun Oct 20 13:25:30 2019
// Host        : rew-desktop running 64-bit Ubuntu 18.04.3 LTS
// Command     : write_verilog -force -mode synth_stub
//               /home/rew/Documents/project_2_vivado/project_2_vivado.srcs/sources_1/ip/rojobot31_0/rojobot31_0_stub.v
// Design      : rojobot31_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "rojobot31,Vivado 2018.3" *)
module rojobot31_0(MotCtl_in, LocX_reg, LocY_reg, Sensors_reg, 
  BotInfo_reg, worldmap_addr, worldmap_data, clk_in, reset, upd_sysregs, Bot_Config_reg)
/* synthesis syn_black_box black_box_pad_pin="MotCtl_in[7:0],LocX_reg[7:0],LocY_reg[7:0],Sensors_reg[7:0],BotInfo_reg[7:0],worldmap_addr[13:0],worldmap_data[1:0],clk_in,reset,upd_sysregs,Bot_Config_reg[7:0]" */;
  input [7:0]MotCtl_in;
  output [7:0]LocX_reg;
  output [7:0]LocY_reg;
  output [7:0]Sensors_reg;
  output [7:0]BotInfo_reg;
  output [13:0]worldmap_addr;
  input [1:0]worldmap_data;
  input clk_in;
  input reset;
  output upd_sysregs;
  input [7:0]Bot_Config_reg;
endmodule
