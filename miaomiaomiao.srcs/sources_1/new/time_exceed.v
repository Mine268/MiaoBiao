`timescale 1ns / 1ps

module time_exceed(
    input wire clk,
    input wire rst,
    input wire [7:0] ms,
    input wire [7:0] sec,
    input wire [7:0] min,
    output reg legal
    );

    always @(posedge clk or posedge rst) begin
        if (rst)
            legal <= 'b1;
        else
        begin
            if (min == 8'b0000_0001 || min == 8'b0000_0000)
                legal <= 'b1;
            else
                legal <= 'b0;
        end
    end

endmodule
