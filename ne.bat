@echo off
set /p NOMBRE=Nombre del ejercicio: 
set /p CARPETA=Carpeta destino (01_combinacional ,02_secuencial, 03_FSM, 04_memorias): 

mkdir %CARPETA%\%NOMBRE%

:: Crear design.sv
echo module %NOMBRE%( > %CARPETA%\%NOMBRE%\%NOMBRE%.sv
echo.>> %CARPETA%\%NOMBRE%\%NOMBRE%.sv
echo ); >> %CARPETA%\%NOMBRE%\%NOMBRE%.sv
echo.>> %CARPETA%\%NOMBRE%\%NOMBRE%.sv
echo.>> %CARPETA%\%NOMBRE%\%NOMBRE%.sv
echo.>> %CARPETA%\%NOMBRE%\%NOMBRE%.sv
echo endmodule >> %CARPETA%\%NOMBRE%\%NOMBRE%.sv

:: Crear testbench
echo module %NOMBRE%_tb; > %CARPETA%\%NOMBRE%\%NOMBRE%_tb.sv
echo     // declara tus senales aqui >> %CARPETA%\%NOMBRE%\%NOMBRE%_tb.sv
echo.>> %CARPETA%\%NOMBRE%\%NOMBRE%_tb.sv
echo     %NOMBRE% dut( >> %CARPETA%\%NOMBRE%\%NOMBRE%_tb.sv
echo         // conecta tus puertos aqui >> %CARPETA%\%NOMBRE%\%NOMBRE%_tb.sv
echo     ); >> %CARPETA%\%NOMBRE%\%NOMBRE%_tb.sv
echo.>> %CARPETA%\%NOMBRE%\%NOMBRE%_tb.sv
echo     integer i; >> %CARPETA%\%NOMBRE%\%NOMBRE%_tb.sv
echo     initial begin >> %CARPETA%\%NOMBRE%\%NOMBRE%_tb.sv
echo         $display("=== Test: %NOMBRE% ==="); >> %CARPETA%\%NOMBRE%\%NOMBRE%_tb.sv
echo         // aplica estimulos aqui >> %CARPETA%\%NOMBRE%\%NOMBRE%_tb.sv
echo         $finish; >> %CARPETA%\%NOMBRE%\%NOMBRE%_tb.sv
echo     end >> %CARPETA%\%NOMBRE%\%NOMBRE%_tb.sv
echo endmodule >> %CARPETA%\%NOMBRE%\%NOMBRE%_tb.sv

:: Crear run.bat
echo @echo off > %CARPETA%\%NOMBRE%\run.bat
echo echo === Simulando: %NOMBRE% === >> %CARPETA%\%NOMBRE%\run.bat
echo iverilog -g2012 -o sim.out %NOMBRE%_tb.sv %NOMBRE%.sv >> %CARPETA%\%NOMBRE%\run.bat
echo vvp sim.out >> %CARPETA%\%NOMBRE%\run.bat
echo echo === Fin de simulacion === >> %CARPETA%\%NOMBRE%\run.bat
echo pause >> %CARPETA%\%NOMBRE%\run.bat

echo.
echo Ejercicio "%NOMBRE%" creado en %CARPETA%\%NOMBRE%\
echo Archivos: %NOMBRE%.sv, %NOMBRE%_tb.sv, run.bat
pause