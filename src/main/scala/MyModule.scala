import chisel3._
import chisel3.util._



class MyModule extends Module {
  val io = IO(new Bundle {
    val led = Output(UInt(1.W))
  })
  val CNT_MAX = (100000000 / 2 - 1).U


  val PC = RegInit(0.U(32.W))
// Instruction memor









  val cntReg = RegInit(0.U(32.W))
  val blkReg = RegInit(0.U(1.W))

  cntReg := cntReg + 1.U
  when(cntReg === CNT_MAX) {
    cntReg := 0.U
    blkReg := ~blkReg
  }
  io.led := blkReg
}

/**
 * An object extending App to generate the Verilog code.
 */
object MyModulemain extends App {
  println("Hello World, I will now generate the Verilog file!")
  emitVerilog(new MyModule())
}
// error: The s-interpolator prints the Scala .toString of Data objects rather than the value of the hardware wire during simulation. Use the cf-interpolator instead. If you want an elaboration time print, use println.
//   printf(s"in = $in\n")
//   ^^^^^^^^^^^^^^^^^^^^^

