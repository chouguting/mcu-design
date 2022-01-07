module ROM (
    input[10:0] addr_in,    //傳入address
    output reg[13:0] data_out  //輸出該address的data(instruction)
);
    always @(*) begin
        case(addr_in)
            11'h0: data_out = 14'h01A5;
            11'h1: data_out = 14'h0103;
            11'h2: data_out = 14'h3006;
            11'h3: data_out = 14'h07A5;
            11'h4: data_out = 14'h3005;
            11'h5: data_out = 14'h0725;
            11'h6: data_out = 14'h3E02;
            11'h7: data_out = 14'h05A5;
            11'h8: data_out = 14'h03A5;
            11'h9: data_out = 14'h09A5;
            11'hA: data_out = 14'h280A;
            11'hB: data_out = 14'h3400;
            11'hC: data_out = 14'h3400;
            default: data_out = 14'hx;
        endcase 
    end
endmodule
