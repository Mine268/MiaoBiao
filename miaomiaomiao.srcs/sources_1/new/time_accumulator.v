`timescale 1ns / 1ps

module time_accumulator(
    input clk,
    input rst,
    input clr_signal,
    input add_signal,

    output reg [7:0] ms,
    output reg [7:0] sec,
    output reg [7:0] min
    );

    always @(posedge clk or negedge rst) begin
        if (rst || clr_signal) begin
            ms <= 'b0;
            sec <= 'b0;
            min <= 'b0;
        end
        else if (add_signal) begin
            ms <= ms + 1;
            if (ms == 100) begin
                ms <= 'b0;
                sec <= sec + 1;
            end
            if (sec == 60) begin
                sec <= 'b0;
                min <= min + 1;
            end
        end
    end

endmodule
