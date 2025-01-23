import chisel3._
import chisel3.util._

class Decoder extends Module {
  val io = IO(new Bundle {
    val instrIn = Input(UInt(32.W))
    val opcode = Output(UInt(7.W))
    val rdOutput = Output(UInt(5.W))
    val funct3 = Output(UInt(3.W))
    val funct7 = Output(UInt(7.W))
    val rs1 = Output(UInt(5.W))
    val rs2 = Output(UInt(5.W))
    val imm_I = Output(SInt(12.W))
    val imm_S = Output(SInt(12.W))
    val imm_B = Output(SInt(13.W))
    val imm_U = Output(UInt(32.W))
    val imm_J = Output(SInt(21.W))

    val rdRegEx = Input(UInt(5.W))
    val LoadMemEnable = Input(Bool())

    val pcIn = Input(SInt(32.W))
    val pcOut = Output(SInt(32.W))
    val shouldMux = Output(Bool())
  })

  val rs1Reg = io.instrIn(19, 15)
  val rs2Reg = io.instrIn(24, 20)
  val pcReg = RegInit(0.S(32.W))

  val instr = RegInit(0.U(32.W))
  val loadMemEnable = (instr(6, 0).asUInt === 3.U)
  val boolean = RegInit(false.B)

  io.shouldMux := loadMemEnable && ((rs1Reg === io.rdOutput) || (rs2Reg === io.rdOutput))
  boolean := io.shouldMux

  pcReg := io.pcIn
  io.pcOut := io.pcIn

  val muxInstr = Mux(io.shouldMux, 0x00000013.U, io.instrIn)


  instr := muxInstr
  io.opcode := instr(6, 0)
  io.rdOutput := instr(11, 7)
  io.funct3 := instr(14, 12)
  io.rs1 := instr(19, 15)

  io.rs2 := instr(24, 20)
  io.funct7 := instr(31, 25)
  io.imm_I := instr(31, 20).asSInt
  io.imm_S := ((instr(31, 25) << 5) | instr(11, 7)).asSInt
  io.imm_B := ((instr(31) << 12) | (instr(7) << 11) | (instr(30, 25) << 5) | (instr(11, 8) << 1)).asSInt
  io.imm_U := instr(31, 12)
  io.imm_J := (((instr(31) << 20) | (instr(19, 12) << 12) | (instr(20) << 11) | (instr(30, 21) << 1))).asSInt
}
