library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity mux_3to1 is
    port(
        mux3to1_in0 : in std_logic_vector (15 downto 0);
        mux3to1_in1 : in std_logic_vector (15 downto 0);
        mux3to1_in2 : in std_logic_vector (15 downto 0);
        mux3to1_sel : in std_logic_vector (1 downto 0);  
        mux3to1_out : out std_logic_vector (15 downto 0)
    );
end mux_3to1;

architecture Behavior of mux_3to1 is
begin
    process(mux3to1_in0, mux3to1_in1, mux3to1_in2, mux3to1_sel)
    begin
        case mux3to1_sel is
            when "00" =>
                mux3to1_out <= mux3to1_in0;
            when "01" =>
                mux3to1_out <= mux3to1_in1;
            when "10" =>
                mux3to1_out <= mux3to1_in2;
            when others =>
                null;
        end case;
    end process;
end Behavior;

