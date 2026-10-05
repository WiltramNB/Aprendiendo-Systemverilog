@echo off 
echo === Simulando: ROM === 
iverilog -g2012 -o sim.out ROM_tb.sv ROM.sv 
vvp sim.out 
echo === Fin de simulacion === 
pause 
