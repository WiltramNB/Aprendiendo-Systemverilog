module win_detect_tb;
    logic [15:0] leds;
    logic        win;

    win_detect dut(.leds(leds), .win(win));

    initial begin
        $display("=== Test: win_detect ===");
        $display("leds             | win | comentario");
        $display("-----------------+-----+-----------");

        // ningun LED encendido
        leds = 16'b0000_0000_0000_0000; #10;
        $display("%16b | %b   | sin LED, win=0", leds, win);

        // LED 0 encendido (no gana)
        leds = 16'b0000_0000_0000_0001; #10;
        $display("%16b | %b   | LED 0, win=0", leds, win);

        // LED 7 encendido (no gana)
        leds = 16'b0000_0000_1000_0000; #10;
        $display("%16b | %b   | LED 7, win=0", leds, win);

        // LED 8 encendido (GANA)
        leds = 16'b0000_0001_0000_0000; #10;
        $display("%16b | %b   | LED 8, win=1 !!!", leds, win);

        // LED 9 encendido (no gana)
        leds = 16'b0000_0010_0000_0000; #10;
        $display("%16b | %b   | LED 9, win=0", leds, win);

        // LED 15 encendido (no gana)
        leds = 16'b1000_0000_0000_0000; #10;
        $display("%16b | %b   | LED 15, win=0", leds, win);

        $finish;
    end
endmodule