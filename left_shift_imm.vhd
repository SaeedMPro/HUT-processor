library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity left_shift_imm is
    port(
        LSI_in   : in std_logic_vector (3 downto 0);
        LSI_out : out std_logic_vector (15 downto 0)
    );
end left_shift_imm;

architecture Behavior of left_shift_imm is
    constant a : std_logic_vector(15 downto 0) := x"0001";
begin
    process(LSI_in)
        variable a_unsigned : unsigned(15 downto 0);
        variable shift_amount : unsigned(3 downto 0);
        variable shifted_result : unsigned(15 downto 0);
    begin
        a_unsigned := unsigned(a);
        shift_amount := unsigned(LSI_in);

        shifted_result := a_unsigned sll to_integer(shift_amount);

        LSI_out <= std_logic_vector(shifted_result);
    end process;
end Behavior;

