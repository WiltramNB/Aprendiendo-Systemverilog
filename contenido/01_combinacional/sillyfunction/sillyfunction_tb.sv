module testbench;
    logic a, b, c, y;

    // Instanciar el DUT
    sillyfunction dut(.a(a), .b(b), .c(c), .y(y));

    initial begin
        $display("a b c | y");
        $display("------+--");
        
        // Probar las 8 combinaciones posibles
        //        N3bits  10ns de espera
        {a,b,c} = 3'b000; #10; $display("%b %b %b | %b", a, b, c, y);
        {a,b,c} = 3'b001; #10; $display("%b %b %b | %b", a, b, c, y);
        {a,b,c} = 3'b010; #10; $display("%b %b %b | %b", a, b, c, y);
        {a,b,c} = 3'b011; #10; $display("%b %b %b | %b", a, b, c, y);
        {a,b,c} = 3'b100; #10; $display("%b %b %b | %b", a, b, c, y);
        {a,b,c} = 3'b101; #10; $display("%b %b %b | %b", a, b, c, y);
        {a,b,c} = 3'b110; #10; $display("%b %b %b | %b", a, b, c, y);
        {a,b,c} = 3'b111; #10; $display("%b %b %b | %b", a, b, c, y);
        
        $finish; // display para ver resultados
    end
endmodule