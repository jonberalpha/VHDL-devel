vsim -novopt -t ps -L unisims_ver -lib work work.tb_vga_controller work.glbl
view *
do vga_controller_wave.do
run 500 ms
