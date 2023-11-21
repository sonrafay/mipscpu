library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ShiftLeft2 is
  port(
        input  : in std_logic_vector(31 downto 0);  -- 32-bit input

        output : out std_logic_vector(31 downto 0)  -- 32-bit output
       );
end ShiftLeft2;

architecture Behavioral of ShiftLeft2 is
begin
  -- Shift the input left by 2 bits, filling the least significant bits with 0
  output <= input(29 downto 0) & "00";
end Behavioral;
