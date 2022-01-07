module acc_counter_adder (
    input clk,reset,
    output reg[7:0] port_A,port_B
);

reg[4:0] current_state,next_state;  //目前狀態,下一個狀態
reg cnt,load_w,load_A,load_B;       //cnt:控制counter  load_x:要不要將資料存進x暫存器

reg[7:0] count_value; //數到的數字(B)
reg[7:0] W; //W暫存器存的值

wire[7:0] sum; //加法器加起來後的線(S)
assign sum = count_value+W;

always @(negedge clk or posedge reset) begin
    if(reset)
    begin
        port_A <= 8'b0;
        port_B <= 8'b0;
        W <= 8'b0;
        current_state <= 5'b0;
        count_value <= 8'b0;
    end
    else
    begin
        current_state <= next_state;  //改變狀態
        if(cnt) count_value <= count_value+1;  //counter+1
        if(load_w) W<=sum;  //加完後的值存到W暫存器
        if(load_A) port_A<=W;  //W暫存器的值移到A
        if(load_B) port_B<=W;  //W暫存器的值移到B
    end
end

always @(*) begin
    next_state=5'd0;
    load_A=0;
    load_B=0;
    load_w=0;
    cnt=0;
    case(current_state)
        5'd0:
        begin
            cnt=1;
            load_w=1;
            next_state=5'd1;
        end
        5'd1:
        begin
            cnt=1;
            load_w=1;
            next_state=5'd2;
        end
        5'd2:
        begin
            cnt=1;
            load_w=1;
            next_state=5'd3;
        end
        5'd3:
        begin
            cnt=1;
            load_w=1;
            next_state=5'd4;
        end
        5'd4:
        begin
            cnt=1;
            load_w=1;
            next_state=5'd5;
        end
        5'd5:
        begin
            cnt=1;
            load_w=1;
            next_state=5'd6;
        end
        5'd6:
        begin
            cnt=1;
            load_w=1;
            next_state=5'd7;
        end
        5'd7:
        begin
            cnt=1;
            load_w=1;
            next_state=5'd8;
        end
        5'd8:
        begin
            cnt=1;
            load_w=1;
            next_state=5'd9;
        end
        5'd9:
        begin
            cnt=1;
            load_w=1;
            next_state=5'd10;
        end
        5'd10:
        begin
            cnt=1;  //這個時候counter數到了10
            load_w=1; 
            next_state=5'd11;
        end
        5'd11:
        begin
            cnt=1;
            load_w=1;  //這個時候加到10的結果存到了W
            load_A=1; //下個clk將加到10的結果存到A中
            next_state=5'd12;
        end
        5'd12:
        begin
            cnt=1;
            load_w=1;  
            next_state=5'd13;
        end
        5'd13:
        begin
            cnt=1;
            load_w=1;  
            next_state=5'd14;
        end
        5'd14:
        begin
            cnt=1;
            load_w=1;  
            next_state=5'd15;
        end
        5'd15:
        begin
            cnt=1;
            load_w=1;  
            next_state=5'd16;
        end
        5'd16:
        begin
            cnt=1;
            load_w=1;  
            next_state=5'd17;
        end
        5'd17:
        begin
            cnt=1;
            load_w=1;  
            next_state=5'd18;
        end
        5'd18:
        begin
            cnt=1;
            load_w=1;  
            next_state=5'd19;
        end
        5'd19:
        begin
            cnt=1;
            load_w=1;  
            next_state=5'd20;
        end
        5'd20:
        begin
            cnt=1;     //這個時候counter已經數到20
            load_w=1;  //下個clk 加到20的結果存進W
            next_state=5'd21;
        end
        5'd21:
        begin     
            load_B=1;  //下個clk將加到20的結果從W存進B
            next_state=5'd22;
        end
        5'd22:
        begin      
            next_state=5'd22; //停在這個state
        end
    endcase
end
    
endmodule
