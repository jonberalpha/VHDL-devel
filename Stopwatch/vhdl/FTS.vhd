----------------------------------------------------------------------------------
-- Engineer:       Berger Jonas
-- Create Date:    24/02/2018
-- Module Name:    FTS - Behavioral 
-- Project Name:   Projekt_2
-- Revision 0.01 - File Created
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FTS is
    Port ( btn1 : in  STD_LOGIC;  --start-button
           btn2 : in  STD_LOGIC;  --1. Zwischenzeit
           btn3 : in  STD_LOGIC;  --2. Zwischenzeit
			  clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;   --mit btn0 aktiviert
			  enanzreg1 : in STD_LOGIC;
			  enanzreg2 : in STD_LOGIC;
           strl : out  STD_LOGIC_VECTOR (1 downto 0);
			  reg1en : out STD_LogiC;
			  reg2en : out STD_LogiC;
			  cnten : out  STD_LOGIC);
end FTS;

architecture Behavioral of FTS is

type state_type is (s_start, s_anzcnt, s_zwz1_fill, s_zwz2_fill, s_anzreg1, s_anzreg2, s_anzreg1_stop, s_anzreg2_stop, s_stop); 
signal curState, nextState: state_type;

--Konstanten fuer strl
constant CNT:STD_LOGIC_VECTOR:="00";
constant TIME1:STD_LOGIC_VECTOR:="10";
constant TIME2:STD_LOGIC_VECTOR:="11";
--Konstanten fuer cnten/reg1en/reg2en
constant ENABLE:STD_LOGIC:='1';
constant DISABLE:STD_LOGIC:='0';

begin
reg_p: process(rst,clk)
   begin
	    if rst='1' then
		    curState <= s_start;
		 elsif clk'event and clk='1' then
			 curState <= nextState;
		 end if;
	end process;
	
nextstatelogic_p: process(btn1, btn2, btn3, enanzreg1, enanzreg2, curState)
   begin
	   nextState <= curState;     --default Anweisung
		case curState is
		--s_start
      when s_start =>
         if btn1='1' then
			   nextState <= s_anzcnt;
			end if;
		--s_anzcnt
      when s_anzcnt =>
         if btn2='1' and enanzreg1 ='1' then
			   nextState <= s_zwz1_fill;
			elsif btn2='1' and enanzreg1='0' then
			   nextState <= s_anzreg1;
			end if;
			if btn3='1' and enanzreg2 ='1' then
			   nextState <= s_zwz2_fill;
			elsif btn3='1' and enanzreg2='0' then
			   nextState <= s_anzreg2;
			end if;
			if btn1='1' then
			   nextState <= s_stop;
			end if;
	   --Register 1 mit Zwischenzeit befuellen
		when s_zwz1_fill =>
		   nextState <= s_anzreg1;
		--Register 2 mit Zwischenzeit befuellen
		when s_zwz2_fill =>
		   nextState <= s_anzreg2;
		--Register 1 waehrend dem Zaehlen anzeigen
		when s_anzreg1 =>
		   if btn2='0' then
		      nextState <= s_anzcnt;
		   end if;
		--Register 2 waehrend dem Zaehlen anzeigen
		when s_anzreg2 =>
		   if btn3='0' then
		      nextState <= s_anzcnt;
		   end if;
		--Register 1 waehrend dem Stoppzustand anzeigen
		when s_anzreg1_stop =>
		   if btn2='0' then
		      nextState <= s_stop;
		   end if;
		--Register 2 waehrend dem Stoppzustand anzeigen
		when s_anzreg2_stop =>
		   if btn3='0' then
		      nextState <= s_stop;
		   end if;
		--Stoppzustand
		when s_stop =>
		   if btn2='1' then
			   nextState <= s_anzreg1_stop;
			end if;
			if btn3='1' then
			   nextState <= s_anzreg2_stop;
			end if;
         if rst='1' then
			   nextState <= s_start;
			end if;
		
      when others =>
         nextState <= s_start;
			
      end case;	
	end process;
	
outputlogic_p: process(enanzreg1,enanzreg2,curState)
   begin
     case curState is
      when s_start =>        --ausgeschaltener Zaehler durchschalten
         strl <= CNT;
			cnten <= DISABLE;
			reg1en <= ENABLE;
			reg2en <= ENABLE;
			
		when s_anzcnt =>       --eingeschaltener Zaehler durchschalten
		   strl <= CNT;
			cnten <= ENABLE;
			if enanzreg1='0' then
			   reg1en <= DISABLE;
			else
			   reg1en <= ENABLE;
			end if;
			if enanzreg2='0' then
			   reg2en <= DISABLE;
			else
			   reg2en <= ENABLE;
			end if;
			
      when s_zwz1_fill =>    --Register 1 mit Zwischenzeit befuellen und durchschalten
		   strl <= TIME1;
			cnten <= ENABLE;
			reg1en <= DISABLE;
			if enanzreg2='0' then
			   reg2en <= DISABLE;
			else
			   reg2en <= ENABLE;
			end if;
			
		when s_zwz2_fill =>    --Register 2 mit Zwischenzeit befuellen und durchschalten
		   strl <= TIME2;
			cnten <= ENABLE;
			reg2en <= DISABLE;
			if enanzreg1='0' then
			   reg1en <= DISABLE;
			else
			   reg1en <= ENABLE;
			end if;
			
		when s_anzreg1 =>      --Register 1 waehrend Zaehlen anzeigen
		   strl <= TIME1;
			cnten <= ENABLE;
			if enanzreg1='0' then
			   reg1en <= DISABLE;
			else
			   reg1en <= ENABLE;
			end if;
			if enanzreg2='0' then
			   reg2en <= DISABLE;
			else
			   reg2en <= ENABLE;
			end if;
			
		when s_anzreg2 =>      --Register 2 waehrend Zaehlen anzeigen
		   strl <= TIME2;
			cnten <= ENABLE;
			if enanzreg1='0' then
			   reg1en <= DISABLE;
			else
			   reg1en <= ENABLE;
			end if;
			if enanzreg2='0' then
			   reg2en <= DISABLE;
			else
			   reg2en <= ENABLE;
			end if;
			
		when s_anzreg1_stop =>  --Register 1 waehrend Stoppen anzeigen
		   strl <= TIME1;
			cnten <= DISABLE;
			reg1en <= DISABLE;
			reg2en <= DISABLE;
			
		when s_anzreg2_stop =>  --Register 2 waehrend Stoppen anzeigen
		   strl <= TIME2;
			cnten <= DISABLE;
			reg1en <= DISABLE;
			reg2en <= DISABLE;
			
		when s_stop =>          --Ausgeschaltener Counter durchschalten
		   strl <= CNT;
			cnten <= DISABLE;
			reg1en <= DISABLE;
			reg2en <= DISABLE;
			
     end case;
	end process;
	
end Behavioral;
