----------------------------------------------------------------------------------
-- Company: CELT
-- Engineer: ISABEL RODRÍGUEZ RUIZ Y JORGE CALATAYUD MAESO
--
-- Create Date:    19:23:49 11/23/2017 
-- Module Name:    automata - Behavioral
--
--El autómata nos da los diferentes estados que podemos tener
--y en función de ello hará que funcionen o no los registros
--de validacion y desplazamiento. Ademas sera el responsable de
--introducir el dato siguiente para el correcto funcionamiento
--de los displays
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity automata is
    Port ( CLK : in  STD_LOGIC; -- Reloj de muestreo
           C0 : in  STD_LOGIC; -- Condición de decision para "0"
           C1 : in  STD_LOGIC; -- Condición de decisión para "1"
           DATO : out  STD_LOGIC; -- Datos a cargar
           CAPTUR  : out  STD_LOGIC; -- Enable del reg. de desplaz.
           VALID : out  STD_LOGIC); -- Enable del reg. de validación
end automata;

architecture a_automata of automata is
--Posibles estados a los que podemos movernos
type TIPO_ESTADO is (ESP_SYNC,AVAN_ZM,MUESTREO,DATO0,DATO1,DATOSYNC);
signal ST : TIPO_ESTADO:= ESP_SYNC ; -- Estado inicial en que arranca
-- Salidas(2) es DATO Salidas(1) es CAPTUR y Salidas(0) es VALID
signal salidas : STD_LOGIC_VECTOR (2 downto 0) :="000";

begin
 process (CLK)
 variable cont : STD_LOGIC_VECTOR (7 downto 0):="00000000"; -- contador
									-- para contar ciclos en un estado, iniciado a 0
	begin
		if (CLK'event and CLK = '1') then
			case ST is
				when ESP_SYNC => -- Estado normal, dura 1 ciclo de reloj
					if C0 = '0' and C1 = '0' then
						ST <= AVAN_ZM; -- Si C0=0 y C1=0 avanza a zona de medida
					else --Si no lo son espera hasta que lo sean que será cuando llegue el sincronismo
						ST <= ESP_SYNC;  --por lo tanto espera en este estado hasta que esto ocurra
					end if;
				when AVAN_ZM => -- Estado que dura 20 ciclos de reloj
					cont:= cont+1; -- Se incrementa el contador.
					if (cont=20) then -- Si llega a 20
						cont:=(others=>'0'); -- Pone el contador a 0
						ST<=MUESTREO; -- Y cambiar de estado a muestreo
					else
						ST<=AVAN_ZM; -- Si no ha llegado a 20 permanecer en el estado de zona medida
					end if; 
				when MUESTREO => --Estado que dura 40 ciclos de reloj
					cont:= cont+1; -- Se incrementa el contador
					if (cont = 39) then -- Si llega a 39
						cont:=(others=>'0'); -- Pone el contador a 0
						if (C0 = '0') and (C1 = '0') then --Si C0 es 0 y C1 es 0
							ST <= DATOSYNC; -- Avanza durante un ciclo a DATO=SYNC
						elsif C0 = '1' and C1 = '0' then --Si C0 es 1 y C1 es 0
							ST <= DATO0; -- Avanza durante un ciclo a DATO0
						elsif C0 = '0' and C1 = '1' then --Si C0 es 0 y C1 es 1
							ST <= DATO1; ---- Avanza durante un ciclo a DATO1
						else --Si no se cumple ninguna de estas opciones se quedan en muestreo
							ST <= MUESTREO;
						end if;
					else
						ST <= MUESTREO; -- Si no ha llegado a 39 permanece en el estado de muestreo
					end if;
				when DATO0 => --Despues de entrar en DATO0 vuelve a MUESTREO tras un ciclo
					ST <= MUESTREO;
				when DATO1 => --Despues de entrar en DATO1 vuelve a MUESTREO tras un ciclo
					ST <= MUESTREO;
				when DATOSYNC => --Despues de entrar en DATOSYNC vuelve a MUESTREO tras un ciclo
					ST <= MUESTREO;	
			end case;
		end if;
	end process;
 
 with ST select
				salidas<=
								"000" when ESP_SYNC, -- Si estamos en ESP_SYNC salida(2)=0 salida(1)=0 salida(0)=0
								"000" when AVAN_ZM, -- Si estamos en AVAN_ZM salida(2)=0 salida(1)=0 salida(0)=0
								"000" when MUESTREO, -- Si estamos en MUESTREO salida(2)=0 salida(1)=0 salida(0)=0
								"010" when DATO0, -- Si estamos en DATO0 salida(2)=0 salida(1)=1 salida(0)=0
								"110" when DATO1, -- Si estamos en DATO1 salida(2)=1 salida(1)=1 salida(0)=0
								"001" when DATOSYNC, -- Si estamos en DATOSYNC salida(2)=0 salida(1)=0 salida(0)=1
								"000" when others; -- En otro caso salida(2)=0 salida(1)=0 salida(0)=0

DATO <= salidas(2); --Asignamos a DATO su bit correspondiente de salida
CAPTUR <= salidas(1);--Asignamos a CAPTUR su bit correspondiente de salida
VALID <= salidas(0);--Asignamos a VALID su bit correspondiente de salida
end a_automata;