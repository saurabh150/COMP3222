LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY L2P3 IS
	PORT(	SW	:IN STD_LOGIC_VECTOR(9 DOWNTO 0);
			LEDG	:OUT STD_LOGIC_VECTOR(9 DOWNTO 0));
END L2P3;

ARCHITECTURE structure OF L2P3 IS
	COMPONENT full_add IS
		PORT (a, b, ci	: IN std_logic;
				co, s	: OUT std_logic);
	END COMPONENT;
	SIGNAL a, b, s : std_logic_vector(3 DOWNTO 0);
	SIGNAL cin, cout : std_logic;
	SIGNAL c	: std_logic_vector(1 TO 3);
BEGIN
	a <= SW(7 DOWNTO 4);
	b <= SW(3 DOWNTO 0);
	cin <= SW(8);
	LEDG(4 DOWNTO 0) <= cout & s;

	--ripple-carry adder
	fa0: full_add PORT MAP (a(0), b(0), cin, c(1), s(0));-- your full_add instantiations
	fa1: full_add PORT MAP (a(1), b(1), c(1), c(2), s(1));
	fa2: full_add PORT MAP (a(2), b(2), c(2), c(3), s(2));
	fa3: full_add PORT MAP (a(3), b(3), c(3), cout, s(3));
END structure;	

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY mux_2to1 IS
	PORT	(d0, d1, s	:IN STD_LOGIC;
			 f	:OUT STD_LOGIC);
END mux_2to1;

ARCHITECTURE logicfunc OF mux_2to1 IS
BEGIN
	f <= (NOT s AND d0) OR (S AND d1);-- your 2-to-1 mux code
END logicfunc;

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY full_add IS
	PORT	(a, b, ci	:IN STD_LOGIC;
			 co, s	:OUT STD_LOGIC);
END full_add;

ARCHITECTURE structure OF full_add IS
	COMPONENT mux_2to1 IS
		PORT (d0, d1, s	: IN std_logic;
				f				: OUT std_logic);
	END COMPONENT;
	SIGNAL ms : std_logic;
BEGIN
	ms <= a XOR b; -- your implementation of Figure 2(a)
	s <= ms XOR ci;
	mu1: mux_2to1 PORT MAP (b, ci, ms, co);
END structure;