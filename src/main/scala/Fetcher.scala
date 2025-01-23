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
  val instrReg = RegInit(0.U(32.W))
  val instr = VecInit(Seq(
    0xdeadc0b7L.U(32.W),
    0xeef08093L.U(32.W),
    0x00800113L.U(32.W),
    0x00112023L.U(32.W),
    0x00012183L.U(32.W),
    0x00308a63L.U(32.W),
    0x00000063L.U(32.W),
    0x00700093L.U(32.W),
    0x00010283L.U(32.W),
    0x00628863L.U(32.W),
    0x00a00213L.U(32.W),
    0x00010303L.U(32.W),
    0xff1ff56fL.U(32.W),
    0x00900493L.U(32.W),
    0xfe000ee3L.U(32.W),
    0x00000063L.U(32.W),
    0x00000013L.U(32.W),
    0x00000013L.U(32.W),
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