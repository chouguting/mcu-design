module middle_test;
	reg clk, rst;
	wire [7:0] out;
	
	middle middle1(clk, rst, out); //期中考電路
	
	always #5 clk = ~clk;
	
	initial begin
			clk = 0; rst = 1;
		#10 rst = 0;
		#2000 $stop;
	end
endmodule