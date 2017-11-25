----------------------------------------------------------------------------------
-- Company: CELT
-- Engineer: ISABEL RODRÍGUEZ RUIZ Y JORGE CALATAYUD MAESO
-- 
-- Create Date:    19:28:18 11/23/2017 
-- Design Name: 
-- Module Name:    decod7s - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity decod7s is
    Port ( D : in STD_LOGIC_VECTOR (3 downto 0); -- Entrada BCD
			  S: out STD_LOGIC_VECTOR (6 downto 0)); -- Salida para excitar los displays (gfedcba)
end decod7s;

architecture a_decod7s of decod7s is

begin

   with D select S <=
		"1000000" when "0000",
      "1111001" when "0001",
      "0100100" when "0010",
      "0110000" when "0011",
      "0011001" when "0100",
      "0010010" when "0101",
      "0000010" when "0110",
      "1111000" when "0111",
      "0000000" when "1000",
      "0011000" when "1001",
      "1111111" when others;

end a_decod7s;
