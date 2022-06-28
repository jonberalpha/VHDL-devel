-------------------------------------------------------------------------------
--                        Calculator - Project
-------------------------------------------------------------------------------
-- ENTITY:         calc_ctrl
-- FILENAME:       calc_ctrl_.vhd
-- ARCHITECTURE:   rtl
-- ENGINEER:       Jonas Berger
-- DATE:           17.03.2022
-- VERSION:        1.0
-------------------------------------------------------------------------------
-- DESCRIPTION:    This is the entity declaration of the calc_ctrl submodule
--                 of the Calculator-Project.
-------------------------------------------------------------------------------
-- REFERENCES:     (none)
-------------------------------------------------------------------------------
-- PACKAGES:       std_logic_1164 (IEEE library)
-------------------------------------------------------------------------------
-- CHANGES:        Version 1.0 - JB - 17.03.2022
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity calc_ctrl is
  port (clk_i      :  in std_logic;
        reset_i    :  in std_logic;
        
        result_i   :  in std_logic_vector(15 downto 0);
        
        finished_i :  in std_logic;
        sign_i     :  in std_logic;
        overflow_i :  in std_logic;
        error_i    :  in std_logic;
        
        swsync_i   :  in std_logic_vector(15 downto 0);
        pbsync_i   :  in std_logic_vector (3 downto 0);
        
        start_o    : out std_logic;
        
        op1_o      : out std_logic_vector(11 downto 0);
        op2_o      : out std_logic_vector(11 downto 0);
        optype_o   : out std_logic_vector (3 downto 0);
        
        dig0_o     : out std_logic_vector (7 downto 0);
        dig1_o     : out std_logic_vector (7 downto 0);
        dig2_o     : out std_logic_vector (7 downto 0);
        dig3_o     : out std_logic_vector (7 downto 0);
        led_o      : out std_logic_vector(15 downto 0));
end calc_ctrl;

