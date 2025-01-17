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
  val ALU           = Module(new ALU)
  val memorizer     = Module(new Memorizer)
  val write_backer  = Module(new Write_backer)
  val instrReg      = RegInit(VecInit(Seq(
    "h00a00093".U(32.W),
    "h00102523".U(32.W),
    "h00a02103".U(32.W),
    0x00110113.U(32.W),
    0x00000013.U(32.W),
    0x00000013.U(32.W),
    0x00000013.U(32.W),
    0x00000013.U(32.W),
    0x00000013.U(32.W),
  )))

  fetcher.io.input    := instrReg

  decoder.io.instruction := fetcher.io.instruction

  decoder.io.pcIn := fetcher.io.pcOut
  executer.io.pcIn := decoder.io.pcOut
  fetcher.io.branchIn := executer.io.branchOut
  fetcher.io.branchEnable := executer.io.branchEnable


  decoder.io.rdRegEx := executer.io.rdOutput

  decoder.io.LoadMemEnable := executer.io.rdEna

  fetcher.io.shouldMux := decoder.io.shouldMux




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
  executer.io.rdLastRegMemIn := memorizer.io.rdLastRegMemOut
  executer.io.aluLastRegMemIn := memorizer.io.aluLastRegMemOut
  executer.io.rdLoadRegMemIn := memorizer.io.rdLoadRegMemOut
  executer.io.aluLoadRegMemIn := memorizer.io.aluLoadRegMemOut
  executer.io.loadEnable := memorizer.io.loadEnabler

  ALU.io.funct3 := decoder.io.funct3
  ALU.io.funct7 := decoder.io.funct7
  ALU.io.rs1 := decoder.io.rs1
  ALU.io.rs2 := decoder.io.rs2
  ALU.io.imm_I := decoder.io.imm_I
  ALU.io.imm_B := decoder.io.imm_B
  ALU.io.imm_J := decoder.io.imm_J
  ALU.io.imm_S := decoder.io.imm_S
  ALU.io.imm_U := decoder.io.imm_U
  ALU.io.PC := decoder.io.pcOut
  ALU.io.group := executer.io.group
  ALU.io.operand1 := executer.io.operand1
  ALU.io.operand2 := executer.io.operand2


  memorizer.io.memOp := executer.io.memOp
  memorizer.io.rdInput := executer.io.rdOutput
  memorizer.io.ALUinput := executer.io.ALUoutput
  memorizer.io.rdEna := executer.io.rdEna
  memorizer.io.wrEna := executer.io.wrEna
  memorizer.io.rdAddr := executer.io.rdAddr
  memorizer.io.wrAddr := executer.io.wrAddr
  memorizer.io.wrData := executer.io.ALUoutput.asUInt
 //test
  memorizer.io.ALUtest := ALU.io.out



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
