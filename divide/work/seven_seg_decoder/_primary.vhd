library verilog;
use verilog.vl_types.all;
entity seven_seg_decoder is
    port(
        data_in         : in     vl_logic_vector(3 downto 0);
        hex_out         : out    vl_logic_vector(7 downto 0)
    );
end seven_seg_decoder;
