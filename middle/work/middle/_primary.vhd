library verilog;
use verilog.vl_types.all;
entity middle is
    generic(
        T0              : integer := 0;
        T1              : integer := 1;
        T2              : integer := 2;
        T3              : integer := 3;
        T4              : integer := 4
    );
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        mid_out         : out    vl_logic_vector(7 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of T0 : constant is 1;
    attribute mti_svvh_generic_type of T1 : constant is 1;
    attribute mti_svvh_generic_type of T2 : constant is 1;
    attribute mti_svvh_generic_type of T3 : constant is 1;
    attribute mti_svvh_generic_type of T4 : constant is 1;
end middle;
