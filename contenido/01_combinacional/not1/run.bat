@echo off 
echo === Simulando: not1 === 
iverilog -g2012 -o sim.out not1_tb.sv not1.sv 
vvp sim.out 
echo === Fin de simulacion === 
pause 
