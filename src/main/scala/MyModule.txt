import chisel3._
import chisel3.util._



class MyModule extends Module {
  val io = IO(new Bundle {
    val led = Output(Bool())
    val xVal = Output(SInt(32.W))
    val sel = Input(Bool())
  })

  val xVal = RegInit(0.S(32.W))

  xVal := 4.S
  val CNT_MAX = (100000000 / 2 - 1).U


  val PC = RegInit(0.U(32.W))


  val cntReg = RegInit(0.U(32.W))
  val blkReg = RegInit(false.B)

  cntReg := cntReg + 1.U
  when(cntReg === CNT_MAX && io.sel) {
    cntReg := 0.U
    blkReg := ~blkReg
  }
  io.xVal := xVal
  io.led := blkReg
}

/**
 * An object extending App to generate the Verilog code.
 */

// error: The s-interpolator prints the Scala .toString of Data objects rather than the value of the hardware wire during simulation. Use the cf-interpolator instead. If you want an elaboration time print, use println.
//   printf(s"in = $in\n")
//   ^^^^^^^^^^^^^^^^^^^^^

