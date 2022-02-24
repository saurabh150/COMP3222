LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY L4P2 IS
	PORT(	E, Clk, Clearn: IN std_logic;
			Q : BUFFER std_logic_vector(15 DOWNTO 0));
END L4P2;

ARCHITECTURE behavioural OF L4P2 IS
BEGIN

	-- your VHDL code
	PROCESS (Clk, Clearn)
	BEGIN
		IF (Clearn = '0') THEN
			Q <= (OTHERS => '0');
		ELSIF (Clk'EVENT AND CLK = '1') THEN
			IF (E = '1') THEN
				Q <= Q + 1;
			END IF;
		END IF;
	END PROCESS;
END behavioural;