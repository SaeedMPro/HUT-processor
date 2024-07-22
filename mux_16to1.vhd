library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity mux_16to1 is
    port(
        mux16to1_in0  : in std_logic_vector (15 downto 0);
        mux16to1_in1  : in std_logic_vector (15 downto 0);
        mux16to1_in2  : in std_logic_vector (15 downto 0);
        mux16to1_in3  : in std_logic_vector (15 downto 0);
        mux16to1_in4  : in std_logic_vector (15 downto 0);
        mux16to1_in5  : in std_logic_vector (15 downto 0);
        mux16to1_in6  : in std_logic_vector (15 downto 0);
        mux16to1_in7  : in std_logic_vector (15 downto 0);
        mux16to1_in8  : in std_logic_vector (15 downto 0);
        mux16to1_in9  : in std_logic_vector (15 downto 0);
        mux16to1_in10 : in std_logic_vector (15 downto 0);
        mux16to1_in11 : in std_logic_vector (15 downto 0);
        mux16to1_in12 : in std_logic_vector (15 downto 0);
        mux16to1_in13 : in std_logic_vector (15 downto 0);
        mux16to1_in14 : in std_logic_vector (15 downto 0);
        mux16to1_in15 : in std_logic_vector (15 downto 0);
        mux16to1_sel  : in std_logic_vector (3 downto 0);  
        mux16to1_out  : out std_logic_vector (15 downto 0)
    );
end mux_16to1;

architecture Behavior of mux_16to1 is
begin
    process(mux16to1_in0, mux16to1_in1, mux16to1_in2, mux16to1_in3, 
            mux16to1_in4, mux16to1_in5, mux16to1_in6, mux16to1_in7, 
            mux16to1_in8, mux16to1_in9, mux16to1_in10, mux16to1_in11, 
            mux16to1_in12, mux16to1_in13, mux16to1_in14, mux16to1_in15, mux16to1_sel)
    begin
        case mux16to1_sel is
            when "0000" =>
                mux16to1_out <= mux16to1_in0;
            when "0001" =>
                mux16to1_out <= mux16to1_in1;
            when "0010" =>
                mux16to1_out <= mux16to1_in2;
            when "0011" =>
                mux16to1_out <= mux16to1_in3;
            when "0100" =>
                mux16to1_out <= mux16to1_in4;
            when "0101" =>
                mux16to1_out <= mux16to1_in5;
            when "0110" =>
                mux16to1_out <= mux16to1_in6;
            when "0111" =>
                mux16to1_out <= mux16to1_in7;
            when "1000" =>
                mux16to1_out <= mux16to1_in8;
            when "1001" =>
                mux16to1_out <= mux16to1_in9;
            when "1010" =>
                mux16to1_out <= mux16to1_in10;
            when "1011" =>
                mux16to1_out <= mux16to1_in11;
            when "1100" =>
                mux16to1_out <= mux16to1_in12;
            when "1101" =>
                mux16to1_out <= mux16to1_in13;
            when "1110" =>
                mux16to1_out <= mux16to1_in14;
            when "1111" =>
                mux16to1_out <= mux16to1_in15;
            when others =>
                mux16to1_out <= (others => '0'); -- Default case to set output to zero if select is invalid
        end case;
    end process;
end Behavior;

