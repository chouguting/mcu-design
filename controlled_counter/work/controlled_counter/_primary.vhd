library verilog;
use verilog.vl_types.all;
entity controlled_counter is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        load_w          : in     vl_logic;
        w_output        : out    vl_logic_vector(4 downto 0)
    );
end controlled_counter;
