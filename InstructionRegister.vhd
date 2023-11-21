library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity InstructionRegister is
  GENERIC(n : integer := 32);
  port(
        CLK             : in std_logic;
        reset_neg       : in std_logic;
        IRWrite         : in std_logic;
        in_instruction  : in std_logic_vector(n-1 downto 0);

        out_instruction : out std_logic_vector(n-1 downto 0)
       );
end InstructionRegister;

architecture Behavioral of InstructionRegister is
  signal instr_reg : std_logic_vector(n-1 downto 0) := (others => '0');

begin
  process(CLK)
  begin
    if reset_neg = '0' then
      instr_reg <= (others => '0');
    elsif rising_edge(CLK) and IRWrite = '1' then
      instr_reg <= in_instruction;
    end if;
  end process;

  out_instruction <= instr_reg;  -- Output the instruction

end Behavioral;
