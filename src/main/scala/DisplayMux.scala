import chisel3._
import chisel3.util._

class DisplayMux(maxCount: Int) extends Module {
  val io = IO(new Bundle {
    val xReg = Input(SInt(32.W))
    val seg = Output(UInt(7.W))
    val an = Output(UInt(8.W))
  })

  val sevSeg = WireDefault("b1111111".U(7.W))
  val select = WireDefault("b00000001".U(8.W))

  // Generator for a counter that can be enabled or disabled
  def genCnt(n: Int, enable: Bool) = {
    val cntReg = RegInit(0.U(log2Ceil(n).W))
    cntReg := Mux(enable, Mux(cntReg === n.U, 0.U, cntReg + 1.U), cntReg)
    cntReg
  }

  // Counter to switch between segments
  val cnt3 = genCnt(7, genCnt(maxCount, true.B) === maxCount.U)
  // Seven segment decoder module
  val dec = Module(new SevSeg)

  // Default input to decoder
  dec.io.in := 0.U
  // Switch case to assign the correct portion of price or sum to the decoder input
  switch(cnt3) {
    is(0.U) { dec.io.in := io.xReg(3, 0) }
    is(1.U) { dec.io.in := io.xReg(7, 4) }
    is(2.U) { dec.io.in := io.xReg(11, 5) }
    is(3.U) { dec.io.in := io.xReg(15, 12) }
    is(4.U) { dec.io.in := io.xReg(19, 16) }
    is(5.U) { dec.io.in := io.xReg(23, 20) }
    is(6.U) { dec.io.in := io.xReg(27, 24) }
    is(7.U) { dec.io.in := io.xReg(31, 28) }
  }

  // Assign decoded output to seven segment display signal
  sevSeg := dec.io.out
  // Update select signals based on the current counter value
  switch(cnt3) {
    is(0.U) { select := "b00000001".U }
    is(1.U) { select := "b00000010".U }
    is(2.U) { select := "b00000100".U }
    is(3.U) { select := "b00001000".U }
    is(4.U) { select := "b00010000".U }
    is(5.U) { select := "b00100000".U }
    is(6.U) { select := "b01000000".U }
    is(7.U) { select := "b10000000".U }
  }

  // Invert signals for common anode 7-segment displays
  io.seg := ~sevSeg
  io.an := ~select
}