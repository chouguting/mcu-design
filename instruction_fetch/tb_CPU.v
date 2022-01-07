module tb_CPU;
    reg clk,reset;
    wire[13:0] ir_out;
    CPU u_cpu(.clk(clk),.reset(reset),.ir_out(ir_out));

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
        $monitor("ir_out= %x",ir_out);
    end
endmodule
