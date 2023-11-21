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
-- lw $t3, 300($s2)
mem(0)  <= "10001110"; -- [31-24] opcode
mem(1)  <= "10010010"; -- [23-16] source register $s2
mem(2)  <= "10110000"; -- [15-8]  target register $t3
mem(3)  <= "00010100"; -- [7-0]   immediate value 300

-- sw $t6, 400($s7)
mem(4)  <= "10101110"; -- [31-24] opcode
mem(5)  <= "11110110"; -- [23-16] source register $s7
mem(6)  <= "11100000"; -- [15-8]  target register $t6
mem(7)  <= "00011001"; -- [7-0]   immediate value 400

-- add $t5, $t3, $s1
mem(8)  <= "00000001"; -- [31-24] opcode
mem(9)  <= "01011001"; -- [23-16] source register 1 $t3
mem(10) <= "00011010"; -- [15-8]  source register 2 $s1
mem(11) <= "10100000"; -- [7-0]   destination register $t5, shift, function code

-- bne $s6, $t5, 200
mem(12) <= "00010110"; -- [31-24] opcode
mem(13) <= "11010101"; -- [23-16] source register 1 $s6
mem(14) <= "01000000"; -- [15-8]  source register 2 $t5
mem(15) <= "11001000"; -- [7-0]   immediate value 200

-- beq $s6, $t5, 200
mem(16) <= "00010010"; -- [31-24] opcode
mem(17) <= "11010101"; -- [23-16] source register 1 $s6
mem(18) <= "01000000"; -- [15-8]  source register 2 $t5
mem(19) <= "11001000"; -- [7-0]   immediate value 200

-- nand $t1, $t2, $t3
mem(20) <= "00000001"; -- [31-24] opcode
mem(21) <= "01010010"; -- [23-16] source register 1 $t2
mem(22) <= "11010100"; -- [15-8]  source register 2 $t3
mem(23) <= "00100111"; -- [7-0]   destination register $t1, shift, function code


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
