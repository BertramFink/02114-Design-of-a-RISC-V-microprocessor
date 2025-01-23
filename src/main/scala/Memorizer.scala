import chisel3._
import chisel3.util._

class Memorizer extends Module {
  val io = IO(new Bundle {
    val ALUinput = Input(SInt(32.W))
    val rdInput = Input(UInt(5.W))
    val rdAddr = Input(UInt(10.W))
    val wrAddr = Input(UInt(10.W))
    val wrData = Input(UInt(32.W))
    val wrEna = Input(Bool())
    val rdEna = Input(Bool())
    val memOp = Input(UInt(3.W))

    val rdLastRegMemOut = Output(UInt(5.W))
    val aluLastRegMemOut = Output(SInt(32.W))
    val rdLoadRegMemOut = Output(UInt(5.W))
    val aluLoadRegMemOut = Output(SInt(32.W))
    val loadEnabler = Output(Bool())

    val rdData = Output(SInt(32.W))
    val rdEnaOut = Output(Bool())
    val wrEnaOut = Output(Bool())

    val rdOutput = Output(UInt(5.W))
    val ALUoutput = Output(SInt(32.W))
  })


  val rdReg = RegNext(io.rdInput, 0.U)
  val ALUreg = RegNext(io.ALUinput, 0.S)
  io.rdOutput := rdReg
  io.ALUoutput := ALUreg


  val rdLastRegMem = RegInit(0.U(5.W))
  val aluLastRegMem = RegInit(0.S(32.W))

  rdLastRegMem := io.rdOutput
  aluLastRegMem := io.ALUoutput
  io.rdLastRegMemOut := rdLastRegMem
  io.aluLastRegMemOut := aluLastRegMem

  val wrEnaReg = RegNext(io.wrEna, false.B)
  val rdEnaReg = RegNext(io.rdEna, false.B)
  val wrDataReg = RegNext(io.wrData, 0.U)
  val wrAddrReg = RegNext(io.wrAddr, 0.U)
  val memOpReg = RegNext(io.memOp, 0.U)
  val mem = Seq.fill(4) {
    SyncReadMem(1080000, UInt(8.W))
  }
  io.wrEnaOut := wrEnaReg
  io.rdEnaOut := rdEnaReg

  val readAddress = io.rdAddr >> 2
  val writeAddress = wrAddrReg >> 2

  val offset = RegNext(io.rdAddr(1, 0), 0.U)
  val writeByte = Seq(
    wrDataReg(7, 0).asUInt,
    wrDataReg(15, 8).asUInt,
    wrDataReg(23, 16).asUInt,
    wrDataReg(31, 24).asUInt,
  )
  val readByte = Seq(
    mem(0).read(readAddress),
    mem(1).read(readAddress),
    mem(2).read(readAddress),
    mem(3).read(readAddress),
  )

  io.rdData := 0.S
  io.rdLoadRegMemOut := 0.U
  io.aluLoadRegMemOut := 0.S

  switch(memOpReg) {
    is(0.U) {
      io.rdData := 9999.S
    }
    is(1.U) { //Byte
      for (i <- 0 until 4) {
        when(offset === i.U) {
          io.rdData := readByte(i).asSInt

          when(wrEnaReg) {
            mem(i).write(writeAddress, writeByte(0))
          }
        }
      }
    }
    is(2.U) { //Half
      for (i <- 0 until 3) {
        when(offset === i.U) {
          io.rdData := Cat(readByte(i + 1), readByte(i)).asSInt

          when(wrEnaReg) {
            mem(i).write(writeAddress, writeByte(0))
            mem(i + 1).write(writeAddress, writeByte(1))
          }
        }
      }
    }
    is(3.U) { //Word
      io.rdData := Cat(readByte(3), readByte(2), readByte(1), readByte(0)).asSInt

      when(wrEnaReg) {
        for (i <- 0 until 4) {
          mem(i).write(writeAddress, writeByte(i))
        }
      }
    }

    is(4.U) { // LBU
      for (i <- 0 until 4) {
        when(offset === i.U) {
          io.rdData := Cat(0.U(24.W), readByte(i)).asSInt
        }
      }
    }
    is(5.U) { //LHU
      for (i <- 0 until 3) {
        when(offset === i.U) {
          io.rdData := Cat(0.U(16.W), readByte(i + 1), readByte(i)).asSInt
        }
      }
    }
  }
  val rdLoadRegger = RegInit(0.U(5.W))
  val aluLoadRegger = RegInit(0.S(32.W))
  val enabler = RegInit(false.B)
  enabler := rdEnaReg
  io.loadEnabler := enabler
  rdLoadRegger := rdReg
  aluLoadRegger := io.rdData
  io.rdLoadRegMemOut := rdLoadRegger
  io.aluLoadRegMemOut := aluLoadRegger
}
