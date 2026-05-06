module top
(
    input  wire CLK,

    output wire LCD_CLK,
    output logic LCD_DEN,
    output logic [4:0] LCD_R,
    output logic [5:0] LCD_G,
    output logic [4:0] LCD_B
);

    localparam H_ACTIVE = 480;
    localparam H_TOTAL  = 525;

    localparam V_ACTIVE = 272;
    localparam V_TOTAL  = 285;

    logic [9:0] x = 0;
    logic [8:0] y = 0;

    assign LCD_CLK = CLK;

    always_ff @(posedge CLK) begin
        if (x == H_TOTAL - 1) begin
            x <= 0;

            if (y == V_TOTAL - 1) begin
                y <= 0;
            end else begin
                y <= y + 1;
            end
        end else begin
            x <= x + 1;
        end
    end

    always_comb begin
        LCD_DEN = 0;
        LCD_R   = 5'd0;
        LCD_G   = 6'd0;
        LCD_B   = 5'd0;

        if ((x < H_ACTIVE) && (y < V_ACTIVE)) begin
            LCD_DEN = 1;

            if (x < 160) begin
                LCD_R = 5'd31;
                LCD_G = 6'd0;
                LCD_B = 5'd0;
            end else if (x < 320) begin
                LCD_R = 5'd0;
                LCD_G = 6'd63;
                LCD_B = 5'd0;
            end else begin
                LCD_R = 5'd0;
                LCD_G = 6'd0;
                LCD_B = 5'd31;
            end
        end
    end

endmodule