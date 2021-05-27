`timescale 1ns / 1ps

module testbench();

    reg clk;
    reg rst;
    reg start;
    reg reset;
    reg pause;

    wire clr_signal;
    wire add_signal;

    wire [7:0] ms;
    wire [7:0] sec;
    wire [7:0] min;

    wire legal;

    time_accumulator ta(clk, rst, clr_signal, add_signal, ms, sec, min);
    state_converter sc(clk, rst, ms, sec, min, start, pause, reset, clr_signal, add_signal);

    always #5 clk = ~clk;

    initial begin
        start = 0;
        pause = 0;
        reset = 0;
        rst = 1;
        clk = 0;
        #20
        rst = 0;
        
        #10
        start = 1;
        #10
        start = 0;

        #121305
        reset = 1;
        #10
        reset = 0;

        #20
        start = 1;
        #10
        start = 0;
    end

endmodule
