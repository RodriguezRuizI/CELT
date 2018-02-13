----------------------------------------------------------------------------------
-- Company: CELT
-- Engineer: ISABEL RODRÍGUEZ RUIZ Y JORGE CALATAYUD MAESO
-- 
-- Create Date:    18:26:02 11/29/2017 
-- Module Name:    deco_dia_sem - Behavioral 
--
-- utilizamos un decodificador para saber el dia de la semana en funcion
-- del dato de entrada. Esto activara un led que nos marca dicho dia 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity deco_dia_sem is
    Port ( CODIGO : in  STD_LOGIC_VECTOR (2 downto 0); --Entrada del codigo para elegir el dia de la semana
           DIA : out  STD_LOGIC_VECTOR(6 downto 0)); --Codifica el día de la semana que se encendera sobre un LED
end deco_dia_sem;


architecture Behavioral of deco_dia_sem is

begin

with CODIGO select DIA <=
			"1000000" when "000", --lunes y se activa el LED 7
			"0100000" when "001", --martes y se activa el LED 6
			"0010000" when "010", --miercoles y se activa el LED 5
			"0001000" when "011", --jueves y se activa el LED 4
			"0000100" when "100", --viernes y se activa el LED 3
			"0000010" when "101", --sabado y se activa el LED 2
			"0000001" when "110", --domingo y se activa el LED 1
			"0000000" when others; --No se activa ningun LED


end Behavioral;

