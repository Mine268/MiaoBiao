`timescale 1ns / 1ps

// max=1:59:99=11999=2edf
// overflo=ffff

module core(
    input wire clk,
    input wire rstn,
    input wire start,
    input wire pause,
    input wire reset,
    output reg [15:0] current
    );

    reg stop;
    parameter TIME_MAX = 16'h2EDF;
    parameter ERROR_CD = 16'hFFFF;

    always @(posedge clk or negedge rstn) begin
        if (rstn) begin
           stop <= 1'b1; 
           current <= 16'h0000;
        end
        else if (current == ERROR_CD &&
            (start == 1'b1 || reset == 1'b1 || pause == 1'b1)) begin
            stop <= 0'b1;
            current <= 16'h0000;
            end
        else if (current == TIME_MAX && stop == 1'b0 &&
            !(reset == 1'b1 || pause == 1'b1)) begin
               stop <= 1'b1;
               current <= ERROR_CD;
            end
        else begin
            if (stop == 1'b0) begin
                if (pause == 1'b1) begin
                    stop <= 1'b1;
                end
                else if (reset == 1'b1) begin
                    stop <= 1'b1;
                    current <= 16'H0000;
                end
                else begin
                    current <= current + 1;
                end
            end
            else begin
                if (start == 1'b1) begin
                    stop <= 0'b0; 
                end
                else if (reset == 1'b1) begin
                    current <= 16'H0000; 
                end
            end
        end
    end

endmodule
