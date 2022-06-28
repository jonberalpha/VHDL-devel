----------------------------------------------------------------------------------
-- Engineer:       Berger Jonas
-- Create Date:    24/02/2018
-- Module Name:    disp_mux_01 - Behavioral 
-- Project Name:   Projekt_2
-- Revision 0.01 - File Created
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;          --fuer unsigned notwendig (beim Counter eingesetzt)

entity disp_mux_01 is
    Port ( A : in  STD_LOGIC_VECTOR (3 downto 0);
           B : in  STD_LOGIC_VECTOR (3 downto 0);
           C : in  STD_LOGIC_VECTOR (3 downto 0);
           D : in  STD_LOGIC_VECTOR (3 downto 0);
           dpi : in  STD_LOGIC_VECTOR (3 downto 0);
           tick : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           seg : out  STD_LOGIC_VECTOR (6 downto 0);
           dpo : out  STD_LOGIC;
           an : out  STD_LOGIC_VECTOR (3 downto 0));
end disp_mux_01;

architecture Behavioral of disp_mux_01 is

--Konstanten- u. Typdefinitionen
--1.) counter-Definition
signal cnt_an_i: unsigned (1 downto 0);             --Zaehlervariable

--2.) interne Signale
signal ABCD_seg: std_logic_vector(3 downto 0);      --Signal von Multiplexer zum binaer-7segment-Converter
signal cnt_an: std_logic_vector(1 downto 0);        --Zaehlerstand

begin
--count-Prozess: 0-3 Zaehler
count_p: process(clk, tick, rst)
  begin
	if rst='1' then
	   cnt_an_i <="00";
	elsif clk'event and clk = '1' then
	   if tick = '1' then
			if cnt_an_i= "11" then
				cnt_an_i <= "00";
			else 
				cnt_an_i <= cnt_an_i +"01";
			end if;
	   end if;
   end if;
end process;
  
cnt_an <= STD_LOGIC_VECTOR(cnt_an_i);

--Multiplexer Prozess:
mux_p: process(cnt_an,tick)
  begin
   case cnt_an is ---an alle invertieren
      when "00" =>               --1. 7-Seg-Anzeige
         an <= "0111";
			ABCD_seg <= A;
			if dpi = "0111" then
			   dpo <= '0';          --Dezimalpunkt bei der ersten 7-Seg-Anzeige
			else
			   dpo <= '1';
			end if;
			
      when "01" =>               --2. 7-Seg-Anzeige
         an <= "1011";
			ABCD_seg <= B;
			if dpi = "1011" then
			   dpo <= '0';          --Dezimalpunkt bei der zweiten 7-Seg-Anzeige
			else
			   dpo <= '1';
			end if;
			
      when "10" =>               --3. 7-Seg-Anzeige
         an <= "1101";
			ABCD_seg <= C;
			if dpi = "1101" then
			   dpo <= '0';          --Dezimalpunkt bei der dritten 7-Seg-Anzeige
			else
			   dpo <= '1';
			end if;
			
      when "11" =>               --4. 7-Seg-Anzeige
         an <= "1110";
			ABCD_seg <= D;
			if dpi = "1110" then
			   dpo <= '0';          --Dezimalpunkt bei der 4. 7-Seg-Anzeige
			else
			   dpo <= '1';
			end if;
			
		when others =>
         an <= "1111";
      end case;			
end process;

--bin-7segm-Prozess: Umwandlung binaer zu 7 Segment-Anzeige
--Info Bitbelegung von seg: "abcdefg"; Bit=1 => Led-Segment leuchtet
bin_7segm_p: process(ABCD_seg,clk)
 begin
  case ABCD_seg is
		when "0000" => seg <= "1000000"; -- 0
		when "0001" => seg <= "1111001"; -- 1
		when "0010" => seg <= "0100100"; -- 2
		when "0011" => seg <= "0110000"; -- 3
		when "0100" => seg <= "0011001"; -- 4
		when "0101" => seg <= "0010010"; -- 5
		when "0110" => seg <= "0000010"; -- 6
		when "0111" => seg <= "1111000"; -- 7
		when "1000" => seg <= "0000000"; -- 8
		when "1001" => seg <= "0010000"; -- 9
		when "1010" => seg <= "0001000"; -- A
		when "1011" => seg <= "0000011"; -- b
		when "1100" => seg <= "0100111"; -- c
		when "1101" => seg <= "0100001"; -- d
		when "1110" => seg <= "0000110"; -- E
		when others => seg <= "0001110"; -- F
	   end case;
end process;
  
end Behavioral;

