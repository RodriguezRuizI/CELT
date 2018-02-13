----------------------------------------------------------------------------------
-- Company: CELT
-- Engineer: ISABEL RODRÍGUEZ RUIZ Y JORGE CALATAYUD MAESO
-- 
-- Create Date:    20:31:55 11/23/2017  
-- Module Name:    visualizacion - Behavioral 
-- 
--Asociaciones del modulo visualizacion que se encarga
--del control y de la activacion de los displays del circuito
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity visualizacion is
    Port ( E0 : in  STD_LOGIC_VECTOR (3 downto 0); -- Entrada MUX 0
           E1 : in  STD_LOGIC_VECTOR (3 downto 0); -- Entrada MUX 1
           E2 : in  STD_LOGIC_VECTOR (3 downto 0); -- Entrada MUX 2
           E3 : in  STD_LOGIC_VECTOR (3 downto 0); -- Entrada MUX 3
           CLK : in  STD_LOGIC;							-- Entrada de reloj de la FPGA
           SEG7 : out STD_LOGIC_VECTOR (6 downto 0); -- Salida para los displays 
           AN : out  STD_LOGIC_VECTOR (3 downto 0));  -- Activación individual
end visualizacion;

architecture a_visualizacion of visualizacion is

signal Y_SAL  : STD_LOGIC_VECTOR (3 downto 0); -- Salida del MUX
signal S_ENT  : STD_LOGIC_VECTOR (1 downto 0); -- Entradas de control del MUX
signal AN_SAL : STD_LOGIC_VECTOR (3 downto 0);-- Activacion de los displays
signal S_SAL  : STD_LOGIC_VECTOR (6 downto 0);

component MUX4x4
 Port ( E0 : in STD_LOGIC_VECTOR (3 downto 0); -- Entrada 0
		  E1 : in STD_LOGIC_VECTOR (3 downto 0); -- Entrada 1
		  E2 : in STD_LOGIC_VECTOR (3 downto 0); -- Entrada 2
		  E3 : in STD_LOGIC_VECTOR (3 downto 0); -- Entrada 3
		  S : in STD_LOGIC_VECTOR (1 downto 0); -- Señal de control
		  Y : out STD_LOGIC_VECTOR (3 downto 0)); -- Salida
end component;

component decod7s
 Port ( D : in STD_LOGIC_VECTOR (3 downto 0); -- Entrada BCD
		  S: out STD_LOGIC_VECTOR (6 downto 0)); -- Salida para excitar los displays
end component;

component refresco
 Port ( CLK : in STD_LOGIC; -- reloj de la FPGA
			 S : out STD_LOGIC_VECTOR (1 downto 0); -- Control para el mux
			AN : out STD_LOGIC_VECTOR (3 downto 0)); -- Control displays individuales
	end component;

begin

	mux4 : MUX4x4 port map (
									E0=>E0, -- Decenas de las horas
									E1=>E1, -- Unidades de las horas
									E2=>E2, -- Decenas de los minutos
									E3=>E3, -- Unidades de los minutos
									S=>S_ENT, --Entrada de control que proviene del refresco
									Y=>Y_SAL -- Salida del mux
									);
	res : refresco port map(
									CLK=>CLK, --Señal de reloj de la FPGA
									S=>S_ENT, --Señal de control para el MUX
									AN=>AN_SAL --Señal de activacion individual de los displays
									);
	dec : decod7s port map(
									D=>Y_SAL, --Entrada del Mux al deco
									S=>S_SAL --Salida del deco para activar los displays
									);
--Nuestro Visualizacion refresca de derecha a izquierda siguiendo el orden de E3 a E0,
-- es decir, del menos significativo al mas significativo
	AN<=AN_SAL; --Salida de activacion de los displays
	SEG7<=S_SAL; --Salida del decod BCD a los displays

end a_visualizacion;

