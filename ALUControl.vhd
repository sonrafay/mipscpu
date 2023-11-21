library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALUControl is
  port(
    ALUOp   : in  std_logic_vector(1 downto 0); -- Input from the main control unit
    instr   : in  std_logic_vector(5 downto 0); -- Function field from the instruction

    result  : out std_logic_vector(3 downto 0)  -- Output to the ALU for operation selection
  );
end ALUControl;

architecture Behavioral of ALUControl is
  signal temp, operation : std_logic_vector(3 downto 0) := "1111"; -- Default to an invalid operation

begin

  -- ALUOp decoding for LW, SW, BEQ, BNE, and R-type instructions
  with ALUOp select
    temp <= "0000"    when "00", -- LW and SW should lead to an ADD operation
            "0001"    when "01", -- BEQ and BNE will require SUBTRACT to set the zero flag
            operation when "10", -- R-type instructions
            "1111"    when others; -- Invalid operation by default

  -- R-type instruction decoding using the function field
  with instr select
    operation <= "0000" when "100000", -- ADD
                 "0010" when "100111", -- NAND (you may need to assign a new opcode)
                 "1111" when others;   -- Invalid operation for all other function codes

  -- Assign the result from temp or operation based on ALUOp
  result <= temp;

end Behavioral;
