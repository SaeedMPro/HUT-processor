library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity one_shift is
    port (
        oneShift_in  : in  std_logic_vector (15 downto 0);
        oneShift_out : out std_logic_vector (15 downto 0)
    );
end one_shift;

architecture Behavior of one_shift is
begin
    process (oneShift_in)
    begin
        oneShift_out <= oneShift_in(14 downto 0) & '0';
    end process;
end Behavior;

