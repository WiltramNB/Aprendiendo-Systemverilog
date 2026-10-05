module shift_register(
    input  logic clk,
    input logic rst,
    input logic load,
    input logic en,
    input logic sin,
    input logic [3:0] din,
    output logic [3:0] q, 
    output logic sout
); 

    always_ff @(posedge clk) begin
        if (rst)
            q<=4'b0000;
        else if (load)
            q<=din;
        else if (en)
            q<= {sin, q[3:1]};
    end

    assign sout = q[0];

endmodule 
