@echo off 
echo === Simulando: shift_register === 
iverilog -g2012 -o sim.out shift_register_tb.sv shift_register.sv 
vvp sim.out 
echo === Fin de simulacion === 
pause 
