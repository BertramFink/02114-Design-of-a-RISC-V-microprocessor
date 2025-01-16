import chisel3._
import chisel3.util._

class Write_backer extends Module {
  val io = IO(new Bundle {
    val ALUinput = Input(SInt(32.W)) // Allow external input for instructions
    val ALUoutput = Output(SInt(32.W))

    val rdInput = Input(UInt(5.W))
    val rdOut = Output(UInt(5.W))
    val rdEnaIn = Input(Bool())
    val wrEnaIn = Input(Bool())
    val rdData = Input(UInt(32.W))
  })
  val rdReg = RegInit(0.U(5.W))
  val ALUreg = RegInit(0.S(32.W))
  val rdDataReg = RegInit(0.U(32.W))
  val rdEnaInReg = RegInit(false.B)
  val wrEnaInReg = RegInit(false.B)

  rdReg := io.rdInput
  ALUreg := io.ALUinput
  rdDataReg := io.rdData
  rdEnaInReg := io.rdEnaIn
  wrEnaInReg := io.wrEnaIn

  //Output MUX
  io.ALUoutput := Mux(rdEnaInReg, rdDataReg.asSInt, ALUreg)
  io.rdOut := rdReg

  when(wrEnaInReg || rdReg === 0.U || rdReg === 32.U) {
    io.ALUoutput := 0.S
    io.rdOut := 0.U
  }
}
