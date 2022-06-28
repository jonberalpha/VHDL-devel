-------------------------------------------------------------------------------
--                        Calculator - Project
-------------------------------------------------------------------------------
-- ENTITY:         io_ctrl
-- FILENAME:       io_ctrl_rtl.vhd
-- ARCHITECTURE:   rtl
-- ENGINEER:       Jonas Berger
-- DATE:           06.03.2022
-- VERSION:        1.0
-------------------------------------------------------------------------------
-- DESCRIPTION:    This is the architecture rtl of the io_ctrl submodule
--                 of the Calculator-Project.
-------------------------------------------------------------------------------
-- REFERENCES:     (none)
-------------------------------------------------------------------------------
-- PACKAGES:       std_logic_1164  (IEEE library)
--                 numeric_std     (numeric library)
-------------------------------------------------------------------------------
-- CHANGES:        Version 1.0 - JB - 06.03.2022
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.ALL;

architecture rtl of io_ctrl is

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
  -- every 100 000 counts one tick (100MHz/1kHz):
  type tick_counter_type is range 99999 downto 0;    -- define new type
  signal tickcounter: tick_counter_type;             -- define signal with new type
  constant max1khz: tick_counter_type := 99999;
  
  -- *** Intermediate signal definitions ***
  signal s_1khzen : std_logic; -- enable signal for the 7-segment-displays
  
  signal swsync   : std_logic_vector(15 downto 0); -- synchronized sw-buttons
  signal pbsync   : std_logic_vector (3 downto 0); -- synchronized pb-buttons
  signal s_pbsync : std_logic_vector (3 downto 0);
  signal sig      : std_logic_vector (3 downto 0);
  
  signal s_ss_sel : std_logic_vector (3 downto 0); -- display select signal
  signal s_ss     : std_logic_vector (7 downto 0); -- display value signal
  
  signal cnt_an: unsigned(1 downto 0); -- counter variable

begin

  -- Tick counter process to achieve a 1kHz tick signal
  tick_1kHz_counter_p : process(clk_i, reset_i)
  begin
    if reset_i = '1' then
       tickcounter <= max1khz;
       s_1khzen <= '0';
    elsif clk_i'event and clk_i = '1' then
      if tickcounter = 0 then
        tickcounter <= max1khz;
        s_1khzen <= '1';
      else
        tickcounter <= tickcounter - 1;
        s_1khzen <= '0';
      end if;
    end if;
  end process;
  
  -- Debounce buttons and switches using generate
  gen_btn_debouncers : for i in 0 to button_count-1 generate
    i_debounce_btn : debounce
    port map 
      (clk_i   => clk_i,
       reset_i => reset_i,
       tick_i  => s_1khzen,
       sw_i    => pb_i(i),
       swout_o => s_pbsync(i));
  end generate gen_btn_debouncers;
  
  gen_sw_debouncers : for i in 0 to switch_count-1 generate
    i_debounce_sw : debounce
    port map 
      (clk_i   => clk_i,
       reset_i => reset_i,
       tick_i  => s_1khzen,
       sw_i    => sw_i(i),
       swout_o => swsync(i));
  end generate gen_sw_debouncers;
  
  swsync_o <= swsync;
  
  -- Button to tick process: Converts respective button push in one clk_period impulse
  btn2tick_p: process(clk_i, reset_i)
  begin
    if reset_i = '1' then
       pbsync <= (others => '0');
       sig <= (others => '0');
    elsif clk_i'event and clk_i = '1' then
      for i in 0 to 3 loop
        if sig(i) = '0' and s_pbsync(i) = '1' then
          pbsync(i) <= not pbsync(i);
          sig(i) <= '1';
        else
          pbsync(i) <= '0';
          sig(i) <= s_pbsync(i);
        end if;
      end loop;
    end if;
  end process;
  
  pbsync_o <= pbsync;
  
  -- Segment process
  -- Display Controller part: controls the 7-segment-displays
  -- Counter part: 0-3 Counter
  segment_p : process(clk_i,reset_i)
  begin
    if reset_i = '1' then
       cnt_an <= "00";
       -- reset state: displays are off (active low)
       s_ss_sel <= (others => '1');
       s_ss <= (others => '1');
    elsif clk_i'event and clk_i = '1' then 
      if s_1khzen = '1' then
         if cnt_an = "11" then -- 2 bit counter
            cnt_an <= "00";
         else
            cnt_an <= cnt_an + 1;
         end if;
         
         case cnt_an is 
           when "00" =>              -- 1. 7-Seg-display
             s_ss_sel <= "0111";
             s_ss <= dig0_i;
      
           when "01" =>              -- 2. 7-Seg-display
             s_ss_sel <= "1011";
             s_ss <= dig1_i;
      
           when "10" =>              -- 3. 7-Seg-display
             s_ss_sel <= "1101";
             s_ss <= dig2_i;
      
           when "11" =>              -- 4. 7-Seg-display
             s_ss_sel <= "1110";
             s_ss <= dig3_i;
      
           when others =>
             s_ss_sel <= "1111";
         end case;  
      end if;
    end if;
  end process;
  
  ss_o <= s_ss;
  ss_sel_o <= s_ss_sel;
  
  -- Handle 16 leds: takeover led_i signal to led_o signal
  led_o <= led_i;
  
end rtl;
