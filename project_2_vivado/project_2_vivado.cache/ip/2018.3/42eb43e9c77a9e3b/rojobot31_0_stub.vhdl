-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.3 (lin64) Build 2405991 Thu Dec  6 23:36:41 MST 2018
-- Date        : Sun Oct 20 13:25:30 2019
-- Host        : rew-desktop running 64-bit Ubuntu 18.04.3 LTS
-- Command     : write_vhdl -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
--               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ rojobot31_0_stub.vhdl
-- Design      : rojobot31_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a100tcsg324-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix is
  Port ( 
    MotCtl_in : in STD_LOGIC_VECTOR ( 7 downto 0 );
    LocX_reg : out STD_LOGIC_VECTOR ( 7 downto 0 );
    LocY_reg : out STD_LOGIC_VECTOR ( 7 downto 0 );
    Sensors_reg : out STD_LOGIC_VECTOR ( 7 downto 0 );
    BotInfo_reg : out STD_LOGIC_VECTOR ( 7 downto 0 );
    worldmap_addr : out STD_LOGIC_VECTOR ( 13 downto 0 );
    worldmap_data : in STD_LOGIC_VECTOR ( 1 downto 0 );
    clk_in : in STD_LOGIC;
    reset : in STD_LOGIC;
    upd_sysregs : out STD_LOGIC;
    Bot_Config_reg : in STD_LOGIC_VECTOR ( 7 downto 0 )
  );

end decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix;

architecture stub of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "MotCtl_in[7:0],LocX_reg[7:0],LocY_reg[7:0],Sensors_reg[7:0],BotInfo_reg[7:0],worldmap_addr[13:0],worldmap_data[1:0],clk_in,reset,upd_sysregs,Bot_Config_reg[7:0]";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "rojobot31,Vivado 2018.3";
begin
end;
