import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class FoodSpec extends AnyFlatSpec with ChiselScalatestTester {
  "Hello" should "just print the testVal" in {
    test(new Food()) { dut =>
      // Disable the default test timeout
      dut.clock.setTimeout(0)

      // Print LED value before stepping
      for (i <- 0 to 0 ) {
        println(s"Cycle 0 testVal_u:($i) ${dut.io.testVal_u(i).peekInt()}, testVal_s($i): ${dut.io.testVal_s(i).peekInt()}")

      }
      // Step N times, printing the LED value each cycle
      for (cycle <- 1 to 30) {
        println(s"Cycle $cycle")
        dut.clock.step(1)
        for (i <- 1 to 8){
          print("x(" + (i-1) + "):" + s"${dut.io.testVal_s(i).peekInt()}. ")

        }

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
