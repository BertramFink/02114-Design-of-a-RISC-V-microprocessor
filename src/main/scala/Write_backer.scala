import chisel3._
import chisel3.util._

class Write_backer extends Module{
  val io = IO(new Bundle {
    val ALUinput = Input(SInt(32.W)) // Allow external input for instructions
    val ALUoutput = Output(SInt(32.W))

    val rdInput  = Input(UInt(5.W))
    val rdOut = Output(UInt(5.W))
  })
  val rdReg      = RegInit(0.U(7.W))
  val ALUreg     = RegInit(0.S(32.W))

  rdReg      := io.rdInput
  ALUreg := io.ALUinput

  io.ALUoutput := ALUreg
  io.rdOut := rdReg

}
