@echo off 
echo === Simulando: flopenr === 
iverilog -g2012 -o sim.out flopenr_tb.sv flopenr.sv 
vvp sim.out 
echo === Fin de simulacion === 
pause 
