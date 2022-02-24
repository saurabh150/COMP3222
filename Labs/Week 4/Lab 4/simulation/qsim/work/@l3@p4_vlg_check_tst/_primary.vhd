library verilog;
use verilog.vl_types.all;
entity L3P4_vlg_check_tst is
    port(
        Qa              : in     vl_logic;
        Qb              : in     vl_logic;
        Qc              : in     vl_logic;
        sampler_rx      : in     vl_logic
    );
end L3P4_vlg_check_tst;
