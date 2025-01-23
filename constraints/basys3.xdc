## This file is a .xdc for the Basys3 rev B board
## Cut down to the Minimum for the Hello World example

set_property IOSTANDARD LVCMOS33 [get_ports *]

## Clock signal
set_property PACKAGE_PIN W5 [get_ports clock]
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clock]

## LED and reset button
set_property PACKAGE_PIN L1 [get_ports {io_led_0}]
set_property PACKAGE_PIN P1 [get_ports {io_led_1}]
set_property PACKAGE_PIN N3 [get_ports {io_led_2}]
set_property PACKAGE_PIN P3 [get_ports {io_led_3}]
set_property PACKAGE_PIN U3 [get_ports {io_led_4}]
set_property PACKAGE_PIN W3 [get_ports {io_led_5}]
set_property PACKAGE_PIN V3 [get_ports {io_led_6}]
set_property PACKAGE_PIN V13 [get_ports {io_led_7}]
set_property PACKAGE_PIN V14 [get_ports {io_led_8}]
set_property PACKAGE_PIN U14 [get_ports {io_led_9}]
set_property PACKAGE_PIN U15 [get_ports {io_led_10}]
set_property PACKAGE_PIN W18 [get_ports {io_led_11}]
set_property PACKAGE_PIN V19 [get_ports {io_led_12}]
set_property PACKAGE_PIN U19 [get_ports {io_led_13}]
set_property PACKAGE_PIN U16 [get_ports {io_led_14}]
set_property PACKAGE_PIN E19 [get_ports {io_led_15}]
set_property PACKAGE_PIN T17 [get_ports reset]
