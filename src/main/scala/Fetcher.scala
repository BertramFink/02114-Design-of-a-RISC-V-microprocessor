import chisel3._
import chisel3.util._

class Fetcher() extends Module {
  val io = IO(new Bundle {
    // Allow external input for instructions
    val branchIn = Input(SInt(32.W))
    val branchEnable = Input(Bool())
    val shouldMux = Input(Bool())

    val instrOut = Output(UInt(32.W))
    val pcOut = Output(SInt(32.W))
  })

  val pcReg = RegInit(-4.S(32.W))
  val instrReg = RegInit(0.U(32.W))
  val instr = VecInit(Seq(
    0xf8500093L.U(32.W),
    0xf8500113L.U(32.W),
    0x07a00193L.U(32.W),
    0x02208463L.U(32.W),
    0x00200213L.U(32.W),
    0x0030cc63L.U(32.W),
    0x00400213L.U(32.W),
    0x00316263L.U(32.W),
    0x00500213L.U(32.W),
    0x07a00093L.U(32.W),
    0x00308663L.U(32.W),
    0x00300213L.U(32.W),
    0xfe1154e3L.U(32.W),
    0x00100213L.U(32.W),
    0xfc309ce3L.U(32.W),
    0x00000093L.U(32.W),
    0x00000113L.U(32.W),
    0x00000193L.U(32.W),
    0x00000213L.U(32.W),
    0x00000063L.U(32.W),

  ))


  val branchEnableReg = RegInit(false.B)
  val branchInReg = RegInit(0.S(32.W))

  branchInReg := io.branchIn
  branchEnableReg := io.branchEnable

  val pcPlusReg = Mux(io.shouldMux, pcReg, Mux(io.branchEnable, io.branchIn + 4.S, pcReg + 4.S))
  val index = ((pcPlusReg) >> 2)

  pcReg := pcPlusReg
  instrReg := instr(index(29, 0))

  io.instrOut := instrReg
  io.pcOut := pcReg
}