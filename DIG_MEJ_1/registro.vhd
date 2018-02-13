----------------------------------------------------------------------------------
-- Company: CELT
-- Engineer: ISABEL RODRÍGUEZ RUIZ Y JORGE CALATAYUD MAESO
-- 
-- Create Date:    20:27:08 11/23/2017 
-- Module Name:    registro - Behavioral 
--
--Si el Enable es 1 la entrada es igual a la salida,
--es decir, registra los datos que entran para pasarlos
--a nuestra siguiente etapa
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity registro is
    Port ( ENTRADA : in STD_LOGIC_VECTOR (14 downto 0); --Entrada del registro de desplazamiento de 15 bits
			  SALIDA : out STD_LOGIC_VECTOR (14 downto 0); --Salida del registro de validacion al Mux
			  EN : in STD_LOGIC; -- Enable que depende del valor de salida del automata VALIDA
			  CLK : in STD_LOGIC); -- Reloj de muestreo
end registro;

architecture a_registro of registro is

signal REG_SAL : STD_LOGIC_VECTOR (14 downto 0) := (others => '0'); --Señal auxiliar para asignar la salida

begin

process(clk)
	begin
		if (CLK'event and CLK ='1') then
			if (EN = '1') then --Si VALIDA del automata es uno se activa y la Salida es igual a la entrada
				REG_SAL<= ENTRADA;
			end if;
		end if;
		
	end process;
	
	SALIDA <= REG_SAL; --Asignamos la señal auxiliar a la salida

end a_registro;

