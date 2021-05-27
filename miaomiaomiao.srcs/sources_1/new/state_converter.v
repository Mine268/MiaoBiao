`timescale 1ns / 1ps

module state_converter(
    input clk,
    input rst,

    input wire [7:0] ms,
    input wire [7:0] sec,
    input wire [7:0] min,

    input start,
    input pause,
    input reset,

    output reg clr_signal,
    output reg add_signal
    
    reg [1:0] State;
    );

    parameter ACTIVE = 2'b00;
    parameter PAUSE = 2'b01;
    parameter ERROR = 2'b10;

    wire time_legal;
    time_exceed te(clk, rst, ms, sec, min, time_legal);

    always @(posedge clk or negedge rst) begin
        if (rst) begin
            State <= PAUSE;
            add_signal <= 'b0;
            clr_signal <= 'b1;
        end
        else begin
            case (State)
            ACTIVE:
            begin
                if (pause) begin
                    add_signal <= 'b0;
                    clr_signal <= 'b0;
                    State <= PAUSE;
                end
                else if (reset) begin
                    add_signal <= 'b0;
                    clr_signal <= 'b1;
                    State <= PAUSE;
                end
                else if (time_legal) begin
                    add_signal <= 'b1;
                    clr_signal <= 'b0;
                end
                else begin
                    add_signal <= 'b0;
                    clr_signal <= 'b1;
                    State <= ERROR;
                end
            end
            PAUSE:
            begin
                if (pause) begin
                    add_signal <= 'b0;
                    clr_signal <= 'b0;
                end
                else if (reset) begin
                    add_signal <= 'b0;
                    clr_signal <= 'b1;
                end
                else if (start) begin
                    add_signal <= 'b1;
                    clr_signal <= 'b0;
                    State = ACTIVE;
                end
            end
            ERROR:
            begin
                if (pause || start) begin
                    add_signal <= 'b0;
                    clr_signal <= 'b0;
                end
                else if (reset) begin
                    add_signal <= 'b0;
                    clr_signal <= 'b1;
                    State <= PAUSE;
                end
            end
            default:;
            endcase
        end
    end

endmodule
