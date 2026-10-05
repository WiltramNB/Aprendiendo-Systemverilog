`timescale 1ns / 1ps

module uart_rx #(
    parameter CLKS_PER_BIT = 10416 // Frecuencia FPGA (100MHz) / Baud Rate (9600)
)(
    input wire clk,          // reloj de la FPGA (100 MHz)
    input wire rx,           // pin de la ESP32
    output reg [7:0] data_out, // byte reconstruido
    output reg data_ready    // byte listo
);

    // estados de FSM
    localparam IDLE         = 3'b000;
    localparam RX_START_BIT = 3'b001;
    localparam RX_DATA_BITS = 3'b010;
    localparam RX_STOP_BIT  = 3'b011;
    localparam CLEANUP      = 3'b100;

    reg [2:0] state = IDLE;
    reg [13:0] clk_count = 0; // contador hasta 10416
    reg [2:0] bit_index = 0;  // para saber que bit del 0 al 7 estamos leyendo
    reg [7:0] rx_data = 0;    // registro temporal para armar el byte

    always @(posedge clk) begin
        case (state)
            // ESTADO 1: Esperando que la linea baje a 0 (Start Bit)
            IDLE: begin
                data_ready <= 0;
                clk_count <= 0;
                bit_index <= 0;
                if (rx == 1'b0) 
                    state <= RX_START_BIT;
                else
                    state <= IDLE;
            end

            // ESTADO 2: Verificando el Start Bit
            RX_START_BIT: begin
                if (clk_count == (CLKS_PER_BIT - 1)/2) begin
                    if (rx == 1'b0) begin
                        clk_count <= 0; // reiniciar
                        state <= RX_DATA_BITS;
                    end else
                        state <= IDLE;
                end else begin
                    clk_count <= clk_count + 1;
                    state <= RX_START_BIT;
                end
            end

            // ESTADO 3: Leyendo los 8 bits de datos
            RX_DATA_BITS: begin
                if (clk_count < CLKS_PER_BIT - 1) begin
                    clk_count <= clk_count + 1;
                    state <= RX_DATA_BITS;
                end else begin
                    clk_count <= 0;
                    rx_data[bit_index] <= rx; // guardar el bit recibido
                    
                    if (bit_index < 7) begin
                        bit_index <= bit_index + 1;
                        state <= RX_DATA_BITS;
                    end else begin
                        bit_index <= 0;
                        state <= RX_STOP_BIT;
                    end
                end
            end

            // ESTADO 4: Leyendo el bit de parada (Stop Bit)
            RX_STOP_BIT: begin
                if (clk_count < CLKS_PER_BIT - 1) begin
                    clk_count <= clk_count + 1;
                    state <= RX_STOP_BIT;
                end else begin
                    data_ready <= 1'b1; // dato listo
                    data_out <= rx_data; // entregar dato
                    clk_count <= 0;
                    state <= CLEANUP;
                end
            end

            // ESTADO 5: Limpieza para recibir el siguiente byte
            CLEANUP: begin
                state <= IDLE;
                data_ready <= 1'b0;
            end
            
            default: state <= IDLE;
        endcase
    end
endmodule