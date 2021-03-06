-- Start of the weird 'hello world' blink:

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity blink01 is
port (
	clk	: in std_logic;  -- clock is on PIN_M2
	led0	: out std_logic; -- led on PIN_M6
	led1	: out std_logic; -- led on PIN_T4
	led2	: out std_logic; -- led on PIN_T3
	sw0	: in std_logic   -- switch (user button) on PIN_N6
);
end blink01;

architecture rtl of blink01 is
	constant CLK_FREQ : integer := 12000000;
	constant BLINK_FREQ : integer := 1;
	constant CNT_MAX : integer := CLK_FREQ/BLINK_FREQ/2-1;
	
	signal cnt		: unsigned(24 downto 0);
	signal blink	: std_logic;
	
begin

	process(clk, sw0)
	
	variable speed : integer range 0 to 1000;
	begin
		if rising_edge(clk) then
		
			if sw0='0' then
				speed := 100;
				led1 <= '1';
			else
				speed := 0;
				led1 <= '0';
			end if;
		
			if cnt=CNT_MAX then
				cnt <= (others => '0');
				blink <= not blink;
			else
				cnt <= cnt + 1 + speed;
			end if;
		end if;
		
	end process;
	
	
	led0 <= blink;
	led2 <= not blink;
	
end rtl;