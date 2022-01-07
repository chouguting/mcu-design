module tb_controlled_counter;

reg clk,reset,load_w;
wire[4:0] w_output;
wire[3:0] count1,count2;

controlled_counter counter1(.clk(clk),
                           .reset(reset),
                           .load_w(load_w),
                           .w_output(w_output));

always 
begin
    #5 clk=~clk;    
end

initial begin
    #0 clk=0;   reset=0;    load_w=1;
    #15 reset=1;
    #200 $stop;
    #10 $finish;
end

initial begin
    $monitor("w_output=%d",w_output);
end
endmodule