----------------------------------------------------------------------------------
-- Company: CELT
-- Engineer: ISABEL RODRÍGUEZ RUIZ Y JORGE CALATAYUD MAESO
-- 
-- Create Date:    20:27:08 11/23/2017 
-- Design Name: 
-- Module Name:    registro - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity registro is
    Port ( ENTRADA : in STD_LOGIC_VECTOR (13 downto 0);
			  SALIDA : out STD_LOGIC_VECTOR (13 downto 0);
			  EN : in STD_LOGIC;
			  CLK : in STD_LOGIC);
end registro;

architecture a_registro of registro is

signal REG_SAL : STD_LOGIC_VECTOR (13 downto 0) := (others => '0');

begin

process(clk)
	begin
		if (CLK'event and CLK ='1') then
			if (EN = '1') then
				REG_SAL<= ENTRADA;
			end if;
		end if;
		
	end process;
	
	SALIDA <= REG_SAL;

end a_registro;

