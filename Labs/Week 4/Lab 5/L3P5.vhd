LIBRARY ieee;
use ieee.std_logic_1164.all;

ENTITY L3P5 IS
PORT (SW:	IN		std_logic_vector(9 DOWNTO 0);
		KEY:	IN		std_logic_vector(3 DOWNTO 0);
		LEDG:	OUT	std_logic_vector(9 DOWNTO 0);
		HEX0	:OUT STD_LOGIC_VECTOR(0 TO 6);
		HEX1	:OUT STD_LOGIC_VECTOR(0 TO 6);
		HEX2	:OUT STD_LOGIC_VECTOR(0 TO 6);
		HEX3	:OUT STD_LOGIC_VECTOR(0 TO 6));
END L3P5;

ARCHITECTURE structural of L3P5 IS
	
	COMPONENT SW_TO_HEX IS
		PORT (B	: IN std_logic_vector(3 DOWNTO 0);
				H	: OUT std_logic_vector(0 TO 6));
	END COMPONENT;
	SIGNAL temp: std_logic_VECTOR(0 TO 6);
	SIGNAL A,B,C,D: std_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL N1,N2, T1, T2: Std_LOGIC_VECTOR(0 to 6);
	
	SIGNAL Clk, Reset, Flag, F: std_logic;
	
BEGIN
	temp <= "0000001";
	LEDG(0) <= KEY(0);
	LEDG(1) <= NOT KEY(1);
	
	Clk <= KEY(1);
	Reset <= KEY(0);
	
	PROCESS (Clk, Reset)
	BEGIN
		IF Reset = '0' THEN
			F <= '0';
			Flag <= '1';
		ELSIF Clk'event AND Clk = '1' THEN
			IF Flag = '1' THEN
				F <= '1';
				Flag <= '0';
				
			ELSE
				Flag <= '1';
			END IF;
		END IF;
	END PROCESS;
	
	PROCESS (F)
	BEGIN
		IF F = '1' THEN
			T1 <= N1;
			T2 <= N2;
		ELSE
			T1 <= temp;
			T2 <= temp;
		END IF;
	END PROCESS;
	
	
	PROCESS (Flag)
	BEGIN
		IF FLAG = '1' THEN
			HEX0 <= N1;
			HEX1 <= N2;
		ELSE
			HEX2 <= (T1(0 to 5) AND N1 (0 to 5)) & (T1(6) OR N1(6));
			HEX3 <= (T2(0 to 5) AND N2 (0 to 5)) & (T2(6) OR N2(6));
		END IF;
	END PROCESS;
		
	H1: SW_TO_HEX PORT MAP (SW(3 DOWNTO 0), N1);
	H2: SW_TO_HEX PORT MAP (SW(7 DOWNTO 4), N2);

END structural;


-- **************************************************************** 

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY SW_TO_HEX IS
	PORT	(B	:IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			 H	:OUT STD_LOGIC_VECTOR(0 TO 6));
END SW_TO_HEX;

ARCHITECTURE logicfunc OF SW_TO_HEX IS
BEGIN
	PROCESS (B)
	BEGIN
		CASE B IS
			WHEN "0000" => H <= "0000001";
			WHEN "0001" => H <= "1001111";
			WHEN "0010" => H <= "0010010";
			WHEN "0011" => H <= "0000110";
			WHEN "0100" => H <= "1001100";
			WHEN "0101" => H <= "0100100";
			WHEN "0110" => H <= "1100000";
			WHEN "0111" => H <= "0001111";
			WHEN "1000" => H <= "0000000";
			WHEN "1001" => H <= "0001100";
			WHEN "1010" => H <= "0001000";
			WHEN "1011" => H <= "0000000";
			WHEN "1100" => H <= "0110001";
			WHEN "1101" => H <= "0000001";
			WHEN "1110" => H <= "0110000";
			WHEN "1111" => H <= "0111000";
		END CASE;
	END PROCESS;
END logicfunc;

-- ****************************************************************