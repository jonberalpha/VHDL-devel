----------------------------------------------------------------------------------
-- Engineer:       Berger Jonas
-- Create Date:    31/03/2019 
-- Design Name:    Komperator 4x4 (2x 4 bit Eingaenge)
-- Module Name:    COMP4x4 - Behavioral 
-- Project Name:   Basic_Elements
-- Revision:       V0.1
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity COMP4x4 is
    Port ( A : in  STD_LOGIC_VECTOR(3 downto 0);
           B : in  STD_LOGIC_VECTOR(3 downto 0);
           ILO : in  STD_LOGIC;
           IEQ : in  STD_LOGIC;
           IHI : in  STD_LOGIC;
           LO : out  STD_LOGIC;
           EQ : out  STD_LOGIC;
           HI : out  STD_LOGIC);
end COMP4x4;

architecture Behavioral of COMP4x4 is

  signal temp : std_logic_vector(2 downto 0);
  signal A_i : unsigned(3 downto 0);
  signal B_i : unsigned(3 downto 0);

begin

  A_i <= unsigned(A);
  B_i <= unsigned(B);

  -- Komperator Prozess
  COMP_p : process(A, B, ILO, IEQ, IHI)
  begin
    if A_i > B_i then
       temp <= "100";
    elsif A_i < B_i then
       temp <= "001";
    elsif IHI = '1' and IEQ = '0' and ILO = '0' then
       temp <= "100";
    elsif IHI = '0' and IEQ = '0' and ILO = '1' then
       temp <= "001";
    elsif IEQ = '1' then
       temp <= "010";       -- Sonderfall 1
    elsif IHI = '1' and IEQ = '0' and ILO = '1' then
       temp <= "000";       -- Sonderfall 2
    else
       temp <= "101";       -- Sonderfall 3
    end if;
  end process;

  HI <= temp(2);
  EQ <= temp(1);
  LO <= temp(0);

end Behavioral;

