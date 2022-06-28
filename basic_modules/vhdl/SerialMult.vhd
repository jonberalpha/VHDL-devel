----------------------------------------------------------------------------------
-- Engineer:       Berger Jonas
-- Create Date:    24/04/2019 
-- Design Name:    Serial Multiplier (=> saves Ressources)
-- Module Name:    SerialMult - Behavioral 
-- Project Name:   Basic_Elements
-- Revision:       V0.1
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity SerialMult is
    Generic ( N : natural := 16 );
    Port ( A : in  STD_LOGIC_VECTOR (N-1 downto 0);
           B : in  STD_LOGIC_VECTOR (N-1 downto 0);
           clk : in STD_LOGIC;
           rst : in  STD_LOGIC;
           CE : in  STD_LOGIC;
           rdy : out STD_LOGIC;
           Product : out  STD_LOGIC_VECTOR (N-1 downto 0));
end SerialMult;

architecture Behavioral of SerialMult is

  signal MultReg: unsigned (N-1 downto 0);
  signal DataReg: signed (N-1 downto 0);
  signal sum: signed (N-1 downto 0);
  signal idx: natural range 0 to N; --Index

begin
 
  -- Shift and Add Multiplier => serieller Multiplizierer
  mult_p : process(clk)
  begin
    if clk'event and clk = '1' then
       if rst = '1' then
          idx <= 0;
          MultReg <= (others => '0');
          sum <= (others => '0');
          Product <= (others => '0');
          rdy <= '1';
       elsif CE = '1' and idx = 0 then
          MultReg <= unsigned(A);                          -- Multiplikator
          DataReg <= signed(B);                            -- Multiplikant
          idx <= N;
          sum <= (others => '0');
          rdy <= '0';                                      --weil noch nicht bereit
       elsif idx > 0 then
          if MultReg(idx-1) = '1' then
             sum <= sum + DataReg;
          end if;
          DataReg <= DataReg(N-1) & DataReg(N-1 downto 1); --Registerwert um 1 bit verschieben, signed bit aber behalten
          idx <= idx - 1;
       else
          Product <= std_logic_vector(sum);
          rdy <= '1';
       end if;
    end if;
  end process;

end Behavioral;

