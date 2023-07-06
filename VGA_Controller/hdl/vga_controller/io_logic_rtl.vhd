-------------------------------------------------------------------------------
--                        VGA Controller - Project
-------------------------------------------------------------------------------
-- ENTITY:         io_logic
-- FILENAME:       io_logic_rtl.vhd
-- ARCHITECTURE:   rtl
-- ENGINEER:       Jonas Berger
-- DATE:           27.09.2022
-- VERSION:        1.0
-------------------------------------------------------------------------------
-- DESCRIPTION:    This is the architecture rtl of the IO Logic
-------------------------------------------------------------------------------
-- REFERENCES:     (none)
-------------------------------------------------------------------------------
-- PACKAGES:       std_logic_1164  (IEEE library)
-------------------------------------------------------------------------------
-- CHANGES:        Version 1.0 - JB - 27.09.2022
-- ADDITIONAL
-- COMMENTS:       -
-------------------------------------------------------------------------------

architecture rtl of io_logic is

  -- *** Component insertions ***
  -- insert debounce module
  component debounce
    port ( clk_i   : in  STD_LOGIC;
           reset_i : in  STD_LOGIC;
           tick_i  : in  STD_LOGIC;    
           sw_i    : in  STD_LOGIC;      
           swout_o : out  STD_LOGIC);
  end component debounce;
  
  -- *** Type definitions ***
  -- every 25 000 counts one tick (25MHz/1kHz):
  type t_tick_counter_type is range 24999 downto 0;    -- define new type
  signal s_tickcounter : t_tick_counter_type;          -- define s_signal with new type
  constant C_max1khz : t_tick_counter_type := 24999;
  
  -- *** Intermediate s_signal definitions ***
  signal s_1khzen : std_logic; -- enable s_signal for debounce
  
  signal s_pbsync  : std_logic_vector(G_BTN_CNT-1 downto 0);
  signal s_pb_sync : std_logic_vector(G_BTN_CNT-1 downto 0);
  signal s_sig       : std_logic_vector(G_BTN_CNT-1 downto 0);
  signal s_sw_sync : std_logic_vector(G_SW_CNT-1 downto 0);

begin

  -- Tick counter process to achieve a 1kHz tick s_signal
  P_tick_1kHz_counter : process(clk_i, reset_i)
  begin
    if reset_i = '1' then
       s_tickcounter <= C_max1khz;
       s_1khzen <= '0';
    elsif clk_i'event and clk_i = '1' then
      if s_tickcounter = 0 then
        s_tickcounter <= C_max1khz;
        s_1khzen <= '1';
      else
        s_tickcounter <= s_tickcounter - 1;
        s_1khzen <= '0';
      end if;
    end if;
  end process;
  
  -- Debounce buttons and switches using generate
  GEN_sw_debouncers : for i in 0 to G_SW_CNT-1 generate
    i_debounce_sw : debounce
      port map 
        (clk_i   => clk_i,
         reset_i => reset_i,
         tick_i  => s_1khzen,
         sw_i    => sw_i(i),
         swout_o => s_sw_sync(i));
  end generate GEN_sw_debouncers;
  
  sw_sync_o <= s_sw_sync;
  
  GEN_btn_debouncers : for i in 0 to G_BTN_CNT-1 generate
    i_debounce_btn : debounce
      port map 
        (clk_i   => clk_i,
         reset_i => reset_i,
         tick_i  => s_1khzen,
         sw_i    => pb_i(i),
         swout_o => s_pbsync(i));
  end generate GEN_btn_debouncers;
  
  -- Button to tick process: Converts respective button push in one clk_period impulse
  P_btn2tick: process(clk_i, reset_i)
  begin
    if reset_i = '1' then
       s_pb_sync <= (others => '0');
       s_sig <= (others => '0');
    elsif clk_i'event and clk_i = '1' then
      for i in 0 to G_BTN_CNT-1 loop
        if s_sig(i) = '0' and s_pbsync(i) = '1' then
          s_pb_sync(i) <= not s_pb_sync(i);
          s_sig(i) <= '1';
        else
          s_pb_sync(i) <= '0';
          s_sig(i) <= s_pbsync(i);
        end if;
      end loop;
    end if;
  end process;
  
  pb_sync_o <= s_pb_sync;

end rtl;
