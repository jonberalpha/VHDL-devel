# ********** compile entities **********
# Submodule - io_ctrl
vcom ../vhdl/debounce.vhd
vcom ../vhdl/io_ctrl_.vhd
vcom ../vhdl/io_ctrl_rtl.vhd
vcom ../vhdl/io_ctrl_rtl_cfg.vhd

# Submodule - alu
vcom ../vhdl/alu_.vhd
vcom ../vhdl/alu_rtl.vhd
vcom ../vhdl/alu_rtl_cfg.vhd

# Submodule - calc_ctrl
vcom ../vhdl/calc_ctrl_.vhd
vcom ../vhdl/calc_ctrl_rtl.vhd
vcom ../vhdl/calc_ctrl_rtl_cfg.vhd

# Topmodule - Calculator
vcom ../vhdl/calculator_.vhd
vcom ../vhdl/calculator_struc.vhd
vcom ../vhdl/calculator_struc_cfg.vhd

# ********** compile testbenches **********
# Submodule testbench - io_ctrl
vcom ../tb/tb_io_ctrl_.vhd
vcom ../tb/tb_io_ctrl_sim.vhd
vcom ../tb/tb_io_ctrl_sim_cfg.vhd

# Submodule testbench - alu
vcom ../tb/tb_alu_.vhd
vcom ../tb/tb_alu_sim.vhd
vcom ../tb/tb_alu_sim_cfg.vhd

# Submodule testbench - calc_ctrl
vcom ../tb/tb_calc_ctrl_.vhd
vcom ../tb/tb_calc_ctrl_sim.vhd
vcom ../tb/tb_calc_ctrl_sim_cfg.vhd

# Topmodule testbench - Calculator
vcom ../tb/tb_calculator_.vhd
vcom ../tb/tb_calculator_sim.vhd
vcom ../tb/tb_calculator_sim_cfg.vhd


