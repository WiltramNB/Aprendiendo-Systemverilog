@echo off 
echo === Simulando: gates === 
iverilog -g2012 -o sim.out gates_tb.sv gates.sv 
vvp sim.out 
echo === Fin de simulacion === 
pause 
