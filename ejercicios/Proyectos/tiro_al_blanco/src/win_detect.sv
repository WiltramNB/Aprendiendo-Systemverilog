module win_detect(
    input  logic [15:0] leds,
    output logic        win
);
    assign win = leds[8];
endmodule