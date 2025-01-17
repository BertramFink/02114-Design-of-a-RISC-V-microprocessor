
import chisel3._
import chisel3.util._
class ALU extends Module {
  val io = IO(new Bundle {
    val funct3 = Input(UInt(3.W))
    val funct7 = Input(UInt(7.W))
    val rs1 = Input(UInt(5.W))
    val rs2 = Input(UInt(5.W))
    val imm_I = Input(SInt(12.W))
    val imm_S = Input(SInt(12.W))
    val imm_B = Input(SInt(13.W))
    val imm_U = Input(UInt(32.W))
    val imm_J = Input(SInt(21.W))
    val out = Output(SInt(32.W))
    val PC = Input(SInt(32.W))
    val group = Input(UInt(2.W))
    //val branchOut = Output(SInt(32.W))
    //val branchEnable = Output(Bool())
    val pcOut = Output(SInt(32.W))

    val operand2 = Input(SInt(5.W))
    val operand1 = Input(SInt(12.W))


  })
  val funct3 = io.funct3
  val funct7 = io.funct7
  val rs1 = io.rs1
  val rs2 = io.rs2
  val imm_I = io.imm_I
  val imm_S = io.imm_S
  val imm_B = io.imm_B
  val imm_U = io.imm_U
  val imm_J = io.imm_J
  val imm_4 = io.rs2
  val PC = io.PC
  val group = io.group
  val operand1 = io.operand1
  val operand2 = io.operand2

  io.out := 0.S
  //io.branchOut := 0.S
  //io.branchEnable := false.B
  io.pcOut := PC



  switch(group) {
    is(1.U) { // R and I types
      switch(funct3) { // does all the simple R and I type instructions
        is(0x0.U) {
          switch(funct7) {
            is(0x0.U) {
              io.out := operand1.asSInt + operand2
            }
            is(0x20.U) {
              io.out := operand1.asSInt - operand2
            }
          }
        }
        is(0x4.U) {
          io.out := operand1.asSInt ^ operand2
        }
        is(0x6.U) {
          io.out := operand1.asSInt | operand2
        }
        is(0x7.U) {
          io.out := operand1.asSInt & operand2
        }
        is(0x1.U) {
          io.out := (operand1.asUInt << operand2.asUInt).asSInt
        }
        is(0x5.U) {

          switch(funct7) {
            is(0x00.U) {
              io.out := (operand1.asUInt >> operand2.asUInt).asSInt
            }
            is(0x20.U) {
              io.out := operand1 >> operand2.asUInt
            }
          }
        }
        is(0x2.U) {
          io.out := Mux(operand1.asSInt < operand2, 1.S, 0.S)
        }
        is(0x3.U) {
          io.out := Mux(operand1.asUInt < operand2.asUInt, 1.S, 0.S)
        }
      }
    }
    is(2.U) { // Load
      //io.rdAddr := (io.x(rs1) + imm_I)(9,0)
      //io.rdEna := true.B
      switch(funct3) {
        is(0x0.U) {
          //io.memOp := 1.U
        }
        is(0x1.U) {
          // io.memOp := 2.U
        }
        is(0x2.U) {
          //io.memOp := 3.U
        }
      }

    }
    is(3.U) { // store

    }
    is(4.U) { //  branch
      switch(funct3) {
        is(0x0.U) {
          when (rs1 === rs2) {
            //io.branchEnable := true.B
           // io.branchOut := PC + imm_B - 4.S
          }
        }
        is(0x1.U) {
          if (rs1 != rs2) {

          }
        }
        is(0x4.U) {
          when(rs1 < rs2) {
            io.pcOut := PC + imm_B
          }
        }
        is(0x5.U) {
          when((rs1 > rs2)) {
            io.pcOut := PC + imm_B
          }
        }
        is(0x6.U) {
          when(rs1.asUInt < rs2.asUInt) {
            io.pcOut := PC + imm_B
          }
        }
        is(0x7.U) {
          when(rs1.asUInt >= rs2.asUInt) {
            io.pcOut := PC + imm_B
          }
        }
      }
    }
    is(5.U) { //jal
      //io.branchOut := PC + imm_J

    }
    is(6.U) { //jalr
      //io.branchOut := rs1.asSInt + imm_I
    }
    is(7.U) { //LUI
      io.out := ((imm_U)(19, 0) << 12).asSInt
    }
    is(8.U) { //AUIPC
      io.out := PC + ((imm_U)(19, 0) << 12).asSInt
    }
  }
}

