----------------------------------------------------------------------------------
-- Company: CELT
-- Engineer: ISABEL RODRÍGUEZ RUIZ Y JORGE CALATAYUD MAESO
-- 
-- Create Date:    19:24:49 11/23/2017 
-- Design Name: 
-- Module Name:    comparador - Behavioral 
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

entity comparador is
    Port ( P : in STD_LOGIC_VECTOR (5 downto 0); -- Entrada P
			  Q : in STD_LOGIC_VECTOR (5 downto 0); -- Entrada Q
			  PGTQ : out STD_LOGIC; -- Salida P>Q
			  PLEQ : out STD_LOGIC); -- Salida P<=Q
end comparador;

architecture a_comparador of comparador is

begin

	process(P,Q)
		begin
			if(P > Q) then
				PLEQ <= '0';
				PGTQ <= '1';
			elsif (P < Q OR P = Q) then
				PLEQ <= '1';
				PGTQ <= '0';
			end if;
		end process;
		
end a_comparador;