module seg7_dec_tb;
    logic       win;
    logic [6:0] seg;

    seg7_dec dut(.win(win), .seg(seg));

    initial begin
        $display("=== Test: seg7_dec ===");
        $display("win | seg     | comentario");
        $display("----+--------+-----------");

        // perdio: debe mostrar "0"
        win = 0; #10;
        $display(" %b  | %7b | debe ser 1000000 (digito 0)", win, seg);

        // gano: debe mostrar "1"
        win = 1; #10;
        $display(" %b  | %7b | debe ser 1111001 (digito 1)", win, seg);

        $finish;
    end
endmodule