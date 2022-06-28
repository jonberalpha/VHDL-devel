----------------------------------------------------------------------------------
-- Engineer:       Berger Jonas
-- Create Date:    31/03/2019 
-- Design Name:    Halb-Subtrahierer
-- Module Name:    HalfSub - Behavioral 
-- Project Name:   Basic_Elements
-- Revision:       V0.1
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity HalfSub is
    Port ( A : in  STD_LOGIC;
           B : in  STD_LOGIC;
           DIFF : out  STD_LOGIC;
           Bout : out  STD_LOGIC);
end HalfSub;

architecture Behavioral of HalfSub is

begin

  DIFF <= A xor B;
  Bout <= (not A) and B;

end Behavioral;

