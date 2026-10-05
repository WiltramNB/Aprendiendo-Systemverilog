module seg7_dec(
    input  logic       win,
    output logic [6:0] seg  // segmentos: {g,f,e,d,c,b,a} activo en bajo
);
    always_comb
        case(win)
            1'b0: seg = 7'b100_0000;  // "0": a,b,c,d,e,f encendidos
            1'b1: seg = 7'b111_1001;  // "1": b,c encendidos
        endcase
endmodule