--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   23:06:26 11/25/2017
-- Design Name:   
-- Module Name:   C:/Users/Isabel/Desktop/Isabel/uni/tercero/CELT/CELT_DIGITAL/test_automata.vhd
-- Project Name:  CELT_DIGITAL
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: automata
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY test_automata IS
END test_automata;
 
ARCHITECTURE behavior OF test_automata IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT automata
    PORT(
         CLK : IN  std_logic;
         C0 : IN  std_logic;
         C1 : IN  std_logic;
         DATO : OUT  std_logic;
         CAPTUR : OUT  std_logic;
         VALID : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal C0 : std_logic := '0';
   signal C1 : std_logic := '0';

 	--Outputs
   signal DATO : std_logic;
   signal CAPTUR : std_logic;
   signal VALID : std_logic;

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: automata PORT MAP (
          CLK => CLK,
          C0 => C0,
          C1 => C1,
          DATO => DATO,
          CAPTUR => CAPTUR,
          VALID => VALID
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- Periodo del reloj = 10 ns.
      wait for 5 ns;
		
		-- Comenzamos en el estado inicial ESP_SYNC
		
		C0<='0';         -- Llegada de un 1
		C1<='1';
      wait for 30 ns;  -- Durante 3 ciclos de reloj
							  -- El aut�mata debe quedarse en ESP_SYNC

		C0<='0';         -- Llegada de un SYNC
		C1<='0';         
      wait for 400 ns; 
							  -- El aut�mata debe pasar al estado
							  -- AVAN_ZM y permanecer durante 20 ciclos.
							  -- Luego debe pasar al estado MUESTREO	
							  -- Durante 40 ciclos
		
		C0<='1';         -- Llegada de un 0
		C1<='0';
      wait for 400 ns; 
							  -- El aut�mata debe pasar al estado DATO0 1 ciclo de reloj
							  -- y volver a MUESTREO
							  -- Durante 40 ciclos
							  
		C0<='0';         -- Llegada de un 1 
		C1<='1';
      wait for 400 ns; 
							  -- El aut�mata debe pasar al estado DATO1  1 ciclo de reloj
							  -- y volver a MUESTREO
							  -- Durante 40 ciclos

      C0<='0';         -- Llegada de un SYNC
		C1<='0';
      wait for 400 ns; 
							  -- El aut�mata debe pasar al estado DATOSYNC
							  -- y volver a MUESTREO

      wait;
   end process;

END;