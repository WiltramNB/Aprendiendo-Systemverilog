@echo off
echo === Simulando: seg7_dec ===
iverilog -g2012 -o sim.out ../sim/seg7_dec_tb.sv ../src/seg7_dec.sv
vvp sim.out
echo === Fin ===
pause