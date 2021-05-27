`timescale 1ns / 1ps

// freq_div

module freq_div #(parameter SEP=100) (
    input wire clk,
    input wire rst,
    output reg enable
    );

    reg [31:0] count;

    always @(posedge clk or negedge rst)
    begin
        if (rst)
        begin
            count <= 32'b0;
        end
        else
        begin
            if (count == SEP)
            begin
                count <= 31'b0;
                enable <= 1'b1;
            end
            else
            begin
                count <= count + 1;
                enable <= 1'b0;
            end
        end
    end

endmodule
