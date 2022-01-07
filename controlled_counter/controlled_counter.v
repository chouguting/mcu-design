module controlled_counter (
    input clk,reset,load_w,
    output reg[4:0] w_output      //加總後的輸出
);

//FSM的 現在狀態和下一個狀態
reg[3:0] current_state,next_state;

reg cp1,cp2;    //控制counter1和counter2(要不要數)

reg[3:0] count1,count2; //counter1和counter2數到的值

always @(negedge clk or negedge reset) begin
    if(reset==1'b0)
    begin
        //reset時把數到的數字和狀態都設為零
        count1 <= 4'h0;
        count2 <= 4'h0;
        current_state <= 4'b0; 
    end
    else 
    begin
        //如果cp=1才能上數
        if(cp1) count1 <= count1+1;
        if(cp2) count2 <= count2+1;
        current_state <= next_state;
    end
end

//這邊是W暫存器，當load_w=1時會載入值
always @(load_w or count1 or count2) begin
    w_output = load_w? count1+count2 : w_output;
end

always @(*) begin
    case (current_state)
        4'h0:  
        begin
            next_state=4'h1;
            cp1=1;
            cp2=1;
        end
        4'h1:  
        begin
            next_state=4'h2;
            cp1=1;
            cp2=1;
        end
        4'h2:  
        begin
            next_state=4'h3;
            cp1=1;
            cp2=1;
        end
        4'h3:  
        begin
            next_state=4'h4;
            cp1=1;
            cp2=1;
        end
        4'h4:  
        begin
            next_state=4'h5;
            cp1=1;
            cp2=0;  //counter2只要數到4
        end
        4'h5:  
        begin
            next_state=4'h6;
            cp1=1;
            cp2=0;
        end
        4'h6:  
        begin
            next_state=4'h7;
            cp1=1;
            cp2=0;
        end
        4'h7:  
        begin
            next_state=4'h8;
            cp1=1;
            cp2=0;
        end
        4'h8:  
        begin
            next_state=4'h9;
            cp1=1;
            cp2=0;
        end
        4'h9:  
        begin
            next_state=4'h9;
            cp1=0;  //counter1數到9
            cp2=0;
        end
        default: 
        begin
            next_state=4'h0;  //其他的狀況它跳回0
            cp1=0;
            cp2=0;
        end
    endcase
    
end
endmodule
