@echo off 
echo === Simulando: flopr === 
iverilog -g2012 -o sim.out flopr_tb.sv flopr.sv 
vvp sim.out 
echo === Fin de simulacion === 
pause 
