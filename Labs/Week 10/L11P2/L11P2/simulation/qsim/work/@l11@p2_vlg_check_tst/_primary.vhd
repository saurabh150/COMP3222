library verilog;
use verilog.vl_types.all;
entity L11P2_vlg_check_tst is
    port(
        Addr            : in     vl_logic_vector(4 downto 0);
        Done            : in     vl_logic;
        Found           : in     vl_logic;
        sampler_rx      : in     vl_logic
    );
end L11P2_vlg_check_tst;
