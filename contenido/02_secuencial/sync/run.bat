@echo off 
echo === Simulando: sync === 
iverilog -g2012 -o sim.out sync_tb.sv sync.sv 
vvp sim.out 
echo === Fin de simulacion === 
pause 
