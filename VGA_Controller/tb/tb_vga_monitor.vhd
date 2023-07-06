library IEEE;
use IEEE.std_logic_1164.all;

entity tb_vga_monitor is
end tb_vga_monitor;

architecture sim of tb_vga_monitor is
  
  component vga_cntrl
    port
      (clk_i   : in  std_logic;                    
       px_en_i : in  std_logic;                    
        
       reset_i : in  std_logic;                    
        
       red_i   : in std_logic_vector(3 downto 0); 
       green_i : in std_logic_vector(3 downto 0); 
       blue_i  : in std_logic_vector(3 downto 0); 
        
       hpos_o : out std_logic_vector (9 downto 0); 
       vpos_o : out std_logic_vector (9 downto 0); 
        
       red_o   : out std_logic_vector(3 downto 0); 
       green_o : out std_logic_vector(3 downto 0); 
       blue_o  : out std_logic_vector(3 downto 0); 
       
       h_sync_o : out std_logic;
       v_sync_o : out std_logic);
  end component vga_cntrl;
  
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
      s_vga_vsync_i : in std_logic
      ); 
  end component vga_monitor;

  -- Declare the signals used stimulating the design's inputs.
  signal clk_i              : std_logic;
  signal reset_i            : std_logic;
  
  signal s_h_sync           : std_logic;
  signal s_v_sync           : std_logic;
  
  signal s_red   : std_logic_vector(3 downto 0);
  signal s_green : std_logic_vector(3 downto 0);
  signal s_blue  : std_logic_vector(3 downto 0);
  
  
  -- Clock period definitions
  constant clk_period : time := 40 ns;

begin

  -- Instantiate the designs for testing
     comp_vga_cntrl : vga_cntrl
      port map (
                clk_i    => clk_i,
                px_en_i  => '1',
                reset_i  => reset_i,
                red_i    => x"F",
                green_i  => x"F",
                blue_i   => x"F",
                hpos_o   => open,
                vpos_o   => open,
                red_o    => s_red,
                green_o  => s_green,
                blue_o   => s_blue,
                h_sync_o => s_h_sync,
                v_sync_o => s_v_sync
   );

  
   comp_vga_monitor : vga_monitor
    generic map (
                 g_no_frames => 1,
                 g_path      => "../tb/vga_output/"
   )
    port map (
              s_reset_i     => reset_i,
              s_vga_red_i   => s_red,
              s_vga_green_i => s_green,
              s_vga_blue_i  => s_blue,
              s_vga_hsync_i => s_h_sync,
              s_vga_vsync_i => s_v_sync
   );
   
  -- Clock process definitions
  clk_p : process
  begin
    clk_i <= '0';
    wait for clk_period/2;
    clk_i <= '1';
    wait for clk_period/2;
  end process;  
  
  vga_monitor_p : process
    begin
    -- Initial states of all input ports and reset signal
    reset_i <= '1';
    wait for 100 ns;
    -- Deassert reset
    reset_i <= '0';
    wait;
  end process vga_monitor_p;

end sim;
