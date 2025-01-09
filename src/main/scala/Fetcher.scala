import chisel3._
import chisel3.util._

class Fetcher() extends Module {
  val io = IO(new Bundle {
    val input = Input(Vec(7, UInt(32.W))) // Allow external input for instructions
    val instruction = Output(UInt(32.W))
    val index = Output(SInt(29.W))

  })

  val pc = RegInit(-4.S(32.W))
  val instruction = RegInit(0.U(32.W))
  val pcPlus = pc+ 4.S
  pc := pcPlus
  val index = (pcPlus) >> 2


  instruction := io.input(index(29,0))
  io.instruction := instruction
  io.index := index
} 