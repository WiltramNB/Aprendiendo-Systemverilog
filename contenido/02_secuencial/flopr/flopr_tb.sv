// 1. Reset asíncrono → Q va a 0 INMEDIATAMENTE, sin esperar flanco
// 2. Operación normal → Q captura D en el posedge clk (igual que antes)

module flopr_tb;
    logic        clk, reset;
    logic [3:0]  d, q;

    flopr dut(.clk(clk), .reset(reset), .d(d), .q(q));

    // clock de periodo 10ns
    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $display("=== Test: flopr (reset asincrono) ===");
        $display("tiempo | clk | reset | d    | q    | comentario");
        $display("-------+-----+-------+------+------+-----------");

        // --- 1) verificar reset asincrono al inicio ---
        reset = 1; d = 4'hA;
        #3;
        $display("%4t   |  %b  |   %b   | %4b | %4b | reset activo, Q debe ser 0", $time, clk, reset, d, q);

        // --- 2) liberar reset, cargar dato ---
        reset = 0;
        @(posedge clk); #1;
        $display("%4t   |  %b  |   %b   | %4b | %4b | Q debe capturar A", $time, clk, reset, d, q);

        // --- 3) cargar otro dato ---
        d = 4'h5;
        @(posedge clk); #1;
        $display("%4t   |  %b  |   %b   | %4b | %4b | Q debe ser 5", $time, clk, reset, d, q);

        // --- 4) reset asincrono A MITAD DEL CICLO ---
        // esto es lo mas importante: reset no espera el flanco
        d = 4'hF;
        #3; // estamos a mitad del ciclo, lejos del flanco
        reset = 1;
        #1; // un instante despues
        $display("%4t   |  %b  |   %b   | %4b | %4b | reset a mitad ciclo, Q debe ser 0 YA", $time, clk, reset, d, q);

        // --- 5) liberar reset y verificar operacion normal ---
        reset = 0;
        @(posedge clk); #1;
        $display("%4t   |  %b  |   %b   | %4b | %4b | Q debe capturar F", $time, clk, reset, d, q);

        // --- 6) un ciclo mas para confirmar ---
        d = 4'h7;
        @(posedge clk); #1;
        $display("%4t   |  %b  |   %b   | %4b | %4b | Q debe ser 7", $time, clk, reset, d, q);

        $finish;
    end
endmodule
