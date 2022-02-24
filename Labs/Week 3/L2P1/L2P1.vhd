LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY L2P1 IS
	PORT(	SW	:IN STD_LOGIC_VECTOR(9 DOWNTO 0);
			HEX0	:OUT STD_LOGIC_VECTOR(0 TO 6);
			HEX1	:OUT STD_LOGIC_VECTOR(0 TO 6));
END L2P1;

ARCHITECTURE structure OF L2P1 IS
	COMPONENT bcd_to_hex IS
		PORT (B	: IN std_logic_vector(3 DOWNTO 0);
				H	: OUT std_logic_vector(0 TO 6));
	END COMPONENT;
BEGIN

	h0: bcd_to_hex PORT MAP(SW(3 DOWNTO 0), HEX0);
	h1: bcd_to_hex PORT MAP(SW(7 DOWNTO 4), HEX1);
	
END structure;	

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