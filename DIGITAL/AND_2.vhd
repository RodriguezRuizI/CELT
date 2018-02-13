----------------------------------------------------------------------------------
-- Company: CELT
-- Engineer: ISABEL RODRÍGUEZ RUIZ Y JORGE CALATAYUD MAESO
-- 
-- Create Date:    19:21:52 11/23/2017 
-- Module Name:    AND_2 - Behavioral 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity AND_2 is
    Port ( A : in  STD_LOGIC; -- ENTRADA A es P>Q del CMP1
           B : in  STD_LOGIC; -- ENTRADA B es P<Q del CMP2
           S : out  STD_LOGIC); -- SALIDA es 1 solo si A y B son 1 si no siempre 0
end AND_2;

architecture a_AND_2 of AND_2 is

begin

S<= A and B; --Operacion AND entre la entrada P>Q del CMP1 y la entrada P<Q del CMP2

end a_AND_2;