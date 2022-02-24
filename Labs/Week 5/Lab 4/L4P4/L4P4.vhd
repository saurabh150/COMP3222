LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY L4P4 IS
	PORT(	CLOCK_50: IN std_logic;
			KEY: IN std_logic_vector(0 TO 2);
			HEX0: OUT std_logic_vector(0 TO 6);
			HEX1: OUT std_logic_vector(0 TO 6);
			HEX2: OUT std_logic_vector(0 TO 6);
			HEX3: OUT std_logic_vector(0 TO 6));
END L4P4;

ARCHITECTURE behavioural OF L4P4 IS
	COMPONENT seg_7 IS
		PORT(	v :IN	std_logic_vector(3 DOWNTO 0);
				d : OUT std_logic_vector(0 TO 6));
	END COMPONENT;
	-- your signal definitions
	SIGNAL counter: std_logic_vector(26 DOWNTO 0);
	SIGNAL t_seconds: std_logic_vector(3 DOWNTO 0);
	SIGNAL clear: std_logic;
	
BEGIN

	HEX1 <= "1111111"; -- blank higher order HEX displays
	HEX2 <= "1111111";
	HEX3 <= "1111111";

	-- your signal assignments to external pins
	clear <= KEY(0);
	-- your one-second timer code
	PROCESS (CLOCK_50, counter, t_seconds, clear)
	BEGIN
		IF clear = '0' THEN
			counter <= (OTHERS => '0');
			t_seconds <= "0000";
		ELSIF (rising_edge(CLOCK_50)) THEN 
			IF counter < 50000000 THEN
				counter <= counter + 1;
			ELSE 
				counter <= (OTHERS => '0');
				IF t_seconds < 9 THEN
					t_seconds <= t_seconds + 1;
				ELSE 
					t_seconds <= "0000";
				END IF;
			END IF;
		END IF;
	END PROCESS;
	-- your instantiation of a 7-segment display to display the BCD count value
	H1: seg_7 PORT MAP (t_seconds, HEX0);
	
END behavioural;

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY seg_7 IS
	PORT(	v :IN	std_logic_vector(3 DOWNTO 0);
			d : OUT std_logic_vector(0 TO 6));
END seg_7;

ARCHITECTURE behavioural OF seg_7 IS
BEGIN	
	PROCESS (v)
	BEGIN	
		CASE v IS             --0123456
			WHEN "0000" => d <= "0000001";
			WHEN "0001" => d <= "1001111";
			WHEN "0010" => d <= "0010010";
			WHEN "0011" => d <= "0000110";
			WHEN "0100" => d <= "1001100";
			WHEN "0101" => d <= "0100100";
			WHEN "0110" => d <= "0100000";
			WHEN "0111" => d <= "0001111";
			WHEN "1000" => d <= "0000000";
			WHEN "1001" => d <= "0001100";
			WHEN "1010" => d <= "0001000";
			WHEN "1011" => d <= "1100000";
			WHEN "1100" => d <= "0110001";
			WHEN "1101" => d <= "1000010";
			WHEN "1110" => d <= "0110000";
			WHEN "1111" => d <= "0111000";
			WHEN OTHERS => d <= "-------";
		END CASE;
	END PROCESS;
END behavioural;
