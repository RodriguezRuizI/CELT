----------------------------------------------------------------------------------
-- Company: CELT
-- Engineer: ISABEL RODRÍGUEZ RUIZ Y JORGE CALATAYUD MAESO
-- 
-- Create Date:    19:28:18 11/23/2017 
-- Module Name:    decod7s - Behavioral 
--
-- Activa el número correspondiente en los displays según la entrada
-- Esta activo a nivel bajo luego se enciende cuando en un segmento hay un cero
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity decod7s is
    Port ( D : in STD_LOGIC_VECTOR (3 downto 0); -- Entrada BCD
			  S: out STD_LOGIC_VECTOR (6 downto 0)); -- Salida para excitar los displays
																  -- Su orden es (gfedcba)
end decod7s;

architecture a_decod7s of decod7s is

begin
-- Las señales de los displays están activas a nivel bajo 
--por tanto S enciende los displays cuando hay un cero
   with D select S <=
		"1000000" when "0000", -- Se enciende el a, b, c, d, e, f y sale el 0
      "1111001" when "0001", -- Se enciende el b, c y sale el 1
      "0100100" when "0010", -- Se enciende el a, b, d, e, g y sale el 2
      "0110000" when "0011", -- Se enciende el a, b, c, d, g y sale el 3
      "0011001" when "0100", -- Se enciende el b, c, f, g y sale el 4
      "0010010" when "0101", -- Se enciende el a, c, d, f, g y sale el 5
      "0000010" when "0110", -- Se enciende el a, c, d, e, f, g y sale el 6
      "1111000" when "0111", -- Se enciende el a, b, c y sale el 7
      "0000000" when "1000", -- Se enciende el a, b, c, d, f, g y sale el 8
      "0011000" when "1001", -- Se enciende el a, b, c, f, g y sale el 9
      "1111111" when others; -- No se enciende ninguno 

end a_decod7s;
