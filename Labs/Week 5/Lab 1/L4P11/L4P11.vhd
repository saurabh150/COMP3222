LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY L4P11 IS
	PORT(	E, Clk, Clearn: IN std_logic;
			Q : BUFFER std_logic_vector(7 DOWNTO 0));
END L4P11;

ARCHITECTURE structural OF L4P11 IS
	COMPONENT T_ff IS
		PORT(	T, Clk, Clearn :IN	std_logic;
				Q : BUFFER std_logic);
	END COMPONENT;

	--SIGNAL temp: STD_LOGIC_VECTOR(8 DOWNTO 0);
	SIGNAL temp: STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL T: STD_LOGIC_VECTOR(8 DOWNTO 0);
BEGIN
	--T(0) <= E;
	--temp(0) <= '1';
	--gen1: FOR I in 0 to 7 generate
		--T(I+1) <= T(0) AND temp(I);
		--H1: T_ff PORT MAP (T(I+1), Clk, Clearn, (temp(I+1))) ;
	--END generate gen1;
	
	T(0) <= E;
	T1: T_FF PORT MAP(T(0),Clk,Clearn,temp(0));
	
	T(1) <= T(0) AND temp(0);
	T2: T_FF PORT MAP(T(1),Clk,clearn,temp(1));
	
	T(2) <= temp(1) AND T(1);
	T3: T_FF PORT MAP(T(2),Clk,Clearn,temp(2));
	
	T(3) <= temp(2) AND T(2);
	T4: T_FF PORT MAP(T(3),Clk,Clearn,temp(3));
	
	T(4)<= temp(3) AND T(3);
	T5: T_FF PORT MAP(T(4),Clk,Clearn,temp(4));
	
	T(5) <= temp(4) AND T(5);
	T6: T_FF PORT MAP(T(5),Clk,Clearn,temp(5));
	
	T(6) <= temp(5) AND T(5);
	T7: T_FF PORT MAP(T(6),Clk,Clearn,temp(6));
	
	T(7) <= temp(6) AND T(6);
	T8: T_FF PORT MAP(T(7),Clk,Clearn,temp(7));
	--Q <= temp(8 DOWNTO 1);
	
	Q <= temp;
END structural;

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY T_ff IS
	PORT(	T, Clk, Clearn :IN	std_logic;
			Q : BUFFER std_logic);
END T_ff;

ARCHITECTURE behavioural OF T_ff IS
BEGIN
	-- your VHDL code
	PROCESS (Clearn, Clk)
	BEGIN
		IF (Clearn = '0') THEN
			Q <= '0';
		ELSIF (Clk'EVENT AND Clk = '1' AND T = '1') THEN
			Q <= NOT Q;
		END IF;
	END PROCESS;
	
END behavioural;