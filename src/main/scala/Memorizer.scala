import chisel3._
import chisel3.util._
class Memorizer extends Module{
  val io = IO(new Bundle {
    val ALUinput  = Input(SInt(32.W)) // Allow external input for instructions
    val ALUoutput = Output(SInt(32.W))
    val rdInput   = Input(UInt(5.W))
    val rdOutput  = Output(UInt(5.W))

    val rdAddr = Input(UInt (10.W))
    val wrAddr = Input(UInt (10.W))
    val wrData = Input(UInt (8.W))
    val wrEna = Input(Bool ())
    val rdEna = Input(Bool ())
    val rdData = Output(UInt (8.W))
    val rdEnaOut = Output(Bool ())

  })
  val rdReg   = RegInit(0.U(5.W))
  val ALUreg  = RegInit(0.S(32.W))

  rdReg     := io.rdInput
  ALUreg    := io.ALUinput
  io.rdOutput   := rdReg
  io.ALUoutput  := ALUreg


  val rdAddrReg = RegInit(0.U(10.W))
  val wrAddrReg = RegInit(0.U(10.W))
  val wrDataReg = RegInit(0.U(8.W))
  val wrEnaReg = RegInit(false.B)
  val rdEnaReg = RegInit(false.B)


   rdAddrReg := io.rdAddr
   wrAddrReg := io.wrAddr
   wrDataReg := io.ALUinput(7,0)
  wrEnaReg := io.wrEna
  rdEnaReg := io.rdEna


  //val mem =RegInit(VecInit(Seq.fill(32)(0.U(8.W))))
  val mem = SyncReadMem (1024 , UInt (8.W))

  when(wrEnaReg) {
   // mem(wrAddrReg) := wrDataReg
    mem.write(wrAddrReg , wrDataReg)
    io.rdOutput := 0.U
    io.ALUoutput := 0.S
  }

  io.rdData := 0.U
  io.rdEnaOut := rdEnaReg
  when(rdEnaReg) {
    //io.ALUoutput := mem(rdAddrReg).asSInt
    io.ALUoutput := mem.read(rdAddrReg).asSInt
    io.rdData := mem.read(io.rdAddr)


  }
}


