----------------------------------------------------------------------------------
-- Company: CELT
-- Engineer: ISABEL RODRÍGUEZ RUIZ Y JORGE CALATAYUD MAESO
-- 
-- Create Date:    20:26:09 11/23/2017 
-- Design Name: 
-- Module Name:    reg_desp40 - Behavioral 
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

entity reg_desp40 is
    Port ( SIN : in STD_LOGIC; -- Datos de entrada serie
           CLK : in STD_LOGIC; -- Reloj de muestreo, es decir, 40 Hz de CLK_M hay que tenerlo en cuenta en el mapeo
           Q : out STD_LOGIC_VECTOR (39 downto 0)); -- Salida paralelo
end reg_desp40;

architecture a_reg_desp40 of reg_desp40 is
signal QS : STD_LOGIC_VECTOR(39 downto 0):= (others=>'0');
begin

  process (CLK)
    begin
      if (CLK'event and CLK='1') then
			QS(39 downto 1) <= QS(38 downto 0);
			QS(0)<=SIN;
		end if;
  end process;
			Q <= QS;
end a_reg_desp40;

