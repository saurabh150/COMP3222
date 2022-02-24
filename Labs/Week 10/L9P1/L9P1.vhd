LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned;

ENTITY L9P1 IS
	PORT (SW: IN std_logic_vector(9 DOWNTO 0);
			KEY: IN std_logic_vector(1 DOWNTO 0);
			clock_50: IN STD_logic;
			LEDR: OUT std_logic_vector(9 DOWNTO 0));
END L9P1;

ARCHITECTURE behavior OF L9P1 IS
	COMPONENT shiftrne
		GENERIC (N: INTEGER := 8);
		PORT (Data: IN std_logic_vector(N-1 DOWNTO 0);
			LA, EM, v, Clk: IN std_logic;
			A: BUFFER std_logic_vector(N-1 DOWNTO 0));
	END COMPONENT;

	TYPE State_type IS (s1, s2, s3);
	SIGNAL y: State_type;
	SIGNAL A: std_logic_vector(7 DOWNTO 0);
	SIGNAL B: INTEGER RANGE 0 to 8;
	SIGNAL LA, z, EA, LB, EB: std_logic;
	SIGNAL Clk, Resetn, Done, s: std_logic;
BEGIN
	
	Resetn <= KEY(0);
	-- Clk <= NOT KEY(1);
	Clk <= clock_50;
	s <= SW(8);
	FSM_transistions: PROCESS(Resetn, Clk)
	BEGIN
		IF Resetn = '0' THEN
			y <= s1;
		ELSIF (Clk'event AND Clk ='1') THEN 
			CASE y IS
				WHEN s1 =>
					IF s = '0' THEN y <= s1;
					ELSE y <= s2; 
					END IF;
				WHEN s2 =>
					IF z = '0' THEN y <= s2;
					ELSE y <= s3; 
					END IF;
				WHEN s3 =>
					IF s = '1' THEN y <= s3;
					ELSE y <= s1; 
					END IF;
			END CASE;
		END IF;
	END PROCESS;
	
	FSM_outputs: PROCESS (y, A(0))
	BEGIN
		LA <= '0'; EA <= '0'; LB <= '0'; EB <= '0'; Done <= '0';
		CASE y IS
			WHEN s1 =>
				LA <= '1';
				LB <= '1';
			WHEN s2 =>
				EA <= '1';
				IF A(0) = '1' THEN
					EB <= '1';
				END IF;
			WHEN s3 =>
				Done <= '1';
		END CASE;
	END PROCESS;
	
	upcount: PROCESS(Resetn, Clk)
	BEGIN
		IF Resetn = '0' THEN
			B <= 0;
		ELSIF (rising_edge(clk)) THEN
			IF LB = '1' THEN
				B <= 0;
			ELSIF EB = '1' THEN
				B <= B + 1;
			END IF;
		END IF;
	END PROCESS;
	
	z <= '1' WHEN A = "00000000" ELSE '0';
	ShiftA: shiftrne GENERIC MAP (N =>8)
		PORT MAP (SW(7 DOWNTO 0), LA, EA, '0', Clk, A);
	LEDR(9) <= Done;
	
	LEDR(3 DOWNTO 0) <=
		"0000" WHEN B = 0 ELSE
		"0001" WHEN B = 1 ELSE
		"0010" WHEN B = 2 ELSE
		"0011" WHEN B = 3 ELSE
		"0100" WHEN B = 4 ELSE
		"0101" WHEN B = 5 ELSE
		"0110" WHEN B = 6 ELSE
		"0111" WHEN B = 7 ELSE
		"1000" WHEN B = 8;
END behavior;


LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned;
ENTITY shiftrne IS
	GENERIC (N: INTEGER := 8);
	PORT (Data: IN std_logic_vector(N-1 DOWNTO 0);
			LA, EM, v, Clk: IN std_logic;
			A: BUFFER std_logic_vector(N-1 DOWNTO 0));
END shiftrne;

ARCHITECTURE shift of shiftrne IS
BEGIN
	PROCESS
	BEGIN
		WAIT UNTIL (rising_edge(Clk));
		IF (LA = '1') THEN A <= Data;
		ELSE
			IF (EM = '1') THEN 
				Genbits: FOR i in 0 to N-2 LOOP
					A(i) <= A(i+1);
				END LOOP;
				A(N-1) <= v;
			END IF;
		END IF;
	END PROCESS;
END shift;

