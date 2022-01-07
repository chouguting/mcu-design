module middle (
    input clk,reset,
    output wire[7:0] mid_out
);

reg[2:0] current_state,next_state; //狀態

//四個state
parameter T0 = 0;
parameter T1 = 1;
parameter T2 = 2;
parameter T3 = 3;
parameter T4 = 4;



reg[3:0] pc_out;  //PC暫存器
wire[3:0] pc_in;  //PC的輸入
assign pc_in = pc_out + 1;  //PC每次加一

wire[15:0] rom_out;
Program_Rom u_rom(.Rom_addr_in(pc_out),.Rom_data_out(rom_out));  //從ROM取DATA

reg[3:0] a_q,b_q,c_q,d_q,out_q;

reg load_pc, load_reg; //控制pc,reg的存入


reg[7:0] mult_out,ad_out,bc_out;  //multiplier output

reg load_ad, load_bc, load_out; //控制pc,reg的存入

reg[7:0] count;

always @(posedge clk or posedge reset) begin
    if(reset)
    begin
        current_state <= T1;  //狀態設回T0
        pc_out <= 4'b0; //PC設回零
        a_q <= 4'b0;
        b_q <= 4'b0;
        c_q <= 4'b0;
        d_q <= 4'b0;
        ad_out <= 0;
        bc_out <= 0;
        load_out <= 0;
        count <= 8'b0;
    end
    else
    begin
        count = count+1;

        if(load_pc) pc_out <= pc_in;  //把新的PC值存入

        if(load_reg)
        begin
            a_q <= rom_out[3:0];
            c_q <= rom_out[7:4];
            d_q <= rom_out[11:8];
            b_q <= rom_out[15:12];
        end

        if(load_ad) ad_out <= a_q * d_q;
        if(load_bc) bc_out <= b_q * c_q;
        if(load_out) out_q <= ad_out - bc_out;

        current_state <= next_state; //下一個state
    end
end

assign mid_out = out_q;

always @(*) begin
    //default值
    load_pc = 0;
    load_reg = 0;
    load_ad = 0;
    load_bc = 0;
    load_out = 0;
    next_state = 0;
    case (current_state)  
        T1: 
        begin
            load_pc=1;  //下一個clk把PC值更新為現在的PC值+1
            load_reg=1;
            load_ad = 1;
            load_bc = 1;  
            load_out=1;
            next_state = T2; 
        end
        T2:
        begin
            load_pc=1;  //下一個clk把PC值更新為現在的PC值+1
            load_reg=1;
            load_ad = 1;
            load_bc = 1;  
            load_out=1;
            next_state = T3;
        end
        T3:
        begin
            load_pc=1;  //下一個clk把PC值更新為現在的PC值+1
            load_reg=1;
            load_ad = 1;
            load_bc = 1;  
            load_out=1;
            next_state = T4;
        end
        T4:
        begin
            load_pc=1;  //下一個clk把PC值更新為現在的PC值+1
            load_reg=1;
            load_ad = 1;
            load_bc = 1;  
            load_out=1;
            next_state = T2;  //T3之後會再跳回T1
        end

    endcase 
end

endmodule
