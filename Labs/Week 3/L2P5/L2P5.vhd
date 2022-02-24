LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY L2P5 IS
	PORT(	SW	:IN STD_LOGIC_VECTOR(9 DOWNTO 0);
			LEDG	:OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
			HEX0	:OUT STD_LOGIC_VECTOR(0 TO 6);
			HEX1	:OUT STD_LOGIC_VECTOR(0 TO 6);
			HEX2	:OUT STD_LOGIC_VECTOR(0 TO 6);
			HEX3	:OUT STD_LOGIC_VECTOR(0 TO 6));
END L2P5;

ARCHITECTURE structure OF L2P5 IS
	COMPONENT bcd_to_hex IS
		PORT (B	: IN std_logic_vector(3 DOWNTO 0);
				H	: OUT std_logic_vector(0 TO 6));
	END COMPONENT;
	SIGNAL a, b : std_logic_vector(3 DOWNTO 0);
	SIGNAL cin, z : std_logic;
	SIGNAL T0, Z0, S0 : std_logic_vector(4 DOWNTO 0);
	SIGNAL S1, C1 : std_logic_vector(3 DOWNTO 0);
BEGIN
	a <= SW(7 DOWNTO 4);
	b <= SW(3 DOWNTO 0);
	cin <= SW(8);
	LEDG(4 DOWNTO 0) <= T0; -- msb = carry_out
	LEDG(7) <= (a(3) AND (a(2) OR a(1))) OR (b(3) AND (b(2) OR b(1))); -- Boolean logic expression set if a or b inputs aren't BCDs

	--addition
	T0 <= (('0' & a) + ('0' & b) + cin);
	
	--muxes
	-- PROCESS that sets Z0 and C1 based on T0 
	PROCESS (T0)
	BEGIN
	IF T0 > 9 THEN
		Z0 <= "01010";
		C1 <= "0001";
	ELSE
		Z0 <= "00000";
		C1 <= "0000";	
	END IF;	
	END PROCESS;
	--outputs
	S0 <= T0 - Z0;
	S1 <= C1;
	
	--7-segment decoders
	h0: bcd_to_hex PORT MAP (S0(3 DOWNTO 0), HEX0);-- your bcd_to_hex instantiations
	h1: bcd_to_hex PORT MAP (S1, HEX1);
	h2: bcd_to_hex PORT MAP (b, HEX2);
	h3: bcd_to_hex PORT MAP (a, HEX3);
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