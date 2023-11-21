library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MemoryDataRegister is
  port(
        CLK        : in  std_logic;
        reset_neg  : in  std_logic;
        input      : in  std_logic_vector(31 downto 0);  -- Data coming from memory

        output     : out std_logic_vector(31 downto 0)   -- Data going to the mux
       );
end MemoryDataRegister;

architecture Behavioral of MemoryDataRegister is
  signal MemDataReg: std_logic_vector(31 downto 0) := (others => '0');

begin
  process(CLK)
  begin
    if reset_neg = '0' then
      MemDataReg <= (others => '0');
    elsif rising_edge(CLK) then
      MemDataReg <= input;
    end if;
  end process;

  output <= MemDataReg;

end Behavioral;
