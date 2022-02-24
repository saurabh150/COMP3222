library verilog;
use verilog.vl_types.all;
entity L9P1sim_vlg_check_tst is
    port(
        BusWires        : in     vl_logic_vector(8 downto 0);
        Done            : in     vl_logic;
        sampler_rx      : in     vl_logic
    );
end L9P1sim_vlg_check_tst;
