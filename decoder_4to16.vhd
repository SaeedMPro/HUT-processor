library IEEE;
use IEEE.std_logic_1164.all;

entity decoder_4to16 is
	port(
		DEC_in	: in std_logic_vector (3 downto 0);
		DEC_en	: in std_logic;
		DEC_out	: out std_logic_vector (15 downto 0)
	);
end decoder_4to16;

architecture Behavioral of decoder_4to16 is
begin
	process(DEC_in, DEC_en)
	begin
		if DEC_en = '1' then
			case DEC_in is
				when "0000" => DEC_out <= "0000000000000001";
				when "0001" => DEC_out <= "0000000000000010";
				when "0010" => DEC_out <= "0000000000000100";
				when "0011" => DEC_out <= "0000000000001000";
				when "0100" => DEC_out <= "0000000000010000";
				when "0101" => DEC_out <= "0000000000100000";
				when "0110" => DEC_out <= "0000000001000000";
				when "0111" => DEC_out <= "0000000010000000";
				when "1000" => DEC_out <= "0000000100000000";
				when "1001" => DEC_out <= "0000001000000000";
				when "1010" => DEC_out <= "0000010000000000";
				when "1011" => DEC_out <= "0000100000000000";
				when "1100" => DEC_out <= "0001000000000000";
				when "1101" => DEC_out <= "0010000000000000";
				when "1110" => DEC_out <= "0100000000000000";
				when "1111" => DEC_out <= "1000000000000000";
				when others => DEC_out <= (others => '0');
			end case;
		else
			DEC_out <= (others => '0');
		end if;
	end process;
end Behavioral;
