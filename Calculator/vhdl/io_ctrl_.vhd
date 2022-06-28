-------------------------------------------------------------------------------
--                        Calculator - Project
-------------------------------------------------------------------------------
-- ENTITY:         io_ctrl
-- FILENAME:       io_ctrl_.vhd
-- ARCHITECTURE:   rtl
-- ENGINEER:       Jonas Berger
-- DATE:           06.03.2022
-- VERSION:        1.0
-------------------------------------------------------------------------------
-- DESCRIPTION:    This is the entity declaration of the io_ctrl submodule
--                 of the Calculator-Project.
-------------------------------------------------------------------------------
-- REFERENCES:     (none)
-------------------------------------------------------------------------------
-- PACKAGES:       std_logic_1164 (IEEE library)
-------------------------------------------------------------------------------
-- CHANGES:        Version 1.0 - JB - 06.03.2022
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity io_ctrl is
  generic (
    button_count : natural :=  4;
    switch_count : natural := 16);
  port (clk_i    :  in std_logic;
        reset_i  :  in std_logic;
        
        sw_i     :  in std_logic_vector(15 downto 0);
        pb_i     :  in std_logic_vector (3 downto 0);
        
        dig0_i   :  in std_logic_vector (7 downto 0);
        dig1_i   :  in std_logic_vector (7 downto 0);
        dig2_i   :  in std_logic_vector (7 downto 0);
        dig3_i   :  in std_logic_vector (7 downto 0);
        
        led_i    :  in std_logic_vector(15 downto 0);
        
        ss_o     : out std_logic_vector (7 downto 0);
        ss_sel_o : out std_logic_vector (3 downto 0);
        led_o    : out std_logic_vector(15 downto 0);
        swsync_o : out std_logic_vector(15 downto 0);
        pbsync_o : out std_logic_vector (3 downto 0));
end io_ctrl;

