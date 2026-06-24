module and8_tb;
    logic [7:0] a;
    logic y;

    and8 dut(.a(a), .y(y));

    integer i;
    initial begin
        $display("=== Test: and8 ===");
        $display("    a     | y");
        $display("----------+--");

        for (i = 0; i < 2**8; i = i + 1) begin
            a = i; #10;
            $display("%8b  | %b", a, y);
        end

        $finish;
    end
endmodule
