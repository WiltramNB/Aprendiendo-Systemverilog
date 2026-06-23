module gates_tb; 
    // declara tus senales aqui
    logic a, b, y1, y2, y3, y4, y5;

    gates dut(.a(a), .b(b), .y1(y1), .y2(y2), .y3(y3), .y4(y4), .y5(y5)); 

    initial begin 
        $display("=== Test: gates ===");
        $display("a b | y1 y2 y3 y4 y5");
        $display("----+---------------");
        // aplica estimulos aqui 

        {a,b} = 2'b00; #10; $display("%b %b | %b %b %b %b %b", a, b, y1, y2, y3, y4, y5);
        {a,b} = 2'b01; #10; $display("%b %b | %b %b %b %b %b", a, b, y1, y2, y3, y4, y5);
        {a,b} = 2'b10; #10; $display("%b %b | %b %b %b %b %b", a, b, y1, y2, y3, y4, y5);
        {a,b} = 2'b11; #10; $display("%b %b | %b %b %b %b %b", a, b, y1, y2, y3, y4, y5);

        $finish; 
    end 
endmodule