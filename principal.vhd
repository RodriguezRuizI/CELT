----------------------------------------------------------------------------------
-- Company: CELT
-- Engineer: ISABEL RODRÍGUEZ RUIZ Y JORGE CALATAYUD MAESO
-- 
-- Create Date:    19:35:47 11/23/2017 
-- Design Name: 
-- Module Name:    principal - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
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
				 SEG7 : out STD_LOGIC_VECTOR (6 downto 0)); -- segmentos de displays
		end principal;

architecture a_principal of principal is

-- Constantes del circuito (umbrales de decisión)

constant UMBRAL1 : STD_LOGIC_VECTOR (5 downto 0) := "100010"; -- 34
constant UMBRAL2 : STD_LOGIC_VECTOR (5 downto 0) := "100110"; -- 38
-- Declaracion de señales necesarias
signal CLK_M  : STD_LOGIC; -- salida de 40 Hz
signal Q_SAL : STD_LOGIC_VECTOR (39 downto 0);-- salida del registro de desplazamiento
signal SUM_SAL : STD_LOGIC_VECTOR (5 downto 0);
signal PG1_SAL : STD_LOGIC;
signal PG2_SAL : STD_LOGIC := '0';
signal PL1_SAL : STD_LOGIC;
signal PL2_SAL : STD_LOGIC;
signal SAL_AND : STD_LOGIC;
signal DATO_SAL : STD_LOGIC;
signal CAPTUR_SAL : STD_LOGIC;
signal VALID_SAL : STD_LOGIC;
signal Q2_SAL : STD_LOGIC_VECTOR (13 downto 0);
signal SAL_REG : STD_LOGIC_VECTOR (13 downto 0);
signal E0_TMP : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
signal E2_TMP : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');

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
	Port ( ENT : in STD_LOGIC_VECTOR (39 downto 0);
			 SAL : out STD_LOGIC_VECTOR (5 downto 0));
	end component;

component comparador
	Port ( P : in STD_LOGIC_VECTOR (5 downto 0);
			 Q : in STD_LOGIC_VECTOR (5 downto 0);
			 PGTQ : out STD_LOGIC;
			 PLEQ : out STD_LOGIC);
	end component;

component AND_2
	Port ( A : in STD_LOGIC;
			 B : in STD_LOGIC;
			 S : out STD_LOGIC);
	end component;

component reg_desp
	Port ( SIN : in STD_LOGIC; -- Datos de entrada serie
			 CLK : in STD_LOGIC; -- Reloj
			 EN : in STD_LOGIC; -- Enable
			 Q : out STD_LOGIC_VECTOR (13 downto 0)); -- Salida paralelo
	end component;

component registro
	Port ( ENTRADA : in STD_LOGIC_VECTOR (13 downto 0);
			 SALIDA : out STD_LOGIC_VECTOR (13 downto 0);
			 EN : in STD_LOGIC; -- Enable
			 CLK : in STD_LOGIC);
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

begin

GEN  : gen_reloj port map(
						CLK => CLK,
						CLK_M => CLK_M
);

REG40: reg_desp40 port map(
						SIN => SIN,
						CLK=> CLK_M,
						Q=> Q_SAL
);

SUM  : sumador40 port map(
						ENT => Q_SAL,
						SAL => SUM_SAL
);

CMP1 : comparador port map(
						P => SUM_SAL,
						Q => UMBRAL1,
						PGTQ => PG1_SAL,
						PLEQ => PL1_SAL
);

CMP2 : comparador port map(
						P => SUM_SAL,
						Q => UMBRAL2,
						PGTQ => PG2_SAL, -- es un cero
						PLEQ => PL2_SAL
);

PAND : AND_2 port map(
						A=> PG1_SAL,
						B=> PL2_SAL,
						S=> SAL_AND
);

AUT  :  automata port map(
						CLK => CLK_M,
						C0 => SAL_AND,
						C1 => PL1_SAL,
						DATO => DATO_SAL,
						CAPTUR => CAPTUR_SAL,
						VALID => VALID_SAL
);

REG14: reg_desp port map(
						SIN => DATO_SAL,
						CLK => CLK_M,
						EN => CAPTUR_SAL,
						Q => Q2_SAL
);

REGV : registro port map(
						ENTRADA => Q2_SAL,
						SALIDA => SAL_REG,
						EN => VALID_SAL,
						CLK => CLK_M
);

VIS  : visualizacion port map(
						E0 => E0_TMP,
						E1 => SAL_REG(10 downto 7),
						E2 => E2_TMP,
						E3 => SAL_REG(3 downto 0),
						CLK => CLK,
						SEG7 => SEG7,
						AN => AN
);

E0_TMP <= '0' & SAL_REG(13 downto 11);
E2_TMP <= '0' & SAL_REG(6 downto 4);

end a_principal;