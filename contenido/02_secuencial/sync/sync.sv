module sync(input logic clk,
            input logic d,
            output logic q);

    logic nl;

    always_ff @(posedge clk)
        begin
            nl <= d;
            q <= nl;
        end
endmodule 