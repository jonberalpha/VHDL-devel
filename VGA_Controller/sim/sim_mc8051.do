vsim -novopt -t ps -L unisims_ver -lib work work.tb_mc8051 work.glbl  
view *
do mc8051_wave.do
run 150 us
