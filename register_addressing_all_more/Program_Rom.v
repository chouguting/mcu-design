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
                10'h1 : data = 14'h0103;
                10'h2 : data = 14'h3028;
                10'h3 : data = 14'h00A5;
                10'h4 : data = 14'h37A5;
                10'h5 : data = 14'h0D25;
                10'h6 : data = 14'h36A5;
                10'h7 : data = 14'h3525;
                10'h8 : data = 14'h0CA5;
                10'h9 : data = 14'h0E25;
                10'ha : data = 14'h280A;
                default: data = 14'h0;   
            endcase
        end

     assign Rom_data_out = data;

endmodule
