module clk_div #(parameter DIVISOR = 12_500_000)(
    input  logic clk,
    input  logic reset,
    output logic tick
);
    logic [23:0] count;

    always_ff @(posedge clk, posedge reset)
        if (reset) begin
            count <= 0;
            tick  <= 0;
        end else if (count == DIVISOR - 1) begin
            count <= 0;
            tick  <= 1;
        end else begin
            count <= count + 1;
            tick  <= 0;
        end
endmodule