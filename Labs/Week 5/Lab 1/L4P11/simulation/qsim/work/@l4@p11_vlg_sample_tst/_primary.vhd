library verilog;
use verilog.vl_types.all;
entity L4P11_vlg_sample_tst is
    port(
        Clearn          : in     vl_logic;
        Clk             : in     vl_logic;
        E               : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end L4P11_vlg_sample_tst;
