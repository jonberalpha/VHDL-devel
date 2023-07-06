#################################################################
# compile simulation models of generated PLL, ROM1, ROM2, ROM and RAM of MC8051
#################################################################
# copy .mif file (which holds content of ROM) into ModelSim simulation directory
file copy -force ../generate/rom1/rom1/rom1.mif ./
file copy -force ../generate/rom2/rom2/rom2.mif ./

vlog ../generate/prescaler/prescaler/prescaler_clk_wiz.v
vlog ../generate/prescaler/prescaler/prescaler.v
vlog ../generate/rom1/rom1/blk_mem_gen_v8_3_2/simulation/blk_mem_gen_v8_3.v
vcom ../generate/rom1/rom1/synth/rom1.vhd
vcom ../generate/rom2/rom2/synth/rom2.vhd

vlog ../generate/mc8051_rom/mc8051_rom/blk_mem_gen_v8_3_2/simulation/blk_mem_gen_v8_3.v
vcom ../generate/mc8051_rom/mc8051_rom/synth/mc8051_rom.vhd
vcom ../generate/mc8051_ram/mc8051_ram/synth/mc8051_ram.vhd

#################################################################
# compile Xilinx GLBL module (required for proper initialization
# of all generated  Xilinx macros during simulation)
#################################################################
vlog ../generate/glbl.v

#################################################################
# compile packages and submodules of the VGA Controller
#################################################################
vcom ../hdl/vga_controller/vga_controller_pkg.vhd

vcom ../hdl/vga_controller/vga_cntrl_.vhd
vcom ../hdl/vga_controller/vga_cntrl_rtl.vhd
vcom ../hdl/vga_controller/vga_cntrl_rtl_cfg.vhd

vcom ../hdl/vga_controller/debounce_.vhd
vcom ../hdl/vga_controller/debounce_rtl.vhd
vcom ../hdl/vga_controller/debounce_rtl_cfg.vhd

vcom ../hdl/vga_controller/io_logic_.vhd
vcom ../hdl/vga_controller/io_logic_rtl.vhd
vcom ../hdl/vga_controller/io_logic_rtl_cfg.vhd

vcom ../hdl/vga_controller/src_mux_.vhd
vcom ../hdl/vga_controller/src_mux_rtl.vhd
vcom ../hdl/vga_controller/src_mux_rtl_cfg.vhd

vcom ../hdl/vga_controller/patgen1_.vhd
vcom ../hdl/vga_controller/patgen1_rtl.vhd
vcom ../hdl/vga_controller/patgen1_rtl_cfg.vhd

vcom ../hdl/vga_controller/patgen2_.vhd
vcom ../hdl/vga_controller/patgen2_rtl.vhd
vcom ../hdl/vga_controller/patgen2_rtl_cfg.vhd

vcom ../hdl/vga_controller/rom1_cntrl_.vhd
vcom ../hdl/vga_controller/rom1_cntrl_rtl.vhd
vcom ../hdl/vga_controller/rom1_cntrl_rtl_cfg.vhd

vcom ../hdl/vga_controller/rom2_cntrl_.vhd
vcom ../hdl/vga_controller/rom2_cntrl_rtl.vhd
vcom ../hdl/vga_controller/rom2_cntrl_rtl_cfg.vhd

#################################################################
# compile mc8051
#################################################################
vcom ../hdl/mc8051/mc8051_p.vhd
     
vcom ../hdl/mc8051/control_mem_.vhd
vcom ../hdl/mc8051/control_mem_rtl.vhd
vcom ../hdl/mc8051/control_mem_rtl_cfg.vhd
     
vcom ../hdl/mc8051/control_fsm_.vhd
vcom ../hdl/mc8051/control_fsm_rtl.vhd
vcom ../hdl/mc8051/control_fsm_rtl_cfg.vhd
     
vcom ../hdl/mc8051/mc8051_control_.vhd
vcom ../hdl/mc8051/mc8051_control_struc.vhd
vcom ../hdl/mc8051/mc8051_control_struc_cfg.vhd
     
vcom ../hdl/mc8051/alucore_.vhd
vcom ../hdl/mc8051/alucore_rtl.vhd
vcom ../hdl/mc8051/alucore_rtl_cfg.vhd
     
vcom ../hdl/mc8051/alumux_.vhd
vcom ../hdl/mc8051/alumux_rtl.vhd
vcom ../hdl/mc8051/alumux_rtl_cfg.vhd
     
vcom ../hdl/mc8051/addsub_cy_.vhd
vcom ../hdl/mc8051/addsub_cy_rtl.vhd
vcom ../hdl/mc8051/addsub_cy_rtl_cfg.vhd
     
vcom ../hdl/mc8051/addsub_ovcy_.vhd
vcom ../hdl/mc8051/addsub_ovcy_rtl.vhd
vcom ../hdl/mc8051/addsub_ovcy_rtl_cfg.vhd
     
vcom ../hdl/mc8051/addsub_core_.vhd
vcom ../hdl/mc8051/addsub_core_struc.vhd
vcom ../hdl/mc8051/addsub_core_struc_cfg.vhd
     
vcom ../hdl/mc8051/comb_divider_.vhd
vcom ../hdl/mc8051/comb_divider_rtl.vhd
vcom ../hdl/mc8051/comb_divider_rtl_cfg.vhd
     
vcom ../hdl/mc8051/comb_mltplr_.vhd
vcom ../hdl/mc8051/comb_mltplr_rtl.vhd
vcom ../hdl/mc8051/comb_mltplr_rtl_cfg.vhd
     
vcom ../hdl/mc8051/dcml_adjust_.vhd
vcom ../hdl/mc8051/dcml_adjust_rtl.vhd
vcom ../hdl/mc8051/dcml_adjust_rtl_cfg.vhd
     
vcom ../hdl/mc8051/mc8051_alu_.vhd
vcom ../hdl/mc8051/mc8051_alu_struc.vhd
vcom ../hdl/mc8051/mc8051_alu_struc_cfg.vhd
     
vcom ../hdl/mc8051/mc8051_siu_.vhd
vcom ../hdl/mc8051/mc8051_siu_rtl.vhd
vcom ../hdl/mc8051/mc8051_siu_rtl_cfg.vhd
     
vcom ../hdl/mc8051/mc8051_tmrctr_.vhd
vcom ../hdl/mc8051/mc8051_tmrctr_rtl.vhd
vcom ../hdl/mc8051/mc8051_tmrctr_rtl_cfg.vhd
     
vcom ../hdl/mc8051/mc8051_core_.vhd
vcom ../hdl/mc8051/mc8051_core_struc.vhd
vcom ../hdl/mc8051/mc8051_core_struc_cfg.vhd
  
vcom ../hdl/mc8051/mc8051_top_.vhd
vcom ../hdl/mc8051/mc8051_top_struc.vhd
vcom ../hdl/mc8051/mc8051_top_struc_cfg.vhd

#################################################################
# compile FPGA top-level design
#################################################################
vcom ../hdl/fpga_top_.vhd
vcom ../hdl/fpga_top_struc.vhd
vcom ../hdl/fpga_top_struc_cfg.vhd
     
#################################################################
# compile testbench
#################################################################
vcom ../tb/tb_vga_controller_.vhd
vcom ../tb/tb_vga_controller_sim.vhd
vcom ../tb/tb_vga_controller_sim_cfg.vhd

vcom ../tb/vga_monitor_.vhd
vcom ../tb/vga_monitor_sim.vhd
vcom ../tb/tb_vga_monitor.vhd

vcom ../tb/tb_mc8051_.vhd
vcom ../tb/tb_mc8051_sim.vhd
vcom ../tb/tb_mc8051_sim_cfg.vhd
