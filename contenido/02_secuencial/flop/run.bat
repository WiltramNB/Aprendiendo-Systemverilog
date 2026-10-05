@echo off 
echo === Simulando: flop === 
iverilog -g2012 -o sim.out flop_tb.sv flop.sv 
vvp sim.out 
echo === Fin de simulacion === 
pause 
