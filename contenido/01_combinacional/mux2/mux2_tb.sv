module mux2_tb;
    logic [3:0] d0, d1, y;
    logic s;

    mux2 dut(.d0(d0), .d1(d1), .s(s), .y(y));

    initial begin
        $display("=== Test: mux2 ===");
        $display("  d0    d1   s |   y   | esperado");
        $display("--------------+-------+---------");

        // s=0 -> y debe seguir a d0
        d0=4'hA; d1=4'h5; s=0; #10;
        $display("%4b  %4b  %b | %4b  | %4b", d0, d1, s, y, d0);

        d0=4'hF; d1=4'h3; s=0; #10;
        $display("%4b  %4b  %b | %4b  | %4b", d0, d1, s, y, d0);

        // s=1 -> y debe seguir a d1
        d0=4'hA; d1=4'h5; s=1; #10;
        $display("%4b  %4b  %b | %4b  | %4b", d0, d1, s, y, d1);

        d0=4'hF; d1=4'h3; s=1; #10;
        $display("%4b  %4b  %b | %4b  | %4b", d0, d1, s, y, d1);

        // casos borde
        d0=4'h0; d1=4'hF; s=0; #10;
        $display("%4b  %4b  %b | %4b  | %4b", d0, d1, s, y, d0);

        d0=4'h0; d1=4'hF; s=1; #10;
        $display("%4b  %4b  %b | %4b  | %4b", d0, d1, s, y, d1);

        $finish;
    end
endmodule
