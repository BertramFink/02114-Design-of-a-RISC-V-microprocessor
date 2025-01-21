import chisel3._
import chisel3.util._

class Executer extends Module {
  val io = IO(new Bundle {
    val opcode = Input(UInt(7.W))
    val funct3 = Input(UInt(3.W))
    val funct7 = Input(UInt(7.W))
    val rdIn = Input(UInt(5.W))

    val rs1 = Input(UInt(5.W))
    val rs2 = Input(UInt(5.W))
    val imm_I = Input(SInt(12.W))
    val imm_S = Input(SInt(12.W))
    val imm_B = Input(SInt(13.W))
    val imm_U = Input(UInt(32.W))
    val imm_J = Input(SInt(21.W))
    val imm = Output(SInt(32.W))
    val funct3out = Output(UInt(3.W))
    val funct7out = Output(UInt(7.W))

    val x = Input(Vec(32, SInt(32.W)))

    val ALUIn = Input(SInt(32.W))

    val group = Output(UInt(4.W))
    val operand1 = Output(SInt(32.W))
    val operand2 = Output(SInt(32.W))

    val rdLastRegMemIn = Input(UInt(5.W))
    val aluLastRegMemIn = Input(SInt(32.W))
    val rdLoadRegMemIn = Input(UInt(5.W))
    val aluLoadRegMemIn = Input(SInt(32.W))
    val loadEnable = Input(Bool())

    val pcIn = Input(SInt(32.W))
    val pcOut = Output(SInt(32.W))

  })
  val opcodeReg = RegInit(0.U(7.W))
  val rdReg = RegInit(0.U(5.W))
  val funct3Reg = RegInit(0.U(3.W))
  val rs1Reg = RegInit(0.U(5.W))
  val rs2Reg = RegInit(0.U(5.W))
  val imm_IReg = RegInit(0.S(12.W))
  val imm_SReg = RegInit(0.S(12.W))
  val imm_BReg = RegInit(0.S(13.W))
  val imm_UReg = RegInit(0.U(32.W))
  val imm_JReg = RegInit(0.S(21.W))
  val funct7Reg = RegInit(0.U(7.W))

  val pcReg = RegInit(0.S(32.W))
  val branchEnableReg = RegInit(false.B)
  val branchOutReg = RegInit(0.S(32.W))

  val rdLastRegEx = RegInit(0.U(5.W))
  val aluLastRegEx = RegInit(0.S(32.W))


  val ALUreg = RegInit(0.S(32.W))
  //val xReg = RegInit(VecInit(Seq.fill(32)(0.S(32.W))))
  //xReg := io.x
  opcodeReg := io.opcode
  funct3Reg := io.funct3
  rs1Reg := io.rs1
  rs2Reg := io.rs2
  imm_IReg := io.imm_I
  imm_SReg := io.imm_S
  imm_BReg := io.imm_B
  imm_UReg := io.imm_U
  imm_JReg := io.imm_J
  funct7Reg := io.funct7
  io.funct7out := funct7Reg
  io.funct3out := funct3Reg



  pcReg := io.pcIn
  branchEnableReg := false.B

  val rs1Wire = Mux((io.rdLastRegMemIn === rs1Reg) && (rs1Reg =/= 0.U), aluLastRegEx, Mux((io.rdLastRegMemIn === rs1Reg) && (rs1Reg =/= 0.U), Mux(io.loadEnable && io.rdLoadRegMemIn === rs1Reg, io.aluLoadRegMemIn,io.aluLastRegMemIn), io.x(rs1Reg)))
  val rs2Wire = Mux((io.rdLastRegMemIn === rs2Reg) && (rs2Reg =/= 0.U), aluLastRegEx, Mux((io.rdLastRegMemIn === rs2Reg) && (rs2Reg =/= 0.U), Mux(io.loadEnable && io.rdLoadRegMemIn === rs2Reg, io.aluLoadRegMemIn,io.aluLastRegMemIn), io.x(rs2Reg)))



  branchOutReg := pcReg
  io.imm := imm_IReg

  io.operand1 := rs1Wire
  io.operand2 := 0.S
  io.group := 0.U
  switch(opcodeReg) { // groups the opcodes like they are in the risc-v card
    is("b0110011".U){
      io.operand2 := rs2Wire
      io.group := 1.U
    }
    is("b0010011".U) { //taking care of edgecases where imm(0:4) is used
      io.group := 1.U
      io.operand2 := imm_IReg
      io.funct7out := 0.U
      switch(funct3Reg) {
        is(0x1.U) {
          io.funct7out := funct7Reg
          io.operand2 := rs2Reg.asSInt //same as imm_4
        }
        is(0x5.U) {
          io.funct7out := funct7Reg
          io.operand2 := rs2Reg.asSInt //same as imm_4
        }
      }
    }
    is("b0000011".U){
      io.group := 2.U
      io.operand2 := rs2Wire
      io.imm := imm_IReg
    }
    is("b0100011".U){
      io.group := 3.U
      io.operand2 := rs2Wire
      io.imm := imm_SReg
    }
    is("b1100011".U){
      io.group := 4.U
      io.operand2 := rs2Wire
      io.imm := imm_BReg
    }
    is("b1101111".U){
      io.group := 5.U
      io.imm := imm_JReg
    }
    is("b1100111".U){
      io.group := 6.U
      io.imm := imm_IReg
    }
    is("b0110111".U){
      io.group := 7.U
      io.imm := imm_UReg.asSInt
    }
    is("b0010111".U){
      io.group := 8.U
      io.imm := imm_UReg.asSInt
    }
  }

  rdLastRegEx := rdReg
  aluLastRegEx := io.ALUIn


  io.pcOut := pcReg

}


