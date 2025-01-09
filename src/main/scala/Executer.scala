import chisel3._
import chisel3.util._

class Executer extends Module{
  val io = IO(new Bundle {
    val opcode      = Input(UInt(7.W))
    val rdInput     = Input(UInt(5.W))
    val funct3      = Input(UInt(3.W))
    val funct7      = Input(UInt(7.W))
    val rs1         = Input(UInt(5.W))
    val rs2         = Input(UInt(5.W))
    val imm_I       = Input(SInt(12.W))
    val imm_S       = Input(SInt(12.W))
    val imm_B       = Input(SInt(13.W))
    val imm_U       = Input(UInt(32.W))
    val imm_J       = Input(SInt(21.W))
    val ALUoutput   = Output(SInt(32.W))
    val rdOutput    = Output(UInt(5.W))
    val x = Input(Vec(32, SInt(32.W)))

  })
  val opcodeReg      = RegInit(0.U(7.W))
  val rdReg          = RegInit(0.U(5.W))
  val funct3Reg      = RegInit(0.U(3.W))
  val rs1Reg         = RegInit(0.U(5.W))
  val rs2Reg         = RegInit(0.U(5.W))
  val imm_IReg       = RegInit(0.S(12.W))
  val imm_SReg       = RegInit(0.S(12.W))
  val imm_BReg       = RegInit(0.S(13.W))
  val imm_UReg       = RegInit(0.U(32.W))
  val imm_JReg       = RegInit(0.S(21.W))
  val funct7Reg      = RegInit(0.U(7.W))

  val ALUreg      = RegInit(0.S(32.W))
  //val xReg = RegInit(VecInit(Seq.fill(32)(0.S(32.W))))
  //xReg := io.x
  opcodeReg      := io.opcode
  rdReg          := io.rdInput
  funct3Reg      := io.funct3
  rs1Reg         := io.rs1
  rs2Reg         := io.rs2
  imm_IReg       := io.imm_I
  imm_SReg       := io.imm_S
  imm_BReg       := io.imm_B
  imm_UReg       := io.imm_U
  imm_JReg       := io.imm_J
  funct7Reg      := io.funct7


  io.ALUoutput := 0.S
  switch(opcodeReg){
    //I-type
    is ("b0010011".U){
      switch(funct3Reg){
        is (0x0.U){
          io.ALUoutput := io.x(rs1Reg) + imm_IReg
        }
        is (0x4.U){
          io.ALUoutput := io.x(rs1Reg) ^ imm_IReg
        }
        is (0x6.U){
          io.ALUoutput := io.x(rs1Reg) | imm_IReg
        }
        is (0x7.U){
          io.ALUoutput := io.x(rs1Reg) & imm_IReg
        }
        is (0x1.U){
          switch(io.funct7){
            is (0x00.U){
              //io.ALUoutput := io.x(rs1Reg) << imm_IReg(4,0)
            }
          }
        }
        is (0x5.U) {
          switch(io.funct7) {
            is(0x00.U) {
              // io.ALUoutput := io.x(rs1Reg) >> imm_IReg(4, 0)
            }
            is(0x20.U) {
              //io.ALUoutput := (io.x(rs1Reg).asSInt >> imm_IReg(4, 0)).asUInt
            }
          }
        }
      }
    }
    //I-type
    is("b0000011".U){
      switch(funct3Reg){
        is(0x0.U){

        }
      }
    }
    //R-type
    is("b0110011".U){
      switch(io.funct7){
        is(0x00.U){
          switch(funct3Reg){
            is(0x0.U){
              io.ALUoutput := io.x(rs1Reg) + io.x(rs2Reg)
            }
            is(0x4.U){
              io.ALUoutput := io.x(rs1Reg) ^ io.x(rs2Reg)
            }
            is(0x6.U){
              io.ALUoutput := io.x(rs1Reg) | io.x(rs2Reg)
            }
            is(0x7.U){
              io.ALUoutput := io.x(rs1Reg) & io.x(rs2Reg)
            }
            is(0x1.U){
              //  io.ALUoutput := io.x(rs1Reg) << io.x(rs2Reg)
            }
            is(0x5.U){
              // io.ALUoutput := io.x(rs1Reg) >> io.x(rs2Reg)
            }
            is(0x2.U){
              //io.ALUoutput := io.x(rs1Reg) < io.x(rs2Reg)
            }
            is(0x3.U){
              io.ALUoutput := io.x(rs1Reg) ^ io.x(rs2Reg)
            }
          }
        }
      }
    }
  }
  //io.ALUoutput := io.ALUoutput
  io.rdOutput := rdReg


}


