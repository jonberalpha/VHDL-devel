# Windows console script

# compile software application for mc8051 using SDCC compiler
# and generate Intel HEX file using packihx_tcl.exe 
sdcc ../sw/mc8051_code/src/main.c -o ../sw/mc8051_code/build/
echo "sdcc: main.c sucessfully compiled"
../tools/packihx_tcl/win/packihx_tcl.exe ../sw/mc8051_code/build/main.ihx ../sw/mc8051_code/build/mc8051_rom.hex

# generate MIF and COE files out of Intel HEX file
../tools/convhex/win/convhex.exe ../sw/mc8051_code/build/mc8051_rom.hex

# copy MIF file (required for simulation only) to ModelSim simulation directory
file copy -force ../sw/mc8051_code/build/mc8051_rom.mif ../sim/

echo "mc8051 software application built successfully!"
