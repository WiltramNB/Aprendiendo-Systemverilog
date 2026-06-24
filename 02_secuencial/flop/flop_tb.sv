module flop_tb;
    logic clk;
    logic [3:0]  d, q;

    // instanciar DUT
    flop dut(.clk(clk), .d(d), .q(q));

    // generar clock: periodo 10ns
    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $display("=== Test: flop D ===");
        $display("tiempo | d    | q    | comentario");
        $display("-------+------+------+-----------");

        // estado inicial
        d = 4'h0;
        #3; // esperar un poco antes del primer flanco
        $display("%4t   | %4b | %4b | inicio", $time, d, q);

        // ciclo 1: cargar A
        d = 4'hA;
        @(posedge clk); #1; // esperar flanco y estabilización
        $display("%4t   | %4b | %4b | Q debe ser A", $time, d, q);

        // ciclo 2: cargar 5
        d = 4'h5;
        @(posedge clk); #1;
        $display("%4t   | %4b | %4b | Q debe ser 5", $time, d, q);

        // ciclo 3: D cambia pero Q mantiene hasta el flanco
        d = 4'hF;
        #2; // cambio a mitad del ciclo
        $display("%4t   | %4b | %4b | Q aun debe ser 5", $time, d, q);
        @(posedge clk); #1;
        $display("%4t   | %4b | %4b | Q debe ser F", $time, d, q);

        // ciclo 4: cargar 0
        d = 4'h0;
        @(posedge clk); #1;
        $display("%4t   | %4b | %4b | Q debe ser 0", $time, d, q);

        $finish;
    end
endmodule
