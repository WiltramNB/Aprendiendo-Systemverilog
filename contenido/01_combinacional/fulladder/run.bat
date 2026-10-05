@echo off 
echo === Simulando: fulladder === 
iverilog -g2012 -o sim.out fulladder_tb.sv fulladder.sv 
vvp sim.out 
echo === Fin de simulacion === 
pause 
