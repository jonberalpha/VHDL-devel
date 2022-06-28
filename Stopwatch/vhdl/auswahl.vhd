----------------------------------------------------------------------------------
-- Engineer:       Berger Jonas
-- Create Date:    28/02/2018
-- Module Name:    auswahl - Behavioral 
-- Project Name:   Projekt_2
-- Revision 0.01 - File Created
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity auswahl is
    Port ( A_cnt_i : in  STD_LOGIC_VECTOR (3 downto 0);
			  B_cnt_i : in  STD_LOGIC_VECTOR (3 downto 0);
			  C_cnt_i : in  STD_LOGIC_VECTOR (3 downto 0);
			  D_cnt_i : in  STD_LOGIC_VECTOR (3 downto 0);
			  
			  A_reg1_i : in  STD_LOGIC_VECTOR (3 downto 0);
			  B_reg1_i : in  STD_LOGIC_VECTOR (3 downto 0);
			  C_reg1_i : in  STD_LOGIC_VECTOR (3 downto 0);
			  D_reg1_i : in  STD_LOGIC_VECTOR (3 downto 0);
			  
			  A_reg2_i : in  STD_LOGIC_VECTOR (3 downto 0);
			  B_reg2_i : in  STD_LOGIC_VECTOR (3 downto 0);
			  C_reg2_i : in  STD_LOGIC_VECTOR (3 downto 0);
			  D_reg2_i : in  STD_LOGIC_VECTOR (3 downto 0);
			  
			  strl : in  STD_LOGIC_VECTOR (1 downto 0);
			  
			  dp : out STD_LOGIC_VECTOR (3 downto 0);
			  
           A_o : out  STD_LOGIC_VECTOR (3 downto 0);
			  B_o : out  STD_LOGIC_VECTOR (3 downto 0);
			  C_o : out  STD_LOGIC_VECTOR (3 downto 0);
			  D_o : out  STD_LOGIC_VECTOR (3 downto 0));
end auswahl;

architecture Behavioral of auswahl is
--Entity hat die Aufgabe je nach Steuerleitung des Automaten
--, den Momentanwert des Zaehlers, das 1.Register oder das 2.Register
--zum disp_mux_01 durchzuschalten; Weiters wird dp auf "0100" gesetzt
begin

auswahl_p: process(strl, A_cnt_i, B_cnt_i, C_cnt_i, D_cnt_i, A_reg1_i, B_reg1_i, C_reg1_i, D_reg1_i, A_reg2_i, B_reg2_i, C_reg2_i, D_reg2_i)
  begin
   case strl is 
      when "00" =>
         A_o <= A_cnt_i;
			B_o <= B_cnt_i;
			C_o <= C_cnt_i;
			D_o <= D_cnt_i;
			
      when "10" =>
         A_o <= A_reg1_i;
			B_o <= B_reg1_i;
			C_o <= C_reg1_i;
			D_o <= D_reg1_i;
			
      when "11" =>
         A_o <= A_reg2_i;
			B_o <= B_reg2_i;
			C_o <= C_reg2_i;
			D_o <= D_reg2_i;
			
		when others =>
         A_o <= A_cnt_i;
			B_o <= B_cnt_i;
			C_o <= C_cnt_i;
			D_o <= D_cnt_i;
      end case;			
end process;

dp <= "1011";

end Behavioral;

