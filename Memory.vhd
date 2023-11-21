library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Memory is
  port(
        CLK       : in std_logic;
        reset_neg : in std_logic;
        address   : in std_logic_vector(31 downto 0);
        MemWrite  : in std_logic;
        MemRead   : in std_logic;
        WriteData : in std_logic_vector(31 downto 0);

        MemData   : out std_logic_vector(31 downto 0)
       );
end Memory;

architecture Behavioral of Memory is
  type mem_type is array (0 to 1023) of std_logic_vector(7 downto 0);
  signal mem: mem_type := (others => "00000000");

begin

-- Initialize memory with the specified instructions
mem(0) <= "100011"; -- lw $t3, 300($s2)
mem(1) <= "10010";
mem(2) <= "01011";
mem(3) <= "00000001";
mem(4) <= "00101100";

mem(5) <= "101011"; -- sw $t6, 400($s7)
mem(6) <= "10111";
mem(7) <= "01110";
mem(8) <= "00000001";
mem(9) <= "10010000";

mem(10) <= "000000"; -- add $t5, $t3, $s1
mem(11) <= "01011";
mem(12) <= "10001";
mem(13) <= "01101";
mem(14) <= "00000";
mem(15) <= "100000";

mem(16) <= "000101"; -- bne $s6, $t5, 200
mem(17) <= "10110";
mem(18) <= "01101";
mem(19) <= "00000000";
mem(20) <= "11001000";

mem(21) <= "000100"; -- beq $s6, $t5, 200
mem(22) <= "10110";
mem(23) <= "01101";
mem(24) <= "00000000";
mem(25) <= "11001000";

mem(26) <= "000000"; -- nand $t1, $t2, $t3
mem(27) <= "01010";
mem(28) <= "01011";
mem(29) <= "01001";
mem(30) <= "00000";
mem(31) <= "100111";


  -- Memory write process
  process(CLK, reset_neg)
  begin
    if rising_edge(CLK) and MemWrite = '1' then
      -- Memory write operation
      mem(to_integer(unsigned(address(9 downto 2))))     <= WriteData(31 downto 24);
      mem(to_integer(unsigned(address(9 downto 2)) + 1)) <= WriteData(23 downto 16);
      mem(to_integer(unsigned(address(9 downto 2)) + 2)) <= WriteData(15 downto 8);
      mem(to_integer(unsigned(address(9 downto 2)) + 3)) <= WriteData(7  downto 0);
    end if;
  end process;

  -- Memory read operation
  MemData <= mem(to_integer(unsigned(address(9 downto 2))))     &
             mem(to_integer(unsigned(address(9 downto 2)) + 1)) &
             mem(to_integer(unsigned(address(9 downto 2)) + 2)) &
             mem(to_integer(unsigned(address(9 downto 2)) + 3)) when MemRead = '1';

end Behavioral;
