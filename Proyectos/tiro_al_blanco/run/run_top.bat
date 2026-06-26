@echo off
echo === Simulando: top (integracion completa) ===
iverilog -g2012 -o sim.out ^
    ../sim/top_tb.sv ^
    ../src/top.sv ^
    ../src/clk_div.sv ^
    ../src/led_ctrl.sv ^
    ../src/win_detect.sv ^
    ../src/seg7_dec.sv
vvp sim.out
echo === Fin ===
pause