`timescale 1ns/100ps
module testbench_bcd_counter;
reg clk,reset;
wire[7:0] out;
bcd_counter bcd1(.clk(clk),.reset(reset),.out(out));

always begin
    #5 clk=~clk;
end

initial begin
    #0 clk=0;  reset=1;
    #20 reset=0;
    #1100 $stop;
    #10 $finish;
end

initial begin
    $monitor("out= %h",out);
end
    
endmodule
