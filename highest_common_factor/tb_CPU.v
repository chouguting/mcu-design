module tb_CPU;
    reg clk,reset;
    wire[7:0] w_output,b_output;
    CPU u_cpu(.clk(clk),.reset(reset),.w_output(w_output),.b_output(b_output));

    always  begin
        #5 clk=~clk;
    end    

    initial begin
        #0 clk=0;   reset=1;
        #15 reset=0;
        #50000 $stop;
        #10 $finish;
    end

    initial begin
        $monitor("w_output= %x  b_output= %x",w_output,b_output);
    end
endmodule
