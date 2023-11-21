library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Registers is
  port(
        CLK          : in  std_logic;
        reset_neg    : in  std_logic;
        address_in_1 : in  std_logic_vector(4 downto 0);
        address_in_2 : in  std_logic_vector(4 downto 0);
        write_reg    : in  std_logic_vector(4 downto 0);
        write_data   : in  std_logic_vector(31 downto 0);
        RegWrite     : in  std_logic;  -- Control signal to enable writing to the register file

        register_1   : out std_logic_vector(31 downto 0);
        register_2   : out std_logic_vector(31 downto 0)
       );
end Registers;

architecture Behavioral of Registers is
  type registers_type is array (0 to 31) of std_logic_vector(31 downto 0);
  signal reg: registers_type := (others => (others => '0'));

begin

  process(CLK)
  begin
    if reset_neg = '0' then
      -- Reset all registers to zero on reset
      reg <= (others => (others => '0'));
    elsif rising_edge(CLK) then
      if RegWrite = '1' then
        -- Write to the register file if RegWrite is asserted
        reg(to_integer(unsigned(write_reg))) <= write_data;
      end if;
    end if;
  end process;

  -- Continuous assignment for reading from the register file
  register_1 <= reg(to_integer(unsigned(address_in_1)));  -- Read from register addressed by address_in_1
  register_2 <= reg(to_integer(unsigned(address_in_2)));  -- Read from register addressed by address_in_2

end Behavioral;
