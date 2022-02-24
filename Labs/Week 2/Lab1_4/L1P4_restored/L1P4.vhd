LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY L1P4 IS
	PORT(	SW	:IN STD_LOGIC_VECTOR(9 DOWNTO 0);
			HEX0	:OUT STD_LOGIC_VECTOR(6 DOWNTO 0));
END L1P4;

ARCHITECTURE behaviour OF L1P4 IS
	SIGNAL C :STD_LOGIC_VECTOR(1 DOWNTO 0);
BEGIN
	C <= SW(1 DOWNTO 0);
	
	-- d -> (C(1) OR C(0))
	-- E -> (C(1) OR NOT C(0))
	-- 1 -> (NOT C(1) OR C(0))
	
 	HEX0(0) <= (C(1) OR NOT C(0));
	HEX0(1) <= (C(1) OR C(0)) AND (NOT C(1) OR C(0));
	HEX0(2) <= (C(1) OR C(0)) AND (NOT C(1) OR C(0));
	HEX0(3) <= (C(1) OR C(0)) AND (C(1) OR NOT C(0));
	HEX0(4) <= (C(1) OR C(0)) AND (C(1) OR NOT C(0));
	HEX0(5) <= (C(1) OR NOT C(0));
	HEX0(6) <= (C(1) OR C(0)) AND (C(1) OR NOT C(0));

	END behaviour;
