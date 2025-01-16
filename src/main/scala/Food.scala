import chisel3._
import chisel3.util._

object Food extends App {
  emitVerilog(new Food(), Array("--target-dir", "generated"))
}

class Food extends Module {
  val io = IO(new Bundle {
    val testVal_s = Output(Vec(9, SInt(32.W))) // Allow external input for instructions
    val testVal_u = Output(Vec(9, SInt(32.W)))
    val testVal_U2 = Output(UInt(32.W))

  })

  val x = RegInit(VecInit(Seq.fill(32)(0.S(32.W))))
  val fetcher       = Module(new Fetcher)
  val decoder       = Module(new Decoder)
  val executer      = Module(new Executer)
  val memorizer     = Module(new Memorizer)
  val write_backer  = Module(new Write_backer)
  val instrReg      = RegInit(VecInit(Seq(
    "hdeadc0b7".U(32.W),
    "heef08093".U(32.W),
    "h00102423".U(32.W),
    "h00801103".U(32.W),
    0x00000013.U(32.W),
    0x00000013.U(32.W),
    "hfff10113".U(32.W),
    0x00000013.U(32.W),
    0x00000013.U(32.W),
  )))

  fetcher.io.input    := instrReg

  decoder.io.instruction := fetcher.io.instruction

  decoder.io.pcIn := fetcher.io.pcOut
  executer.io.pcIn := decoder.io.pcOut
  fetcher.io.branchIn := executer.io.branchOut
  fetcher.io.branchEnable := executer.io.branchEnable


  executer.io.x := x
  executer.io.opcode := decoder.io.opcode
  executer.io.rdInput := decoder.io.rdOutput
  executer.io.rs1 := decoder.io.rs1
  executer.io.rs2 := decoder.io.rs2
  executer.io.imm_I := decoder.io.imm_I
  executer.io.imm_B := decoder.io.imm_B
  executer.io.imm_J := decoder.io.imm_J
  executer.io.imm_S := decoder.io.imm_S
  executer.io.imm_U := decoder.io.imm_U
  executer.io.funct3 := decoder.io.funct3
  executer.io.funct7 := decoder.io.funct7

  memorizer.io.memOp := executer.io.memOp
  memorizer.io.rdInput := executer.io.rdOutput
  memorizer.io.ALUinput := executer.io.ALUoutput
  memorizer.io.rdEna := executer.io.rdEna
  memorizer.io.wrEna := executer.io.wrEna
  memorizer.io.rdAddr := executer.io.rdAddr
  memorizer.io.wrAddr := executer.io.wrAddr
  memorizer.io.wrData := executer.io.ALUoutput.asUInt

  write_backer.io.rdData := memorizer.io.rdData
  write_backer.io.rdEnaIn := memorizer.io.rdEnaOut
  write_backer.io.rdInput := memorizer.io.rdOutput
  write_backer.io.ALUinput := memorizer.io.ALUoutput
  write_backer.io.wrEnaIn := memorizer.io.wrEnaOut


  x(write_backer.io.rdOut) := write_backer.io.ALUoutput




  for (i <- 0 to 8 ) {
    io.testVal_u(i) := 0.S
    io.testVal_s(i) := 0.S
  }

  for (i<- 1 to 8 ){
    io.testVal_s(i) := x(i-1)
  }
  io.testVal_u(0) := fetcher.io.pcOut
  io.testVal_u(1) := executer.io.immOut
  io.testVal_u(2) := executer.io.pcOut
  io.testVal_u(3) := decoder.io.pcOut
  io.testVal_u(4) := executer.io.branchOut
  io.testVal_u(6) := fetcher.io.index

  io.testVal_U2 := fetcher.io.instruction


//  io.testVal_u(0) := write_backer.io.rdOut
//  io.testVal_s(0) := write_backer.io.ALUoutput
}
