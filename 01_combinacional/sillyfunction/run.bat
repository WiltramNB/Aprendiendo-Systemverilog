@echo off
echo === Simulando: sillyfunction ===
iverilog -g2012 -o sim.out sillyfunction_tb.sv sillyfunction.sv
vvp sim.out
echo === Fin de simulacion ===
pause