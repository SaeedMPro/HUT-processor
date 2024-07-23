library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity alu is
	port (
		ALU_in0, ALU_in1	: in std_logic_vector (15 downto 0);
		ALU_opr				: in std_logic; 	-- '0' for "+" & '1' for "or"
		ALU_out				: out std_logic_vector (15 downto 0)
	);
end alu;

architecture Behavioral of alu is
	signal ALU_temp : std_logic_vector (15 downto 0);
begin
	process(ALU_in0, ALU_in1, ALU_opr)
	begin
		case ALU_opr is
			when '0' =>
				ALU_temp <= std_logic_vector(unsigned(ALU_in0) + unsigned(ALU_in1));
			when '1' =>
				ALU_temp <= ALU_in0 or ALU_in1;
			when others =>
				ALU_temp <= (others => '0');
		end case;
	end process;
	ALU_out <= ALU_temp;
end Behavioral;

