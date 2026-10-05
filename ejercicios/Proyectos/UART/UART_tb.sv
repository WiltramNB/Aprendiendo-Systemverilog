`timescale 1ns / 1ps

module uart_rx_tb();

    reg clk;
    reg rx;
    
    wire [7:0] data_out;
    wire data_ready;

    localparam CLK_PERIOD = 10; 
    localparam BIT_PERIOD = 104166; 

    uart_rx uut (
        .clk(clk),
        .rx(rx),
        .data_out(data_out),
        .data_ready(data_ready)
    );

    always # (CLK_PERIOD/2) clk = ~clk;

    // Tarea de transmisión ajustada
    task enviar_byte(input [7:0] byte_in);
        integer j;
        begin
            // 1. Start Bit
            rx = 1'b0;
            #(BIT_PERIOD);
            
            // 2. Bits de datos
            for (j = 0; j < 8; j = j + 1) begin
                rx = byte_in[j];
                #(BIT_PERIOD);
            end
            
            // 3. Stop Bit (Línea a 1). 
            rx = 1'b1;
        end
    endtask

    // arreglo para almacenar nuestras pruebas
    reg [7:0] bytes_de_prueba [0:4];
    integer i;
    integer errores = 0;

    initial begin
        // cargamos 5 casos de prueba
        bytes_de_prueba[0] = 8'hAA; // 10101010
        bytes_de_prueba[1] = 8'h55; // 01010101
        bytes_de_prueba[2] = 8'h00; // 00000000
        bytes_de_prueba[3] = 8'hFF; // 11111111
        bytes_de_prueba[4] = 8'hC3; // 11000011

        // estado inicial de las líneas
        clk = 0;
        rx = 1;

        #1000;

        $display("\n============================================================");
        $display("=== INICIANDO BANCO DE PRUEBAS UART RX (9600 BAUDIOS) ===");
        $display("============================================================\n");

        // Bucle for para ejecutar el envío de los 5 paquetes
        for (i = 0; i < 5; i = i + 1) begin
            $display("[%0t ns] >> TRANSMITIENDO byte %0d: Hex 0x%h (Bin: %b)", $time, i+1, bytes_de_prueba[i], bytes_de_prueba[i]);
            
            enviar_byte(bytes_de_prueba[i]);
            
            // Esperamos explícitamente a que el módulo FPGA levante su bandera
            @(posedge data_ready);
            
            $display("[%0t ns] << RX COMPLETADO.   Dato leido: Hex 0x%h (Bin: %b)", $time, data_out, data_out);
            
            // Comparamos lo que enviamos con lo que entendió la FPGA
            if (data_out === bytes_de_prueba[i]) begin
                $display("          [EXITO] Los datos coinciden perfectamente.\n");
            end else begin
                $display("          [ERROR] Ruido o desfase detectado.\n");
                errores = errores + 1;
            end
            
            // Tiempo de reposo (Idle) antes de enviar el siguiente byte
            #(BIT_PERIOD * 3);
        end

        // resumen
        $display("============================================================");
        if (errores == 0)
            $display("=== RESULTADO FINAL: 5/5 PRUEBAS PASADAS CON EXITO :)  ===");
        else
            $display("=== RESULTADO FINAL: SE ENCONTRARON %0d ERRORES ===", errores);
        $display("============================================================\n");

        $finish;
    end
endmodule