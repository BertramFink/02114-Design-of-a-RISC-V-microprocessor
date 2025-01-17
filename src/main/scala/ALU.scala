
import chisel3._
import chisel3.util._
class ALU extends Module {
  val io = IO(new Bundle {
    val funct3 = Input(UInt(3.W))
    val funct7 = Input(UInt(7.W))
    val imm = Input(SInt(32.W))
    val PC = Input(SInt(32.W))
    val group = Input(UInt(2.W))

    val operand2 = Input(SInt(32.W))
    val operand1 = Input(SInt(32.W))
    val branchOut = Output(SInt(32.W))
    val branchEnable = Output(Bool())
    val ALUout = Output(SInt(32.W))

    val pcOut = Output(SInt(32.W))

    val rdAddr = Output(UInt(10.W))
    val wrAddr = Output(UInt(10.W))
    val wrEna = Output(Bool())
    val rdEna = Output(Bool())
    val memOp = Output(UInt(3.W))


  })
  val funct3 = io.funct3
  val funct7 = io.funct7
  val PC = io.PC
  val group = io.group
  val operand1 = io.operand1
  val operand2 = io.operand2
  val imm = io.imm

  io.wrEna := false.B
  io.rdEna := false.B
  io.rdAddr := 0.U
  io.wrAddr := 0.U
  io.memOp := 0.U

  io.ALUout := 0.S
  io.branchOut := 0.S
  io.branchEnable := false.B
  io.pcOut := PC


  switch(group) {
    is(1.U) { // R and I types
      switch(funct3) { // does all the simple R and I type instructions
        is(0x0.U) {
          switch(funct7) {
            is(0x0.U) {
              io.ALUout := operand1.asSInt + operand2
            }
            is(0x20.U) {
              io.ALUout := operand1.asSInt - operand2
            }
          }
        }
        is(0x4.U) {
          io.ALUout := operand1.asSInt ^ operand2
        }
        is(0x6.U) {
          io.ALUout := operand1.asSInt | operand2
        }
        is(0x7.U) {
          io.ALUout := operand1.asSInt & operand2
        }
        is(0x1.U) {

          io.ALUout := (operand1.asUInt << operand2.asUInt(18,0)).asSInt  //may not work, error if using more than (18,0)
        }
        is(0x5.U) {

          switch(funct7) {
            is(0x00.U) {
              io.ALUout := (operand1.asUInt >> operand2.asUInt).asSInt
            }
            is(0x20.U) {
              io.ALUout := operand1 >> operand2.asUInt
            }
          }
        }
        is(0x2.U) {
          io.ALUout := Mux(operand1.asSInt < operand2, 1.S, 0.S)
        }
        is(0x3.U) {
          io.ALUout := Mux(operand1.asUInt < operand2.asUInt, 1.S, 0.S)
        }
      }
    }
    is(2.U) { // Load
      io.rdAddr := (operand1 + imm)(9, 0)
      io.rdEna := true.B
      switch(funct3) {

        is(0x0.U) {
          io.memOp := 1.U
        }
        is(0x1.U) {
          io.memOp := 2.U
        }
        is(0x2.U) {
          io.memOp := 3.U
        }
        is(0x4.U) {
          io.memOp := 4.U
        }
        is(0x5.U) {
          io.memOp := 5.U
        }
      }

    }
    is(3.U) { // store
      io.ALUout := operand2
      io.wrAddr := (operand1 + imm)(9, 0)
      io.wrEna := true.B
      switch(funct3) {
        is(0x0.U) {
          io.memOp := 1.U
        }
        is(0x1.U) {
          io.memOp := 2.U
        }
        is(0x2.U) {
          io.memOp := 3.U
        }
      }

    }
    is(4.U) { //  branch
      switch(funct3) {
        is(0x0.U) {
          when(operand1 === operand2) {
            io.branchEnable := true.B
            io.branchOut := PC + imm - 4.S
          }
        }
        is(0x1.U) {
          when(operand1 =/= operand2) {
            io.branchEnable := true.B
            io.branchOut := PC + imm - 4.S

          }
        }
        is(0x4.U) {
          when(operand1 < operand2) {
            io.branchEnable := true.B
            io.branchOut := PC + imm - 4.S
          }
        }
        is(0x5.U) {
          when(operand1 >= operand2) {
            io.branchEnable := true.B
            io.branchOut := PC + imm - 4.S
          }
        }

          is(0x6.U) {
            when(operand1 < operand2) {
              io.branchEnable := true.B
              io.branchOut := PC + imm - 4.S
            }
          }
          is(0x7.U) {
            when(operand1.asUInt >= operand2.asUInt) {
              io.branchEnable := true.B
              io.branchOut := PC + imm - 4.S
            }
          }
        }
      }

    is(5.U) { //jal
      io.branchOut := PC + imm

    }
    is(6.U) { //jalr
      io.branchOut := operand1 + imm
    }
    is(7.U) { //LUI
      io.ALUout := ((imm)(19, 0) << 12).asSInt
    }
    is(8.U) { //AUIPC
      io.ALUout := PC + ((imm)(19, 0) << 12).asSInt

    }
  }
}


