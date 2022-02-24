library verilog;
use verilog.vl_types.all;
entity L4P2 is
    port(
        E               : in     vl_logic;
        Clk             : in     vl_logic;
        Clearn          : in     vl_logic;
        Q               : out    vl_logic_vector(15 downto 0)
    );
end L4P2;
