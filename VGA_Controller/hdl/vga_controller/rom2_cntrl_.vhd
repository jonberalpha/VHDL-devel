-------------------------------------------------------------------------------
--                        VGA Controller - Project
-------------------------------------------------------------------------------
-- ENTITY:         rom2_cntrl
-- FILENAME:       rom2_cntrl_.vhd
-- ARCHITECTURE:   rtl
-- ENGINEER:       Jonas Berger
-- DATE:           01.10.2022
-- VERSION:        1.0
-------------------------------------------------------------------------------
-- DESCRIPTION:    This is the entity declaration of the ROM 2 Control Unit
-------------------------------------------------------------------------------
-- REFERENCES:     (none)
-------------------------------------------------------------------------------
-- PACKAGES:       std_logic_1164 (IEEE library)
-------------------------------------------------------------------------------
-- CHANGES:        Version 1.0 - JB - 01.10.2022
-------------------------------------------------------------------------------

library IEEE; 
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity rom2_cntrl is
  generic(
        G_SCREEN_WIDTH  : natural := 1920;
        G_SCREEN_HEIGHT : natural := 1080
  );
  port(
        clk_i      : in  std_logic;                      -- 25 MHz clock signal coming from clock oscillator
        reset_i    : in  std_logic;                      -- reset signal
        
        hpos_i     : in std_logic_vector (9 downto 0);   -- 10 bit to fit max 640 count for both h_pos and v_pos
        vpos_i     : in std_logic_vector (9 downto 0);
        rom_data_i : in std_logic_vector(11 downto 0);
        uC_i       : in std_logic_vector (7 downto 0);
        sw_i       : in std_logic;
        pb_i       : in std_logic_vector (3 downto 0);
        
        rom_addr_o : out std_logic_vector(13 downto 0);  -- size is 14 bit
        red_o      : out std_logic_vector (3 downto 0);  -- red value vga out
        green_o    : out std_logic_vector (3 downto 0);  -- green value vga out
        blue_o     : out std_logic_vector (3 downto 0);  -- blue value vga out
      
        mov_img_flag_o : out std_logic
      );
end rom2_cntrl;
