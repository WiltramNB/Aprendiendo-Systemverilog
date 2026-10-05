@echo off
set /p NOMBRE=Nombre del ejercicio: 
set /p CARPETA=Carpeta destino (01_combinacional, 02_secuencial, 03_FSM, 04_memorias, proyectos, ayudantias): 

if /i "%CARPETA%"=="ayudantias" goto es_ayudantia

:: Ruta normal
set RUTA=%CARPETA%\%NOMBRE%
goto crear

:es_ayudantia
set /p SUBCARPETA=Subcarpeta (ej: ayudantia_14\parte_A): 
set RUTA=%CARPETA%\%SUBCARPETA%\%NOMBRE%

:crear
mkdir %RUTA%

:: Crear design.sv
echo module %NOMBRE%( > %RUTA%\%NOMBRE%.sv
echo. >> %RUTA%\%NOMBRE%.sv
echo ); >> %RUTA%\%NOMBRE%.sv
echo. >> %RUTA%\%NOMBRE%.sv
echo endmodule >> %RUTA%\%NOMBRE%.sv

:: Crear testbench
echo module %NOMBRE%_tb; > %RUTA%\%NOMBRE%_tb.sv
echo     // declara tus senales aqui >> %RUTA%\%NOMBRE%_tb.sv
echo. >> %RUTA%\%NOMBRE%_tb.sv
echo     %NOMBRE% dut( >> %RUTA%\%NOMBRE%_tb.sv
echo         // conecta tus puertos aqui >> %RUTA%\%NOMBRE%_tb.sv
echo     ); >> %RUTA%\%NOMBRE%_tb.sv
echo. >> %RUTA%\%NOMBRE%_tb.sv
echo     integer i; >> %RUTA%\%NOMBRE%_tb.sv
echo     initial begin >> %RUTA%\%NOMBRE%_tb.sv
echo         $display("=== Test: %NOMBRE% ==="); >> %RUTA%\%NOMBRE%_tb.sv
echo         // aplica estimulos aqui >> %RUTA%\%NOMBRE%_tb.sv
echo         $finish; >> %RUTA%\%NOMBRE%_tb.sv
echo     end >> %RUTA%\%NOMBRE%_tb.sv
echo endmodule >> %RUTA%\%NOMBRE%_tb.sv

:: Crear run.bat
echo @echo off > %RUTA%\run.bat
echo echo === Simulando: %NOMBRE% === >> %RUTA%\run.bat
echo iverilog -g2012 -o sim.out %NOMBRE%_tb.sv %NOMBRE%.sv >> %RUTA%\run.bat
echo vvp sim.out >> %RUTA%\run.bat
echo echo === Fin de simulacion === >> %RUTA%\run.bat
echo pause >> %RUTA%\run.bat

echo.
echo Ejercicio "%NOMBRE%" creado en %RUTA%\
echo Archivos: %NOMBRE%.sv, %NOMBRE%_tb.sv, run.bat
pause