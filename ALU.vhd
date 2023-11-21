library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU is
  GENERIC(n : integer := 32);
  port( 
        operand_1   : in std_logic_vector(31 downto 0);  -- First operand
        operand_2   : in std_logic_vector(31 downto 0);  -- Second operand
        ALU_control : in std_logic_vector(3 downto 0);  -- Control signals

        result      : out std_logic_vector(31 downto 0); -- Result of the operation
        zero        : out std_logic                     -- Zero flag for comparison
       );
end ALU;

architecture Behavioral of ALU is
  signal temp : std_logic_vector(31 downto 0);

begin

  temp <=
    -- ADD operation (used in lw, sw, add)
    std_logic_vector(unsigned(operand_1) + unsigned(operand_2)) when ALU_control = "0000" else
    -- SUBTRACT operation (used in beq, bne)
    std_logic_vector(unsigned(operand_1) - unsigned(operand_2)) when ALU_control = "0001" else
    -- NAND operation
    operand_1 NAND operand_2 when ALU_control = "0010" else
    -- Default case
    (others => '0');

  -- Set the zero flag if the result is zero (for beq and bne)
  zero <= '1' when temp = (others => '0') else '0';
  result <= temp;

end Behavioral;
