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
	signal op_code				  : std_logic_vector(2 downto 0);
    signal pc_sel		          : std_logic;
    signal we_pc 		          : std_logic := '0';
    signal we_reg, we_mem         : std_logic;
    signal alu_sel_a              : std_logic_vector(1 downto 0);
    signal alu_sel_b              : std_logic_vector(1 downto 0);
    signal alu_opr                : std_logic;
    signal wd_sel                 : std_logic_vector(1 downto 0);
    signal pc_in, pc_out 	      : std_logic_vector(15 downto 0):= x"0000";
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
    signal adder_RJMP             : std_logic_vector(15 downto 0):= x"0000";
    signal alu_in_a               : std_logic_vector(15 downto 0);
    signal alu_in_b               : std_logic_vector(15 downto 0);
	signal adder_RJMP_shifted     : std_logic_vector(15 downto 0);
	
	component controller
    	port(
        	op_code : in  std_logic_vector(2 downto 0);
        	pc_sel      : out std_logic;
        	we_pc       : out std_logic;
        	we_reg      : out std_logic;
        	we_mem      : out std_logic;
        	alu_sel_a   : out std_logic_vector(1 downto 0);
        	alu_sel_b   : out std_logic_vector(1 downto 0);
        	alu_opr     : out std_logic;
        	wd_sel      : out std_logic_vector(1 downto 0);
        	wr_sel      : out std_logic
    	);
	end component;
	
	component adder
    	port(
        	adder_a : in std_logic_vector (15 downto 0);
        	adder_b : in std_logic_vector (15 downto 0);
        	adder_out : out std_logic_vector (15 downto 0)
    	);
	end component;
	
	component PC
    	port(
        	clk         : in std_logic;
        	reset       : in std_logic;
        	PC_write    : in std_logic;                  
       		PC_in       : in std_logic_vector(15 downto 0);  
        	PC_out      : out std_logic_vector(15 downto 0)  
    	);
	end component;
	
	component register_file
		port (
			clk, rst, RE_we		 : in std_logic;
        	RF_read, RF_adr_w    : in std_logic_vector (3 downto 0);
        	RF_wd    			 : in std_logic_vector (15 downto 0);
        	RF_out    			 : out std_logic_vector (15 downto 0)
		);
	end component; 
	
	component data_memory 
    	port(
        	clk      : in std_logic;
        	MEM_we   : in std_logic;
        	MEM_adr  : in std_logic_vector(15 downto 0);
        	MEM_din  : in std_logic_vector(15 downto 0);
        	MEM_dout : out std_logic_vector(15 downto 0)
    	);
	end component;
	
	component instruction_memory
    	port(
        	read_address : in std_logic_vector (15 downto 0);
        	instruction  : out std_logic_vector (15 downto 0)
    	);
	end component;

	component alu
		port (
			ALU_in0, ALU_in1	: in std_logic_vector (15 downto 0);
			ALU_opr				: in std_logic; 	
			ALU_out				: out std_logic_vector (15 downto 0)
		);
	end component;
	
	component mux_2to1
		generic (n : integer := 16);
    	port(
        	mux2to1_in0 : in std_logic_vector (n-1 downto 0);
        	mux2to1_in1 : in std_logic_vector (n-1 downto 0);
        	mux2to1_sel : in std_logic;  
        	mux2to1_out : out std_logic_vector (n-1 downto 0)
    	);
	end component;
	
	component mux_3to1
    	port(
        	mux3to1_in0 : in std_logic_vector (15 downto 0);
        	mux3to1_in1 : in std_logic_vector (15 downto 0);
        	mux3to1_in2 : in std_logic_vector (15 downto 0);
        	mux3to1_sel : in std_logic_vector (1 downto 0);  
        	mux3to1_out : out std_logic_vector (15 downto 0)
    	);
	end component;
	
	component mux_4to1
    	port(
    	    mux4to1_in0 : in std_logic_vector (15 downto 0);
        	mux4to1_in1 : in std_logic_vector (15 downto 0);
        	mux4to1_in2 : in std_logic_vector (15 downto 0);
        	mux4to1_in3 : in std_logic_vector (15 downto 0);
        	mux4to1_sel : in std_logic_vector (1 downto 0);  
        	mux4to1_out : out std_logic_vector (15 downto 0)
    	);
	end component;

	component not_16bit
    	port(
        	NOT_in  : in  std_logic_vector(15 downto 0);
        	NOT_out : out std_logic_vector(15 downto 0)
    	);
	end component;

	component left_shift_imm
    	port(
        	LSI_in   : in std_logic_vector (3 downto 0);
        	LSI_out : out std_logic_vector (15 downto 0)
    	);
	end component;
	
	component seven_shift
    	port (
        	sevenShift_in  : in  std_logic_vector (8 downto 0);
        	sevenShift_out : out std_logic_vector (15 downto 0)
    	);
	end component;

	component one_shift
   		port (
        	oneShift_in  : in  std_logic_vector (15 downto 0);
        	oneShift_out : out std_logic_vector (15 downto 0)
    	);
	end component;

	component sign_extend
    	port(
        	SE_in  : in std_logic_vector (8 downto 0);
        	SE_out : out std_logic_vector (15 downto 0)    
    	);
	end component;
	
	component zero_filling	
		generic (n : natural := 1);	
		port(
		ZF_in	: in std_logic_vector (n - 1 downto 0);
		ZF_out  : out std_logic_vector (15 downto 0)
		);
	end component;
	
	signal temp : std_logic;
begin

	-- Increment PC
    pc_increment : adder
        port map(
            adder_a => pc_out,
            adder_b => x"0002",
            adder_out => pc_incremented
        );
	
    -- PC
    program_counter : PC
    	port map(
        	clk       => clk,
        	reset     => rst,
       		PC_write  => we_pc,                 
        	PC_in     => pc_in,  
       	 	PC_out    => pc_out 
    	);
    
    -- Instruction Memory
    inst_mem : instruction_memory
        port map(
            read_address => pc_out,
            instruction  => instruction
        );
	
	
    -- Controller
	op_code <= instruction(15 downto 13);
    controller_inst : controller
        port map(
            op_code 	=> op_code,
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

	-- Mux for PC
    mux_pc : mux_2to1
		generic map(16)
        port map(
            mux2to1_in0 => pc_incremented,
            mux2to1_in1 => adder_RJMP_shifted,
            mux2to1_sel => pc_sel,
            mux2to1_out => pc_in
        );


    -- Immediate Value Extraction
    immediate_y_type <= instruction(7 downto 4);
    immediate_z_type <= instruction(12 downto 4);

    -- Left Shift Immediate
    LSI : left_shift_imm
        port map(
            LSI_in => immediate_y_type,
            LSI_out => immediate_shift_y
        );
        
    -- Sign Extension
    se : sign_extend
        port map(
            SE_in  => immediate_z_type,
            SE_out => immediate_se_z
        );

    -- Seven Shift imm
    seven_shifted : seven_shift
        port map(
            sevenShift_in  => immediate_z_type,
            sevenShift_out => immediate_seven_shift_z
        );

    -- Zero Filling Z Type
    zf_ztype : zero_filling
        generic map(9)
        port map(
            ZF_in  => immediate_z_type,
            ZF_out => immediate_zf_z
        );

    -- Shifting Zero Filling Z Type
    zf_shift_ztype : one_shift
        port map(
            oneShift_in  => immediate_zf_z,
            oneShift_out => immediate_zf_shift_z
        );

    -- Zero Filling Y Type
    zf_ytype : zero_filling
        generic map(4)
        port map(
            ZF_in  => immediate_y_type,
            ZF_out => immediate_zf_y
        );

    -- Register File
    reg_file : register_file
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
    not16 : not_16bit
        port map(
            NOT_in  => reg_out,
            NOT_out => not_out
        );

    -- ALU Multiplexer A
    alu_mux_a : mux_3to1
        port map(
            mux3to1_in0 => immediate_shift_y,
            mux3to1_in1 => not_out,
            mux3to1_in2 => reg_out,
            mux3to1_sel => alu_sel_a,
            mux3to1_out => alu_in_a
        );

    -- ALU Multiplexer B
    alu_mux_b : mux_4to1
        port map(
            mux4to1_in0 => x"0001",
            mux4to1_in1 => reg_out,
            mux4to1_in2 => immediate_se_z,
            mux4to1_in3 => immediate_zf_y,
            mux4to1_sel => alu_sel_b,
            mux4to1_out => alu_in_b
        );

    -- ALU
    alu_exe : alu
        port map(
            ALU_in0 => alu_in_a,
            ALU_in1 => alu_in_b,
            ALU_opr => alu_opr, 
            ALU_out => alu_result
        );

    -- adder for RJMP inst.
    adder_rjmp_instruction : adder
        port map(
            adder_a => pc_out,
            adder_b => alu_result,
            adder_out => adder_RJMP
        );

    -- 2*(adder RJMP)
    adder_shifted : one_shift
        port map(
            oneShift_in  => adder_RJMP,
            oneShift_out => adder_RJMP_shifted
        );

    -- Data Memory
    mem : data_memory
        port map(
            clk      => clk,
            MEM_we   => we_mem,
            MEM_adr  => immediate_zf_shift_z,
            MEM_din  => reg_out,
            MEM_dout => mem_data_out
        );

    -- Write Data address Selection
    wr_mux : mux_2to1
	generic map(4)
        port map(
            mux2to1_in0 => instruction(3 downto 0),
            mux2to1_in1 => instruction(12 downto 9),
            mux2to1_sel => wr_sel,
            mux2to1_out => wr_adr
        );

    -- Write Data Selection
    wd_mux : mux_3to1
        port map(
            mux3to1_in0 => mem_data_out,
            mux3to1_in1 => immediate_seven_shift_z,
            mux3to1_in2 => alu_result,
            mux3to1_sel => wd_sel,
            mux3to1_out => wd_data
        );

end Behavioral;

