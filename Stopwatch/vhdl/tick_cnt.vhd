----------------------------------------------------------------------------------
-- Engineer:       Berger Jonas
-- Create Date:    24/02/2018
-- Module Name:    tick_cnt - Behavioral 
-- Project Name:   Projekt_2
-- Revision 0.01 - File Created
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tick_gen is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           tick : out  STD_LOGIC);
end tick_gen;

architecture Behavioral of tick_gen is
--Entity soll alle 500000-mal einen Tick abgeben
type tick_counter_type is range 499999 downto 0;    --neuer typ definiert
signal tickcounter: tick_counter_type;      --ein signal mit dem datentyp
constant max: tick_counter_type := 499999; 

begin
counter_p: process(clk,rst)
  begin
    if rst='1' then
	    tickcounter <= max;
	 elsif clk'event and clk='1' then
	    if tickcounter = 0 then
			 tickcounter <= max;
			 tick <= '1';
		 else
		    tickcounter <= tickcounter - 1;
			 tick <= '0';
		 end if;
	 end if;
end process;

end Behavioral;
