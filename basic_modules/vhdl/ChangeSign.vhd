----------------------------------------------------------------------------------
-- Engineer:       Berger Jonas
-- Create Date:    16/10/2020 
-- Design Name:    Change Sign of 4 Bit Value
-- Module Name:    ChangeSign - Behavioral
-- Project Name:   Basic_Elements
-- Revision:       V0.1
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ChangeSign is
    Port ( a : in  SIGNED (3 downto 0);
           b : out  SIGNED (3 downto 0));
end ChangeSign;

architecture Behavioral of ChangeSign is

begin

  b <= not(a) + 1;

end Behavioral;

