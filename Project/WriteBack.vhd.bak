Library ieee;
Use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

Entity WriteBack is
PORT  ( Clk, rst : in std_logic;
	DataIn1, DataIn2, DataIn3 : in std_logic_vector(15 downto 0);
	ControlIn : in std_logic_vector (1 downto 0);
	DataOut : out std_logic_vector (15 downto 0);
);
END WriteBack;

architecture arch_WriteBack of WriteBack is

begin

DataOut <= 	DataIn1 when ControlIn = "00" else
			DataIn2 when ControlIn = "01" else
			DataIn3 when ControlIn = "10" else
			(others => '0');

end architecture arch_WriteBack;