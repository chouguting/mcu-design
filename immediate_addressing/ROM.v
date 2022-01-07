module ROM (
    input[10:0] addr_in,    //傳入address
    output reg[13:0] data_out  //輸出該address的data(instruction)
);
    always @(*) begin
        case(addr_in)
            11'h0: data_out = 14'h3044;
            11'h1: data_out = 14'h3E01;
            11'h2: data_out = 14'h3802;
            11'h3: data_out = 14'h39FE;
            11'h4: data_out = 14'h3C47;
            11'h5: data_out = 14'h3A55;
            11'h6: data_out = 14'h3AAA;
            default: data_out = 14'hx;
        endcase 
    end
endmodule
