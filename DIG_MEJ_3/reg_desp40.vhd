----------------------------------------------------------------------------------
-- Company: CELT
-- Engineer: ISABEL RODRÍGUEZ RUIZ Y JORGE CALATAYUD MAESO
-- 
-- Create Date:    20:26:09 11/23/2017 
-- Module Name:    reg_desp40 - Behavioral  
--
--Desplaza los bits del menos significativo hacia el mas
--significativo metiendo el nuevo bit de entrada en la
--posicion cero del registro
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity reg_desp40 is
    Port ( SIN : in STD_LOGIC; -- Datos de entrada serie que es la SIN del circuito
           CLK : in STD_LOGIC; -- Reloj de muestreo, es decir, 40 Hz 
           Q : out STD_LOGIC_VECTOR (39 downto 0)); -- Salida paralelo hacia el sumador
end reg_desp40;

architecture a_reg_desp40 of reg_desp40 is
signal QS : STD_LOGIC_VECTOR(39 downto 0):= (others=>'0'); --Señal auxiliar para la asignacion de la salida
begin

  process (CLK)
    begin
      if (CLK'event and CLK='1') then
			QS(39 downto 1) <= QS(38 downto 0); --Copio lo que hay del 38 al 0 en las posiciones 
										--del 39 al 1 borrando siempre lo que hay en la ultima posicion
			QS(0)<=SIN; --En la primera posicion metemos el nuevo dato que entra
		end if;
  end process;
			Q <= QS; --Asignacion de la salida 
end a_reg_desp40;

