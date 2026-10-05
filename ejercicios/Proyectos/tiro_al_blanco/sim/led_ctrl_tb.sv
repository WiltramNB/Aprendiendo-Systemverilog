module led_ctrl_tb;
    logic        clk, reset, tick, btn_b;
    logic [15:0] leds;

    led_ctrl dut(.clk(clk), .reset(reset), .tick(tick),
                 .btn_b(btn_b), .leds(leds));

    initial clk = 0;
    always #5 clk = ~clk;

    // tarea para generar un tick manual
    task gen_tick;
        @(posedge clk); #1;
        tick = 1;
        @(posedge clk); #1;
        tick = 0;
    endtask

    initial begin
        $display("=== Test: led_ctrl ===");
        $display("tiempo | btn_b | tick | leds             | comentario");
        $display("-------+-------+------+------------------+-----------");

        // reset inicial
        reset = 1; btn_b = 0; tick = 0; #20;
        reset = 0; #5;
        $display("%4t   |   %b   |  %b   | %16b | post-reset, LED 15 encendido", $time, btn_b, tick, leds);

        btn_b = 1;
        $display("--- btn_b presionado, LED debe moverse derecha (pos decrece) ---");
        repeat(18) begin
            gen_tick();
            $display("%4t   |   %b   |  %b   | %16b | pos LED", $time, btn_b, tick, leds);
        end

        // soltar btn_b: LED debe congelarse
        btn_b = 0;
        $display("--- btn_b suelto, LED debe congelarse ---");
        repeat(4) begin
            gen_tick();
            $display("%4t   |   %b   |  %b   | %16b | debe mantenerse", $time, btn_b, tick, leds);
        end

        // reset nuevamente
        reset = 1; #20; reset = 0; #5;
        $display("%4t   |   %b   |  %b   | %16b | reset, leds=0", $time, btn_b, tick, leds);

        $finish;
    end
endmodule