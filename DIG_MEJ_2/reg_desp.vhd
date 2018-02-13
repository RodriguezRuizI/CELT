----------------------------------------------------------------------------------
-- Company: CELT
-- Engineer: ISABEL RODRÍGUEZ RUIZ Y JORGE CALATAYUD MAESO
-- 
-- Create Date:    20:25:04 11/23/2017 
-- Module Name:    reg_desp - Behavioral 
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

entity reg_desp is
	Port ( SIN : in STD_LOGIC; -- Datos de entrada serie que depende del valor de DATO que sale del automata
			 CLK : in STD_LOGIC; -- Reloj de muestreo
			 EN : in STD_LOGIC; -- Enable que depende del valor del automata de CAPTURA
			 Q : out STD_LOGIC_VECTOR (27 downto 0)); -- Salida paralelo hacia el registro de validacion
end reg_desp;

architecture a_reg_desp of reg_desp is

signal QSAL : STD_LOGIC_VECTOR(27 downto 0):= (others=>'0'); --Señal auxiliar para asignar la salida

begin

  process (CLK)
    begin
      if (CLK'event and CLK='1') then
			if(EN = '1') then --Si CAPTURA del automata es 1
				QSAL(27 downto 1) <= QSAL(26 downto 0); --Copio lo que hay del 26 al 0 en las posiciones del 27 al 1 borrando siempre lo que hay en la ultima posicion
				QSAL(0)<=SIN; --En la primera posicion metemos el nuevo dato que entra
			end if;
		end if;
  end process;
			Q <= QSAL; --Asigna la señal auxiliar a la salida

end a_reg_desp;

