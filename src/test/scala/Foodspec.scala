import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class FoodSpec extends AnyFlatSpec with ChiselScalatestTester {
  "Hello" should "just print the testVal" in {
    test(new Food()) { dut =>
      // Disable the default test timeout
      dut.clock.setTimeout(0)


      // Step N times, printing the LED value each cycle
      for (cycle <- 0 to 30) {
        println(s"Cycle $cycle")

        dut.clock.step(1)
        println(s"pcOutFe: ${dut.io.testVal_u(0).peekInt()}, pcOutDe: ${dut.io.testVal_u(3).peekInt()}, pcOutEx: ${dut.io.testVal_u(2).peekInt()}, imm_B: ${dut.io.testVal_u(1).peekInt()}, branchOutEx: ${dut.io.testVal_u(4).peekInt()}, branchInFe: ${dut.io.testVal_u(5).peekInt()}")
        println(s"ALUOutEx: ${dut.io.testVal_U2.peek()}, indexFe: ${dut.io.testVal_u(6).peekInt()}")

        for (i <- 1 to 8){
          print("x(" + (i-1) + "):" + s"${dut.io.testVal_s(i).peekInt()}. ")

        }
        println()

        println()
//
//        println(s"Cycle $cycle\n" +
//          s"testVal_u: (0) ${dut.io.testVal_u(0).peekInt()}, (1) ${dut.io.testVal_u(1).peekInt()}, (2) ${dut.io.testVal_u(2).peekInt()}, " +
//          s"(3) ${dut.io.testVal_u(3).peekInt()}, (4) ${dut.io.testVal_u(4).peekInt()}, (5) ${dut.io.testVal_u(5).peekInt()}\n" +
//          s"testVal_s: (0) ${dut.io.testVal_s(0).peekInt()}, (1) ${dut.io.testVal_s(1).peekInt()}, (2) ${dut.io.testVal_s(2).peekInt()}, " +
//          s"(3) ${dut.io.testVal_s(3).peekInt()}, (4) ${dut.io.testVal_s(4).peekInt()}, (5) ${dut.io.testVal_s(5).peekInt()}")
      }

    }
  }
}
