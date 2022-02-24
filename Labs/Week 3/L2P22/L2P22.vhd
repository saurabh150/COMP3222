LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY L2P22 IS
	PORT(	SW	:IN STD_LOGIC_VECTOR(9 DOWNTO 0);
			HEX0	:OUT STD_LOGIC_VECTOR(0 TO 6);
			HEX1	:OUT STD_LOGIC_VECTOR(0 TO 6));
END L2P22;

ARCHITECTURE structure OF L2P22 IS
	COMPONENT mux_2to1 IS
		PORT (d0, d1, s	: IN std_logic;
				f				: OUT std_logic);
	END COMPONENT;
	COMPONENT bcd_to_hex IS
		PORT (B	: IN std_logic_vector(3 DOWNTO 0);
				H	: OUT std_logic_vector(0 TO 6));
	END COMPONENT;
	SIGNAL V	: std_logic_vector(3 DOWNTO 0);
	SIGNAL z : std_logic;
	SIGNAL A : std_logic_vector(2 DOWNTO 0);
	SIGNAL M	: std_logic_vector(3 DOWNTO 0);
BEGIN

	V <= SW(3 DOWNTO 0);
	
	--circuit A
	A(0) <= V(0);-- your Boolean logic expressions
	A(1) <= NOT V(1);
	A(2) <= V(2) AND V(1);
	
	--comparator
	z <= V(3) AND (V(1) OR V(2));-- your Boolean logic expression
	
	--circuit B
	HEX1(0) <= z;-- your Boolean logic expressions
	HEX1(1) <= '0';
	HEX1(2) <= '0';
	HEX1(3) <= z;
	HEX1(4) <= z;
	HEX1(5) <= z;
	HEX1(6) <= '1'; 
	
	--muxes
	m0: mux_2to1 PORT MAP (V(0), A(0), z, M(0));-- your mux_2to1 instantiations
	m1: mux_2to1 PORT MAP (V(1), A(1), z, M(1));
	m2: mux_2to1 PORT MAP (V(2), A(2), z, M(2));
	m3: mux_2to1 PORT MAP (V(3), '0', z, M(3));
	
	--7-segment decoder
	h0: bcd_to_hex PORT MAP(M(3 DOWNTO 0), HEX0);-- your bcd_to_hex instantiation
	
END structure;	

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY mux_2to1 IS
	PORT	(d0, d1, s	:IN STD_LOGIC;
			 f	:OUT STD_LOGIC);
END mux_2to1;

ARCHITECTURE logicfunc OF mux_2to1 IS
BEGIN
	f <= (NOT s AND d0) OR (s AND d1);-- your 2-to-1 mux code
END logicfunc;

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY bcd_to_hex IS
	PORT	(B	:IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			 H	:OUT STD_LOGIC_VECTOR(0 TO 6));
END bcd_to_hex;

ARCHITECTURE logicfunc OF bcd_to_hex IS
BEGIN
	H(0) <= NOT B(3) AND ((B(2) AND NOT B(0)) OR (NOT B(2) AND NOT B(1) AND B(0)));
	H(1) <= (NOT B(3) AND B(2)) AND ((NOT B(1) AND B(0)) OR (B(1) AND NOT B(0)));
	H(2) <= NOT B(3) AND NOT B(2) AND B(1) AND NOT B(0);
	H(3) <= (B(2) AND B(1) AND B(0)) OR (NOT B(1) AND (B(2) XOR B(0)));
	H(4) <= B(0) OR (B(2) AND NOT B(1));
	H(5) <= ((NOT B(3) AND NOT B(2)) AND (B(0) OR B(1))) OR (NOT B(3) AND B(1) AND B(0));
	H(6) <= (NOT B(3) AND NOT B(2) AND NOT B(1)) OR (B(2) AND B(1) AND B(0));
END logicfunc;