-------------------------------------------------------------------------------
--                        Calculator - Project
-------------------------------------------------------------------------------
-- ENTITY:         tb_calc_ctrl
-- FILENAME:       tb_calc_ctrl_sim.vhd
-- ARCHITECTURE:   rtl
-- ENGINEER:       Jonas Berger
-- DATE:           17.03.2022
-- VERSION:        1.0
-------------------------------------------------------------------------------
-- DESCRIPTION:    This is the architecture of the calc_ctrl testbench
--                 for the Calculator-Project.
-------------------------------------------------------------------------------
-- REFERENCES:     (none)
-------------------------------------------------------------------------------
-- PACKAGES:       std_logic_1164 (IEEE library)
-------------------------------------------------------------------------------
-- CHANGES:        Version 1.0 - JB - 17.03.2022
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

architecture sim of tb_calc_ctrl is
  
  component calc_ctrl
  port (clk_i      :  in std_logic;
        reset_i    :  in std_logic;
        
        result_i   :  in std_logic_vector(15 downto 0);
        
        finished_i :  in std_logic;
        sign_i     :  in std_logic;
        overflow_i :  in std_logic;
        error_i    :  in std_logic;
        
        swsync_i   :  in std_logic_vector(15 downto 0);
        pbsync_i   :  in std_logic_vector (3 downto 0);
        
        start_o    : out std_logic;
        
        op1_o      : out std_logic_vector(11 downto 0);
        op2_o      : out std_logic_vector(11 downto 0);
        optype_o   : out std_logic_vector (3 downto 0);
        
        dig0_o     : out std_logic_vector (7 downto 0);
        dig1_o     : out std_logic_vector (7 downto 0);
        dig2_o     : out std_logic_vector (7 downto 0);
        dig3_o     : out std_logic_vector (7 downto 0);
        led_o      : out std_logic_vector(15 downto 0));
  end component;
  
  -- Declare the signals used stimulating the design's inputs.
  signal   clk_i      : std_logic;
  signal   reset_i    : std_logic;
  signal   result_i   : std_logic_vector(15 downto 0);
  signal   finished_i : std_logic;
  signal   sign_i     : std_logic;
  signal   overflow_i : std_logic;
  signal   error_i    : std_logic;
  signal   swsync_i   : std_logic_vector(15 downto 0);
  signal   pbsync_i   : std_logic_vector (3 downto 0);
  signal   start_o    : std_logic;
  signal   op1_o      : std_logic_vector(11 downto 0);
  signal   op2_o      : std_logic_vector(11 downto 0);
  signal   optype_o   : std_logic_vector (3 downto 0);
  signal   dig0_o     : std_logic_vector (7 downto 0);
  signal   dig1_o     : std_logic_vector (7 downto 0);
  signal   dig2_o     : std_logic_vector (7 downto 0);
  signal   dig3_o     : std_logic_vector (7 downto 0);
  signal   led_o      : std_logic_vector(15 downto 0);
  
  -- Clock period definitions
  constant clk_period : time := 10 ns;
  
  -- Optype definitions
  constant ADD      : std_logic_vector(3 downto 0) := "0000";
  constant MULTIPLY : std_logic_vector(3 downto 0) := "0010";
  constant LNOT     : std_logic_vector(3 downto 0) := "1000";
  constant LXOR     : std_logic_vector(3 downto 0) := "1011";
  
begin
   -- Instantiate the calc_ctrl design for testing
   i_calc_ctrl : calc_ctrl
   port map 
   (clk_i      => clk_i,
    reset_i    => reset_i,
    result_i   => result_i,
    finished_i => finished_i,
    sign_i     => sign_i,
    overflow_i => overflow_i,
    error_i    => error_i,
    swsync_i   => swsync_i,
    pbsync_i   => pbsync_i,
    start_o    => start_o,
    op1_o      => op1_o,
    op2_o      => op2_o,
    optype_o   => optype_o,
    dig0_o     => dig0_o,
    dig1_o     => dig1_o,
    dig2_o     => dig2_o,
    dig3_o     => dig3_o,
    led_o      => led_o);
  
  -- Clock process definitions
  clk_p : process
  begin
    clk_i <= '0';
    wait for clk_period/2;
    clk_i <= '1';
    wait for clk_period/2;
  end process;

  test_p : process
  begin
    reset_i <= '1';
    result_i <= (others => '0');
    sign_i <= '0';
    overflow_i <= '0';
    error_i <= '0';
    swsync_i <= (others => '0');
    wait for clk_period*10;
    reset_i <= '0';
    result_i <= (others => '0');
    sign_i <= '0';
    overflow_i <= '0';
    error_i <= '0';
    swsync_i <= ADD & b"0000_0100_1100";
    wait for clk_period*100;
    result_i <= (others => '0');
    sign_i <= '0';
    overflow_i <= '0';
    error_i <= '0';
    swsync_i <= ADD & b"0000_0000_1110";
    wait for clk_period*100;
    result_i <= b"0000_0000_0101_1010";
    sign_i <= '0';
    overflow_i <= '0';
    error_i <= '0';
    swsync_i <= ADD & b"0000_0000_1110";
    wait for clk_period*100;
  end process;
  
  pb_p : process
  begin
    pbsync_i <= "0000";
    wait for clk_period*80;
    pbsync_i <= "1000";
    wait for clk_period;
  end process;
  
  finished_i <= '0', '1' after clk_period*210, '0' after clk_period*211;

end sim;

