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
                10'h2 : data = 14'h01A7;
                10'h3 : data = 14'h3007;
                10'h4 : data = 14'h00A5;
                10'h5 : data = 14'h301D;
                10'h6 : data = 14'h00A4;
                10'h7 : data = 14'h0825;
                10'h8 : data = 14'h00A9;
                10'h9 : data = 14'h0824;
                10'ha : data = 14'h00AA;
                10'hb : data = 14'h201A;
                10'hc : data = 14'h0828;
                10'hd : data = 14'h00A7;
                10'he : data = 14'h0824;
                10'hf : data = 14'h00A5;
                10'h10 : data = 14'h0827;
                10'h11 : data = 14'h00A4;
                10'h12 : data = 14'h0824;
                10'h13 : data = 14'h00A7;
                10'h14 : data = 14'h03A7;
                10'h15 : data = 14'h1FA7;
                10'h16 : data = 14'h2807;
                10'h17 : data = 14'h0825;
                10'h18 : data = 14'h008D;
                10'h19 : data = 14'h2819;
                10'h1a : data = 14'h01AC;
                10'h1b : data = 14'h082A;
                10'h1c : data = 14'h02A9;
                10'h1d : data = 14'h0AAC;
                10'h1e : data = 14'h1FA9;
                10'h1f : data = 14'h33FA;
                10'h20 : data = 14'h03AC;
                10'h21 : data = 14'h01AB;
                10'h22 : data = 14'h0829;
                10'h23 : data = 14'h02AB;
                10'h24 : data = 14'h082B;
                10'h25 : data = 14'h022A;
                10'h26 : data = 14'h00A8;
                10'h27 : data = 14'h0008;
                default: data = 14'h0;   
            endcase
        end

     assign Rom_data_out = data;

endmodule
