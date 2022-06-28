----------------------------------------------------------------------------------
-- Engineer:       Berger Jonas
-- Create Date:    31/03/2019 
-- Design Name:    D - Flip Flop (DFF)
-- Module Name:    DFF - Behavioral 
-- Project Name:   Basic_Elements
-- Revision:       V0.1
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DFF is
    Port ( D : in  STD_LOGIC;
           EN : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           RESET : in  STD_LOGIC;
           Q : out  STD_LOGIC);
end DFF;

architecture Behavioral of DFF is

begin

  -- D-Flip Flop Prozess
  DFF_p : process(CLK, RESET)
  begin
    if RESET = '1' then
       Q <= '0';
    elsif CLK'event and CLK = '1' then
       if EN = '1' then
          Q <= D;
       end if;
    end if;
  end process;

end Behavioral;

