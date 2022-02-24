library verilog;
use verilog.vl_types.all;
entity L4P2_vlg_check_tst is
    port(
        Q               : in     vl_logic_vector(15 downto 0);
        sampler_rx      : in     vl_logic
    );
end L4P2_vlg_check_tst;
