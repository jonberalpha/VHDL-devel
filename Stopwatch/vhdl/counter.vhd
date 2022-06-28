----------------------------------------------------------------------------------
-- Engineer:       Berger Jonas
-- Create Date:    24/02/2018
-- Design Name:    counter
-- Module Name:    counter - Behavioral 
-- Project Name:   Projekt_2
-- Revision 0.01 - File Created
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity counter is
    Port ( tick : in  STD_LOGIC;
           en : in  STD_LOGIC;
			  rst : in  STD_LOGIC;
			  cnt_A : out  STD_LOGIC_VECTOR (3 downto 0);
			  cnt_B : out  STD_LOGIC_VECTOR (3 downto 0);
			  cnt_C : out  STD_LOGIC_VECTOR (3 downto 0);
           cnt_D : out  STD_LOGIC_VECTOR (3 downto 0));
end counter;

architecture Behavioral of counter is
--default auf 0 sonst undefinierte Zustaende am Beginn der Simulation
signal cnt_A_i: signed (3 downto 0):="0000";
signal cnt_B_i: signed (3 downto 0):="0000";
signal cnt_C_i: signed (3 downto 0):="0000";
signal cnt_D_i: signed (3 downto 0):="0000";

begin
--count-Prozess: 4 Zaehler ineinander verschachtelt
count_p: process(tick, rst)
  begin
	if rst = '1' then           --im Reset-Fall alle auf "0000" setzen
	   cnt_A_i <= "0000";
	   cnt_B_i <= "0000";
	   cnt_C_i <= "0000";
	   cnt_D_i <= "0000";
	elsif tick'event and tick = '1' then 
	   if en='1' then
	      if cnt_A_i = "1001" and cnt_B_i = "1001" and cnt_C_i = "1001" and cnt_D_i = "1001" then
			   cnt_A_i <= "1110"; -- set to EE.EE, wenn alle auf 9 stehen
			   cnt_B_i <= "1110";
			   cnt_C_i <= "1110";
			   cnt_D_i <= "1110";
		   elsif cnt_A_i = "1110" and cnt_B_i = "1110" and cnt_C_i = "1110" and cnt_D_i = "1110" then
			   --leeres elsif => weil sonst trifft der else-Fall ein und der Zaehler beginnt von vorne an zu zaehlen
		   else
		      if cnt_D_i = "1001" then --wenn die letzte Stelle beim Zaehlen erreicht ist, dann alles auf E
			      cnt_D_i <= "0000";
			      if cnt_C_i = "1001" then
				      cnt_C_i <= "0000";
				      if cnt_B_i = "1001" then
					      cnt_B_i <= "0000";
					      cnt_A_i <= cnt_A_i + "0001";
				      else
					      cnt_B_i <= cnt_B_i + "0001";
				      end if;
			      else
				     cnt_C_i <= cnt_C_i + "0001";
			      end if;
		      else 
			      cnt_D_i <= cnt_D_i +"0001";
	         end if;
	      end if;
	   end if;
    end if;
  end process;
--nebenlaeufige Anweisungen
cnt_A <= STD_LOGIC_VECTOR(cnt_A_i);
cnt_B <= STD_LOGIC_VECTOR(cnt_B_i);
cnt_C <= STD_LOGIC_VECTOR(cnt_C_i);
cnt_D <= STD_LOGIC_VECTOR(cnt_D_i);

end Behavioral;

