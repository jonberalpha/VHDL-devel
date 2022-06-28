----------------------------------------------------------------------------------
-- Engineer:       Berger Jonas
-- Create Date:    31/03/2019 
-- Design Name:    N bit Schieberegister
-- Module Name:    NbitShiftReg - Behavioral 
-- Project Name:   Basic_Elements
-- Revision:       V0.1
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity NbitShiftReg is
    Generic( RegWidth : natural := 4 );
    Port ( Din : in  STD_LOGIC;
           EN : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           RESET : in  STD_LOGIC;
           Dout : out  STD_LOGIC_VECTOR (RegWidth-1 downto 0));
end NbitShiftReg;

architecture Behavioral of NbitShiftReg is

  signal temp : std_logic_vector(RegWidth-1 downto 0);

begin

  -- Schieberegister Prozess
  ShiftReg_p : process (CLK, RESET)
  begin
    if RESET = '1' then
       temp <= (others => '0');
    elsif CLK'event and CLK = '1' then
      if EN = '1' then    
         temp <= temp(RegWidth-2 downto 0) & Din;
      end if;
    end if;
  end process;
  
  Dout <= temp;

end Behavioral;

