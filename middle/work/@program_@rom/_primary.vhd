library verilog;
use verilog.vl_types.all;
entity Program_Rom is
    port(
        Rom_data_out    : out    vl_logic_vector(15 downto 0);
        Rom_addr_in     : in     vl_logic_vector(3 downto 0)
    );
end Program_Rom;
