----------------------------------------------------------------------------------
-- Company: CELT
-- Engineer: ISABEL RODRÍGUEZ RUIZ Y JORGE CALATAYUD MAESO
--
-- Create Date:    19:39:14 11/23/2017 
-- Design Name: 
-- Module Name:    refresco - Behavioral 
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

entity refresco is
    Port ( CLK : in STD_LOGIC; -- reloj
			  S : out STD_LOGIC_VECTOR (1 downto 0); -- Control para el mux
			  AN : out STD_LOGIC_VECTOR (3 downto 0)); -- Control displays individuales
end refresco;

architecture a_refresco of refresco is

signal SS : STD_LOGIC_VECTOR(1 downto 0) := (others => '0');
signal counter : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
begin

process(CLK)
	begin
	
	if(CLK'event and CLK='1') then
		if counter = 50000 then
			if SS = "11" then
				SS <= "00";
			else
				SS <= SS+1;
			end if;
			counter <= (others => '0');
		else
			counter <= counter + 1;
		end if;
	end if;
end process;

S<=SS;

AN<="1110" when SS="00" else   -- activa cada display en function del valor de SS
    "1101" when SS="01" else
    "1011" when SS="10" else
    "0111" when SS="11";
end a_refresco;

