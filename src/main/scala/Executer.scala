import chisel3._
import chisel3.util._

class Executer extends Module {
  val io = IO(new Bundle {
    val opcode = Input(UInt(7.W))
    val rdInput = Input(UInt(5.W))
    val funct3 = Input(UInt(3.W))
    val funct7 = Input(UInt(7.W))
    val rs1 = Input(UInt(5.W))
    val rs2 = Input(UInt(5.W))
    val imm_I = Input(SInt(12.W))
    val imm_S = Input(SInt(12.W))
    val imm_B = Input(SInt(13.W))
    val imm_U = Input(UInt(32.W))
    val imm_J = Input(SInt(21.W))
    val ALUoutput = Output(SInt(32.W))
    val rdOutput = Output(UInt(5.W))
    val x = Input(Vec(32, SInt(32.W)))

    val rdAddr = Output(UInt(10.W))
    val wrAddr = Output(UInt(10.W))
    val wrEna = Output(Bool())
    val rdEna = Output(Bool())
    val memOp =  Output(UInt(3.W))

    val pcIn = Input(SInt(32.W))
    val pcOut = Output(SInt(32.W))
    val branchOut = Output(SInt(32.W))
    val branchEnable = Output(Bool())
    val immOut = Output(SInt(32.W))

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

  val rdLastReg = RegInit(0.U(5.W))
  val aluLastReg = RegInit(0.S(32.W))


  val ALUreg = RegInit(0.S(32.W))
  //val xReg = RegInit(VecInit(Seq.fill(32)(0.S(32.W))))
  //xReg := io.x
  opcodeReg := io.opcode
  rdReg := io.rdInput
  funct3Reg := io.funct3
  rs1Reg := io.rs1
  rs2Reg := io.rs2
  imm_IReg := io.imm_I
  imm_SReg := io.imm_S
  imm_BReg := io.imm_B
  imm_UReg := io.imm_U
  imm_JReg := io.imm_J
  funct7Reg := io.funct7
  io.wrEna := false.B
  io.rdEna := false.B
  io.rdAddr := 0.U
  io.wrAddr := 0.U
  io.memOp := 0.U

  pcReg := io.pcIn
  branchEnableReg := false.B
  io.ALUoutput := 0.S

  val rs1Wire = Mux(rdLastReg === rs1Reg,  aluLastReg, io.x(rs1Reg))
  val rs2Wire = Mux(rdLastReg === rs2Reg, aluLastReg, io.x(rs2Reg))


  branchOutReg := pcReg

  io.branchEnable := false.B
  io.branchOut := 0.S
  switch(opcodeReg) {
    //I-type
    is("b0010011".U) {
      switch(funct3Reg) {
        is(0x0.U) {
          io.ALUoutput := rs1Wire + imm_IReg
        }
        is(0x4.U) {
          io.ALUoutput := rs1Wire ^ imm_IReg
        }
        is(0x6.U) {
          io.ALUoutput := io.x(rs1Reg) | imm_IReg
        }
        is(0x7.U) {
          io.ALUoutput := io.x(rs1Reg) & imm_IReg
        }
        is(0x1.U) {
          switch(funct7Reg) {
            is(0x00.U) {
              //io.ALUoutput := io.x(rs1Reg) << imm_IReg(4,0)
            }
          }
        }
        is(0x5.U) {
          switch(funct7Reg) {
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

    // S-type
    is("b0100011".U){
      io.ALUoutput := rs2Wire
      io.wrAddr := (rs1Wire + imm_SReg)(9,0)
      io.wrEna := true.B
      switch(funct3Reg){
        is(0x0.U){
          io.memOp := 1.U

        }
        is(0x1.U){
          io.memOp := 2.U
        }
        is(0x2.U){
          io.memOp := 3.U
        }
      }
    }
    is("b0000011".U){
      io.rdAddr := (rs1Wire + imm_IReg)(9,0)
      io.rdEna := true.B
      switch(funct3Reg){

        is(0x0.U){
          io.memOp := 1.U
        }
        is(0x1.U){
          io.memOp := 2.U
        }
        is(0x2.U){
          io.memOp := 3.U
        }
        is(0x4.U){
          io.memOp := 4.U
        }
        is(0x5.U){
          io.memOp := 5.U
        }
      }
    }


    //R-type
    is("b0110011".U) {
      switch(funct7Reg) {
        is(0x00.U) {
          switch(funct3Reg) {
            is(0x0.U) {
              io.ALUoutput := rs1Wire + rs2Wire
            }
            is(0x4.U) {
              io.ALUoutput := io.x(rs1Reg) ^ io.x(rs2Reg)
            }
            is(0x6.U) {
              io.ALUoutput := io.x(rs1Reg) | io.x(rs2Reg)
            }
            is(0x7.U) {
              io.ALUoutput := io.x(rs1Reg) & io.x(rs2Reg)
            }
            is(0x1.U) {
              //  io.ALUoutput := io.x(rs1Reg) << io.x(rs2Reg)
            }
            is(0x5.U) {
              // io.ALUoutput := io.x(rs1Reg) >> io.x(rs2Reg)
            }
            is(0x2.U) {
              //io.ALUoutput := io.x(rs1Reg) < io.x(rs2Reg)
            }
            is(0x3.U) {
              io.ALUoutput := io.x(rs1Reg) ^ io.x(rs2Reg)
            }
          }
        }
      }
    }
//B-type
    is("b1100011".U) {
      switch(funct3Reg) {
        is(0x0.U) {
          when(rs1Reg === rs2Reg) {
            io.branchEnable := true.B
            io.branchOut := pcReg + imm_BReg - 4.S

          }
        }
      }
    }
    //U-type Jump and link
    is("b1101111".U){
      io.branchOut := pcReg + imm_JReg
    }
    is("b1100111".U){
      io.branchOut := io.x(rs1Reg) + imm_IReg
    }
    is("b0110111".U){
      io.ALUoutput := ((imm_UReg)(19,0) << 12).asSInt
    }
    is("b0010111".U){
      io.ALUoutput := pcReg + ((imm_UReg)(19,0) << 12).asSInt
    }

  }

  io.rdOutput := rdReg

  rdLastReg := io.rdOutput
  aluLastReg := io.ALUoutput



  io.immOut := imm_BReg
  io.pcOut := pcReg

}


