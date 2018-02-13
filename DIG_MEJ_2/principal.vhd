----------------------------------------------------------------------------------
-- Company: CELT
-- Engineer: ISABEL RODRÍGUEZ RUIZ Y JORGE CALATAYUD MAESO
-- 
-- Create Date:    19:35:47 11/23/2017 
-- Module Name:    principal - Behavioral 
--
-- Modulo principal en el que se hacen todas 
-- las interconexiones del circuito para el 
--correcto funcionamiento de este
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity principal is
		Port ( CLK : in STD_LOGIC; -- entrada de reloj
				 SIN : in STD_LOGIC; -- entrada de datos
				 AN : out STD_LOGIC_VECTOR (3 downto 0); -- control de displays
				 SEG7 : out STD_LOGIC_VECTOR (6 downto 0); -- segmentos de displays
				 PULSADOR : in STD_LOGIC); --Entrada del pulsador para controlar hora o fecha
		end principal;

architecture a_principal of principal is

-- Constantes del circuito (umbrales de decisión)
constant UMBRAL1 : STD_LOGIC_VECTOR (5 downto 0) := "100010"; -- 34
constant UMBRAL2 : STD_LOGIC_VECTOR (5 downto 0) := "100110"; -- 38

-- Declaracion de señales necesarias
signal CLK_M  : STD_LOGIC; -- salida de 40 Hz
signal Q_SAL : STD_LOGIC_VECTOR (39 downto 0); -- salida del registro de desplazamiento de 40
signal SUM_SAL : STD_LOGIC_VECTOR (5 downto 0); --salida sumador
signal PG1_SAL : STD_LOGIC; --salida P>Q del comparador 1
signal PG2_SAL : STD_LOGIC := '0'; --salida P>Q del comparador 2 que es siempre 0
signal PL1_SAL : STD_LOGIC; --salida P<Q del comparador 1
signal PL2_SAL : STD_LOGIC; --salida P<Q del comparador 2
signal SAL_AND : STD_LOGIC; --salida de la puerta and
signal DATO_SAL : STD_LOGIC; --salida DATO del automata
signal CAPTUR_SAL : STD_LOGIC; --salida CAPTURA del automata
signal VALID_SAL : STD_LOGIC; --salida VALIDA del automata
signal Q2_SAL : STD_LOGIC_VECTOR (27 downto 0); --salida registro de desplazamiento de 28 bits
signal SAL_REG : STD_LOGIC_VECTOR (27 downto 0); --salida registro de validacion
signal SAL_MUX : STD_LOGIC_VECTOR (13 downto 0); --salida del Mux hacia el modulo de visualizacion que elige la trama que se muestra segun si tenemos pulsado o no el pulsador
signal E0_TMP : STD_LOGIC_VECTOR(3 downto 0) := (others => '0'); --señal auxiliar para concatenar un 0 a la izquierda con E0
signal E2_TMP : STD_LOGIC_VECTOR(3 downto 0) := (others => '0'); --señal auxiliar para concatenar un 0 a la izquierda con E2

component gen_reloj
	Port ( CLK : in STD_LOGIC; -- Reloj de la FPGA
			 CLK_M : out STD_LOGIC); -- Reloj de frecuencia dividida
	end component;

component reg_desp40
	Port ( SIN : in STD_LOGIC; -- Datos de entrada serie
			 CLK : in STD_LOGIC; -- Reloj de muestreo
			 Q : out STD_LOGIC_VECTOR (39 downto 0)); -- Salida paralelo
	end component;

component sumador40
	Port ( ENT : in STD_LOGIC_VECTOR (39 downto 0);  --salida paralelo del registro de desplazamiento de 40
			 SAL : out STD_LOGIC_VECTOR (5 downto 0)); --salida del sumador
	end component;

component comparador
	Port ( P : in STD_LOGIC_VECTOR (5 downto 0); --Datos de salida del sumador
			 Q : in STD_LOGIC_VECTOR (5 downto 0); --Umbral
			 PGTQ : out STD_LOGIC; --salida P>Q
			 PLEQ : out STD_LOGIC); --salida P<Q
	end component;

component AND_2
	Port ( A : in STD_LOGIC;  --Entrada P>Q comparador 1
			 B : in STD_LOGIC; --Entrada P<Q comparador 2
			 S : out STD_LOGIC); --Salida lógica AND
	end component;

component reg_desp
	Port ( SIN : in STD_LOGIC; -- Datos de entrada serie que corresponde a DATO del automata
			 CLK : in STD_LOGIC; -- Reloj de muestreo
			 EN : in STD_LOGIC; -- Enable que corresponde con CAPTURA del automata
			 Q : out STD_LOGIC_VECTOR (27 downto 0)); -- Salida paralelo
	end component;

component registro
	Port ( ENTRADA : in STD_LOGIC_VECTOR (27 downto 0); --Entrada de datos del registro
			 SALIDA : out STD_LOGIC_VECTOR (27 downto 0); --Salida datos del registro al MUX2x1
			 EN : in STD_LOGIC; -- Enable que corresponde con VALIDA del automata
			 CLK : in STD_LOGIC); --Reloj de muestreo
	end component;

component automata
	Port ( CLK : in STD_LOGIC; -- Reloj del autómata
			 C0 : in STD_LOGIC; -- Condición de decision para "0"
			 C1 : in STD_LOGIC; -- Condición de decisión para "1"
			 DATO : out STD_LOGIC; -- Datos a cargar
			 CAPTUR : out STD_LOGIC; -- Enable del reg. de desplaz.
			 VALID : out STD_LOGIC); -- Activación registro
	end component;

component visualizacion
	Port ( E0 : in STD_LOGIC_VECTOR (3 downto 0); -- Entrada MUX 0
			 E1 : in STD_LOGIC_VECTOR (3 downto 0); -- Entrada MUX 1
			 E2 : in STD_LOGIC_VECTOR (3 downto 0); -- Entrada MUX 2
			 E3 : in STD_LOGIC_VECTOR (3 downto 0); -- Entrada MUX 3
			 CLK : in STD_LOGIC; -- Entrada de reloj FPGA
			 SEG7 : out STD_LOGIC_VECTOR (6 downto 0); -- Salida para los displays
			 AN : out STD_LOGIC_VECTOR (3 downto 0)); -- Activación individual
end component;

component MUX2x1
    Port ( E0 : in  STD_LOGIC_VECTOR (13 downto 0); --Entrada Mux E0 da la fecha
           E1 : in  STD_LOGIC_VECTOR (13 downto 0); --Entrada Mux E1 da la hora
           S : in  STD_LOGIC; --Entrada de control al Mux que sera el pulsador
           Y : out  STD_LOGIC_VECTOR (13 downto 0)); --Salida del Mux en funcion de si mostramos hora o fecha
end component;

begin

GEN  : gen_reloj port map(
						CLK => CLK, --Reloj de la FPGA
						CLK_M => CLK_M --Reloj de muestreo
);

REG40: reg_desp40 port map(
						SIN => SIN, --Entrada de la señal al circuito
						CLK=> CLK_M, --Reloj de muestreo
						Q=> Q_SAL --Salida del reg. de desplazamiento de 40 bits
);

SUM  : sumador40 port map(
						ENT => Q_SAL, --Salida del Reg. desp. de 40
						SAL => SUM_SAL --Suma de los 40 bits
);

CMP1 : comparador port map(
						P => SUM_SAL, --Salida del sumador
						Q => UMBRAL1, --Umbral = 34
						PGTQ => PG1_SAL, --Salida P>Q del CMP1
						PLEQ => PL1_SAL --Salida P<Q del CMP1
);

CMP2 : comparador port map(
						P => SUM_SAL, --Salida del sumador
						Q => UMBRAL2, --Umbral = 38
						PGTQ => PG2_SAL, --Salida P>Q del CMP2 es un cero siempre
						PLEQ => PL2_SAL --Salida P<Q del CMP2 
);

PAND : AND_2 port map(
						A=> PG1_SAL, --P>Q
						B=> PL2_SAL, --P<Q
						S=> SAL_AND --Salida logica de la operacion AND
);

AUT  :  automata port map(
						CLK => CLK_M, --Reloj de muestreo
						C0 => SAL_AND, --U1<SUM<=U2
						C1 => PL1_SAL, --SUM<=U1 
						DATO => DATO_SAL, --Salida dato del automata
						CAPTUR => CAPTUR_SAL, --Salida captura del automata
						VALID => VALID_SAL --Salida valida del automata
);

REG28: reg_desp port map(
						SIN => DATO_SAL, --Salida DATO del automata
						CLK => CLK_M, --Reloj de muestreo
						EN => CAPTUR_SAL, --Enable que activa el registro de desplazamiento si CAPTURA es 1
						Q => Q2_SAL --Salida del registro de desplazamiento de 28 bits
);

REGV : registro port map(
						ENTRADA => Q2_SAL, --Salida del registro de desplazamiento
						SALIDA => SAL_REG, --Salida del registro de validacion
						EN => VALID_SAL, --Enable del registro que se activa si VALIDA es 1
						CLK => CLK_M --Reloj de muestreo
);

MUX2 : MUX2x1 port map (
						E0=>SAL_REG(13 downto 0), --Codifica la fecha y sale cuando S es 1
						E1=>SAL_REG(27 downto 14), --Codifica la hora y sale cuando S es 0
						S=>PULSADOR, --Si es 0 saca la hora si es 1 saca la fecha
						Y=>SAL_MUX --Salida del Mux hacia el modulo visualiza
);

VIS  : visualizacion port map(
						E0 => E0_TMP, --decenas de la hora/dia representadas con 3 bits
						E1 => SAL_MUX(10 downto 7), --unidades de la hora/dia representadas con 4 bits
						E2 => E2_TMP, --decenas de los minutos/mes representadas con 3 bits
						E3 => SAL_MUX(3 downto 0), --unidades de los minutos/mes representadas con 4 bits
						CLK => CLK, --Reloj de la FPGA
						SEG7 => SEG7, --Salida de los segmentos BCD
						AN => AN --Control de activacion de los displays
);

E0_TMP <= '0' & SAL_MUX(13 downto 11); --Entrada de E0
E2_TMP <= '0' & SAL_MUX(6 downto 4); --Entrada de E2

end a_principal;