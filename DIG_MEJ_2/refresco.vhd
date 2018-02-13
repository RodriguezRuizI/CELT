----------------------------------------------------------------------------------
-- Company: CELT
-- Engineer: ISABEL RODRÍGUEZ RUIZ Y JORGE CALATAYUD MAESO
--
-- Create Date:    19:39:14 11/23/2017 
-- Module Name:    refresco - Behavioral 
--
-- Controla la activación de los displays y la entrada del MUX
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity refresco is
    Port ( CLK : in STD_LOGIC; -- reloj de la FPGA
			  S : out STD_LOGIC_VECTOR (1 downto 0); -- Control para el mux
			  AN : out STD_LOGIC_VECTOR (3 downto 0)); -- Control displays individuales
end refresco;

architecture a_refresco of refresco is

signal SS : STD_LOGIC_VECTOR(1 downto 0) := (others => '0'); --Señal de control para el MUX
signal counter : STD_LOGIC_VECTOR(15 downto 0) := (others => '0'); --Contador para poner frec. a 1000 Hz 
begin

process(CLK)
	begin
	
	if(CLK'event and CLK='1') then -- Dividimos los 50 MHz y dejamos la frecuencia en
		if counter = 50000 then --1000 Hz para poder ver algo coherente sobre los displays
			if SS = "11" then -- Si llega a 11 reiniciamos a 00
				SS <= "00";
			else
				SS <= SS+1; --Si no es 11 incrementa SS
			end if;
			counter <= (others => '0'); --Si ha contado 50000 ponemos el contador a cero
		else --Si no ha llegado a 50000 incrementamos el contador hasta que llegue 
			counter <= counter + 1;
		end if;
	end if;
end process;

S<=SS; -- Asignamos a la salida la señal SS
-- activa cada display en function del valor de SS
AN<="1110" when SS="00" else --Activa el display AN3
    "1101" when SS="01" else --Activa el display AN2
    "1011" when SS="10" else --Activa el display AN1
    "0111" when SS="11"; --Activa el display AN0
end a_refresco;

