library verilog;
use verilog.vl_types.all;
entity L3P4_vlg_sample_tst is
    port(
        Clock           : in     vl_logic;
        D               : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end L3P4_vlg_sample_tst;
