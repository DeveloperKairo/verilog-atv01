module fsm (
    input wire clk,
    input wire sensor,
    output wire agua
);

    parameter OFF = 2'b00;
    parameter DETECCAO = 2'b01;
    parameter LIGADA = 2'b10;
    parameter DESLIGANDO = 2'b11;

    reg [1:0] estado;

    initial begin
        estado = OFF;
    end

    always @(posedge clk) begin

        case (estado)

            OFF: begin
                if (sensor)
                    estado <= DETECCAO;
            end

            DETECCAO: begin
                if (sensor)
                    estado <= LIGADA;
                else
                    estado <= OFF;
            end

            LIGADA: begin
                if (!sensor)
                    estado <= DESLIGANDO;
            end

            DESLIGANDO: begin
                estado <= OFF;
            end

            default: begin
                estado <= OFF;
            end

        endcase

    end

    assign agua = (estado == LIGADA);

endmodule