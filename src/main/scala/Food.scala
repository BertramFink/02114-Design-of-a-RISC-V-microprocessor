import chisel3._
import chisel3.util._

object Food extends App {
  emitVerilog(new Food(), Array("--target-dir", "generated"))
}

class Food extends Module {
  val io = IO(new Bundle {
    val testVal_s = Output(Vec(9, SInt(32.W))) // Allow external input for instructions
    val testVal_u = Output(Vec(9, UInt(32.W)))

  })

  val x = RegInit(VecInit(Seq.fill(32)(0.S(32.W))))
  val fetcher       = Module(new Fetcher)
  val decoder       = Module(new Decoder)
  val executer      = Module(new Executer)
  val memorizer     = Module(new Memorizer)
  val write_backer  = Module(new Write_backer)
  val instrReg      = RegInit(VecInit(Seq(
    0x00100093.U(32.W),
    0x00200113.U(32.W),
    0x00300193.U(32.W),
    0x00400213.U(32.W),
    0x00500293.U(32.W),
    0x00600313.U(32.W),
    0x002083b3.U(32.W),
  )))

  fetcher.io.input    := instrReg

  decoder.io.instruction := fetcher.io.instruction

  executer.io.x := x
  executer.io.opcode  := decoder.io.opcode
  executer.io.rdInput := decoder.io.rdOutput
  executer.io.rs1     := decoder.io.rs1
  executer.io.rs2     := decoder.io.rs2
  executer.io.imm_I   := decoder.io.imm_I
  executer.io.imm_B   := decoder.io.imm_B
  executer.io.imm_J   := decoder.io.imm_J
  executer.io.imm_S   := decoder.io.imm_S
  executer.io.imm_U   := decoder.io.imm_U
  executer.io.funct3  := decoder.io.funct3
  executer.io.funct7  := decoder.io.funct7

  memorizer.io.rdInput      :=   executer.io.rdOutput
  memorizer.io.ALUinput     :=   executer.io.ALUoutput
  write_backer.io.rdInput   :=   memorizer.io.rdOutput
  write_backer.io.ALUinput  :=   memorizer.io.ALUoutput


  x(write_backer.io.rdOut) := write_backer.io.ALUoutput





  for (i <- 0 to 5 ) {
    io.testVal_u(i) := 0.U
    io.testVal_s(i) := 0.S
  }

  for (i<- 1 to 8 ){
    io.testVal_u(i) := (i-1).U
    io.testVal_s(i) := x(i-1)
  }

//  io.testVal_u(0) := write_backer.io.rdOut
//  io.testVal_s(0) := write_backer.io.ALUoutput
}
