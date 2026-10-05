module shift_register_tb;
    logic        clk, rst, load, en, sin;
    logic [3:0]  din, q;
    logic        sout;

    shift_register dut(.clk(clk), .rst(rst), .load(load),
                       .en(en), .sin(sin), .din(din), .q(q), .sout(sout));

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $display("=== Test: shift_register ===");
        $display("tiempo | rst | load | en | sin | din  | q    | sout | comentario");
        $display("-------+-----+------+----+-----+------+------+------+-----------");

        // --- 1) reset ---
        rst=1; load=0; en=0; sin=0; din=4'b0000;
        @(posedge clk); #1;
        $display("%4t   |  %b  |   %b  |  %b |  %b  | %4b | %4b |  %b   | reset, q=0000", $time, rst, load, en, sin, din, q, sout);
        rst = 0;

        // --- 2) load: carga un valor en q ---
        $display("--- carga paralela ---");
        load=1; din=4'b1011;
        @(posedge clk); #1;
        $display("%4t   |  %b  |   %b  |  %b |  %b  | %4b | %4b |  %b   | load 1011, q debe ser 1011", $time, rst, load, en, sin, din, q, sout);
        load = 0;

        // --- 3) desplazamiento con sin=0 ---
        $display("--- desplazamiento con sin=0 ---");
        en=1; sin=0;
        @(posedge clk); #1;
        $display("%4t   |  %b  |   %b  |  %b |  %b  | %4b | %4b |  %b   | shift: 0101", $time, rst, load, en, sin, din, q, sout);

        @(posedge clk); #1;
        $display("%4t   |  %b  |   %b  |  %b |  %b  | %4b | %4b |  %b   | shift: 0010", $time, rst, load, en, sin, din, q, sout);

        @(posedge clk); #1;
        $display("%4t   |  %b  |   %b  |  %b |  %b  | %4b | %4b |  %b   | shift: 0001", $time, rst, load, en, sin, din, q, sout);

        @(posedge clk); #1;
        $display("%4t   |  %b  |   %b  |  %b |  %b  | %4b | %4b |  %b   | shift: 0000", $time, rst, load, en, sin, din, q, sout);

        // --- 4) desplazamiento con sin=1 ---
        $display("--- desplazamiento con sin=1 ---");
        sin = 1;
        @(posedge clk); #1;
        $display("%4t   |  %b  |   %b  |  %b |  %b  | %4b | %4b |  %b   | shift: 1000", $time, rst, load, en, sin, din, q, sout);

        @(posedge clk); #1;
        $display("%4t   |  %b  |   %b  |  %b |  %b  | %4b | %4b |  %b   | shift: 1100", $time, rst, load, en, sin, din, q, sout);

        @(posedge clk); #1;
        $display("%4t   |  %b  |   %b  |  %b |  %b  | %4b | %4b |  %b   | shift: 1110", $time, rst, load, en, sin, din, q, sout);

        @(posedge clk); #1;
        $display("%4t   |  %b  |   %b  |  %b |  %b  | %4b | %4b |  %b   | shift: 1111", $time, rst, load, en, sin, din, q, sout);

        // --- 5) en=0: q no debe cambiar ---
        $display("--- en=0: q congelado ---");
        en = 0; sin = 0;
        @(posedge clk); #1;
        $display("%4t   |  %b  |   %b  |  %b |  %b  | %4b | %4b |  %b   | q debe mantenerse 1111", $time, rst, load, en, sin, din, q, sout);

        // --- 6) load tiene prioridad sobre en ---
        $display("--- load tiene prioridad sobre en ---");
        load=1; en=1; din=4'b1010;
        @(posedge clk); #1;
        $display("%4t   |  %b  |   %b  |  %b |  %b  | %4b | %4b |  %b   | load gana sobre en, q=1010", $time, rst, load, en, sin, din, q, sout);

        // --- 7) rst tiene prioridad sobre todo ---
        $display("--- rst tiene prioridad sobre load y en ---");
        rst=1; load=1; en=1; din=4'b1111;
        @(posedge clk); #1;
        $display("%4t   |  %b  |   %b  |  %b |  %b  | %4b | %4b |  %b   | rst gana, q=0000", $time, rst, load, en, sin, din, q, sout);

        $finish;
    end
endmodule