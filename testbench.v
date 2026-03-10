/*
    incentive document
*/
`timescale 1ns / 1ns
`include "test.v"
module testbench();
    reg clk;
    /* define the wire below */
    wire dout;

    parameter CYCLE    = 2;
    parameter END_TIME = 200;
    /* init the module below */

    test mod(
        .clk    (clk),
        .dout   (dout)
    );

/***************************************************/
    initial begin            
        $dumpfile("wave.vcd");        //生成的vcd文件名称
        $dumpvars(0, testbench);    //tb模块名称
    end 
/***************************************************/
    /* init the state */
    initial begin
        clk = 0;
        $display("time = %0t, clk = %b, dout = %b", $time, clk, dout);
    end
/***************************************************/
    /* genrate clock */
    always begin
        #(CYCLE / 2) clk = ~clk;
    end
/***************************************************/
    /* stop the simulation */
    initial begin
        #END_TIME;
        $stop;
    end

endmodule