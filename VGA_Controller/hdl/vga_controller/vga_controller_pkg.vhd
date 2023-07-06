-------------------------------------------------------------------------------
--                        VGA Controller - Project
-------------------------------------------------------------------------------
-- ENTITY:         vga_controller_pkg
-- FILENAME:       vga_controller_pkg.vhd
-- ARCHITECTURE:   package
-- ENGINEER:       Jonas Berger
-- DATE:           19.09.2022
-- VERSION:        1.0
-------------------------------------------------------------------------------
-- DESCRIPTION:    This a package declaration used for the VGA Controller
-------------------------------------------------------------------------------
-- REFERENCES:     (none)
-------------------------------------------------------------------------------
-- PACKAGES:       std_logic_1164  (IEEE library)
-------------------------------------------------------------------------------
-- CHANGES:        Version 1.0 - JB - 19.09.2022
-- ADDITIONAL
-- COMMENTS:       -
-------------------------------------------------------------------------------
library IEEE; 
use IEEE.std_logic_1164.all;

package vga_controller_pkg is

  component prescaler
  port(
        clk_in1  : in  std_logic;
        clk_out1 : out std_logic;
        reset    : in  std_logic;
        locked   : out std_logic
      );
  end component prescaler;
  
  component vga_cntrl
  port(
        clk_i   : in  std_logic;                    
        px_en_i : in  std_logic;                    
        
        reset_i : in  std_logic;                    
        
        red_i   : in  std_logic_vector(3 downto 0);
        green_i : in  std_logic_vector(3 downto 0);
        blue_i  : in  std_logic_vector(3 downto 0);
        
        hpos_o  : out std_logic_vector(9 downto 0);
        vpos_o  : out std_logic_vector(9 downto 0);
        
        red_o   : out std_logic_vector(3 downto 0); 
        green_o : out std_logic_vector(3 downto 0); 
        blue_o  : out std_logic_vector(3 downto 0); 
       
        h_sync_o : out std_logic;
        v_sync_o : out std_logic
      );
  end component vga_cntrl;
  
  component io_logic
  generic (
        G_BTN_CNT : natural;
        G_SW_CNT  : natural
      );
  port(
        clk_i     : in   STD_LOGIC;
        reset_i   : in   STD_LOGIC;
        pb_i      : in   STD_LOGIC_VECTOR(3 downto 0);
        sw_i      : in   STD_LOGIC_VECTOR(3 downto 0);
        pb_sync_o : out  STD_LOGIC_VECTOR(3 downto 0);
        sw_sync_o : out  STD_LOGIC_VECTOR(3 downto 0)
      );
  end component io_logic;
  
  component src_mux
  port(
        sw_sync_i       : in  std_logic_vector (2 downto 0);
        mov_img_flag_i  : in  std_logic;
        rgb_patgen1_i   : in  std_logic_vector(11 downto 0);
        rgb_patgen2_i   : in  std_logic_vector(11 downto 0);
        rgb_rom1_i      : in  std_logic_vector(11 downto 0);
        rgb_rom2_i      : in  std_logic_vector(11 downto 0);
        rgb_vga_cntrl_o : out std_logic_vector(11 downto 0)
      );
  end component src_mux;
  
  component patgen1
  generic(
        G_SCREEN_WIDTH : natural;
        G_COL_CNT      : natural
      );
  port(
        clk_i   : in  std_logic;                                     
        reset_i : in  std_logic;                    
        hpos_i  : in  std_logic_vector(9 downto 0); 
        red_o   : out std_logic_vector(3 downto 0); 
        green_o : out std_logic_vector(3 downto 0); 
        blue_o  : out std_logic_vector(3 downto 0)
      );
  end component patgen1;
  
  component patgen2
  generic(
        G_SCREEN_WIDTH  : natural;
        G_SCREEN_HEIGHT : natural
      );
  port(
        clk_i    : in  std_logic;                   
        reset_i  : in  std_logic;                   
        hpos_i   : in  std_logic_vector(9 downto 0); 
        vpos_i   : in  std_logic_vector(9 downto 0); 
        red_o    : out std_logic_vector(3 downto 0); 
        green_o  : out std_logic_vector(3 downto 0); 
        blue_o   : out std_logic_vector(3 downto 0)  
      );
  end component patgen2;
  
  component rom1
  port (
        clka  : in  std_logic;
        addra : in  std_logic_vector(16 downto 0);
        douta : out std_logic_vector(11 downto 0)
  );
  end component rom1;
  
  component rom1_cntrl
  generic(
        G_SCREEN_WIDTH : natural
  );
  port(
        clk_i      : in  std_logic;                     
        reset_i    : in  std_logic;                     
        
        hpos_i     : in  std_logic_vector (9 downto 0);   
        vpos_i     : in  std_logic_vector (9 downto 0);
        rom_data_i : in  std_logic_vector(11 downto 0);
        
        rom_addr_o : out std_logic_vector(16 downto 0); 
        red_o      : out std_logic_vector (3 downto 0);  
        green_o    : out std_logic_vector (3 downto 0);  
        blue_o     : out std_logic_vector (3 downto 0)   
  );
  end component rom1_cntrl;
  
  component rom2
  port (
    clka  : in  std_logic;
    addra : in  std_logic_vector(13 downto 0);
    douta : out std_logic_vector(11 downto 0)
  );
  end component rom2;

  component rom2_cntrl
  generic(
        G_SCREEN_WIDTH  : natural;
        G_SCREEN_HEIGHT : natural
  );
  port(
        clk_i      : in  std_logic;                     
        reset_i    : in  std_logic;                     
        
        hpos_i     : in  std_logic_vector (9 downto 0);   
        vpos_i     : in  std_logic_vector (9 downto 0);
        rom_data_i : in  std_logic_vector(11 downto 0);
        uC_i       : in  std_logic_vector (7 downto 0);
        sw_i       : in  std_logic;
        pb_i       : in  std_logic_vector (3 downto 0);
        
        rom_addr_o : out std_logic_vector(13 downto 0); 
        red_o      : out std_logic_vector (3 downto 0);  
        green_o    : out std_logic_vector (3 downto 0);  
        blue_o     : out std_logic_vector (3 downto 0);
        
        mov_img_flag_o : out std_logic
  );
  end component rom2_cntrl;

end vga_controller_pkg;
