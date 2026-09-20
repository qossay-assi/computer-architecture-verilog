`timescale 1ps / 1ps

module tb_design2;
    reg clk;

    design2 uut (
        .clk(clk)
    );

    initial begin
        clk = 0;
    end

    always begin
        #5 clk = ~clk;
    end

    initial begin
        #2000 $finish;
    end
endmodule