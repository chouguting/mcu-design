module CPU (
    input clk,reset,
    output [7:0] w_output //alu的輸出後存的值(本次作業的輸出)
);

reg[2:0] current_state,next_state; //狀態

//六個state
parameter T0 = 0;
parameter T1 = 1;
parameter T2 = 2;
parameter T3 = 3;
parameter T4 = 4;
parameter T5 = 5;
parameter T6 = 6;

//Instruction Fetch相關
reg[10:0] pc_out;  //PC暫存器
wire[10:0] pc_in;  //PC的輸入
assign pc_in = pc_out + 1;  //PC每次加一
reg [10:0] mar_out; //Memory Address Register
reg load_pc, load_mar, load_ir; //控制pc,mar,ir的存入

//指令(IR)相關
wire[13:0] ir_in;  //instruction register的輸入
reg [13:0] ir_out; //instruction存的值
ROM u_rom(.addr_in(mar_out),.data_out(ir_in));  //從ROM取DATA

//W相關
reg load_w; //控制ALU之後的結果儲存
reg[7:0] w_out; //alu的輸出後的暫存器值

//ALU相關
reg[7:0] alu_out; //alu的輸出
reg[5:0] op;  //給ALU看的OPCODE

assign w_output = w_out;  //alu的輸出後存的值(本次作業的輸出)

always @(negedge clk or posedge reset) begin
    if(reset)
    begin
        current_state <= T0;  //狀態設回T0
        pc_out <= 11'b0; //PC設回零
        mar_out <= 11'b0;  //MAR歸零
        ir_out <= 14'b0;   //IR歸零
        alu_out <= 8'h0;  //ALU輸出歸零
        w_out <=  8'h0; //W暫存器輸出歸零
    end
    else
    begin
        if(load_pc) pc_out <= pc_in;  //把新的PC值存入
        if(load_mar) mar_out <= pc_out;  //PC值傳給MAR
        if(load_ir) ir_out <= ir_in; //存入新的instruction
        if(load_w)  w_out <= alu_out;  //alu的輸出給W
        current_state <= next_state; //下一個state
    end
end

//opcode解碼部分
wire MOVLW, ADDLW, SUBLW, ANDLW, IORLW, XORLW; //立即定址的指令
assign MOVLW = (ir_out[13:8]==6'h30);
assign ADDLW = (ir_out[13:8]==6'h3E);
assign SUBLW = (ir_out[13:8]==6'h3C);
assign ANDLW = (ir_out[13:8]==6'h39);
assign IORLW = (ir_out[13:8]==6'h38);
assign XORLW = (ir_out[13:8]==6'h3A);

//ALU的運作
always @(*) begin
    case(op)
        6'h0: alu_out = ir_out[7:0] + w_out;
        6'h1: alu_out = ir_out[7:0] - w_out;
        6'h2: alu_out = ir_out[7:0] & w_out;
        6'h3: alu_out = ir_out[7:0] | w_out;
        6'h4: alu_out = ir_out[7:0] ^ w_out;
        6'h5: alu_out = ir_out[7:0];
        default: alu_out = 8'hx;
    endcase 
end

//FSM
always @(*) begin
    //default值
    load_pc = 0;
    load_mar = 0;
    load_ir =0;
    load_w = 0;
    next_state = 0;
    op = 0;
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
            next_state = T4;  
        end
        T4:
        begin
            if(MOVLW)
            begin
                op = 6'h5;
                load_w = 1;
            end
            else if(ADDLW)
            begin
                op = 6'h0;
                load_w = 1;
            end
            else if(SUBLW)
            begin
                op = 6'h1;
                load_w = 1;
            end
            else if(ANDLW)
            begin
                op = 6'h2;
                load_w = 1;
            end
            else if(IORLW)
            begin
                op = 6'h3;
                load_w = 1;
            end
            else if(XORLW)
            begin
                op = 6'h4;
                load_w = 1;
            end
            next_state = T5; 
        end
        T5:
        begin
            next_state = T6;  
        end
        T6:
        begin
            next_state = T1;  //T6之後會再跳回T1
        end
    endcase 
end 
endmodule
