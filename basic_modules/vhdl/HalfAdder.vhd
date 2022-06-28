----------------------------------------------------------------------------------
-- Engineer:       Berger Jonas
-- Create Date:    31/03/2019 
-- Design Name:    Halb-Addierer
-- Module Name:    HalfAdder - Behavioral 
-- Project Name:   Basic_Elements
-- Revision:       V0.1
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity HalfAdder is
    Port ( A : in  STD_LOGIC;
           B : in  STD_LOGIC;
           SUM : out  STD_LOGIC;
           Cout : out  STD_LOGIC);
end HalfAdder;

architecture Behavioral of HalfAdder is

begin

  SUM <= A xor B;
  Cout <= A and B;

end Behavioral;

