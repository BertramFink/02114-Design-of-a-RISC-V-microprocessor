circuit MyModule :
  module MyModule :
    input clock : Clock
    input reset : UInt<1>
    output io : { led : UInt<1>}

    reg PC : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[MyModule.scala 13:19]
    reg cntReg : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[MyModule.scala 17:23]
    reg blkReg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[MyModule.scala 18:23]
    node _cntReg_T = add(cntReg, UInt<1>("h1")) @[MyModule.scala 20:20]
    node _cntReg_T_1 = tail(_cntReg_T, 1) @[MyModule.scala 20:20]
    cntReg <= _cntReg_T_1 @[MyModule.scala 20:10]
    node _T = eq(cntReg, UInt<26>("h2faf07f")) @[MyModule.scala 21:15]
    when _T : @[MyModule.scala 21:28]
      cntReg <= UInt<1>("h0") @[MyModule.scala 22:12]
      node _blkReg_T = not(blkReg) @[MyModule.scala 23:15]
      blkReg <= _blkReg_T @[MyModule.scala 23:12]
    io.led <= blkReg @[MyModule.scala 25:10]

