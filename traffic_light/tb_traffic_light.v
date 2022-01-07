module tb_traffic_light;

reg clk,reset;
wire[1:0] red_light,yellow_light,green_light;

traffic_light tf1(.clk(clk),.reset(reset),.red_light(red_light),
                  .yellow_light(yellow_light),.green_light(green_light));

always begin
    #5 clk=~clk;
end

initial begin
    #0 reset=0; clk=0;
    #15 reset=1;
    #200 $stop;
    #10 $finish;
end

initial begin
    $monitor("traffic light 1=> R:%d  Y:%d  G:%d\ntraffic light 0=> R:%d  Y:%d  G:%d\n",
              red_light[1],yellow_light[1],green_light[1],
              red_light[0],yellow_light[0],green_light[0]);
end
    
endmodule
