`timescale 1ns/100ps
module tb_timer_clock;
reg reset,clk;
wire[7:0] hour,minute;

timer_clock c1(.reset(reset),.clk(clk),.hour(hour),.minute(minute));

always begin
    #5 clk=~clk;
end

initial begin
    #0 clk=0;  reset=1;
    #20 reset=0;
    #21000 $stop;
    #10 $finish;
end

initial begin
    $monitor("time=%x:%x",hour,minute);
end
endmodule
