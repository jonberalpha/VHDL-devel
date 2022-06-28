----------------------------------------------------------------------------------
-- Engineer:       Berger Jonas
-- Create Date:    19/03/2019 
-- Design Name:    Cosinus Modulator mit Lookup-Table
-- Module Name:    CosineMod - Behavioral 
-- Project Name:   Cosine_Modulator
-- Revision:       V0.1
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity CosineMod is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           ce : in  STD_LOGIC;
           phase : in  STD_LOGIC_VECTOR (7 downto 0);
           S90 : in  STD_LOGIC;
           data_out : out  STD_LOGIC_VECTOR (15 downto 0));
end CosineMod;

architecture Behavioral of CosineMod is

-- Cosine Lookup-Table
type Cosine_Type is array (63 downto 0) of signed (15 downto 0);
constant CosineLUT : Cosine_Type :=
(
  x"7FFF", x"7FF5", x"7FD7", x"7FA6",
  x"7F60", x"7F07", x"7E9A", x"7E19",
  x"7D84", x"7CDD", x"7C21", x"7B53",
  x"7A71", x"797C", x"7875", x"775A", -- 1. Quadrant
  x"762D", x"74EE", x"739D", x"7239",
  x"70C4", x"6F3D", x"6DA5", x"6BFC",
  x"6A43", x"6878", x"669E", x"64B3",
  x"62B9", x"60B0", x"5E97", x"5C70", -- 2. Quadrant
  x"5A3A", x"57F7", x"55A5", x"5347",
  x"50DB", x"4E63", x"4BDF", x"494F",
  x"46B3", x"440D", x"415C", x"3EA1",
  x"3BDC", x"390E", x"3636", x"3357", -- 3. Quadrant
  x"306F", x"2D80", x"2A8A", x"278E",
  x"248B", x"2182", x"1E74", x"1B62",
  x"184B", x"1531", x"1213", x"0EF2",
  x"0BCF", x"08AB", x"0584", x"025D"  -- 4. Quadrant
);

-- Signal definitions
signal phase_i: std_logic_vector(7 downto 0);
signal data_i: signed(15 downto 0);

begin
  -- Phase Delay 90 degreese Process
  -- => if S90 is set sine wave will be created
  phase90_p: process(phase, S90)
  begin
    if S90 = '1' then
     -- go one Quadrant back in each case:
       if phase(7 downto 6) = "00" then
          phase_i(7 downto 6) <= "11";
       elsif phase(7 downto 6) = "01" then
          phase_i(7 downto 6) <= "00";
       elsif phase(7 downto 6) = "10" then
          phase_i(7 downto 6) <= "01";
       elsif phase(7 downto 6) = "11" then
          phase_i(7 downto 6) <= "10";
       end if;
       -- inner phasevalue is phasevalue:
       phase_i(5 downto 0) <= phase(5 downto 0);
    else
       phase_i <= phase;
    end if;
  end process;


  -- Cosine Modulator Process
  cosine_mod_p: process(phase_i)
  begin
    -- 1.Quadrant: MSBits = 00
    if phase_i(7 downto 6) = "00" then
       data_i <= CosineLUT(63 - to_integer(unsigned(phase_i(5 downto 0))));          -- normal aus LUT auslesen
      
    -- 2.Quadrant: MSBits = 01
    elsif phase_i(7 downto 6) = "01" then
       data_i <= not(CosineLUT(to_integer(unsigned(phase_i(5 downto 0))))) + 1;      -- 2er-Komplement; verkehrt aus LUT auslesen
      
    -- 3.Quadrant: MSBits = 10
    elsif phase_i(7 downto 6) = "10" then
       data_i <= not(CosineLUT(63 - to_integer(unsigned(phase_i(5 downto 0))))) + 1; -- 2er-Komplement; normal aus LUT auslesen
      
    -- 4.Quadrant: MSBits = 11
    elsif phase_i(7 downto 6) = "11" then
       data_i <= CosineLUT(to_integer(unsigned(phase_i(5 downto 0))));               -- verkehrt aus LUT auslesen
      
    else
       data_i <= (others => '0'); -- Latch verhindern
    end if;
  end process;

  -- Register Process
  register_p: process(rst, clk, ce)
  begin
    if rst = '1' then
       data_out <= (others => '0');
    elsif clk'event and clk = '1' then
       if ce = '1' then
          data_out <= std_logic_vector(data_i);
       end if;
    end if;
  end process;

end Behavioral;

