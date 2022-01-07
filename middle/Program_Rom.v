module Program_Rom(
output reg [15:0] Rom_data_out, 
input [3:0]Rom_addr_in
);

//---------

//---------
    
    always @(*)
        begin
            case (Rom_addr_in)
               4'h0 : Rom_data_out = 16'h1234;		// a = 4 、b = 1、 c = 3、 d = 2 ， out = ad-bc = 5
               4'h1 : Rom_data_out = 16'h2138;    	// a = 8 、b = 2、 c = 3、 d = 1 ， out = ad-bc = 2
               4'h2 : Rom_data_out = 16'h1256;    	// a = 6 、b = 1、 c = 5、 d = 2 ， out = ad-bc = 7
               4'h3 : Rom_data_out = 16'h7757;      // a = 7 、b = 7、 c = 5、 d = 7 ， out = ad-bc = 14
               4'h4 : Rom_data_out = 16'h7758;      // a = 7 、b = 7、 c = 5、 d = 7 ， out = ad-bc = 14
               4'h5 : Rom_data_out = 16'h7758;      // a = 7 、b = 7、 c = 5、 d = 7 ， out = ad-bc = 14
               4'h6 : Rom_data_out = 16'h7759;      // a = 7 、b = 7、 c = 5、 d = 7 ， out = ad-bc = 14
               4'h7 : Rom_data_out = 16'h7758;      // a = 7 、b = 7、 c = 5、 d = 7 ， out = ad-bc = 14
               4'h8 : Rom_data_out = 16'h7750;      // a = 7 、b = 7、 c = 5、 d = 7 ， out = ad-bc = 14
                default: Rom_data_out = 16'h0;   
            endcase
        end
endmodule
