@echo off 
echo === Simulando: mux2 === 
iverilog -g2012 -o sim.out mux2_tb.sv mux2.sv 
vvp sim.out 
echo === Fin de simulacion === 
pause 
