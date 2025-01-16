import chisel3._
import chisel3.util._

class Decoder extends Module {
  val io = IO(new Bundle {
    val instruction = Input(UInt(32.W))
    val opcode      = Output(UInt(7.W))
    val rdOutput          = Output(UInt(5.W))
    val funct3      = Output(UInt(3.W))
    val funct7      = Output(UInt(7.W))
    val rs1         = Output(UInt(5.W))
    val rs2         = Output(UInt(5.W))
    val imm_I       = Output(SInt(12.W))
    val imm_S       = Output(SInt(12.W))
    val imm_B       = Output(SInt(13.W))
    val imm_U       = Output(UInt(32.W))
    val imm_J       = Output(SInt(21.W))

    val pcIn = Input(SInt(32.W))
    val pcOut = Output(SInt(32.W))

  })

  //val imm_s = instruction(31, 25) << 5 | instruction(11, 7)

  val pcReg = RegInit(0.S(32.W))
  pcReg := io.pcIn
  io.pcOut := io.pcIn
  //io.pcOut := pcReg

//

  val instruction = RegInit(0.U(32.W))
  instruction :=io.instruction
  io.opcode := instruction(6, 0)
  io.rdOutput     := instruction(11, 7)
  io.funct3 := instruction(14, 12)
  io.rs1    := instruction(19, 15)

  io.rs2    := instruction(24, 20)
  io.funct7 := instruction(31, 25)
  io.imm_I  := instruction(31, 20).asSInt
  io.imm_S  := ((instruction(31, 25) << 5) | instruction(11, 7)).asSInt
  io.imm_B  := ((instruction(31) << 12) | (instruction(7) << 11) | (instruction(30, 25) << 5) | (instruction(11, 8) << 1)).asSInt
  io.imm_U  := instruction(31, 12)
  io.imm_J  := (((instruction(31) << 20) | (instruction(19, 12) << 12) | (instruction(20) << 11) | (instruction(30, 21) << 1))).asSInt
}
