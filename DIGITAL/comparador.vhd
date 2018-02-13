----------------------------------------------------------------------------------
-- Company: CELT
-- Engineer: ISABEL RODRÍGUEZ RUIZ Y JORGE CALATAYUD MAESO
-- 
-- Create Date:    19:24:49 11/23/2017 
-- Module Name:    comparador - Behavioral 
--
--Compara dos señales de entrada e indica cuando es
--P<=Q o por otro lado P>Q
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

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
			if(P > Q) then --Si P>Q pongo PGTQ a uno y PLEQ a 0 siempre
				PLEQ <= '0';
				PGTQ <= '1';
			elsif (P < Q OR P = Q) then --Si P<Q o P=Q pongo PLEQ a 1 y PGTQ a 0 siempre
				PLEQ <= '1';
				PGTQ <= '0';
			end if;
		end process;
		
end a_comparador;