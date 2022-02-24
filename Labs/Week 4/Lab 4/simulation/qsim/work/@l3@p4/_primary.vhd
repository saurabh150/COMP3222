library verilog;
use verilog.vl_types.all;
entity L3P4 is
    port(
        Clock           : in     vl_logic;
        D               : in     vl_logic;
        Qa              : out    vl_logic;
        Qb              : out    vl_logic;
        Qc              : out    vl_logic
    );
end L3P4;
