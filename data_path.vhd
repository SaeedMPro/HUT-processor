library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity data_path is
    port(
        clk     : in std_logic;
        rst     : in std_logic
    );
end data_path;

architecture Behavioral of data_path is

    -- Signals
    signal instruction            : std_logic_vector(15 downto 0);
    signal pc_sel, we_pc          : std_logic;
    signal we_reg, we_mem         : std_logic;
    signal alu_sel_a              : std_logic_vector(1 downto 0);
    signal alu_sel_b              : std_logic_vector(1 downto 0);
    signal alu_opr                : std_logic;
    signal wd_sel                 : std_logic_vector(1 downto 0);
    signal pc_in, pc, pc_out      : std_logic_vector(15 downto 0);
    signal alu_result             : std_logic_vector(15 downto 0);
    signal reg_out                : std_logic_vector(15 downto 0);
    signal not_out                : std_logic_vector(15 downto 0);
    signal mem_data_out           : std_logic_vector(15 downto 0);
    signal immediate_y_type       : std_logic_vector(3 downto 0);
    signal immediate_z_type       : std_logic_vector(8 downto 0);
    signal pc_incremented         : std_logic_vector(15 downto 0);
    signal immediate_shift_y      : std_logic_vector(15 downto 0);
    signal immediate_se_z         : std_logic_vector(15 downto 0);
    signal immediate_seven_shift_z: std_logic_vector(15 downto 0);
    signal immediate_zf_y         : std_logic_vector(15 downto 0);
    signal immediate_zf_z         : std_logic_vector(15 downto 0);
    signal immediate_zf_shift_z   : std_logic_vector(15 downto 0);
    signal wd_data                : std_logic_vector(15 downto 0);
    signal wr_adr                 : std_logic_vector(3 downto 0);
    signal wr_sel                 : std_logic;
    signal adder_RJMP             : std_logic_vector(15 downto 0);
    signal alu_in_a               : std_logic_vector(15 downto 0);
    signal alu_in_b               : std_logic_vector(15 downto 0);

begin

    -- PC
    process(clk, rst)
    begin
        if rst = '1' then
            pc <= (others => '0');
        elsif rising_edge(clk) then
            if we_pc = '1' then
                pc <= pc_in;
            end if;
        end if;
    end process;

    pc_out <= pc;
    
    -- Instruction Memory
    instruction_memory : entity work.instruction_memory
        port map(
            read_address => pc,
            instruction  => instruction
        );

    -- Controller
    controller_inst : entity work.controller
        port map(
            instruction => instruction,
            rst         => rst,
            pc_sel      => pc_sel,
            we_pc       => we_pc,
            we_reg      => we_reg,
            we_mem      => we_mem,
            alu_sel_a   => alu_sel_a,
            alu_sel_b   => alu_sel_b,
            alu_opr     => alu_opr,
            wd_sel      => wd_sel,
            wr_sel      => wr_sel
        );
    
    -- Left Shift Immediate
    left_shift_imm : entity work.left_shift_imm
        port map(
            LSI_in => immediate_y_type,
            LSI_out => immediate_shift_y
        );
        
    -- Sign Extension
    se : entity work.sign_extend
        generic map(9)
        port map(
            SE_in  => immediate_z_type,
            SE_out => immediate_se_z
        );

    -- Seven Shift imm
    seven_shifted : entity work.seven_shift
        port map(
            sevenShift_in  => immediate_z_type,
            sevenShift_out => immediate_seven_shift_z
        );

    -- Zero Filling Z Type
    zf_ztype : entity work.zero_filling
        generic map(9)
        port map(
            ZF_in  => immediate_z_type,
            ZF_out => immediate_zf_z
        );

    -- Zero Filling Y Type
    zf_ytype : entity work.zero_filling
        generic map(4)
        port map(
            ZF_in  => immediate_y_type,
            ZF_out => immediate_zf_y
        );

    -- Register File
    register_file : entity work.register_file
        port map(
            clk        => clk,
            rst        => rst,
            RE_we      => we_reg,
            RF_read    => instruction(3 downto 0),
            RF_adr_w   => wr_adr,
            RF_wd      => wd_data,
            RF_out     => reg_out
        );

    -- not 16-bit
    not16: entity work.not_16bit
        port map(
            NOT_in  => reg_out,
            NOT_out => not_out
        );

    -- ALU Multiplexer A
    alu_mux_a : entity work.mux_3to1
        port map(
            mux3to1_in0 => immediate_shift_y,
            mux3to1_in1 => not_out,
            mux3to1_in2 => reg_out,
            mux3to1_sel => alu_sel_a,
            mux3to1_out => alu_in_a
        );

    -- ALU Multiplexer B
    alu_mux_b : entity work.mux_4to1
        port map(
            mux4to1_in0 => x"0001",
            mux4to1_in1 => reg_out,
            mux4to1_in2 => immediate_se_z,
            mux4to1_in3 => immediate_zf_y,
            mux4to1_sel => alu_sel_b,
            mux4to1_out => alu_in_b
        );

    -- ALU
    alu : entity work.alu
        port map(
            ALU_in0 => alu_in_a,
            ALU_in1 => alu_in_b,
            ALU_opr => alu_opr, 
            ALU_out => alu_result
        );

    -- adder for RJMP inst.
    adder : entity work.adder
        port map(
            adder_a => pc,
            adder_b => alu_result,
            adder_out => adder_RJMP
        );

    -- Data Memory
    mem : entity work.data_memory
        port map(
            clk      => clk,
            MEM_we   => we_mem,
            MEM_adr  => alu_result,
            MEM_din  => reg_out,
            MEM_dout => mem_data_out
        );

    -- Write Data address Selection
    wr_mux : entity work.mux_2to1
	generic map(4)
    port map(
        mux2to1_in0 => instruction(3 downto 0),
        mux2to1_in1 => instruction(12 downto 9),
        mux2to1_sel => wr_sel,
        mux2to1_out => wr_adr
    );

    -- Write Data Selection
    wd_mux : entity work.mux_3to1
        port map(
            mux3to1_in0 => mem_data_out,
            mux3to1_in1 => immediate_seven_shift_z,
            mux3to1_in2 => alu_result,
            mux3to1_sel => wd_sel,
            mux3to1_out => wd_data
        );

    -- Increment PC
    pc_increment : entity work.adder
        port map(
            adder_a => pc,
            adder_b => x"0002",
            adder_out => pc_incremented
        );

    -- Mux for PC
    mux_pc : entity work.mux_2to1
        port map(
            mux2to1_in0 => pc_incremented,
            mux2to1_in1 => adder_RJMP,
            mux2to1_sel => pc_sel,  
            mux2to1_out => pc_in
        );

end Behavioral;

