LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY L3P22 IS
	PORT( SW: 	IN		std_logic_vector(9 DOWNTO 0);
			LEDG: OUT	std_logic_vector(9 DOWNTO 0));
END L3P22;

ARCHITECTURE structural OF L3P22 IS
	COMPONENT L3P2 IS
		PORT( Clk, D : IN		std_logic;
				Q :		OUT	std_logic);
	END COMPONENT;
BEGIN
	Latch: L3P2 PORT MAP (SW(1), SW(0), LEDG(0));
END structural;