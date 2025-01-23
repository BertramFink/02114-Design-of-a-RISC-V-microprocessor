To  to set up and run our processor on your FPGA / run tests on our processor:<br/>

First open the project and use "sbt run" to compile food.scala <br/>
Afterward a verilog file "Food.v" will be generated in the "02114-Design-of-a-RISC-V-microprocessor" directory.<br/>
Open Vivado and open a new project, use Food.v as design source, and pick the constraints source (.xdc files) that match your board. we have constraints made for Basys3 or nexys A7 boards.<br/>
Generate bitstream in vivado and program your device.<br/>
If you are on the nexys A7 the sevensegment displays will be displaying the contents of register x17 in hexa decimal.<br/>
by using the switches you can snoop on all registers.<br/>
