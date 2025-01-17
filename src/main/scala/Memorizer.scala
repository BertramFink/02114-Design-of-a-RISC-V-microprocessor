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
  val mem = SyncReadMem(1024, UInt(8.W))
  io.wrEnaOut := wrEnaReg
  io.rdEnaOut := rdEnaReg
  val readByte0  = mem.read(io.rdAddr)
  val readByte1  = mem.read(io.rdAddr + 1.U)
  val readByte2  = mem.read(io.rdAddr + 2.U)
  val readByte3  = mem.read(io.rdAddr + 3.U)
  val writeByte0 = wrDataReg(7,0).asUInt
  val writeByte1 =wrDataReg(15,8).asUInt
  val writeByte2 =wrDataReg(23,16).asUInt
  val writeByte3 =wrDataReg(31,24).asUInt

  io.rdData := mem.read(io.rdAddr).asSInt
  io.rdLoadRegMemOut := 0.U
  io.aluLoadRegMemOut := 0.S
  switch(memOpReg) {
    is(0.U) {
      io.rdData := 4.S
    }
    is(1.U) {
      io.rdData := readByte0.asSInt
      when(wrEnaReg) {
        mem.write(wrAddrReg, writeByte0)
      }
    }
    is(2.U) {
      io.rdData := Cat(readByte1,  readByte0).asSInt
      when(wrEnaReg) {
        mem.write(wrAddrReg, writeByte0)
        mem.write(wrAddrReg + 1.U, writeByte1)
      }
    }
    is(3.U) {
      io.rdData := Cat(readByte3, readByte2, readByte1, readByte0).asSInt
      when(wrEnaReg) {
        mem.write(wrAddrReg, writeByte0)
        mem.write(wrAddrReg + 1.U, writeByte1)
        mem.write(wrAddrReg+2.U, writeByte2)
        mem.write(wrAddrReg + 3.U, writeByte3)
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
