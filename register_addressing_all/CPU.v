module CPU (
    input clk,reset,
    output [7:0] w_output, //alu的輸出後存的值(本次作業的輸出)
    output [7:0] ram_output //alu的輸出後存的值(本次作業的輸出)
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
reg [10:0] mar_out; //Memory Address Register
reg load_pc, load_mar, load_ir; //控制pc,mar,ir的存入


//指令(IR)相關
wire[13:0] ir_in;  //instruction register的輸入
reg [13:0] ir_out; //instruction存的值
Program_Rom u_rom(.Rom_addr_in(mar_out),.Rom_data_out(ir_in));  //從ROM取DATA

//W相關
reg load_w; //控制ALU之後的結果儲存
reg[7:0] w_out; //alu的輸出後的暫存器值

//ALU相關
reg[7:0] alu_out; //alu的輸出
reg[5:0] op;  //給ALU看的OPCODE

assign w_output = w_out;  //alu的輸出後存的值(本次作業的輸出)

//RAM相關
wire[7:0] databus; //RAM的輸入
reg ram_en; //控制RAM的存入
wire[7:0] ram_out; //RAM的輸出
single_port_ram_128x8 u_ram(.data(databus),.addr(ir_out[6:0]),.en(ram_en),.clk(clk),.q(ram_out));

assign ram_output = ram_out;  //ram的輸出後存的值(本次作業的輸出)

//決定ALU的輸入
reg sel_alu; //決定ALU的輸入來自哪裡
wire[7:0] mux1_out;
assign mux1_out = (sel_alu) ? ram_out : ir_out[7:0];  //ALU的輸入來自指令或RAM

//決定PC的輸入來自哪裡
reg sel_pc; //決定PC的輸入來自哪裡
assign pc_in = (sel_pc)? ir_out[10:0] : (pc_out + 1);  //PC每次加一


//決定RAM的輸入
reg sel_bus; //決定RAM的輸入來自哪裡
assign databus = (sel_bus) ? w_out : alu_out;  //RAM的輸入來自指令或ALU




always @(negedge clk or posedge reset) begin
    if(reset)
    begin
        current_state <= T0;  //狀態設回T0
        pc_out <= 11'b0; //PC設回零
        mar_out <= 11'b0;  //MAR歸零
        ir_out <= 14'b0;   //IR歸零
        //alu_out <= 8'h0;  //ALU輸出歸零
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
wire ADDWF, ANDWF, CLRF, CLRW, COMF, DECF; //暫存器定址的指令
wire INCF,IORWF,MOVF,MOVWF,SUBWF,XORWF; //更多暫存器定址的指令

wire GOTO; //跳躍指令
assign MOVLW = (ir_out[13:8]==6'h30);
assign ADDLW = (ir_out[13:8]==6'h3E);
assign SUBLW = (ir_out[13:8]==6'h3C);
assign ANDLW = (ir_out[13:8]==6'h39);
assign IORLW = (ir_out[13:8]==6'h38);
assign XORLW = (ir_out[13:8]==6'h3A);
assign ADDWF = (ir_out[13:8]==6'h07);
assign ANDWF = (ir_out[13:8]==6'h05);
assign CLRF = (ir_out[13:8]==6'h01 && ir_out[7]==1'b1);
assign CLRW = (ir_out[13:4]==10'h010 && ir_out[3:2]==2'b00);
assign COMF = (ir_out[13:8]==6'h09);
assign DECF = (ir_out[13:8]==6'h03);
assign GOTO = (ir_out[13:11]==3'b101);
assign INCF = (ir_out[13:8]==6'h0A);
assign IORWF = (ir_out[13:8]==6'h04);
assign MOVF = (ir_out[13:8]==6'h08);
assign MOVWF = (ir_out[13:8]==6'h00 && ir_out[7]==1'b1);
assign SUBWF = (ir_out[13:8]==6'h02);
assign XORWF = (ir_out[13:8]==6'h06);

//ALU的運作
always @(*) begin
    case(op)
        6'h0: alu_out = mux1_out + w_out;
        6'h1: alu_out = mux1_out - w_out;
        6'h2: alu_out = mux1_out & w_out;
        6'h3: alu_out = mux1_out | w_out;
        6'h4: alu_out = mux1_out ^ w_out;
        6'h5: alu_out = mux1_out;
        6'h6: alu_out = mux1_out+1;
        6'h7: alu_out = mux1_out-1;
        6'h8: alu_out = 0;
        6'h9: alu_out = ~mux1_out;
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
    sel_pc = 0;
    sel_alu = 0;
    op = 0;
    ram_en=0;
    sel_bus=0;  //決定RAM的輸入來自哪裡(預設來自ALU)
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
            sel_pc = 0; //PC輸入來自PC+1
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
            else if(GOTO)
            begin
                sel_pc=1;
                load_pc=1;
            end
            else if(ADDWF)
            begin
                op = 6'h0;
                sel_alu = 1;
                if(ir_out[7]==1'b0)
                    load_w=1;
                else
                    ram_en=1;
            end
            else if(ANDWF)
            begin
                op = 6'h2;
                sel_alu = 1;
                if(ir_out[7]==1'b0)
                    load_w=1;
                else
                    ram_en=1;
            end
            else if(CLRF)
            begin
                op = 6'h8;
                ram_en=1;
            end
            else if(CLRW)
            begin
                op = 6'h8;
                sel_alu = 1;
                load_w=1;
            end
            else if(COMF)
            begin
                op = 6'h9;
                sel_alu = 1;
                ram_en = 1;
            end
            else if(DECF)
            begin
                op = 6'h7;
                sel_alu = 1;
                ram_en = 1;
            end
            else if(INCF)
            begin
                op = 6'h6;
                sel_alu = 1;
                if(ir_out[7]==1'b0)
                    load_w=1;
                else
                begin
                    ram_en=1;
                    sel_bus=0;
                end
                   
            end
            else if(IORWF)
            begin
                op = 6'h3;
                sel_alu = 1;
                if(ir_out[7]==1'b0)
                    load_w=1;
                else
                begin
                    ram_en=1;
                    sel_bus=0;
                end
                   
            end
            else if(MOVF)
            begin
                op = 6'h5;
                sel_alu = 1;
                if(ir_out[7]==1'b0)
                    load_w=1;
                else
                begin
                    ram_en=1;
                    sel_bus=0;
                end
                   
            end
            else if(MOVWF)
            begin
               ram_en=1;
               sel_bus=1; 
            end
            else if(SUBWF)
            begin
                op = 6'h1;
                sel_alu = 1;
                if(ir_out[7]==1'b0)
                    load_w=1;
                else
                begin
                    ram_en=1;
                    sel_bus=0;
                end
                   
            end
            else if(XORWF)
            begin
                op = 6'h4;
                sel_alu = 1;
                if(ir_out[7]==1'b0)
                    load_w=1;
                else
                begin
                    ram_en=1;
                    sel_bus=0;
                end
                   
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
