----------------------------------------------------------------------------------
-- Engineer:       Berger Jonas
-- Create Date:    31/03/2019 
-- Design Name:    Voll-Subtrahierer
-- Module Name:    FullSub - Behavioral 
-- Project Name:   Basic_Elements
-- Revision:       V0.1
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FullSub is
    Port ( A : in  STD_LOGIC;
           B : in  STD_LOGIC;
           Bin : in  STD_LOGIC;
           DIFF : out  STD_LOGIC;
           Bout : out  STD_LOGIC);
end FullSub;

architecture Behavioral of FullSub is

begin

  DIFF <= A xor B xor Bin;
  Bout <= ((not A) and (B or Bin)) or (B and Bin);

end Behavioral;

