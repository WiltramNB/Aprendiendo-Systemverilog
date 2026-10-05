module fulladder_tb; 
    // declara tus senales aqui 
    logic a, b, cin, cout, s;

    fulladder dut(.a(a), .b(b), .cin(cin), .cout(cout), .s(s)); 

    initial begin 
        $display("=== Test: fulladder ==="); 
        $display("a b cin | s  cout "); 
        $display("-------+---------"); 
        
        //cin=0
        $display("cin=0-----------------"); 
        a=1'b0; b=1'b0; cin=1'b0; #10;
        $display("%b %b %b   | %b %b ", a, b, cin, s, cout);

        a=1'b0; b=1'b1; cin=1'b0; #10;
        $display("%b %b %b   | %b %b ", a, b, cin, s, cout);

        a=1'b1; b=1'b0; cin=1'b0; #10;
        $display("%b %b %b   | %b %b ", a, b, cin, s, cout);

        a=1'b1; b=1'b1; cin=1'b0; #10;
        $display("%b %b %b   | %b %b ", a, b, cin, s, cout);

        //cin=1
        $display("-----------------------------------------");
        $display("cin=1-----------------"); 
        a=1'b0; b=1'b0; cin=1'b1; #10;
        $display("%b %b %b   | %b %b ", a, b, cin, s, cout);

        a=1'b0; b=1'b1; cin=1'b1; #10;
        $display("%b %b %b   | %b %b ", a, b, cin, s, cout);

        a=1'b1; b=1'b0; cin=1'b1; #10;
        $display("%b %b %b   | %b %b ", a, b, cin, s, cout);

        a=1'b1; b=1'b1; cin=1'b1; #10;
        $display("%b %b %b   | %b %b ", a, b, cin, s, cout);

        $finish; 
    end 
endmodule 
