module test (
    input clk,
    output dout
);
    assign dout = ~clk;
endmodule
