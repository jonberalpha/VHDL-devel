----------------------------------------------------------------------------------
-- Engineer:       Berger Jonas
-- Create Date:    12/03/2018
-- Module Name:    tick_cnt - Behavioral 
-- Project Name:   Projekt_2
-- Revision 0.01 - File Created
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity btn1tick is
    Port ( btn1 : in  STD_LOGIC;
           rst : in  STD_LOGIC;
			  clk : in STD_LOGIC;
           tick : out  STD_LOGIC);
end btn1tick;

architecture Behavioral of btn1tick is

signal tick_i : STD_LOGIC:='0';
signal sig : STD_LOGIC:='0';

begin
tick_p: process(clk,rst)
  begin
    if rst='1' then
	    tick_i <= '0';
	 elsif clk'event and clk='1' then
	    if sig='0' and btn1='1' then
		    tick_i <= not tick_i;
			 sig <= '1';
		 else
		    tick_i <= '0';
		    sig <= btn1;
		 end if;
	 end if;
end process;

tick <= tick_i;

end Behavioral;
