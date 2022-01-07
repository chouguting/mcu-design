module tb_acc_counter_adder;
reg clk,reset;
wire[7:0] port_A,port_B;
acc_counter_adder A1(.clk(clk),.reset(reset),.port_A(port_A),.port_B(port_B));

always  begin
    #5 clk = ~clk;
end

initial begin
    #0 clk=0; reset=1;
    #15 reset=0;
    #280 $stop;
    #10 $finish;
end    

initial begin
    $monitor("A=%d  B=%d",port_A,port_B);
end

endmodule