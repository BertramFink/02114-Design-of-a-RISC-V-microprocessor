import chisel3._

class FoodTest extends Module {
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

    0xdeadc0b7L.U(32.W),
    0xeef08093L.U(32.W),
    0x00102023.U(32.W),
    0x00002103.U(32.W),
    0x00000063.U(32.W),
    0x00100093.U(32.W),
    0x00000013.U(32.W),
    0x00000013.U(32.W),
    0x00000013.U(32.W),

  )))

  fetcher.io.input    := instrReg

  decoder.io.instruction := fetcher.io.instruction

  decoder.io.pcIn := fetcher.io.pcOut
  executer.io.pcIn := decoder.io.pcOut

  executer.io.rdIn := ALU.io.rdOut

  fetcher.io.branchIn := ALU.io.branchOut
  fetcher.io.branchEnable := ALU.io.branchEnable


  decoder.io.rdRegEx := ALU.io.rdOut

  decoder.io.LoadMemEnable := ALU.io.rdEna

  fetcher.io.shouldMux := decoder.io.shouldMux




  executer.io.x := x
  executer.io.opcode := decoder.io.opcode
  ALU.io.rdIn := decoder.io.rdOutput
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

  ALU.io.funct3 := executer.io.funct3out
  ALU.io.funct7 := executer.io.funct7out
  ALU.io.pcIn := executer.io.pcOut
  ALU.io.group := executer.io.group
  ALU.io.operand1 := executer.io.operand1
  ALU.io.operand2 := executer.io.operand2
  ALU.io.imm := executer.io.imm


  executer.io.ALUIn := ALU.io.ALUout


  memorizer.io.memOp := ALU.io.memOp
  memorizer.io.rdInput := ALU.io.rdOut
  memorizer.io.ALUinput := ALU.io.ALUout
  memorizer.io.rdEna := ALU.io.rdEna
  memorizer.io.wrEna := ALU.io.wrEna
  memorizer.io.rdAddr := ALU.io.rdAddr
  memorizer.io.wrAddr := ALU.io.wrAddr
  memorizer.io.wrData := ALU.io.ALUout.asUInt




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
  io.testVal_u(2) := executer.io.pcOut
  io.testVal_u(3) := decoder.io.pcOut
  io.testVal_u(4) := ALU.io.branchOut
  io.testVal_u(6) := fetcher.io.index

  io.testVal_U2 := fetcher.io.instruction


  //  io.testVal_u(0) := write_backer.io.rdOut
  //  io.testVal_s(0) := write_backer.io.ALUoutput
}
