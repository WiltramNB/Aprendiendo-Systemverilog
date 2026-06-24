@echo off 
echo === Simulando: mux4 === 
iverilog -g2012 -o sim.out mux4_tb.sv mux4.sv 
vvp sim.out 
echo === Fin de simulacion === 
pause 
