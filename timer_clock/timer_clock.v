module timer_clock (
    input reset,clk,
    output reg [7:0] hour,minute
);
    reg[2:0] Carry_bit;

    reg twoOrNot; //時的十位數是不是2
    reg[3:0] hour_LSB_upper; //決定時的個位數要數到多少

    //分的個位數
    always @(negedge clk or posedge reset)
    begin
        if(reset==1'b1)
        begin
            hour<=8'b0;
            minute<=8'b0;
            hour_LSB_upper<=4'h9;
        end
        else
        begin
            if(minute[3:0]==4'h9)
            begin
                minute[3:0]<=4'b0;
                Carry_bit[0]<=1; //進位給下一位
            end
            else
            begin
                minute[3:0]<=minute[3:0]+1;
                Carry_bit[0]<=0;
            end
        end        
    end

    //分的十位數
    always @(posedge Carry_bit[0])
    begin  
        if(minute[7:4]==4'h5)
        begin
            minute[7:4]<=4'b0;
            Carry_bit[1]<=1;  //進位給下一位
        end
        else
        begin
            minute[7:4]<=minute[7:4]+1;
            Carry_bit[1]<=0;
        end              
    end

    //時的十位能決定時的個位數要屬到幾
    always @(twoOrNot) begin
        if(twoOrNot==1'b1)
            hour_LSB_upper=4'h3;
        else
            hour_LSB_upper=4'h9;
    end

    //時的個位數
    always @(posedge Carry_bit[1])
    begin  
        if(hour[3:0]==hour_LSB_upper)
        begin
            hour[3:0]<=4'b0;
            Carry_bit[2]<=1;  //進位給下一位
        end
        else
        begin
            hour[3:0]<=hour[3:0]+1;
            Carry_bit[2]<=0;
        end              
    end


    
    //時的十位數
    always @(posedge Carry_bit[2])
    begin  
        if(hour[7:4]==4'h2)
            hour[7:4]<=4'b0;
        else
            hour[7:4]<=hour[7:4]+1;      

        if(hour[7:4]==4'h1)
            twoOrNot<=1;
        else   
            twoOrNot<=0;     
    end
        
endmodule
