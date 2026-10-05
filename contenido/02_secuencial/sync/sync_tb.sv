module sync_tb;
    logic clk, d, q;

    sync dut(.clk(clk), .d(d), .q(q));

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $display("=== Test: sincronizador 2 etapas ===");
        $display("tiempo | d | q | comentario");
        $display("-------+---+---+-----------");

        d = 0;
        #3;
        $display("%4t   | %b | %b | inicio, Q debe ser x", $time, d, q);

        // --- caso 1: D cambia lejos del flanco (caso normal) ---
        d = 1;
        #2; // D cambia en t=5, lejos del flanco
        $display("%4t   | %b | %b | D=1, Q aun no cambia", $time, d, q);

        @(posedge clk); #1; // 1er flanco: FF1 captura D=1, Q sigue en 0
        $display("%4t   | %b | %b | 1er flanco: FF1=1, Q debe ser 0", $time, d, q);

        @(posedge clk); #1; // 2do flanco: FF2 captura FF1=1, Q=1
        $display("%4t   | %b | %b | 2do flanco: Q debe ser 1", $time, d, q);

        // --- caso 2: D vuelve a 0 lejos del flanco ---
        d = 0;
        #2;
        $display("%4t   | %b | %b | D=0, Q aun debe ser 1", $time, d, q);

        @(posedge clk); #1;
        $display("%4t   | %b | %b | 1er flanco: FF1=0, Q debe ser 1", $time, d, q);

        @(posedge clk); #1;
        $display("%4t   | %b | %b | 2do flanco: Q debe ser 0", $time, d, q);

        // --- caso 3: D cambia MUY CERCA del flanco (riesgo de metaestabilidad) ---
        // en simulacion no hay metaestabilidad real, pero verificamos el retardo
        @(negedge clk); // estamos a mitad del ciclo
        #4;             // esperamos hasta 1ns antes del flanco
        d = 1;          // D cambia justo antes del flanco
        $display("%4t   | %b | %b | D=1 casi en el flanco", $time, d, q);

        @(posedge clk); #1;
        $display("%4t   | %b | %b | 1er flanco: FF1 capturo D=1, Q=0", $time, d, q);

        @(posedge clk); #1;
        $display("%4t   | %b | %b | 2do flanco: Q debe ser 1", $time, d, q);

        // --- caso 4: pulso corto, menos de un ciclo ---
        d = 0;
        @(posedge clk); #1;
        $display("%4t   | %b | %b | D=0, 1er flanco", $time, d, q);

        @(posedge clk); #1;
        $display("%4t   | %b | %b | Q debe ser 0", $time, d, q);

        $finish;
    end
endmodule
