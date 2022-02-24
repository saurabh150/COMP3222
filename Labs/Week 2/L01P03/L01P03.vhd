LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY L01P03 IS
	PORT(	SW : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
			LEDG : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
END L01P03;

ARCHITECTURE behaviour OF L01P03 IS
	SIGNAL U, V, W, M, N	:STD_LOGIC_VECTOR(1 DOWNTO 0);
	SIGNAL s :STD_LOGIC_VECTOR(1 DOWNTO 0);
BEGIN
	LEDG(7 DOWNTO 2) <= "000000";
	LEDG(1 DOWNTO 0) <= M;
	
	U <= SW(5 DOWNTO 4);
	V <= SW(3 DOWNTO 2);
	W <= SW(1 DOWNTO 0);
	s <= SW(9 DOWNTO 8);
	
	N(1) <= (NOT s(0) AND U(1)) OR (s(0) AND V(1));
	N(0) <= (NOT s(0) AND U(0)) OR (s(0) AND V(0));
	M(1) <= (NOT s(1) AND N(1)) OR (s(1) AND W(1));
	M(0) <= (NOT s(1) AND N(0)) OR (s(1) AND W(0));
END behaviour;