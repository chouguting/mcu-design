module CPU (
    input clk,reset,
    output reg[13:0] ir_out //instruction register的輸出
);

reg[2:0] current_state,next_state; //狀態

//四個state
parameter T0 = 0;
parameter T1 = 1;
parameter T2 = 2;
parameter T3 = 3;

reg[10:0] pc_out;  //PC暫存器
wire[10:0] pc_in;  //PC的輸入
assign pc_in = pc_out + 1;  //PC每次加一

reg [10:0] mar_out; //Memory Address Register

wire[13:0] ir_in;  //instruction register的輸入

ROM u_rom(.addr_in(mar_out),.data_out(ir_in));  //從ROM取DATA

reg load_pc, load_mar, load_ir; //控制pc,mar,ir的存入

always @(negedge clk or posedge reset) begin
    if(reset)
    begin
        current_state <= T0;  //狀態設回T0
        pc_out <= 11'b0; //PC設回零
        mar_out <= 11'b0;  //MAR歸零
        ir_out <= 14'b0;   //IR歸零
    end
    else
    begin
        if(load_pc) pc_out <= pc_in;  //把新的PC值存入
        if(load_mar) mar_out <= pc_out;  //PC值傳給MAR
        if(load_ir) ir_out <= ir_in; //存入新的instruction
        current_state <= next_state; //下一個state
    end
end

always @(*) begin
    //default值
    load_pc = 0;
    load_mar = 0;
    load_ir =0;
    next_state = 0;
    case (current_state)    
        T0: 
        begin
            next_state = T1;  //reset時的state
        end
        T1:
        begin
            load_mar = 1;  //下一個CLK時把現在的PC值存入MAR
            next_state = T2;
        end
        T2:
        begin
            load_pc = 1;   //下一個clk把PC值更新為現在的PC值+1
            next_state = T3;
        end
        T3:
        begin
            load_ir = 1;  //下一個clk把ROM的輸出DATA(instruction)存入IR
            next_state = T1;  //T3之後會再跳回T1
        end
    endcase 
end
    
endmodule
