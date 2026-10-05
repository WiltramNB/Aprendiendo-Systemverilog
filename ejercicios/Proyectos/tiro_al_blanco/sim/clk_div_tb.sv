module clk_div_tb;
    logic clk, reset, tick;

    // DIVISOR=5 para simular rapido
    clk_div #(.DIVISOR(5)) dut(.clk(clk), .reset(reset), .tick(tick));

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $display("=== Test: clk_div ===");
        $display("tiempo | tick | comentario");
        $display("-------+------+-----------");

        // reset inicial
        reset = 1; #20;
        $display("%4t   |  %b   | reset activo, tick debe ser 0", $time, tick);

        reset = 0;

        // esperar varios ticks
        repeat(30) begin
            @(posedge clk); #1;
            if (tick)
                $display("%4t   |  %b   | tick generado!", $time, tick);
            else
                $display("%4t   |  %b   | contando...", $time, tick);
        end

        $finish;
    end
endmodule