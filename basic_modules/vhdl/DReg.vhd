----------------------------------------------------------------------------------
-- Engineer:       Berger Jonas
-- Create Date:    31/03/2019 
-- Design Name:    D-Register
-- Module Name:    DReg - Behavioral 
-- Project Name:   Basic_Elements
-- Revision:       V0.1
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DReg is
    Generic( RegWidth : natural := 16);
    Port ( D : in  STD_LOGIC_VECTOR (RegWidth downto 0);
           EN : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           RESET : in  STD_LOGIC;
           Q : out  STD_LOGIC_VECTOR (RegWidth downto 0));
end DReg;

architecture Behavioral of DReg is

begin

  -- D-Register Prozess
  DReg_p : process(CLK, RESET)
  begin
    if RESET = '1' then
       Q <= (others => '0');
    elsif CLK'event and CLK = '1' then
       if EN = '1' then
          Q <= D;
       end if;
    end if;
  end process;

end Behavioral;

