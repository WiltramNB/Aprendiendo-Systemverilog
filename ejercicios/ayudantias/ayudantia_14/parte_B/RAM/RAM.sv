module RAM (
    input  logic       clk,
    input  logic       rst,
    input  logic       we,
    input  logic [1:0] addr,
    input  logic [3:0] din,
    output logic [3:0] dout
);
    logic [3:0] mem [0:3];

    always_ff @(posedge clk) begin
        if (rst) begin
            mem[0] <= 4'b0000;
            mem[1] <= 4'b0000;
            mem[2] <= 4'b0000;
            mem[3] <= 4'b0000;
        end else if (we) begin
            mem[addr] <= din;
        end
    end

    // Lectura combinacional
    assign dout = mem[addr];

endmodule