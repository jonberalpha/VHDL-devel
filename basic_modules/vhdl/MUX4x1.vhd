----------------------------------------------------------------------------------
-- Engineer:       Berger Jonas
-- Create Date:    31/03/2019 
-- Design Name:    4 zu 1 Multiplexer
-- Module Name:    MUX4x1 - Behavioral 
-- Project Name:   Basic_Elements
-- Revision:       V0.1
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX4x1 is
    Port ( ABCD : in  STD_LOGIC_VECTOR (3 downto 0);
           S : in  STD_LOGIC_VECTOR (1 downto 0);
           Q : out  STD_LOGIC);
end MUX4x1;

architecture Behavioral of MUX4x1 is

begin

   -- Multiplexer Prozess:
   MUX_p : process(ABCD, S)
   begin
     case S is 
       when "00" =>
         Q <= ABCD(3);
       when "01" =>
         Q <= ABCD(2);
       when "10" =>
         Q <= ABCD(1);
       when "11" =>
         Q <= ABCD(0);
       when others =>
         Q <= ABCD(0);
     end case;
  end process;

end Behavioral;

