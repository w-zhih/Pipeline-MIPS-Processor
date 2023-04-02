create_clock -period 20.000 -name CLK -waveform {0.000 5.000} [get_ports clk]

set_property PACKAGE_PIN W5 [get_ports {clk}]
set_property PACKAGE_PIN T18 [get_ports {reset}]

set_property PACKAGE_PIN U16 [get_ports {leds[0]}]
set_property PACKAGE_PIN E19 [get_ports {leds[1]}]
set_property PACKAGE_PIN U19 [get_ports {leds[2]}]
set_property PACKAGE_PIN V19 [get_ports {leds[3]}]
set_property PACKAGE_PIN W18 [get_ports {leds[4]}]
set_property PACKAGE_PIN U15 [get_ports {leds[5]}]
set_property PACKAGE_PIN U14 [get_ports {leds[6]}]
set_property PACKAGE_PIN V14 [get_ports {leds[7]}]

set_property PACKAGE_PIN W4 [get_ports {an[3]}]
set_property PACKAGE_PIN V4 [get_ports {an[2]}]
set_property PACKAGE_PIN U4 [get_ports {an[1]}]
set_property PACKAGE_PIN U2 [get_ports {an[0]}]

set_property PACKAGE_PIN W7 [get_ports {BCD[0]}]
set_property PACKAGE_PIN W6 [get_ports {BCD[1]}]
set_property PACKAGE_PIN U8 [get_ports {BCD[2]}]
set_property PACKAGE_PIN V8 [get_ports {BCD[3]}]
set_property PACKAGE_PIN U5 [get_ports {BCD[4]}]
set_property PACKAGE_PIN V5 [get_ports {BCD[5]}]
set_property PACKAGE_PIN U7 [get_ports {BCD[6]}]
set_property PACKAGE_PIN V7 [get_ports {BCD[7]}]

set_property IOSTANDARD LVCMOS33 [get_ports {clk}]
set_property IOSTANDARD LVCMOS33 [get_ports {reset}]

set_property IOSTANDARD LVCMOS33 [get_ports {leds[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[7]}]

set_property IOSTANDARD LVCMOS33 [get_ports {an[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {an[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {an[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {an[0]}]

set_property IOSTANDARD LVCMOS33 [get_ports {BCD[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {BCD[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {BCD[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {BCD[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {BCD[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {BCD[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {BCD[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {BCD[7]}]