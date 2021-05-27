`timescale 1ns / 1ps

module testbench_freq_div ();
	reg clk;
	reg rstn;
	wire getFreq;

	always #5 clk = ~clk;

	initial begin
		clk = 0;
		rstn = 1;
		#20
		rstn = 0;
	end

	freq_div #(1<<4) fd(.clk(clk), .rst(rstn), .enable(getFreq));

endmodule