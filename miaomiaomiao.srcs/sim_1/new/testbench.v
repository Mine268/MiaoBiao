`timescale 1ns / 1ps

module testbench();

    reg clock;
    reg rstn;
    reg start;
    reg reset;
    reg pause;
    wire[15:0] current;

    always #5 clock = ~clock;

    initial begin
        clock = 0;
        rstn = 1;
        start = 0;
        reset = 0;
        pause = 0;

        #10
        rstn = 0;
        start = 1;

        #10
        start = 0;

        #30
        pause = 1;
        #10
        pause = 0;

        #30
        start = 1;
        #10
        start = 0;

        #30
        pause = 1;
        #10
        pause = 0;

        #30
        reset = 1;
        #10
        reset = 0;

        #30
        start = 1;
        #20
        start = 0;
    end

    core core1(
        .clk(clock),
        .rstn(rstn),
        .start(start),
        .pause(pause),
        .reset(reset),
        .current(current));

endmodule
