CÓDIGO:
--------------------------------------------------------------------------------
-- Company: CELT
-- Engineer: ISABEL RODRÍGUEZ RUIZ Y JORGE CALATAYUD MAESO
--
-- Create Date:   10:48:11 11/29/2017
-- Project Name:  CELT_DIGITAL
--
--Este es el testbench para probar que le módulo visualizacion saca bien
--los estimulos por los displays
--
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY test_visu IS
END test_visu;
 
ARCHITECTURE behavior OF test_visu IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT visualizacion
    PORT(
         E0 : IN  std_logic_vector(3 downto 0); -- Entrada E0 
         E1 : IN  std_logic_vector(3 downto 0); -- Entrada E1 
         E2 : IN  std_logic_vector(3 downto 0); -- Entrada E2 
         E3 : IN  std_logic_vector(3 downto 0); -- Entrada E3
         CLK : IN  std_logic; -- Reloj de la FPGA
         SEG7 : OUT  std_logic_vector(6 downto 0); --Segmentos BCD 
         AN : OUT  std_logic_vector(3 downto 0) --Controla la activación de displays
        );
    END COMPONENT;
    

   --Inputs
   signal E0 : std_logic_vector(3 downto 0) := (others => '0');
   signal E1 : std_logic_vector(3 downto 0) := (others => '0');
   signal E2 : std_logic_vector(3 downto 0) := (others => '0');
   signal E3 : std_logic_vector(3 downto 0) := (others => '0');
   signal CLK : std_logic := '0';

 	--Outputs
   signal SEG7 : std_logic_vector(6 downto 0);
   signal AN : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 20 ns; -- Reloj de 50 Mhz
 
BEGIN
 --Hacemos el mapeo para asociar las entradas y salidas
   vis: visualizacion PORT MAP (
          E0 => E0,
          E1 => E1,
          E2 => E2,
          E3 => E3,
          CLK => CLK,
          SEG7 => SEG7,
          AN => AN
        );

   -- Clock process definitions
   CLK_process :process
   begin
    CLK <= '0';
    wait for CLK_period/2; --mitad de periodo 0
    CLK <= '1';
    wait for CLK_period/2; --mitad de periodo 1
   end process;

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for CLK_period*10;

      -- insert stimulus here
			E0 <= "0001";
			E1 <= "0010";
			E2 <= "0100";
			E3 <= "1000";
			-- Cambio de valores para comprobar que cambian correctamente
			-- El tiempo de refresco son 1ms por display, por lo que esta es la ventana que se tiene para refrescar los 4 displays
			wait for 4 ms; 
			E0 <= "0011";
			E1 <= "0110";
			E2 <= "1100";
			E3 <= "1001";
			-- Cambios de valores por debajo del tiempo de refresco
			-- Solo deberian cambiar los dos primeros displays
			wait for 4 ms;
			E0 <= "0111";
			E1 <= "0111";
			E2 <= "0111";
			E3 <= "0111";
			wait for 2 ms;
			E0 <= "0000";
			E1 <= "0000";
			E2 <= "0000";
			E3 <= "0000";
			
			
			
			
      wait;
   end process;

END;
