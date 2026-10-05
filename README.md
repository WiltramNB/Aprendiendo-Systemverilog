# Entorno de Aprendizaje y Desarrollo en SystemVerilog

Este repositorio funciona como un "cuaderno" de estudio interactivo y automatizado para el diseño, simulación y verificación de circuitos digitales utilizando **SystemVerilog**. 

El proyecto incluye scripts personalizados en Batch (`.bat`) para agilizar la creación de módulos (arquitectura + testbench) y ejecutar simulaciones rápidamente, eliminando la fricción de configurar archivos manualmente para cada ejercicio.

## Dependencias y Requisitos

Para que este entorno funcione correctamente en tu máquina local, necesitas las siguientes herramientas instaladas:

1. **Icarus Verilog (Compilador y Simulador):**
   - Descarga e instala [Icarus Verilog for Windows](http://bleyer.org/icarus/).
   - **Importante:** Asegúrate de marcar la opción para agregar `iverilog` y `vvp` a las variables de entorno (`PATH`) durante la instalación.
2. **Sistema Operativo:**
   - Windows (el sistema de automatización está construido con scripts `.bat`).
3. **Editor Recomendado:**
   - [Visual Studio Code](https://code.visualstudio.com/).
   - Se recomienda instalar la extensión *Verilog-HDL/SystemVerilog/Bluespec SystemVerilog* (de mshr-h) para obtener resaltado de sintaxis y autocompletado.

## Estructura del Proyecto

El repositorio está organizado en categorías para separar apuntes de clases, proyectos personales y talleres específicos (como DSP):

```text
raiz-del-proyecto
 ┣ contenidos         # Ejercicios y apuntes de ramos/asignaturas pasadas
 ┃ ┣ 01_combinacional
 ┃ ┣ 02_secuencial
 ┃ ┣ 03_FSM
 ┃ ┣ 04_memorias
 ┃ ┗ ayudantias
 ┣ ejercicios         # Prácticas sueltas y pruebas de concepto
 ┣ proyectos          # Proyectos más extensos y completos
 ┣ taller_dsp         # Diseños orientados a Digital Signal Processing
 ┣ ne.bat             # Script principal para generar nuevos módulos
 ┗ ne.txt             # Guía rápida de uso del script


# Flujo de Trabajo (Cómo Funciona)

El núcleo de este repositorio es la **automatización**. No necesitas crear archivos en blanco manualmente.

## 1. Crear un nuevo ejercicio

En la terminal integrada de VSCode (en la raíz del proyecto), ejecuta el script de creación:

```bat
.\ne.bat
```

El script es interactivo y te pedirá:

- **Nombre del ejercicio:** (ej. `sumador4b`).
- **Categoría destino:** (`contenidos`, `proyectos`, `ejercicios` o `taller_dsp`).
- *(Opcional)* Si eliges `contenidos`, te preguntará en qué subcarpeta guardarlo.

Automáticamente se generará una carpeta aislada con la siguiente estructura base:

- `nombre_del_ejercicio.sv`: Plantilla vacía para tu diseño RTL.
- `nombre_del_ejercicio_tb.sv`: Plantilla configurada para el Testbench.
- `run.bat`: Script local preconfigurado para compilar y simular este circuito en específico.

## 2. Simular un circuito

Cada carpeta generada es **100% independiente**. Una vez que hayas escrito tu código y testbench, navega hasta la carpeta del ejercicio y ejecuta su simulador local:

```bat
cd ejercicios\sumador4b
.\run.bat
```

El script `run.bat` compilará los archivos usando `iverilog` (estándar 2012) y ejecutará la simulación con `vvp`, mostrando los resultados de tus sentencias `$display` directamente en la terminal.

## Ejemplo de Código Generado

Si ejecutas `.\ne.bat` y creas un módulo llamado `and8`, el entorno te dejará los archivos listos para programar.

Un diseño terminado se vería así:

```systemverilog
// and8.sv
module and8(
    input logic [7:0] a,
    output logic y
);
    assign y = &a;
endmodule
```

Al ejecutar `.\run.bat`, el output en la terminal será:

```text
=== Simulando: and8 ===
=== Test: and8 ===
    a     | y
----------+--
00000000  | 0
00000001  | 0
...
11111111  | 1
=== Fin de simulacion ===
Press any key to continue . . .
```

## Autor

**Martín Ignacio Medel Vallejos**
Estudiante de Ingeniería Eléctrica