library IEEE;
use IEEE.std_logic_1164.all;

entity reg is 
	port(
		clk, rst, we : in std_logic;
		d_in    : in std_logic_vector (15 downto 0);
		d_out   : out std_logic_vector (15 downto 0)
	);
end reg;

architecture Behavioral of reg is
	signal reg_temp : std_logic_vector (15 downto 0);
begin
	process(clk, rst)
	begin
		if (rst = '1') then
			reg_temp <= x"0000";
		elsif rising_edge(clk) then
			if we = '1' then
				reg_temp <= d_in;
			end if;
		end if;
	end process;
	d_out <= reg_temp;
end Behavioral;

