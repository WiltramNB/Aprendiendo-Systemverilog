@echo off
echo === Simulando: clk_div ===
iverilog -g2012 -o sim.out ../sim/clk_div_tb.sv ../src/clk_div.sv
vvp sim.out
echo === Fin ===
pause