----------------------------------------------------------------------------------
-- Engineer:       Berger Jonas
-- Create Date:    31/03/2019 
-- Design Name:    4 zu 1 Demultiplexer
-- Module Name:    DMUX1x4 - Behavioral 
-- Project Name:   Basic_Elements
-- Revision:       V0.1
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DMUX1x4 is
    Port ( D : in  STD_LOGIC;
           S : in  STD_LOGIC_VECTOR (1 downto 0);
           ABCD : out  STD_LOGIC_VECTOR (3 downto 0));
end DMUX1x4;

architecture Behavioral of DMUX1x4 is

begin

  -- Demultiplexer Prozess:
  DMUX_p : process(D, S)
  begin
    ABCD <= (others => '0'); -- default-Anweisung
    case S is 
      when "00" =>
        ABCD(3) <= D;
      when "01" =>
        ABCD(2) <= D;
      when "10" =>
        ABCD(1) <= D;
      when "11" =>
        ABCD(0) <= D;
      when others =>
        ABCD(0) <= D;
    end case;
  end process;

end Behavioral;

