library verilog;
use verilog.vl_types.all;
entity timer_clock is
    port(
        reset           : in     vl_logic;
        clk             : in     vl_logic;
        hour            : out    vl_logic_vector(7 downto 0);
        minute          : out    vl_logic_vector(7 downto 0)
    );
end timer_clock;
