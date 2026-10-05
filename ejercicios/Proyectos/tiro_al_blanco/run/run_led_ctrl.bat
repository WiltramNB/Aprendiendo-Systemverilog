@echo off
echo === Simulando: led_ctrl ===
iverilog -g2012 -o sim.out ../sim/led_ctrl_tb.sv ../src/led_ctrl.sv
vvp sim.out
echo === Fin ===
pause