import chisel3._
import chisel3.util._

class Fetcher() extends Module {
  val io = IO(new Bundle {
    val instrIn = Input(Vec(18, UInt(32.W))) // Allow external input for instructions
    val branchIn = Input(SInt(32.W))
    val branchEnable = Input(Bool())
    val shouldMux = Input(Bool())

    val instrOut = Output(UInt(32.W))
    val pcOut = Output(SInt(32.W))
  })

  val pcReg = RegInit(-4.S(32.W))
  val instr = RegInit(0.U(32.W))

  val branchEnableReg = RegInit(false.B)
  val branchInReg = RegInit(0.S(32.W))

  branchInReg := io.branchIn
  branchEnableReg := io.branchEnable

  val pcPlusReg = Mux(io.shouldMux, pcReg, Mux(io.branchEnable, io.branchIn + 4.S, pcReg + 4.S))
  val index = ((pcPlusReg) >> 2)

  pcReg := pcPlusReg
  instr := io.instrIn(index(29, 0)).asUInt

  io.instrOut := instr
  io.pcOut := pcReg
}