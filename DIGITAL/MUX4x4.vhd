----------------------------------------------------------------------------------
-- Company: CELT
-- Engineer: ISABEL RODR�GUEZ RUIZ Y JORGE CALATAYUD MAESO
-- 
-- Create Date:    19:33:49 11/23/2017 
-- Design Name: 
-- Module Name:    MUX4x4 - Behavioral 
--
--El Mux controla la salida BCD de los segmentos en el display
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity MUX4x4 is
 Port ( E0 : in STD_LOGIC_VECTOR (3 downto 0); -- Entrada 0
		  E1 : in STD_LOGIC_VECTOR (3 downto 0); -- Entrada 1
		  E2 : in STD_LOGIC_VECTOR (3 downto 0); -- Entrada 2
		  E3 : in STD_LOGIC_VECTOR (3 downto 0); -- Entrada 3
		  S : in STD_LOGIC_VECTOR (1 downto 0); -- Se�al de control que viene del refreco
		  Y : out STD_LOGIC_VECTOR (3 downto 0)); -- Salida al decod BCD
end MUX4x4;

architecture a_MUX4x4 of MUX4x4 is

begin

Y <= E0 when S="11" else -- se selecciona la salida en funci�n de las entradas de control
     E1 when S="10" else -- En este caso los bits mas significativos son los de E0 
     E2 when S="01" else --mientra que los menos son los de E3
     E3 when S="00";

end a_MUX4x4;