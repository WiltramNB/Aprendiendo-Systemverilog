module not1_tb; 
    // declara tus senales aqui
    logic a, y;

    not1 dut(.a(a), .y(y)); 

    initial begin 
        $display("=== Test: not1 ==="); 
        $display("a | y");
        $display("--+--");

        {a} = 1'b0; #10; $display("%b | %b", a, y);
        {a} = 1'b1; #10; $display("%b | %b", a, y);

        $finish; 
    end 
endmodule 
