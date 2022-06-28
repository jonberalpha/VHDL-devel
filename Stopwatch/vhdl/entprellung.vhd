----------------------------------------------------------------------------------
-- Engineer: 		   Berger Jonas
-- Create Date:    14:08:41 11/10/2017 
-- Module Name:    cnt10 - Behavioral 
-- Project Name:   seq
-- Revision 0.01 - File Created
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;										--Numeric Biblio weil wir rechen 

entity entprellung is
    Port ( rst : in  STD_LOGIC;
	        btn : in STD_LOGIC;
           clk : in  STD_LOGIC;
           btnout : out  STD_LOGIC);
end entprellung;

architecture Behavioral of entprellung is
signal q_i: unsigned (3 downto 0);
constant maxwert: unsigned (3 downto 0):="1010";
														 
begin
count_p: process(btn, clk, rst)
  begin
	if rst='1' or btn='0' then
	   btnout<='0';
	elsif clk'event and clk = '1' then
	   if btn='1' then
		   if q_i= "0000" then
			   btnout<= '1';
			else
			   q_i <= q_i - "0001";
		   end if;
		end if;
	end if;
  end process;

end Behavioral;

