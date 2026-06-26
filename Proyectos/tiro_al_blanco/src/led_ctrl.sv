module led_ctrl(
    input  logic        clk,
    input  logic        reset,
    input  logic        tick,
    input  logic        btn_b,
    output logic [15:0] leds
);
    typedef enum logic {LEFT, RIGHT} direction_t;
    direction_t dir;
    logic [3:0] pos;

    always_ff @(posedge clk, posedge reset)
        if (reset) begin
            pos  <= 4'd15;        // empieza en LED 15 (extremo izquierdo)
            dir  <= RIGHT;        // dirección: hacia la derecha (pos decrece)
            leds <= 16'b1 << 15;  // LED 15 encendido
        end else if (btn_b && tick) begin
            if (dir == RIGHT) begin
                if (pos == 4'd0) begin
                    dir <= LEFT;
                    pos <= pos + 1;
                end else
                    pos <= pos - 1;
            end else begin
                if (pos == 4'd15) begin
                    dir <= RIGHT;
                    pos <= pos - 1;
                end else
                    pos <= pos + 1;
            end
            leds <= 16'b1 << pos;
        end

endmodule