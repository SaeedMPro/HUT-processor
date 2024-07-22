library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity adder is
    port(
        adder_a : in std_logic_vector (15 downto 0);
        adder_b : in std_logic_vector (15 downto 0);
        adder_out : out std_logic_vector (15 downto 0)
    );
end adder;

architecture Behavior of adder is
begin
    process(adder_a, adder_b)
    begin
        adder_out <= std_logic_vector(unsigned(adder_a) + unsigned(adder_b));
    end process;
end Behavior;

