----------------------------------------------------------------------------------
-- Engineer:       Berger Jonas
-- Create Date:    31/03/2019 
-- Design Name:    JK - Flip Flop (JKFF)
-- Module Name:    JKFF - Behavioral 
-- Project Name:   Basic_Elements
-- Revision:       V0.1
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity JKFF is
    Port ( J : in  STD_LOGIC;
           K : in  STD_LOGIC;
           EN : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           RESET : in  STD_LOGIC;
           Q : out  STD_LOGIC);
end JKFF;

architecture Behavioral of JKFF is

signal Q_i : std_logic;

begin

  -- JK-Flip Flop Prozess
  JKFF_p : process(CLK, RESET)
  begin
    if RESET = '1' then
       Q_i <= '0';
    elsif CLK'event and CLK = '1' then
      if EN = '1' then
         if J = '0' and K = '0' then
            Q_i <= Q_i;
         elsif J = '0' and K = '1' then
            Q_i <= '0';
         elsif J = '1' and K = '0' then
            Q_i <= '1';
         elsif J='1' and K='1' then
            Q_i <= not(Q_i);
         end if;
      end if;
    end if;
  end process;

  Q <= Q_i;

end Behavioral;

