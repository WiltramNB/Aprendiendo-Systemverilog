@echo off
echo === Simulando: win_detect ===
iverilog -g2012 -o sim.out ../sim/win_detect_tb.sv ../src/win_detect.sv
vvp sim.out
echo === Fin ===
pause