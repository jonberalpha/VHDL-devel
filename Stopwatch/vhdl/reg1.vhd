----------------------------------------------------------------------------------
-- Engineer:       Berger Jonas
-- Create Date:    24/02/2018
-- Module Name:    reg1 - Behavioral 
-- Project Name:   Projekt_2
-- Revision 0.01 - File Created
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity reg1 is
    Port ( A_i : in  STD_LOGIC_VECTOR (3 downto 0);
	        B_i : in  STD_LOGIC_VECTOR (3 downto 0);
			  C_i : in  STD_LOGIC_VECTOR (3 downto 0);
			  D_i : in  STD_LOGIC_VECTOR (3 downto 0);
			  en : in STD_LOGIC;
           rst : in  STD_LOGIC;
           clk : in  STD_LOGIC;
			  enanzreg1 : out STD_LOGIC;
           A_o : out  STD_LOGIC_VECTOR (3 downto 0);
			  B_o : out  STD_LOGIC_VECTOR (3 downto 0);
			  C_o : out  STD_LOGIC_VECTOR (3 downto 0);
			  D_o : out  STD_LOGIC_VECTOR (3 downto 0));
end reg1;

architecture Behavioral of reg1 is

begin
reg_p: process(clk,rst)
  begin
   if rst = '1' then       --im Reset-Fall alle auf "0000" setzen
      A_o <= "0000";
	   B_o <= "0000";
		C_o <= "0000";
		D_o <= "0000";
		enanzreg1 <= '0';
   elsif clk'event and clk = '1' then
	   if en = '1' then     --nur wenn EN-Eingang auf '1' ist wird gespeichert
			A_o <= A_i;
			B_o <= B_i;
			C_o <= C_i;
			D_o <= D_i;
			enanzreg1 <= '1';
		else
			enanzreg1 <= '0';
		end if;
   end if;
end process;

end Behavioral;

