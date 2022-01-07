module pipeline_calculate (
    input clk,reset,
    input[4:0] A,B,C,D,E,
    output reg[4:0] S
);

//pipeline第一階的暫存器
reg[4:0] A_B_sum,C_D_sum,E_mid;   //A+B, C+D, E

//pipeline第二階的暫存器
reg[4:0] AB_CD_minus,E_end;  //(A+B)-(C+D) ,E

//pipeline第三階是輸出S

always @(negedge clk,posedge reset) begin
    if(reset)   
    begin
        A_B_sum <= 5'b0;
        C_D_sum <= 5'b0;
        E_mid <= 5'b0;
        AB_CD_minus <= 5'b0;
        E_end <= 5'b0;
        S <= 5'b0;
    end
    else
    begin
        //pipeline 第一階
        A_B_sum <= A+B;
        C_D_sum <= C+D;
        E_mid <= E;

        //pipeline 第二階
        AB_CD_minus <= A_B_sum-C_D_sum;
        E_end <= E_mid;

        //pipeline 第三階
        S <= AB_CD_minus & E_end;
    end
end
    
endmodule
