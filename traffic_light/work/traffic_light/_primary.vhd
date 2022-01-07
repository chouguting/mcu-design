library verilog;
use verilog.vl_types.all;
entity traffic_light is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        red_light       : out    vl_logic_vector(1 downto 0);
        yellow_light    : out    vl_logic_vector(1 downto 0);
        green_light     : out    vl_logic_vector(1 downto 0)
    );
end traffic_light;
