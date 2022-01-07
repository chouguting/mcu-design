module bcd_counter (
    input clk,
    input reset,
    output reg [7:0] out
);

reg Carry_bit; //低位進位

//低位的4bit BCD counter
always @(negedge clk or posedge reset) begin
    if(reset==1'b1)
        out<=8'b0;
    else
        begin
            if(out[3:0]==4'h9)
            begin
                out[3:0]<=4'h0;
                Carry_bit<=1'b1;
            end
            else
            begin
                out[3:0]<=out[3:0]+1; 
                Carry_bit<=1'b0; 
            end        
        end 
end

//高位的4bit BCD counter
always @(posedge Carry_bit) begin
    if(out[7:4]==4'h9)
        out[7:4]<=4'h0;
    else
        out[7:4]<=out[7:4]+1;  
end
    
endmodule
