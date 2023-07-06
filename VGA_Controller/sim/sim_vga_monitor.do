vsim -novopt -t ps -L unisims_ver -lib work work.tb_vga_monitor work.glbl
view *
do vga_monitor_wave.do
run 500 ms
