library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all; -- Only necessary if you are using text I/O in your test bench

entity TestBench is
end TestBench;

architecture Behavioral of TestBench is

  -- constants
  constant CLK_low    : time := 12 ns;
  constant CLK_high   : time := 8 ns;
  constant CLK_period : time := CLK_low + CLK_high;
  constant ResetTime  : time := 10 ns;

  -- dut signals
  signal clock, reset_neg : std_logic := '1'; -- Initialize reset_neg to '1' for an active-low reset

  component TopLevel is
    port(
      CLK        : in std_logic;
      reset_neg  : in std_logic
    );
  end component;

begin
  -- Instantiation of the TopLevel component, renaming reset to reset_neg
  dut : TopLevel port map (CLK => clock, reset_neg => reset_neg);

  -- reset process
  reset_process : process
  begin
    reset_neg <= '0'; -- Assert reset (active low)
    wait for ResetTime;
    reset_neg <= '1'; -- Deassert reset
    wait; -- Wait indefinitely, or specify a simulation end time if desired
  end process reset_process;

  -- Clock process
  clock_process : process
  begin
    clock <= '0';
    wait for CLK_low;
    clock <= '1';
    wait for CLK_high;
  end process clock_process;

end Behavioral;
