module traffic_light (
    input clk,reset,
    //兩組紅綠燈的輸出
    output reg[1:0] red_light,yellow_light,green_light 
);

//FSM的 現在狀態和下一個狀態
reg[3:0] current_state,next_state;

always @(negedge clk or negedge reset) begin
    if(reset==1'b0)
    begin
       current_state <= 4'h0;  //state歸零
    end
    else
        current_state <= next_state;  //下一個state
end

always @(*) begin
    case (current_state)
        4'h0: 
        begin
            //1號紅綠燈是紅燈, 0號紅綠燈是綠燈
            {red_light,yellow_light,green_light}=6'b100001;
            next_state = 4'h1; 
        end
        4'h1: 
        begin
            //1號紅綠燈是紅燈, 0號紅綠燈是綠燈
            {red_light,yellow_light,green_light}=6'b100001;
            next_state = 4'h2; 
        end
        4'h2: 
        begin
            //1號紅綠燈是紅燈, 0號紅綠燈是綠燈
            {red_light,yellow_light,green_light}=6'b100001;
            next_state = 4'h3; 
        end
        4'h3: 
        begin
            //1號紅綠燈是紅燈, 0號紅綠燈是綠燈
            {red_light,yellow_light,green_light}=6'b100001;
            next_state = 4'h4; 
        end
        4'h4: 
        begin
            //1號紅綠燈是紅燈, 0號紅綠燈是綠燈
            {red_light,yellow_light,green_light}=6'b100001;
            next_state = 4'h5; 
        end
        4'h5: 
        begin
            //1號紅綠燈是紅燈, 0號紅綠燈是綠燈
            {red_light,yellow_light,green_light}=6'b100001;
            next_state = 4'h6; 
        end
        4'h6: 
        begin
            //1號紅綠燈是紅燈, 0號紅綠燈是黃燈
            {red_light,yellow_light,green_light}=6'b100100;
            next_state = 4'h7; 
        end
        4'h7: 
        begin
            //1號紅綠燈是紅燈, 0號紅綠燈是黃燈
            {red_light,yellow_light,green_light}=6'b100100;
            next_state = 4'h8; 
        end
        4'h8: 
        begin
            //1號紅綠燈是綠燈, 0號紅綠燈是紅燈
            {red_light,yellow_light,green_light}=6'b010010;
            next_state = 4'h9; 
        end
        4'h9: 
        begin
             //1號紅綠燈是綠燈, 0號紅綠燈是紅燈
            {red_light,yellow_light,green_light}=6'b010010;
            next_state = 4'hA; 
        end
        4'hA: 
        begin
             //1號紅綠燈是綠燈, 0號紅綠燈是紅燈
            {red_light,yellow_light,green_light}=6'b010010;
            next_state = 4'hB; 
        end
        4'hB: 
        begin
             //1號紅綠燈是綠燈, 0號紅綠燈是紅燈
            {red_light,yellow_light,green_light}=6'b010010;
            next_state = 4'hC; 
        end
        4'hC: 
        begin
             //1號紅綠燈是綠燈, 0號紅綠燈是紅燈
            {red_light,yellow_light,green_light}=6'b010010;
            next_state = 4'hD; 
        end
        4'hD: 
        begin
             //1號紅綠燈是綠燈, 0號紅綠燈是紅燈
            {red_light,yellow_light,green_light}=6'b010010;
            next_state = 4'hE; 
        end
        4'hE: 
        begin
             //1號紅綠燈是黃燈, 0號紅綠燈是紅燈
            {red_light,yellow_light,green_light}=6'b011000;
            next_state = 4'hF; 
        end
        4'hF: 
        begin
             //1號紅綠燈是黃燈, 0號紅綠燈是紅燈
            {red_light,yellow_light,green_light}=6'b011000;
            next_state = 4'h0; 
        end
        default: 
        begin
            //其他狀況，讓它跳回零
            {red_light,yellow_light,green_light}=6'b000000;
            next_state = 4'h0; 
        end
    endcase
end
endmodule
