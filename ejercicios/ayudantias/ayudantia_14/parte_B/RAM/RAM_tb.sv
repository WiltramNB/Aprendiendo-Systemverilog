module RAM_tb;
    logic        clk, rst, we;
    logic [1:0]  addr;
    logic [3:0]  din, dout;

    RAM dut(.clk(clk), .rst(rst), .we(we), .addr(addr), .din(din), .dout(dout));

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $display("=== Test: RAM 4x4 ===");
        $display("tiempo | rst | we | addr | din  | dout | comentario");
        $display("-------+-----+----+------+------+------+-----------");

        // --- 1) reset: todas las posiciones deben quedar en 0 ---
        rst = 1; we = 0; addr = 0; din = 0;
        @(posedge clk); #1;
        $display("%4t   |  %b  |  %b | %2b   | %4b | %4b | reset activo", $time, rst, we, addr, din, dout);
        rst = 0;

        // --- 2) verificar que todas las posiciones son 0 post-reset ---
        $display("--- verificando posiciones post-reset ---");
        for (int i = 0; i < 4; i++) begin
            addr = i; #10;
            $display("%4t   |  %b  |  %b | %2b   | %4b | %4b | mem[%0d] debe ser 0000", $time, rst, we, addr, din, dout, i);
        end

        // --- 3) escritura en cada posicion ---
        $display("--- escritura en cada posicion ---");
        we = 1;
        addr = 2'b00; din = 4'hA; @(posedge clk); #1;
        $display("%4t   |  %b  |  %b | %2b   | %4b | %4b | escribo A en mem[0]", $time, rst, we, addr, din, dout);

        addr = 2'b01; din = 4'hB; @(posedge clk); #1;
        $display("%4t   |  %b  |  %b | %2b   | %4b | %4b | escribo B en mem[1]", $time, rst, we, addr, din, dout);

        addr = 2'b10; din = 4'hC; @(posedge clk); #1;
        $display("%4t   |  %b  |  %b | %2b   | %4b | %4b | escribo C en mem[2]", $time, rst, we, addr, din, dout);

        addr = 2'b11; din = 4'hD; @(posedge clk); #1;
        $display("%4t   |  %b  |  %b | %2b   | %4b | %4b | escribo D en mem[3]", $time, rst, we, addr, din, dout);

        // --- 4) lectura: verificar que se guardo correctamente ---
        $display("--- lectura post-escritura ---");
        we = 0;
        addr = 2'b00; #10;
        $display("%4t   |  %b  |  %b | %2b   | %4b | %4b | mem[0] debe ser 1010 (A)", $time, rst, we, addr, din, dout);

        addr = 2'b01; #10;
        $display("%4t   |  %b  |  %b | %2b   | %4b | %4b | mem[1] debe ser 1011 (B)", $time, rst, we, addr, din, dout);

        addr = 2'b10; #10;
        $display("%4t   |  %b  |  %b | %2b   | %4b | %4b | mem[2] debe ser 1100 (C)", $time, rst, we, addr, din, dout);

        addr = 2'b11; #10;
        $display("%4t   |  %b  |  %b | %2b   | %4b | %4b | mem[3] debe ser 1101 (D)", $time, rst, we, addr, din, dout);

        // --- 5) we=0: escribir no debe cambiar la memoria ---
        $display("--- we=0: escritura bloqueada ---");
        we = 0; addr = 2'b00; din = 4'hF;
        @(posedge clk); #1;
        $display("%4t   |  %b  |  %b | %2b   | %4b | %4b | mem[0] debe seguir siendo A", $time, rst, we, addr, din, dout);

        // --- 6) reset con datos escritos: todo vuelve a 0 ---
        $display("--- reset con datos en memoria ---");
        rst = 1;
        @(posedge clk); #1;
        rst = 0;
        for (int i = 0; i < 4; i++) begin
            addr = i; #10;
            $display("%4t   |  %b  |  %b | %2b   | %4b | %4b | mem[%0d] debe ser 0000", $time, rst, we, addr, din, dout, i);
        end

        $finish;
    end
endmodule