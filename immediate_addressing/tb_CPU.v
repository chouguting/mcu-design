module tb_CPU;
    reg clk,reset;
    wire[7:0] w_output;
    CPU u_cpu(.clk(clk),.reset(reset),.w_output(w_output));

    always  begin
        #5 clk=~clk;
    end    

    initial begin
        #0 clk=0;   reset=1;
        #15 reset=0;
        #1000 $stop;
        #10 $finish;
    end

    initial begin
        $monitor("w_output= %x",w_output);
    end
endmodule
