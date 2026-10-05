module ROM( input  logic [2:0] addr,
            output logic [3:0] cmd);

    always_comb begin
        case (addr)
            3'b000: cmd = 4'b1011;
            3'b001: cmd = 4'b0110;
            3'b010: cmd = 4'b1100;
            3'b011: cmd = 4'b0001;
            3'b100: cmd = 4'b1110;
            3'b101: cmd = 4'b0101;
            3'b110: cmd = 4'b1000;
            3'b111: cmd = 4'b0011;
            default: cmd = 4'b0000;
        endcase
    end
endmodule