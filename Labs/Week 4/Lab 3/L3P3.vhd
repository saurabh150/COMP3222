LIBRARY ieee;
use ieee.std_logic_1164.all;

ENTITY L3P3 IS
PORT (SW:	IN		std_logic_vector(9 DOWNTO 0);
		LEDG:	OUT	std_logic_vector(9 DOWNTO 0));
END L3P3;

ARCHITECTURE structural of L3P3 IS
	COMPONENT L3P2 IS
		PORT (Clk, D:	IN		std_logic;
				Q:			OUT	std_logic);
	END COMPONENT;
	Signal Qm, Cn : std_logic;
BEGIN
	Cn <= NOT SW(1);
	master: L3P2 PORT MAP (Cn, SW(0), Qm);
	slave: L3P2 PORT MAP (SW(1), Qm, LEDG(0));
END structural;