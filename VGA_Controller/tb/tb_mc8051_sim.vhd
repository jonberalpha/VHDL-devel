architecture sim of tb_mc8051 is

  component fpga_top is
    port(
        clk_i   : in  std_logic;                    
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
  
  signal   clk_i    : std_logic := '0'; -- clock signal coming from oscillator
  signal   reset_i  : std_logic := '0'; -- reset signal coming from reset button BTNC  
  signal   pb_i     : std_logic_vector(3 downto 0);
  signal   sw_i     : std_logic_vector(3 downto 0);
  signal   red_o    : std_logic_vector(3 downto 0);
  signal   green_o  : std_logic_vector(3 downto 0);
  signal   blue_o   : std_logic_vector(3 downto 0);
  signal   h_sync_o : std_logic;
  signal   v_sync_o : std_logic;
  signal   led_o    : std_logic_vector(7 downto 0); -- LEDs LED0 - LED7

  
begin
 
  i_fpga_top : fpga_top
    port map (
      clk_i    => clk_i,
      reset_i  => reset_i,
      pb_i     => pb_i,
      sw_i     => sw_i,
      red_o    => red_o,
      green_o  => green_o,
      blue_o   => blue_o,
      h_sync_o => h_sync_o,
      v_sync_o => v_sync_o,
      led_o    => led_o
    );

  clk_i   <= not clk_i after 5 ns; -- 100 MHz clock
  reset_i <= '1', '0' after 50 ns; -- generate reset after power-up

end;
