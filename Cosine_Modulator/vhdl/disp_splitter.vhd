----------------------------------------------------------------------------------
-- Engineer:       Berger Jonas
-- Create Date:    28/02/2018
-- Module Name:    disp_splitter - Behavioral 
-- Project Name:   Cosine_Modulator
-- Revision:       V0.1
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity disp_splitter is
    Port ( data_in : in STD_LOGIC_VECTOR (15 downto 0);
           A : out  STD_LOGIC_VECTOR (3 downto 0);
           B : out  STD_LOGIC_VECTOR (3 downto 0);
           C : out  STD_LOGIC_VECTOR (3 downto 0);
           D : out  STD_LOGIC_VECTOR (3 downto 0);
           dp : out  STD_LOGIC_VECTOR (3 downto 0));
end disp_splitter;

architecture Behavioral of disp_splitter is

begin

  -- Vector-Splitter
  A <= data_in(15 downto 12);
  B <= data_in(11 downto 8);
  C <= data_in(7 downto 4);
  D <= data_in(3 downto 0);
  
  -- no decimal point
  dp <= "1111";

end Behavioral;

