module top #(parameter DIVISOR = 12_500_000)(
    input  logic        clk,
    input  logic        reset,
    input  logic        btn_b,
    output logic [15:0] led,
    output logic [6:0]  seg,
    output logic [3:0]  an
);
    logic tick;
    logic win;

    clk_div #(.DIVISOR(DIVISOR)) u_clk_div(
        .clk(clk),
        .reset(reset),
        .tick(tick)
    );

    led_ctrl u_led_ctrl(
        .clk(clk),
        .reset(reset),
        .tick(tick),
        .btn_b(btn_b),
        .leds(led)
    );

    win_detect u_win_detect(
        .leds(led),
        .win(win)
    );

    seg7_dec u_seg7_dec(
        .win(win),
        .seg(seg)
    );

    assign an = 4'b1110;

endmodule