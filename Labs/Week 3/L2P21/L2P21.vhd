LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY L2P21 IS
	PORT(	V	:IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			M	:OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
			z	:OUT STD_LOGIC);
END L2P21;

ARCHITECTURE structure OF L2P21 IS
	COMPONENT mux_2to1 IS
		PORT (d0, d1, s	: IN std_logic;
				f				: OUT std_logic);
	END COMPONENT;
	SIGNAL A : std_logic_vector(2 DOWNTO 0);
	SIGNAL s : std_logic; -- intermediate signal for z
BEGIN	

	--circuit A
	A(0) <= V(0);-- your Boolean logic expressions
	A(1) <= NOT V(1);
	A(2) <= V(2) AND V(1);
	
	--comparator
	s <= V(3) AND (V(1) OR V(2)); -- your Boolean logic expression
	z <= s;
	
	--muxes
	m0: mux_2to1 PORT MAP (V(0), A(0), s, M(0));-- your mux_2to1 instantiations
	m1: mux_2to1 PORT MAP (V(1), A(1), s, M(1));
	m2: mux_2to1 PORT MAP (V(2), A(2), s, M(2));
	m3: mux_2to1 PORT MAP (V(3), '0', s, M(3));
	
END structure;	

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY mux_2to1 IS
	PORT	(d0, d1, s	:IN STD_LOGIC;
			 f	:OUT STD_LOGIC);
END mux_2to1;

ARCHITECTURE logicfunc OF mux_2to1 IS
BEGIN
	f <= (NOT s AND d0) OR (s AND d1) ;-- your 2-to-1 mux code
END logicfunc;