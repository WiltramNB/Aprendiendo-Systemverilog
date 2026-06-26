module top_tb;
    logic        clk, reset, btn_b;
    logic [15:0] led;
    logic [6:0]  seg;
    logic [3:0]  an;

    top #(.DIVISOR(5)) dut(
        .clk(clk), .reset(reset),
        .btn_b(btn_b), .led(led), .seg(seg),
        .an(an)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $display("=== Test: top (integracion) ===");
        $display("tiempo | btn_b | led              | seg     | an   | win");
        $display("-------+-------+------------------+---------+------+----");

        // reset inicial
        reset = 1; btn_b = 0; #20;
        reset = 0; #10;
        $display("%4t   |   %b   | %16b | %7b | %4b | %b  post-reset", $time, btn_b, led, seg, an, led[8]);

        // presionar btn_b y observar movimiento del LED
        btn_b = 1;
        $display("--- btn_b presionado ---");
        repeat(40) begin
            @(posedge clk); #1;
            $display("%4t   |   %b   | %16b | %7b | %4b | %b", $time, btn_b, led, seg, an, led[8]);
        end

        // soltar btn_b
        btn_b = 0;
        $display("--- btn_b suelto ---");
        repeat(10) begin
            @(posedge clk); #1;
            $display("%4t   |   %b   | %16b | %7b | %4b | %b  congelado", $time, btn_b, led, seg, an, led[8]);
        end

        // reset final
        reset = 1; #20; reset = 0; #10;
        $display("%4t   |   %b   | %16b | %7b | %4b | %b  reset final", $time, btn_b, led, seg, an, led[8]);

        $finish;
    end
endmodule