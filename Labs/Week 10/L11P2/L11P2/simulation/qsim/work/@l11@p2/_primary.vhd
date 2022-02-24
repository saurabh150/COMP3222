library verilog;
use verilog.vl_types.all;
entity L11P2 is
    port(
        Clock           : in     vl_logic;
        Resetn          : in     vl_logic;
        s               : in     vl_logic;
        Data            : in     vl_logic_vector(7 downto 0);
        Addr            : out    vl_logic_vector(4 downto 0);
        Found           : out    vl_logic;
        Done            : out    vl_logic
    );
end L11P2;
