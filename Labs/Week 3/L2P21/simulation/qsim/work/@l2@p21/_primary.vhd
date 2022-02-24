library verilog;
use verilog.vl_types.all;
entity L2P21 is
    port(
        V               : in     vl_logic_vector(3 downto 0);
        M               : out    vl_logic_vector(3 downto 0);
        z               : out    vl_logic
    );
end L2P21;
