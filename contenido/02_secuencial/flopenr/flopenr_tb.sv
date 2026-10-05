module flopr_tb;
    logic        clk, reset, en;
    logic [3:0]  d, q;

    flopr dut(.clk(clk), .reset(reset), .en(en), .d(d), .q(q));

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $display("=== Test: flopr con enable ===");
        $display("tiempo | reset | en | d    | q    | comentario");
        $display("-------+-------+----+------+------+-----------");

        // --- 1) reset asincrono al inicio ---
        reset = 1; en = 0; d = 4'hA;
        #3;
        $display("%4t   |   %b   |  %b | %4b | %4b | reset activo, Q=0", $time, reset, en, d, q);

        // --- 2) liberar reset, en=1, debe capturar D ---
        reset = 0; en = 1;
        @(posedge clk); #1;
        $display("%4t   |   %b   |  %b | %4b | %4b | en=1, Q debe capturar A", $time, reset, en, d, q);

        // --- 3) en=0, D cambia pero Q no debe cambiar ---
        en = 0; d = 4'hF;
        @(posedge clk); #1;
        $display("%4t   |   %b   |  %b | %4b | %4b | en=0, Q debe mantener A", $time, reset, en, d, q);

        // --- 4) otro ciclo con en=0, Q sigue sin cambiar ---
        d = 4'h3;
        @(posedge clk); #1;
        $display("%4t   |   %b   |  %b | %4b | %4b | en=0, Q debe mantener A", $time, reset, en, d, q);

        // --- 5) en=1, ahora si captura el ultimo D ---
        en = 1;
        @(posedge clk); #1;
        $display("%4t   |   %b   |  %b | %4b | %4b | en=1, Q debe capturar 3", $time, reset, en, d, q);

        // --- 6) reset asincrono a mitad de ciclo con en=1 ---
        d = 4'h7; en = 1;
        #3;
        reset = 1;
        #1;
        $display("%4t   |   %b   |  %b | %4b | %4b | reset mitad ciclo, Q=0 YA", $time, reset, en, d, q);

        // --- 7) liberar reset, verificar operacion normal ---
        reset = 0;
        @(posedge clk); #1;
        $display("%4t   |   %b   |  %b | %4b | %4b | Q debe capturar 7", $time, reset, en, d, q);

        $finish;
    end
endmodule