----------------------------------------------------------------------------------
-- Engineer:       Berger Jonas
-- Create Date:    10.04.2022 
-- Design Name:    VGA_Treiber
-- Module Name:    vga_driver - rtl 
-- Project Name:   VGA Treiber
-- Revision:       V1.0
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity vga_driver is
    Generic ( CLK25_CNT : integer := 100*10**6/4 );
    Port ( clk_i : in  STD_LOGIC;
           reset_i : in  STD_LOGIC;
           HSYNC_o : out  STD_LOGIC;
           VSYNC_o : out  STD_LOGIC;
           RGB_o : out  STD_LOGIC_VECTOR (2 downto 0));
end vga_driver;

architecture rtl of vga_driver is
  
  -- Define constants
  constant HD  : natural := 639;  -- 639  Horizontal Display (640)
  constant HFP : natural :=  16;  --  16  Right border (front porch)
  constant HSP : natural :=  96;  --  96  Sync pulse (Retrace)
  constant HBP : natural :=  48;  --  48  Left boarder (back porch)
  
  constant VD  : natural := 479;  -- 479  Vertical Display (480)
  constant VFP : natural :=  10;  --  10  Right border (front porch)
  constant VSP : natural :=   2;  --   2  Sync pulse (Retrace)
  constant VBP : natural :=  33;  --  33  Left boarder (back porch)

  -- Define signals
  signal clk25 : std_logic;
  
  signal hpos : integer;
  signal vpos : integer;
  
  signal video_on : std_logic;

begin
  
  -- Divide clock from 100MHz to 25MHz
  clk_div_25MHz_p : process(clk_i, reset_i)
    variable count : integer range 0 to CLK25_CNT;
  begin
    if reset_i = '1' then
       count := CLK25_CNT;
       clk25 <= '0';
    elsif clk_i'event and clk_i = '1' then
       if count = 0 then
         count := CLK25_CNT;
         clk25 <= '1';
       else
         count := count - 1;
         clk25 <= '0';
       end if;
    end if;
  end process;
  
  -- Horizontal counter process
  horizontal_pos_counter_p : process(clk_i, reset_i)
  begin
    if reset_i = '1' then
      hpos <= 0;
    elsif clk_i'event and clk_i = '1' then
      if clk25 = '1' then
        if hpos = (HD + HFP + HSP + HBP) then
          hpos <= 0;
        else
          hpos <= hpos + 1;
        end if;
      end if;
    
    end if;
  end process;
  
  -- Vertical counter process
  vertical_pos_counter_p : process(clk_i, reset_i, hpos)
  begin
    if reset_i = '1' then
      vpos <= 0;
    elsif clk_i'event and clk_i = '1' then
      if clk25 = '1' then
        if hpos = (HD + HFP + HSP + HBP) then
          if vpos = (VD + VFP + VSP + VBP) then
            vpos <= 0;
          else
            vpos <= vpos + 1;
          end if;
        end if;
      end if;
    end if;
  end process;
  
  -- Horizontal synchronization process
  horizontal_sync_p : process(clk_i, reset_i, hpos)
  begin
    if reset_i = '0' then   
      HSYNC_o <= '0';
    elsif clk_i'event and clk_i = '1' then
      if clk25 = '1' then
        if (hpos <= (HD + HFP)) or (hpos > (HD + HFP + HSP)) then
          HSYNC_o <= '1';
        else
          HSYNC_o <= '0';
        end if;
      end if;
    end if;
  end process;
  
  -- Vertical synchronization process
  vertical_sync_p : process(clk_i, reset_i, vpos)
  begin
    if reset_i = '0' then   
      VSYNC_o <= '0';
    elsif clk_i'event and clk_i = '1' then
      if clk25 = '1' then
        if (vpos <= (VD + VFP)) or (vpos > (VD + VFP + VSP)) then
          VSYNC_o <= '1';
        else
          VSYNC_o <= '0';
        end if;
      end if;
    end if;
  end process;
  
  -- Video on process
  video_on_p : process(clk_i, reset_i, hpos, vpos)
  begin
    if reset_i = '0' then   
      video_on <= '0';
    elsif clk_i'event and clk_i = '1' then
      if clk25 = '1' then
        if (hpos <= HD) and (vpos <= VD) then
          video_on <= '1';
        else
          video_on <= '0';
        end if;
      end if;
    end if;
  end process;
  
  -- Draw process - draws a simple square
  draw_p : process(clk_i, reset_i, hpos, vpos, video_on)
  begin
    if reset_i = '0' then   
      RGB_o <= "000";
    elsif clk_i'event and clk_i = '1' then
      if clk25 = '1' then
        if video_on = '1' then
          if ((hpos >= 10) and (hpos <= 60)) and ((vpos >= 10) and (vpos <= 60)) then
            RGB_o <= "111";
          else
            RGB_o <= "000";
          end if;
        else
          RGB_o <= "000";
        end if;
      end if;
    end if;
  end process;

end rtl;

