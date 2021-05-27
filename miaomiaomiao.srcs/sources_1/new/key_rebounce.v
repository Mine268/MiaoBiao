`timescale 1ns / 1ps

module key_rebounce(
    input I_clk,
    input I_rst_n,
    input I_key_in,
    output reg O_key_out
    );

    reg R_key_in0;
    reg [19:0] R_count;

    wire W_change;

    parameter C_COUNTER_NUM = 180000;

    always @(posedge I_clk or negedge I_rst_n)
        if (!I_rst_n)
            R_key_in0 <= 0;
        else
            R_key_in0 <= I_key_in;

    assign W = (I_key_in & !R_key_in0) | (!I_key_in && R_key_in0);

    always @(posedge I_clk or negedge I_rst_n)
        if (!I_rst_n)
            R_count <= 0;
        else if (W_change)
            R_count <= 0;
        else
            R_count <= R_count + 1;
    
    always @(posedge I_clk or negedge I_rst_n)
        if (!I_rst_n)
            O_key_out <= 0;
        else if (R_count >= C_COUNTER_NUM - 1)
            O_key_out <= I_key_in;

endmodule
