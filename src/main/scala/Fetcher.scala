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

    0xf8500293L.U(32.W),
    0xf8500313L.U(32.W),
    0x07a00393L.U(32.W),
    0x02628263L.U(32.W),
    0x00200613L.U(32.W),
    0x00734a63L.U(32.W),
    0x00400713L.U(32.W),
    0x0053e263L.U(32.W),
    0x00500793L.U(32.W),
    0x02737a63L.U(32.W),
    0x00300693L.U(32.W),
    0xfe53d6e3L.U(32.W),
    0x00100593L.U(32.W),
    0xfc729ee3L.U(32.W),
    0x00000513L.U(32.W),
    0x00000593L.U(32.W),
    0x00000613L.U(32.W),
    0x00000693L.U(32.W),
    0x00000713L.U(32.W),
    0x00000793L.U(32.W),
    0x00000813L.U(32.W),
    0x00000893L.U(32.W),
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