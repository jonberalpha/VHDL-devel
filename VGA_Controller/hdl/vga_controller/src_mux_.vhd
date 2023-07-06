-------------------------------------------------------------------------------
--                        VGA Controller - Project
-------------------------------------------------------------------------------
-- ENTITY:         src_mux
-- FILENAME:       src_mux_.vhd
-- ARCHITECTURE:   rtl
-- ENGINEER:       Jonas Berger
-- DATE:           27.09.2022
-- VERSION:        1.0
-------------------------------------------------------------------------------
-- DESCRIPTION:    This is the entity declaration of Source Multiplexer
-------------------------------------------------------------------------------
-- REFERENCES:     (none)
-------------------------------------------------------------------------------
-- PACKAGES:       std_logic_1164 (IEEE library)
-------------------------------------------------------------------------------
-- CHANGES:        Version 1.0 - JB - 27.09.2022
-------------------------------------------------------------------------------

library IEEE; 
use IEEE.std_logic_1164.all;

entity src_mux is
  port(
        sw_sync_i       : in  std_logic_vector (2 downto 0);
        mov_img_flag_i  : in  std_logic;
        rgb_patgen1_i   : in  std_logic_vector (11 downto 0);
        rgb_patgen2_i   : in  std_logic_vector (11 downto 0);
        rgb_rom1_i      : in  std_logic_vector (11 downto 0);
        rgb_rom2_i      : in  std_logic_vector (11 downto 0);
        rgb_vga_cntrl_o : out std_logic_vector (11 downto 0)
      );
end src_mux;
