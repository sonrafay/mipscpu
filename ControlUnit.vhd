library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ControlUnit is
  port( 
        CLK         : in std_logic;
        Reset       : in std_logic;
        Op          : in std_logic_vector(5 downto 0);

        PCWriteCond : out std_logic;
        PCWrite     : out std_logic;
        IorD        : out std_logic;
        MemRead     : out std_logic;
        MemWrite    : out std_logic;
        MemToReg    : out std_logic;
        IRWrite     : out std_logic;
        PCSource    : out std_logic_vector(1 downto 0);
        ALUOp       : out std_logic_vector(1 downto 0);
        ALUSrcB     : out std_logic_vector(1 downto 0);
        ALUSrcA     : out std_logic;
        RegWrite    : out std_logic;
        RegDst      : out std_logic
       );
end ControlUnit;

architecture Behavioral of ControlUnit is
  -- Define the FSM states (simplified for the given instructions)
  type state is(InstructionFetch, InstructionDecode, MemoryAddressComp, Execution, BranchCompletion, MemoryAccess, WriteBack);
  signal current_state, next_state : state;
  signal ctrl_state : std_logic_vector(15 downto 0) := (others => '0');

begin
  -- State transition logic
  process(CLK, Reset)
  begin
    if Reset = '1' then
      current_state <= InstructionFetch;
    elsif rising_edge(CLK) then
      current_state <= next_state;
    end if;

    case current_state is
      when InstructionFetch =>
        next_state <= InstructionDecode;

      when InstructionDecode =>
        case Op is
          when "000000" =>  -- R-type (add and nand)
            next_state <= Execution;
          when "100011" =>  -- lw
            next_state <= MemoryAddressComp;
          when "101011" =>  -- sw
            next_state <= MemoryAddressComp;
          when "000100" =>  -- beq
            next_state <= BranchCompletion;
          when "000101" =>  -- bne
            next_state <= BranchCompletion;
          when others => 
            next_state <= InstructionFetch;  -- For unexpected opcodes
        end case;

      when MemoryAddressComp =>
        -- Decide based on the opcode if it's a load or store
        if Op = "100011" then  -- lw
          next_state <= MemoryAccess;
        else  -- sw
          next_state <= MemoryAccess;
        end if;

      when Execution =>
        -- After execution, go to WriteBack for R-type instructions
        next_state <= WriteBack;

      when BranchCompletion =>
        -- After branch completion, go back to fetch the next instruction
        next_state <= InstructionFetch;

      when MemoryAccess =>
        -- After memory access, go to WriteBack for loads or fetch the next instruction for stores
        if Op = "100011" then  -- lw
          next_state <= WriteBack;
        else  -- sw
          next_state <= InstructionFetch;
        end if;

      when WriteBack =>
        -- After write back, fetch the next instruction
        next_state <= InstructionFetch;

      when others =>
        next_state <= InstructionFetch;
    end case;
  end process;

  -- Control signal logic based on the current state
  with current_state select
    ctrl_state <= "1001001000001000" when InstructionFetch,  -- Fetch instruction from memory
                  "0100000000011000" when InstructionDecode,  -- Decode the fetched instruction
                  "0000000000010100" when MemoryAddressComp,  -- Compute memory address for lw/sw
                  "0000000001000100" when Execution,          -- Execute the instruction
                  "0100000010100100" when BranchCompletion,   -- Complete the branch instruction
                  "0011000000000000" when MemoryAccess,       -- Access memory for lw/sw
                  "0000010000000011" when WriteBack,          -- Write back to register for R-type and lw
                  "0000000000000000" when others;             -- Default case

  -- Assign control signals based on the ctrl_state vector
  PCWrite     <= ctrl_state(15);
  PCWriteCond <= ctrl_state(14);
  IorD        <= ctrl_state(13);
  MemRead     <= ctrl_state(12);
  MemWrite    <= ctrl_state(11);
  MemToReg    <= ctrl_state(10);
  IRWrite     <= ctrl_state(9);
  PCSource    <= ctrl_state(8 downto 7);
  ALUOp       <= ctrl_state(6 downto 5);
  ALUSrcB     <= ctrl_state(4 downto 3);
  ALUSrcA     <= ctrl_state(2);
  RegWrite    <= ctrl_state(1);
  RegDst      <= ctrl_state(0);

end Behavioral;
