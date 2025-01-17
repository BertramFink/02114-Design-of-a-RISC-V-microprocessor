import chisel3._
import chisel3.util._

class Fetcher() extends Module {
  val io = IO(new Bundle {
    val input = Input(Vec(9, UInt(32.W))) // Allow external input for instructions
    val instruction = Output(UInt(32.W))
    val index = Output(SInt(29.W))
    val branchIn = Input(SInt(32.W))


    val shouldMux = Input(Bool())


    val pcOut = Output(SInt(32.W))
    val branchEnable = Input(Bool())

  })

  val pcReg = RegInit(-4.S(32.W))
  val instruction = RegInit(0.U(32.W))

  val branchEnableReg = RegInit(false.B)
  val branchInReg = RegInit(0.S(32.W))


  branchInReg := io.branchIn
  branchEnableReg := io.branchEnable



  val pcPlusReg = Mux(io.shouldMux, pcReg,Mux(io.branchEnable, io.branchIn,   pcReg + 4.S))

  pcReg:= pcPlusReg


  val index = ((pcPlusReg) >> 2)


  instruction := io.input(index(29,0)).asUInt

  io.instruction := instruction
  io.index := index
  io.pcOut := pcReg
} 