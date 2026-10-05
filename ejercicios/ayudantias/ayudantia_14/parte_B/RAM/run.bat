@echo off 
echo === Simulando: RAM === 
iverilog -g2012 -o sim.out RAM_tb.sv RAM.sv 
vvp sim.out 
echo === Fin de simulacion === 
pause 
