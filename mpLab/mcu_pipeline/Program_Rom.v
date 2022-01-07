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
                10'h0 : data = 14'h01A1;
                10'h1 : data = 14'h01A2;
                10'h2 : data = 14'h01A3;
                10'h3 : data = 14'h01A4;
                10'h4 : data = 14'h3018;
                10'h5 : data = 14'h00A5;
                10'h6 : data = 14'h300A;
                10'h7 : data = 14'h00A6;
                10'h8 : data = 14'h3006;
                10'h9 : data = 14'h00A7;
                10'ha : data = 14'h01A4;
                10'hb : data = 14'h300A;
                10'hc : data = 14'h00A8;
                10'hd : data = 14'h0824;
                10'he : data = 14'h00A2;
                10'hf : data = 14'h0823;
                10'h10 : data = 14'h00A1;
                10'h11 : data = 14'h0AA4;
                10'h12 : data = 14'h0BA8;
                10'h13 : data = 14'h33F9;
                10'h14 : data = 14'h0EA4;
                10'h15 : data = 14'h0AA4;
                10'h16 : data = 14'h0EA4;
                10'h17 : data = 14'h30F0;
                10'h18 : data = 14'h05A4;
                10'h19 : data = 14'h0BA7;
                10'h1a : data = 14'h33F0;
                10'h1b : data = 14'h0AA3;
                10'h1c : data = 14'h0BA5;
                10'h1d : data = 14'h3201;
                10'h1e : data = 14'h33E3;
                10'h1f : data = 14'h01A4;
                10'h20 : data = 14'h0BA6;
                10'h21 : data = 14'h33E6;
                10'h22 : data = 14'h0EA3;
                10'h23 : data = 14'h0AA3;
                10'h24 : data = 14'h0EA3;
                10'h25 : data = 14'h30F0;
                10'h26 : data = 14'h05A3;
                10'h27 : data = 14'h0823;
                10'h28 : data = 14'h00A1;
                10'h29 : data = 14'h33DC;
                default: data = 14'h0;   
            endcase
        end

     assign Rom_data_out = data;

endmodule
