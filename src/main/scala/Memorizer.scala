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
  val rdAddrReg = RegNext(io.rdAddr, 0.U)
  val wrAddrReg = RegNext(io.wrAddr, 0.U)
  val memOpReg = RegNext(io.memOp, 0.U)
  val mem = Seq.fill(4) { SyncReadMem(1024, UInt(8.W)) }
  io.wrEnaOut := wrEnaReg
  io.rdEnaOut := rdEnaReg

  val readByte0  = mem(0).read(io.rdAddr>>2)
  val readByte1  = mem(1).read(io.rdAddr>>2)
  val readByte2  = mem(2).read(io.rdAddr>>2)
  val readByte3  = mem(3).read(io.rdAddr>>2)
  val offset =  RegNext(io.rdAddr(1,0), 0.U)


  val writeByte3 =wrDataReg(31,24).asUInt
  val writeByte2 =wrDataReg(23,16).asUInt
  val writeByte1 =wrDataReg(15,8).asUInt
  val writeByte0 =wrDataReg(7,0).asUInt

  io.rdData := 0.S
  io.rdLoadRegMemOut := 0.U
  io.aluLoadRegMemOut := 0.S
  switch(memOpReg) {
    is(0.U) {
      io.rdData := 4.S
    }
    is(1.U) {
      io.rdData := readByte0.asSInt
      when(wrEnaReg) {
        io.rdData := 0.S
        switch(offset) {
          is(0.U) {
            mem(0).write(wrAddrReg>>2, writeByte0)
          }
          is(1.U) {
            mem(1).write(wrAddrReg>>2, writeByte0)
          }
          is(2.U) {
            mem(2).write(wrAddrReg>>2, writeByte0)
          }
          is(3.U) {
            mem(3).write(wrAddrReg>>2, writeByte0)
          }
        }
      }
    }
    is(2.U) {
      io.rdData := Cat(readByte1,  readByte0).asSInt
      when(wrEnaReg) {
        io.rdData := 0.S
        switch(offset) {
          is(0.U) {
            mem(0).write(wrAddrReg>>2, writeByte0)
            mem(1).write(wrAddrReg>>2, writeByte1)
          }
          is(1.U) {
            mem(1).write(wrAddrReg>>2, writeByte0)
            mem(2).write(wrAddrReg>>2, writeByte1)
          }
          is(2.U) {
            mem(2).write(wrAddrReg>>2, writeByte0)
            mem(3).write(wrAddrReg>>2, writeByte1)
          }
          is(3.U) {
            mem(3).write(wrAddrReg>>2, writeByte0)

          }
        }
      }
    }
    is(3.U) {
          io.rdData := Cat(readByte3, readByte2, readByte1, readByte0).asSInt
          when(wrEnaReg) {

            mem(0).write(wrAddrReg >> 2, writeByte0)
            mem(1).write(wrAddrReg >> 2, writeByte1)
            mem(2).write(wrAddrReg >> 2, writeByte2)
            mem(3).write(wrAddrReg >> 2, writeByte3)
          }
    }

    is(4.U) {
      io.rdData := Cat(0.U(24.W), readByte0).asSInt
    }
    is(5.U) {
      io.rdData := Cat(0.U(16.W), readByte1,  readByte0).asSInt
    }
  }
  val rdLoadRegger = RegInit(0.U(5.W))
  val aluLoadRegger = RegInit(0.S(32.W))
  val enabler = RegInit(false.B)
  enabler := rdEnaReg
  io.loadEnabler := enabler
  rdLoadRegger := rdReg
  aluLoadRegger:= io.rdData
  io.rdLoadRegMemOut := rdLoadRegger
  io.aluLoadRegMemOut := aluLoadRegger
}
