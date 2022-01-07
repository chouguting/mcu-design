library verilog;
use verilog.vl_types.all;
entity bcd_counter is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        \out\           : out    vl_logic_vector(7 downto 0)
    );
end bcd_counter;
