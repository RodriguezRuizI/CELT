----------------------------------------------------------------------------------
-- Company: CELT
-- Engineer: ISABEL RODRÍGUEZ RUIZ Y JORGE CALATAYUD MAESO
-- 
-- Create Date:    19:30:24 11/23/2017 
-- Module Name:    gen_reloj
-- 
-- Este es un generador de reloj que divide la frecuencia
-- de la FPGA, que es de 50 MHz, en una frecuencia de 40Hz.
-- Esto ocurrira cada vez que nuestro contador cuente 625000 ciclos.
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity gen_reloj is
    Port ( CLK : in  STD_LOGIC; -- Reloj de la FPGA
           CLK_M : out  STD_LOGIC); -- Reloj de muestreo
end gen_reloj;

architecture a_gen_reloj of gen_reloj is

signal cont_M : STD_LOGIC_VECTOR (31 downto 0):= (others=>'0'); -- contador para la division
signal S_M : STD_LOGIC :='0'; --Señal que marca el flanco de subida

begin

	PROC_CONT : process (CLK)
		begin
			if CLK'event and CLK='1' then
				cont_M <= cont_M + 1; -- Incrementamos el contador a 625000
				if cont_M >= 625000 then --Si llega a 625000 divide frec a 40 Hz 
					S_M <=not S_M; --Se niega S_M para marcar el flanco de baj.
					cont_M <=(others=>'0'); --Se pone el contador a 0 
													--para empezar el siguiente ciclo
				end if;
			end if;
		end process;
--Asociamos a nuestro reloj de muestreo la señal de 40 Hz		
CLK_M<=S_M; 

end a_gen_reloj;