module tb_pipeline_calculate;

reg clk,reset;
reg[4:0] A,B,C,D,E;
wire[4:0] S;

pipeline_calculate pc1(.clk(clk),.reset(reset),
                       .A(A),.B(B),.C(C),.D(D),.E(E),.S(S));
always begin
    #5 clk=~clk;
end

initial begin
    #0  clk=0; reset=1;
        A=0; B=0; C=0; D=0; E=0;
    #15 reset=0;
    @(negedge clk) A=6; B=7; C=8; D=3; E=10;
    @(negedge clk) A=4; B=8; C=7; D=3; E=1; 
    @(negedge clk) A=1; B=9; C=6; D=3; E=5;
    @(negedge clk) A=8; B=7; C=3; D=7; E=2;
    @(negedge clk) A=6; B=10; C=3; D=3; E=10;
    @(negedge clk) A=11; B=9; C=6; D=5; E=6;
    @(negedge clk) A=6; B=8; C=2; D=7; E=1;
    @(negedge clk) A=11; B=10; C=4; D=3; E=2;
    @(negedge clk) A=7; B=4; C=10; D=7; E=9;
    @(negedge clk) A=2; B=8; C=11; D=13; E=5;
    #50 $stop;
    #10 $finish;
end

initial begin
    $monitor("S=%d",S);
end
endmodule
