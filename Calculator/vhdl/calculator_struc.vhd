-------------------------------------------------------------------------------
--                        Calculator - Project
-------------------------------------------------------------------------------
-- ENTITY:         calculator
-- FILENAME:       calculator_struc.vhd
-- ARCHITECTURE:   struc
-- ENGINEER:       Jonas Berger
-- DATE:           09.03.2022
-- VERSION:        1.0
-------------------------------------------------------------------------------
-- DESCRIPTION:    This is the architecture struc of the Calculator-Project.
-------------------------------------------------------------------------------
-- REFERENCES:     (none)
-------------------------------------------------------------------------------
-- PACKAGES:       std_logic_1164 (IEEE library)
-------------------------------------------------------------------------------
-- CHANGES:        Version 1.0 - JB - 09.03.2022
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

architecture struc of calculator is

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
  end component io_ctrl;
  
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
  end component calc_ctrl;
  
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

  -- Declare the signals used for interconnection of the submodules.
  signal s_swsync   : std_logic_vector(15 downto 0);
  signal s_pbsync   : std_logic_vector (3 downto 0);
  signal s_dig3     : std_logic_vector (7 downto 0);
  signal s_dig2     : std_logic_vector (7 downto 0);
  signal s_dig1     : std_logic_vector (7 downto 0);
  signal s_dig0     : std_logic_vector (7 downto 0);
  signal s_led      : std_logic_vector(15 downto 0);
  
  signal s_op1      : std_logic_vector(11 downto 0);
  signal s_op2      : std_logic_vector(11 downto 0);
  signal s_optype   : std_logic_vector (3 downto 0);
  signal s_start    : std_logic;
  signal s_finished : std_logic;
  signal s_result   : std_logic_vector(15 downto 0);
  signal s_sign     : std_logic;
  signal s_overflow : std_logic;
  signal s_error    : std_logic;

begin

  -- Instantiate the IO control unit
  i_io_ctrl : io_ctrl
  port map 
    (clk_i    => clk_i,
     reset_i  => reset_i,
     sw_i     => sw_i,
     pb_i     => pb_i,
     dig0_i   => s_dig0,
     dig1_i   => s_dig1,
     dig2_i   => s_dig2,
     dig3_i   => s_dig3,
     led_i    => s_led,
     ss_o     => ss_o,
     ss_sel_o => ss_sel_o,
     led_o    => led_o,
     swsync_o => s_swsync,
     pbsync_o => s_pbsync);


  -- Instantiate the calculation control unit
  i_calc_ctrl : calc_ctrl
  port map 
    (clk_i      => clk_i,
     reset_i    => reset_i,
     result_i   => s_result,
     finished_i => s_finished,
     sign_i     => s_sign,
     overflow_i => s_overflow,
     error_i    => s_error,
     swsync_i   => s_swsync,
     pbsync_i   => s_pbsync,
     start_o    => s_start,
     op1_o      => s_op1,
     op2_o      => s_op2,
     optype_o   => s_optype,
     dig0_o     => s_dig0,
     dig1_o     => s_dig1,
     dig2_o     => s_dig2,
     dig3_o     => s_dig3,
     led_o      => s_led);


  -- Instantiate the ALU
  i_alu : alu
  port map 
    (clk_i      => clk_i,
     reset_i    => reset_i,
     start_i    => s_start,
     op1_i      => s_op1,
     op2_i      => s_op2,
     optype_i   => s_optype,
     result_o   => s_result,
     finished_o => s_finished,
     sign_o     => s_sign,
     overflow_o => s_overflow,
     error_o    => s_error);

end struc;
