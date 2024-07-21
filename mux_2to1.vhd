library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity mux_2to1 is
    port(
        mux2to1_in0 : in std_logic_vector (15 downto 0);
        mux2to1_in1 : in std_logic_vector (15 downto 0);
        mux2to1_sel : in std_logic;  
        mux2to1_out : out std_logic_vector (15 downto 0)
    );
end mux_2to1;

architecture Behavior of mux_2to1 is
begin
    process(mux2to1_in0, mux2to1_in1, mux2to1_sel)
    begin
        if mux2to1_sel = '0' then
            mux2to1_out <= mux2to1_in0;
        else
            mux2to1_out <= mux2to1_in1;
        end if;
    end process;
end Behavior;

