@echo off 
echo === Simulando: and8 === 
iverilog -g2012 -o sim.out and8_tb.sv and8.sv 
vvp sim.out 
echo === Fin de simulacion === 
pause 
