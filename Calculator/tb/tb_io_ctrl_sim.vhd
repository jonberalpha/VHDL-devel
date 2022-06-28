-------------------------------------------------------------------------------
--                        Calculator - Project
-------------------------------------------------------------------------------
-- ENTITY:         tb_io_ctrl
-- FILENAME:       tb_io_ctrl_sim.vhd
-- ARCHITECTURE:   rtl
-- ENGINEER:       Jonas Berger
-- DATE:           06.03.2022
-- VERSION:        1.0
-------------------------------------------------------------------------------
-- DESCRIPTION:    This is the architecture of the io_ctrl testbench
--                 for the Calculator-Project.
-------------------------------------------------------------------------------
-- REFERENCES:     (none)
-------------------------------------------------------------------------------
-- PACKAGES:       std_logic_1164 (IEEE library)
-------------------------------------------------------------------------------
-- CHANGES:        Version 1.0 - JB - 06.03.2022
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

architecture sim of tb_io_ctrl is
  
  component io_ctrl
  port (clk_i    :  in std_logic;
        reset_i  :  in std_logic;
        
        sw_i     :  in std_logic_vector(15 downto 0);
        pb_i     :  in std_logic_vector (3 downto 0);
        
        dig0_i   :  in std_logic_vector (7 downto 0);
        dig1_i   :  in std_logic_vector (7 downto 0);
        dig2_i   :  in std_logic_vector (7 downto 0);
        dig3_i   :  in std_logic_vector (7 downto 0);
        
        led_i    :  in std_logic_vector(15 downto 0);
        
        ss_o     : out std_logic_vector (7 downto 0);
        ss_sel_o : out std_logic_vector (3 downto 0);
        led_o    : out std_logic_vector(15 downto 0);
        swsync_o : out std_logic_vector(15 downto 0);
        pbsync_o : out std_logic_vector (3 downto 0));
  end component;
  
  -- Declare the signals used stimulating the design's inputs.
  signal   clk_i    : std_logic;
  signal   reset_i  : std_logic;
  signal   sw_i     : std_logic_vector(15 downto 0);
  signal   pb_i     : std_logic_vector (3 downto 0);
  signal   dig0_i   : std_logic_vector (7 downto 0);
  signal   dig1_i   : std_logic_vector (7 downto 0);
  signal   dig2_i   : std_logic_vector (7 downto 0);
  signal   dig3_i   : std_logic_vector (7 downto 0);
  signal   led_i    : std_logic_vector(15 downto 0);
  signal   ss_o     : std_logic_vector (7 downto 0);
  signal   ss_sel_o : std_logic_vector (3 downto 0);
  signal   led_o    : std_logic_vector(15 downto 0);
  signal   swsync_o : std_logic_vector(15 downto 0);
  signal   pbsync_o : std_logic_vector (3 downto 0);
  
  -- Clock period definitions
  constant clk_period : time := 10 ns;
  
begin
   -- Instantiate the io_ctrl design for testing
   i_io_ctrl : io_ctrl
   port map 
   (clk_i    => clk_i,
    reset_i  => reset_i,
    sw_i     => sw_i,
    pb_i     => pb_i,
    dig0_i   => dig0_i,
    dig1_i   => dig1_i,
    dig2_i   => dig2_i,
    dig3_i   => dig3_i,
    led_i    => led_i,
    ss_o     => ss_o,
    ss_sel_o => ss_sel_o,
    led_o    => led_o,
    swsync_o => swsync_o,
    pbsync_o => pbsync_o);
  
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
    dig0_i <= x"00";
    dig1_i <= x"00";
    dig2_i <= x"00";
    dig3_i <= x"00";
    sw_i <= x"0000";
    pb_i <= x"0";
    led_i <= x"0000";
    wait for 20 ms;
    reset_i <= '0';
    dig0_i <= x"AA";
    dig1_i <= x"AB";
    dig2_i <= x"AC";
    dig3_i <= x"AD";
    sw_i <= x"03AB";
    pb_i <= x"3";
    led_i <= x"3333";
    wait for 15 ms;
    reset_i <= '0';
    dig0_i <= x"12";
    dig1_i <= x"23";
    dig2_i <= x"34";
    dig3_i <= x"45";
    sw_i <= x"21FF";
    pb_i <= x"A";
    led_i <= x"7FFF";
    wait for 15 ms;
  end process;

end sim;

