----------------------------------------------------------------------------------
-- Engineer:       Berger Jonas
-- Create Date:    31/03/2019 
-- Design Name:    T-Flip Flop (TFF)
-- Module Name:    TFF - Behavioral 
-- Project Name:   Basic_Elements
-- Revision:       V0.1
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TFF is
    Port ( T : in  STD_LOGIC;
           EN : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           RESET : in  STD_LOGIC;
           Q : out  STD_LOGIC);
end TFF;

architecture Behavioral of TFF is

  signal Q_i : std_logic;

begin

  -- T-Flip Flop Prozess
  TFF_p : process(CLK, RESET)
  begin
    if RESET = '1' then
       Q_i <= '0';
    elsif CLK'event and CLK = '1' then
       if EN = '1' then
          if T = '0' then
             Q_i <= Q_i;
          elsif T = '1' then
             Q_i <= not(Q_i);
          end if;
       end if;
    end if;
  end process;
   
  Q <= Q_i;

end Behavioral;

