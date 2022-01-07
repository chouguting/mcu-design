module Program_Rom(Rom_data_out, Rom_addr_in);

//---------
    output [13:0] Rom_data_out;
    input [10:0] Rom_addr_in; 
//---------
    
    reg   [13:0] data;
    wire  [13:0] Rom_data_out;
    
    always @(Rom_addr_in)
        begin
            case (Rom_addr_in)
                10'h0 : data = 14'h01A5;
                10'h1 : data = 14'h01A4;
                10'h2 : data = 14'h01A3;
                10'h3 : data = 14'h3005;
                10'h4 : data = 14'h00A5;
                10'h5 : data = 14'h3006;
                10'h6 : data = 14'h00A4;
                10'h7 : data = 14'h07A3;
                10'h8 : data = 14'h0BA5;
                10'h9 : data = 14'h33FD;
                10'ha : data = 14'h0823;
                10'hb : data = 14'h008D;
                10'hc : data = 14'h301E;
                10'hd : data = 14'h00A0;
                10'he : data = 14'h01A1;
                10'hf : data = 14'h01A2;
                10'h10 : data = 14'h0BA2;
                10'h11 : data = 14'h2810;
                10'h12 : data = 14'h0BA1;
                10'h13 : data = 14'h280F;
                10'h14 : data = 14'h0BA0;
                10'h15 : data = 14'h280F;
                10'h16 : data = 14'h0008;
                default: data = 14'h0;   
            endcase
        end

     assign Rom_data_out = data;

endmodule
