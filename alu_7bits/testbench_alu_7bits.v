`timescale 1ns/100ps
module testbench_alu_7bits;
    reg[7:0]A,B;
    reg[2:0]op;
    wire[7:0] S;
    alu_7bits alu1(.A(A),.B(B),.op(op),.S(S));

    initial begin
        #0   A=8'h00; B=8'h00; op=3'b000;
        #10  A=8'h95; B=8'h27; op=3'b000;
        #10  A=8'h95; B=8'h27; op=3'b001;
        #10  A=8'h0A; B=8'hD0; op=3'b000;
        #10  A=8'h0A; B=8'hD0; op=3'b001;
        #10 $stop;
        #10 $finish;
    end

    initial begin
        $monitor("A=%x   B=%x   S=%x",A,B,S);
    end

    
endmodule
