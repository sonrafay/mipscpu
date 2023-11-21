library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity TempRegisters is
  port(
        CLK         : in  std_logic;
        reset_neg   : in  std_logic;
        in_reg_A    : in  std_logic_vector(31 downto 0);
        in_reg_B    : in  std_logic_vector(31 downto 0);
        in_ALU_out  : in  std_logic_vector(31 downto 0);

        out_reg_A   : out std_logic_vector(31 downto 0);
        out_reg_B   : out std_logic_vector(31 downto 0);
        out_ALU_out : out std_logic_vector(31 downto 0)
       );
end TempRegisters;

architecture Behavioral of TempRegisters is
  signal reg_A, reg_B, ALU_out: std_logic_vector(31 downto 0) := (others => '0');

begin
  process(CLK)
  begin
    if reset_neg = '0' then
      reg_A   <= (others => '0');
      reg_B   <= (others => '0');
      ALU_out <= (others => '0');
    elsif rising_edge(CLK) then
      reg_A   <= in_reg_A;
      reg_B   <= in_reg_B;
      ALU_out <= in_ALU_out;
    end if;
  end process;

  out_reg_A   <= reg_A;
  out_reg_B   <= reg_B;
  out_ALU_out <= ALU_out;

end Behavioral;
