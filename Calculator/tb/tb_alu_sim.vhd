-------------------------------------------------------------------------------
--                        Calculator - Project
-------------------------------------------------------------------------------
-- ENTITY:         tb_alu
-- FILENAME:       tb_alu_sim.vhd
-- ARCHITECTURE:   rtl
-- ENGINEER:       Jonas Berger
-- DATE:           10.03.2022
-- VERSION:        1.0
-------------------------------------------------------------------------------
-- DESCRIPTION:    This is the architecture of the alu testbench
--                 for the Calculator-Project.
-------------------------------------------------------------------------------
-- REFERENCES:     (none)
-------------------------------------------------------------------------------
-- PACKAGES:       std_logic_1164 (IEEE library)
-------------------------------------------------------------------------------
-- CHANGES:        Version 1.0 - JB - 10.03.2022
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

architecture sim of tb_alu is
  
  component alu
  port (clk_i      :  in std_logic;
        reset_i    :  in std_logic;
        
        start_i    :  in std_logic;
        
        op1_i      :  in std_logic_vector(11 downto 0);
        op2_i      :  in std_logic_vector(11 downto 0);
        optype_i   :  in std_logic_vector (3 downto 0);
        
        result_o   : out std_logic_vector(15 downto 0);
        
        finished_o : out std_logic;
        sign_o     : out std_logic;
        overflow_o : out std_logic;
        error_o    : out std_logic);
  end component alu;
  
  -- Declare the signals used stimulating the design's inputs.
  signal   clk_i      : std_logic;
  signal   reset_i    : std_logic;
  signal   start_i    : std_logic;
  signal   op1_i      : std_logic_vector(11 downto 0);
  signal   op2_i      : std_logic_vector(11 downto 0);
  signal   optype_i   : std_logic_vector (3 downto 0);
  signal   result_o   : std_logic_vector(15 downto 0);
  signal   finished_o : std_logic;
  signal   sign_o     : std_logic;
  signal   overflow_o : std_logic;
  signal   error_o    : std_logic;
  
  -- Clock period definitions
  constant clk_period : time := 10 ns;
  
begin
  -- Instantiate the io_ctrl design for testing
  -- Port map declaration for alu
  i_alu : alu
  port map (clk_i      => clk_i,
            reset_i    => reset_i,
            start_i    => start_i,
            op1_i      => op1_i,
            op2_i      => op2_i,
            optype_i   => optype_i,
            result_o   => result_o,
            finished_o => finished_o,
            sign_o     => sign_o,
            overflow_o => overflow_o,
            error_o    => error_o
  );
  
  -- Clock process definitions
  clk_p : process
  begin
    clk_i <= '0';
    wait for clk_period/2;
    clk_i <= '1';
    wait for clk_period/2;
  end process;
  
  reset_i_p : process
  begin
    reset_i <= '1';
    wait for clk_period*4;
    reset_i <= '0';
    wait for clk_period*650;
  end process;

  test_p : process
  begin
    op1_i <= x"000";
    op2_i <= x"000";
    optype_i <= "0000";
    wait for clk_period*4;
    op1_i <= x"024";
    op2_i <= x"011";
    optype_i <= "0000"; -- ADD 1 - normal calculation
    wait for clk_period*50;
    op1_i <= x"FFF";
    op2_i <= x"FFF";
    optype_i <= "0000"; -- ADD 2 - test limit
    wait for clk_period*50;
    op1_i <= b"1001_1001_0110";
    op2_i <= b"0010_0100_0100";
    optype_i <= "1000"; -- LNOT
    wait for clk_period*50;
    op1_i <= b"1001_1001_0110";
    op2_i <= b"0010_0100_0100";
    optype_i <= "1011"; -- LXOR
    wait for clk_period*50;
    op1_i <= x"196";
    op2_i <= x"244";
    optype_i <= "0010"; -- MULTIPLY 1 - with overflow
    wait for clk_period*190; -- ~1800ns max multiply time
    op1_i <= x"005";
    op2_i <= x"004";
    optype_i <= "0010"; -- MULTIPLY 2 - no overflow
    wait for clk_period*240;
  end process;
  
  start_i_p : process
  begin
    start_i <= '0';
    wait for clk_period*25;
    start_i <= '1';
    wait for clk_period;
  end process;

end sim;
