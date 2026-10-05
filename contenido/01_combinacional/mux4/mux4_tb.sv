module mux4_tb; 
    // declara tus senales aqui 
    logic [3:0] d0, d1, d2, d3, y;
    logic [1:0] s;

    mux4 dut(.d0(d0), .d1(d1), .d2(d2), .d3(d3), .s(s), .y(y)); 

    initial begin 
        $display("=== Test: mux4 ==="); 
        $display("  d3    d2    d1    d0   s  |  y  | valor esperado"); 
        $display("----------------------------+-----"); 

        // s=00 -> y = d0
        d0=4'b1111; d1=4'b0000; d2=4'b0000; d3=4'b0000; s=2'b00; #10;
        $display("%4b  %4b  %4b  %4b  %2b | %4b  | %4b", d0, d1, d2, d3, s, y, d0);

        // s=01 -> y = d1
        d1=4'b1111; d0=4'b0000; d2=4'b0000; d3=4'b0000; s=2'b01; #10;
        $display("%4b  %4b  %4b  %4b  %2b | %4b  | %4b", d0, d1, d2, d3, s, y, d1);

        // s=10 -> y = d2
        d2=4'b1111; d1=4'b0000; d0=4'b0000; d3=4'b0000; s=2'b10; #10;
        $display("%4b  %4b  %4b  %4b  %2b | %4b  | %4b", d0, d1, d2, d3, s, y, d2);

        // s=11 -> y = d3
        d3=4'b1111; d1=4'b0000; d2=4'b0000; d0=4'b0000; s=2'b11; #10;
        $display("%4b  %4b  %4b  %4b  %2b | %4b  | %4b", d0, d1, d2, d3, s, y, d3);

        $finish; 
    end 
endmodule 
