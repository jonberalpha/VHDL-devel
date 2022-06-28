-------------------------------------------------------------------------------
--                        Calculator - Project
-------------------------------------------------------------------------------
-- ENTITY:         tb_calculator
-- FILENAME:       tb_calculator_sim.vhd
-- ARCHITECTURE:   rtl
-- ENGINEER:       Jonas Berger
-- DATE:           18.03.2022
-- VERSION:        1.0
-------------------------------------------------------------------------------
-- DESCRIPTION:    This is the architecture of the calculator testbench
--                 for the Calculator-Project.
-------------------------------------------------------------------------------
-- REFERENCES:     (none)
-------------------------------------------------------------------------------
-- PACKAGES:       std_logic_1164 (IEEE library)
-------------------------------------------------------------------------------
-- CHANGES:        Version 1.0 - JB - 18.03.2022
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

architecture sim of tb_calculator is

  component calculator
    port (reset_i  :  in std_logic;
          clk_i    :  in std_logic;
          pb_i     :  in std_logic_vector(3 downto 0);
          sw_i     :  in std_logic_vector(15 downto 0);
          ss_o     : out std_logic_vector(7 downto 0);
          ss_sel_o : out std_logic_vector(3 downto 0);
          led_o    : out std_logic_vector(15 downto 0));
  end component calculator;
  
  -- Declare the signals used stimulating the design's inputs.
  signal   reset_i  : std_logic;
  signal   clk_i    : std_logic;
  signal   pb_i     : std_logic_vector(3 downto 0);
  signal   sw_i     : std_logic_vector(15 downto 0);
  signal   ss_o     : std_logic_vector(7 downto 0);
  signal   ss_sel_o : std_logic_vector(3 downto 0);
  signal   led_o    : std_logic_vector(15 downto 0);
  
  -- Clock period definitions
  constant clk_period : time := 10 ns;
  
  -- Optype definitions
  constant ADD      : std_logic_vector(3 downto 0) := "0000";
  constant MULTIPLY : std_logic_vector(3 downto 0) := "0010";
  constant LNOT     : std_logic_vector(3 downto 0) := "1000";
  constant LXOR     : std_logic_vector(3 downto 0) := "1011";
  
begin

  -- Instantiate the calculator design for testing
  i_calculator : calculator
  port map 
    (reset_i  => reset_i,
     clk_i    => clk_i,
     pb_i     => pb_i,
     sw_i     => sw_i,
     ss_o     => ss_o,
     ss_sel_o => ss_sel_o,
     led_o    => led_o);
     
  -- Clock process definitions
  clk_p : process
  begin
    clk_i <= '0';
    wait for clk_period/2;
    clk_i <= '1';
    wait for clk_period/2;
  end process;

  p_test : process
    begin
      reset_i <= '1';
      sw_i <= (others => '0');
      pb_i <= (others => '0');
      wait for 100 us;
      reset_i <= '0';
      sw_i <= b"0000_0000_0000_0100";
      pb_i <= "1000";
      wait for 20 ms;
      pb_i <= "0000";
      wait for 20 ms;
      pb_i <= "1000";
      wait for 20 ms;
      pb_i <= "0000";
      wait for 20 ms;
      pb_i <= "1000";
      wait for 20 ms;
      pb_i <= "0000";
      wait for 20 ms;
    end process;

end sim;

