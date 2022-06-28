vsim -t ns -novopt -lib work work.tb_calculator_sim_cfg  
view *
do calculator_wave.do
run 130 ms
