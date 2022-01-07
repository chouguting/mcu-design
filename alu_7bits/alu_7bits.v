module alu_7bits (
    input[7:0] A,B,
    input[2:0] op,
    output reg[7:0] S
);

always @(A or B or op) begin
    if(op==3'b000)
        S=A+B;
    else if(op==3'b001)
        S=A-B;
    else
        S=0; 
end
    
endmodule
