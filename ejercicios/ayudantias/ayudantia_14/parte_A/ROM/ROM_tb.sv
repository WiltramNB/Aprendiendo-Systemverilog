module ROM_tb;
    logic [2:0] addr;
    logic [3:0] cmd;

    ROM dut(.addr(addr), .cmd(cmd));

    // tabla de valores esperados
    logic [3:0] esperado [0:7];

    initial begin
        // cargar valores esperados (igual que la ROM)
        esperado[0] = 4'b1011;
        esperado[1] = 4'b0110;
        esperado[2] = 4'b1100;
        esperado[3] = 4'b0001;
        esperado[4] = 4'b1110;
        esperado[5] = 4'b0101;
        esperado[6] = 4'b1000;
        esperado[7] = 4'b0011;

        $display("=== Test: ROM 8x4 ===");
        $display("addr | cmd  | esperado | resultado");
        $display("-----+------+----------+---------");

        for (int i = 0; i < 8; i++) begin
            addr = i; #10;
            if (cmd === esperado[i])
                $display(" %3b | %4b |   %4b   | OK", addr, cmd, esperado[i]);
            else
                $display(" %3b | %4b |   %4b   | ERROR", addr, cmd, esperado[i]);
        end

        $finish;
    end
endmodule