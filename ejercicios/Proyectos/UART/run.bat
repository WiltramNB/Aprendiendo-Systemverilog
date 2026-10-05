@echo off 
echo === Simulando: UART === 
iverilog -g2012 -o sim.out UART_tb.sv UART.sv 
vvp sim.out 
echo === Fin de simulacion === 
pause 
