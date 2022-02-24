library verilog;
use verilog.vl_types.all;
entity L2P21_vlg_check_tst is
    port(
        M               : in     vl_logic_vector(3 downto 0);
        z               : in     vl_logic;
        sampler_rx      : in     vl_logic
    );
end L2P21_vlg_check_tst;
