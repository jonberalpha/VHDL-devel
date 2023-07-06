-------------------------------------------------------------------------------
--                        VGA Controller - Project
-------------------------------------------------------------------------------
-- ENTITY:         tb_vga_controller
-- FILENAME:       tb_vga_controller_sim.vhd
-- ARCHITECTURE:   rtl
-- ENGINEER:       Jonas Berger
-- DATE:           20.09.2022
-- VERSION:        1.0
-------------------------------------------------------------------------------
-- DESCRIPTION:    This is the architecture of the VGA Controller testbench
--                 for the VGA Controller - Project
-------------------------------------------------------------------------------
-- REFERENCES:     (none)
-------------------------------------------------------------------------------
-- PACKAGES:       std_logic_1164 (IEEE library)
-------------------------------------------------------------------------------
-- CHANGES:        Version 1.0 - JB - 20.09.2022
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

architecture sim of tb_vga_controller is

  component fpga_top
      port (clk_i   : in  std_logic;                    
            reset_i : in  std_logic;                    
            
            pb_i    : in  std_logic_vector(3 downto 0);
            sw_i    : in  std_logic_vector(3 downto 0);
            
            red_o   : out std_logic_vector(3 downto 0); 
            green_o : out std_logic_vector(3 downto 0); 
            blue_o  : out std_logic_vector(3 downto 0); 
            
            h_sync_o : out std_logic;
            v_sync_o : out std_logic;
            
            led_o : out std_logic_vector(7 downto 0)
           );
  end component fpga_top;
  
  component vga_monitor is
    generic(
        g_no_frames : integer range 1 to 99;
        g_path      : string
      );
    port(
        s_reset_i     : in std_logic;
        s_vga_red_i   : in std_logic_vector(3 downto 0);
        s_vga_green_i : in std_logic_vector(3 downto 0);
        s_vga_blue_i  : in std_logic_vector(3 downto 0);
        s_vga_hsync_i : in std_logic;
        s_vga_vsync_i : in std_logic);
  end component vga_monitor;
  
  -- Declare the signals used stimulating the design's inputs.
  signal   s_clk    : std_logic;
  signal   s_reset  : std_logic;
  signal   s_red    : std_logic_vector(3 downto 0);
  signal   s_green  : std_logic_vector(3 downto 0);
  signal   s_blue   : std_logic_vector(3 downto 0);
  signal   s_h_sync : std_logic;
  signal   s_v_sync : std_logic;
  signal   s_pb     : std_logic_vector(3 downto 0);
  signal   s_sw     : std_logic_vector(3 downto 0);
  signal   s_led_o  : std_logic_vector(7 downto 0);
  
  -- Clock period definitions
  constant C_CLK_PERIOD : time := 10 ns;
  
begin

  -- Instantiate the calculator design for testing
  i_fpga_top : fpga_top
  port map 
    (clk_i    => s_clk,
     reset_i  => s_reset,
     pb_i     => s_pb,
     sw_i     => s_sw,
     red_o    => s_red,
     green_o  => s_green,
     blue_o   => s_blue,
     h_sync_o => s_h_sync,
     v_sync_o => s_v_sync,
     led_o    => s_led_o
    );
  
  i_vga_monitor : vga_monitor
  generic map (
               g_no_frames => 1,
               g_path      => "../tb/vga_output/"
  )
  port map (
            s_reset_i     => s_reset,
            s_vga_red_i   => s_red,
            s_vga_green_i => s_green,
            s_vga_blue_i  => s_blue,
            s_vga_hsync_i => s_h_sync,
            s_vga_vsync_i => s_v_sync
  );
     
  -- Clock process definitions
  P_clk : process
  begin
    s_clk <= '0';
    wait for C_CLK_PERIOD/2;
    s_clk <= '1';
    wait for C_CLK_PERIOD/2;
  end process;

  P_test : process
  begin
    s_reset <= '1';
    s_pb <= (others => '0');
    s_sw <= "0001";
    wait for 100 ns;
    s_reset <= '0';
    wait;
  end process;

end sim;

