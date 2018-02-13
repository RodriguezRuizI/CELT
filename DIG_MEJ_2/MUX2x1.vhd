----------------------------------------------------------------------------------
-- Company: CELT
-- Engineer: ISABEL RODRÍGUEZ RUIZ Y JORGE CALATAYUD MAESO
-- 
-- Create Date:    16:38:57 11/29/2017 
-- Module Name:    MUX2x1 - Behavioral
--
-- Mux de 2x1 que controla la salida que saca el botón en los displays
-- 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX2x1 is
    Port ( E0 : in  STD_LOGIC_VECTOR (13 downto 0); -- Entrada E0 que corresponde a la fecha
           E1 : in  STD_LOGIC_VECTOR (13 downto 0); -- Entrada E1 que corresponde a la hora
           S : in  STD_LOGIC; --Entrada de control que corresponde al pulsador
           Y : out  STD_LOGIC_VECTOR (13 downto 0)); --Salida del Mux de 2x1 al modulo de visualizacion
end MUX2x1;

architecture Behavioral of MUX2x1 is

begin
-- se selecciona la salida en función de las entradas
Y <= E0 when S='1' else  --Si pulsamos sale la fecha
     E1 when S='0'; --Si no pulsamos sale la hora

end Behavioral;

