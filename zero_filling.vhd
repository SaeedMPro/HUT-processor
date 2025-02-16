library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity zero_filling is
	generic (n : natural := 1);
	port(
		ZF_in	: in std_logic_vector (n - 1 downto 0);
		ZF_out  : out std_logic_vector (15 downto 0)
	);
end zero_filling;

architecture Behavior of zero_filling is
begin
    process (ZF_in)
    begin
        for i in 0 to 15 loop
            if i < n then
                ZF_out(i) <= ZF_in(i);
            else
                ZF_out(i) <= '0';
            end if;
        end loop;
    end process;
end Behavior;
