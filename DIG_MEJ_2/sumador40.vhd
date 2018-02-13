----------------------------------------------------------------------------------
-- Company: CELT
-- Engineer: ISABEL RODRÍGUEZ RUIZ Y JORGE CALATAYUD MAESO
-- 
-- Create Date:    20:31:06 11/23/2017 
-- Design Name: 
-- Module Name:    sumador40 - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity sumador40 is
    Port ( ENT : in STD_LOGIC_VECTOR (39 downto 0); -- entradas (40 bits)
			  SAL : out STD_LOGIC_VECTOR (5 downto 0)); -- salida (6 bits)
end sumador40;

architecture a_sumador40 of sumador40 is
signal E0 : STD_LOGIC_VECTOR (5 downto 0); --Señal de salida 1 al sumador
signal E1 : STD_LOGIC_VECTOR (5 downto 0); --Señal de salida 1 al sumador
signal E2 : STD_LOGIC_VECTOR (5 downto 0); --Señal de salida 2 al sumador
signal E3 : STD_LOGIC_VECTOR (5 downto 0); --Señal de salida 3 al sumador
signal E4 : STD_LOGIC_VECTOR (5 downto 0); --Señal de salida 4 al sumador
signal E5 : STD_LOGIC_VECTOR (5 downto 0); --Señal de salida 5 al sumador
signal E6 : STD_LOGIC_VECTOR (5 downto 0); --Señal de salida 6 al sumador
signal E7 : STD_LOGIC_VECTOR (5 downto 0); --Señal de salida 7 al sumador
signal E8 : STD_LOGIC_VECTOR (5 downto 0); --Señal de salida 8 al sumador
signal E9 : STD_LOGIC_VECTOR (5 downto 0); --Señal de salida 9 al sumador
signal E10 : STD_LOGIC_VECTOR (5 downto 0); --Señal de salida 10 al sumador
signal E11 : STD_LOGIC_VECTOR (5 downto 0); --Señal de salida 11 al sumador
signal E12 : STD_LOGIC_VECTOR (5 downto 0); --Señal de salida 12 al sumador
signal E13 : STD_LOGIC_VECTOR (5 downto 0); --Señal de salida 13 al sumador
signal E14 : STD_LOGIC_VECTOR (5 downto 0); --Señal de salida 14 al sumador
signal E15 : STD_LOGIC_VECTOR (5 downto 0); --Señal de salida 15 al sumador
signal E16 : STD_LOGIC_VECTOR (5 downto 0); --Señal de salida 16 al sumador
signal E17 : STD_LOGIC_VECTOR (5 downto 0); --Señal de salida 17 al sumador
signal E18 : STD_LOGIC_VECTOR (5 downto 0); --Señal de salida 18 al sumador
signal E19 : STD_LOGIC_VECTOR (5 downto 0); --Señal de salida 19 al sumador
signal E20 : STD_LOGIC_VECTOR (5 downto 0); --Señal de salida 20 al sumador
signal E21 : STD_LOGIC_VECTOR (5 downto 0); --Señal de salida 21 al sumador
signal E22 : STD_LOGIC_VECTOR (5 downto 0); --Señal de salida 22 al sumador
signal E23 : STD_LOGIC_VECTOR (5 downto 0); --Señal de salida 23 al sumador
signal E24 : STD_LOGIC_VECTOR (5 downto 0); --Señal de salida 24 al sumador
signal E25 : STD_LOGIC_VECTOR (5 downto 0); --Señal de salida 25 al sumador
signal E26 : STD_LOGIC_VECTOR (5 downto 0); --Señal de salida 26 al sumador
signal E27 : STD_LOGIC_VECTOR (5 downto 0); --Señal de salida 27 al sumador
signal E28 : STD_LOGIC_VECTOR (5 downto 0); --Señal de salida 28 al sumador
signal E29 : STD_LOGIC_VECTOR (5 downto 0); --Señal de salida 29 al sumador
signal E30 : STD_LOGIC_VECTOR (5 downto 0); --Señal de salida 30 al sumador
signal E31 : STD_LOGIC_VECTOR (5 downto 0); --Señal de salida 31 al sumador
signal E32 : STD_LOGIC_VECTOR (5 downto 0); --Señal de salida 32 al sumador 
signal E33 : STD_LOGIC_VECTOR (5 downto 0); --Señal de salida 33 al sumador
signal E34 : STD_LOGIC_VECTOR (5 downto 0); --Señal de salida 34 al sumador
signal E35 : STD_LOGIC_VECTOR (5 downto 0); --Señal de salida 35 al sumador
signal E36 : STD_LOGIC_VECTOR (5 downto 0); --Señal de salida 36 al sumador
signal E37 : STD_LOGIC_VECTOR (5 downto 0); --Señal de salida 37 al sumador
signal E38 : STD_LOGIC_VECTOR (5 downto 0); --Señal de salida 38 al sumador
signal E39 : STD_LOGIC_VECTOR (5 downto 0); --Señal de salida 39 al sumador

begin
E39<= "00000" & ENT(39); --Salida del bit 40
E38<= "00000" & ENT(38); --Salida del bit 39
E37<= "00000" & ENT(37); --Salida del bit 38
E36<= "00000" & ENT(36); --Salida del bit 37
E35<= "00000" & ENT(35); --Salida del bit 36
E34<= "00000" & ENT(34); --Salida del bit 35
E33<= "00000" & ENT(33); --Salida del bit 34
E32<= "00000" & ENT(32); --Salida del bit 33
E31<= "00000" & ENT(31); --Salida del bit 32
E30<= "00000" & ENT(30); --Salida del bit 31
E29<= "00000" & ENT(29); --Salida del bit 30
E28<= "00000" & ENT(28); --Salida del bit 29
E27<= "00000" & ENT(27); --Salida del bit 28
E26<= "00000" & ENT(26); --Salida del bit 27
E25<= "00000" & ENT(25); --Salida del bit 26
E24<= "00000" & ENT(24); --Salida del bit 25
E23<= "00000" & ENT(23); --Salida del bit 24
E22<= "00000" & ENT(22); --Salida del bit 23
E21<= "00000" & ENT(21); --Salida del bit 22
E20<= "00000" & ENT(20); --Salida del bit 21
E19<= "00000" & ENT(19); --Salida del bit 20
E18<= "00000" & ENT(18); --Salida del bit 19
E17<= "00000" & ENT(17); --Salida del bit 18
E16<= "00000" & ENT(16); --Salida del bit 17
E15<= "00000" & ENT(15); --Salida del bit 16
E14<= "00000" & ENT(14); --Salida del bit 15
E13<= "00000" & ENT(13); --Salida del bit 14
E12<= "00000" & ENT(12); --Salida del bit 13
E11<= "00000" & ENT(11); --Salida del bit 12
E10<= "00000" & ENT(10); --Salida del bit 11
E9<= "00000" & ENT(9); --Salida del bit 10
E8<= "00000" & ENT(8); --Salida del bit 9
E7<= "00000" & ENT(7); --Salida del bit 8
E6<= "00000" & ENT(6); --Salida del bit 7
E5<= "00000" & ENT(5); --Salida del bit 6
E4<= "00000" & ENT(4); --Salida del bit 5
E3<= "00000" & ENT(3); --Salida del bit 4
E2<= "00000" & ENT(2); --Salida del bit 3
E1<= "00000" & ENT(1); --Salida del bit 2
E0<= "00000" & ENT(0); --Salida del bit 1
SAL<= E39+E38+E37+E36+E35+E34+E33+E32+E31+E30+
E29+E28+E27+E26+E25+E24+E23+E22+E21+E20+
E19+E18+E17+E16+E15+E14+E13+E12+E11+E10+
E9+E8+E7+E6+E5+E4+E3+E2+E1+E0; --Suma de los 40 bits de señal de entrada


end a_sumador40;

