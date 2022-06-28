----------------------------------------------------------------------------------
-- Engineer:       Berger Jonas
-- Create Date:    31/03/2019 
-- Design Name:    Voll-Addierer
-- Module Name:    FullAdder - Behavioral 
-- Project Name:   Basic_Elements
-- Revision:       V0.1
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FullAdder is
    Port ( A : in  STD_LOGIC;
           B : in  STD_LOGIC;
           Cin : in  STD_LOGIC;
           SUM : out  STD_LOGIC;
           Cout : out  STD_LOGIC);
end FullAdder;

architecture Behavioral of FullAdder is

begin

  SUM <= A xor B xor Cin;
  Cout <= (A and B) or (Cin and A) or (Cin and B);

end Behavioral;

