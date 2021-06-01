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

    reg [3:0] temp;

    always @(posedge clk or negedge rst) begin
        if (rst || clr_signal) begin
            ms <= 'b0;
            sec <= 'b0;
            min <= 'b0;
        end
        else if (add_signal) begin
            ms[3:0] = ms[3:0] + 'b1;
            if (ms[3:0] == 'b1010) begin
                ms[3:0] <= 'b0000;
                ms[7:4] = ms[7:4] + 'b1;
            end
            if (ms[7:4] == 'b1010) begin
                sec[3:0] = sec[3:0] + 'b1;
                ms[7:4] <= 'b0000;
            end

            if (sec[3:0] == 'b1010) begin
                sec[3:0] <= 'b0000;
                sec[7:4] = sec[7:4] + 'b1; 
            end
            if (sec[7:4] == 'b0110) begin
                sec[7:4] <= 'b0000;
                min[3:0] = min[3:0] + 'b1; 
            end
        end
    end

endmodule
