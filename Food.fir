circuit Food :
  module Fetcher :
    input clock : Clock
    input reset : Reset
    output io : { flip instrIn : UInt<32>[18], flip branchIn : SInt<32>, flip branchEnable : UInt<1>, flip shouldMux : UInt<1>, instrOut : UInt<32>, pcOut : SInt<32>}

    reg pcReg : SInt<32>, clock with :
      reset => (reset, asSInt(UInt<32>("hfffffffc"))) @[Fetcher.scala 15:22]
    reg instrReg : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[Fetcher.scala 16:25]
    wire instr : UInt<32>[18] @[Fetcher.scala 17:22]
    instr[0] <= UInt<32>("hdeadc0b7") @[Fetcher.scala 17:22]
    instr[1] <= UInt<32>("heef08093") @[Fetcher.scala 17:22]
    instr[2] <= UInt<32>("h800113") @[Fetcher.scala 17:22]
    instr[3] <= UInt<32>("h112023") @[Fetcher.scala 17:22]
    instr[4] <= UInt<32>("h12183") @[Fetcher.scala 17:22]
    instr[5] <= UInt<32>("h308a63") @[Fetcher.scala 17:22]
    instr[6] <= UInt<32>("h63") @[Fetcher.scala 17:22]
    instr[7] <= UInt<32>("h700093") @[Fetcher.scala 17:22]
    instr[8] <= UInt<32>("h10283") @[Fetcher.scala 17:22]
    instr[9] <= UInt<32>("h628863") @[Fetcher.scala 17:22]
    instr[10] <= UInt<32>("ha00213") @[Fetcher.scala 17:22]
    instr[11] <= UInt<32>("h10303") @[Fetcher.scala 17:22]
    instr[12] <= UInt<32>("hff1ff56f") @[Fetcher.scala 17:22]
    instr[13] <= UInt<32>("h900493") @[Fetcher.scala 17:22]
    instr[14] <= UInt<32>("hfe000ee3") @[Fetcher.scala 17:22]
    instr[15] <= UInt<32>("h63") @[Fetcher.scala 17:22]
    instr[16] <= UInt<32>("h13") @[Fetcher.scala 17:22]
    instr[17] <= UInt<32>("h13") @[Fetcher.scala 17:22]
    reg branchEnableReg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[Fetcher.scala 38:32]
    reg branchInReg : SInt<32>, clock with :
      reset => (reset, asSInt(UInt<32>("h0"))) @[Fetcher.scala 39:28]
    branchInReg <= io.branchIn @[Fetcher.scala 41:15]
    branchEnableReg <= io.branchEnable @[Fetcher.scala 42:19]
    node _pcPlusReg_T = add(io.branchIn, asSInt(UInt<4>("h4"))) @[Fetcher.scala 44:77]
    node _pcPlusReg_T_1 = tail(_pcPlusReg_T, 1) @[Fetcher.scala 44:77]
    node _pcPlusReg_T_2 = asSInt(_pcPlusReg_T_1) @[Fetcher.scala 44:77]
    node _pcPlusReg_T_3 = add(pcReg, asSInt(UInt<4>("h4"))) @[Fetcher.scala 44:90]
    node _pcPlusReg_T_4 = tail(_pcPlusReg_T_3, 1) @[Fetcher.scala 44:90]
    node _pcPlusReg_T_5 = asSInt(_pcPlusReg_T_4) @[Fetcher.scala 44:90]
    node _pcPlusReg_T_6 = mux(io.branchEnable, _pcPlusReg_T_2, _pcPlusReg_T_5) @[Fetcher.scala 44:47]
    node pcPlusReg = mux(io.shouldMux, pcReg, _pcPlusReg_T_6) @[Fetcher.scala 44:22]
    node index = shr(pcPlusReg, 2) @[Fetcher.scala 45:28]
    pcReg <= pcPlusReg @[Fetcher.scala 47:9]
    node _instrReg_T = bits(index, 29, 0) @[Fetcher.scala 48:26]
    node _instrReg_T_1 = bits(_instrReg_T, 4, 0)
    instrReg <= instr[_instrReg_T_1] @[Fetcher.scala 48:12]
    io.instrOut <= instrReg @[Fetcher.scala 50:15]
    io.pcOut <= pcReg @[Fetcher.scala 51:12]

  module Decoder :
    input clock : Clock
    input reset : Reset
    output io : { flip instrIn : UInt<32>, opcode : UInt<7>, rdOutput : UInt<5>, funct3 : UInt<3>, funct7 : UInt<7>, rs1 : UInt<5>, rs2 : UInt<5>, imm_I : SInt<12>, imm_S : SInt<12>, imm_B : SInt<13>, imm_U : UInt<32>, imm_J : SInt<21>, flip rdRegEx : UInt<5>, flip LoadMemEnable : UInt<1>, flip pcIn : SInt<32>, pcOut : SInt<32>, shouldMux : UInt<1>}

    node rs1Reg = bits(io.instrIn, 19, 15) @[Decoder.scala 27:26]
    node rs2Reg = bits(io.instrIn, 24, 20) @[Decoder.scala 28:26]
    reg pcReg : SInt<32>, clock with :
      reset => (reset, asSInt(UInt<32>("h0"))) @[Decoder.scala 29:22]
    reg instr : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[Decoder.scala 31:22]
    node _loadMemEnable_T = bits(instr, 6, 0) @[Decoder.scala 32:29]
    node loadMemEnable = eq(_loadMemEnable_T, UInt<2>("h3")) @[Decoder.scala 32:43]
    reg boolean : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[Decoder.scala 33:24]
    node _io_shouldMux_T = eq(rs1Reg, io.rdOutput) @[Decoder.scala 35:45]
    node _io_shouldMux_T_1 = eq(rs2Reg, io.rdOutput) @[Decoder.scala 35:73]
    node _io_shouldMux_T_2 = or(_io_shouldMux_T, _io_shouldMux_T_1) @[Decoder.scala 35:62]
    node _io_shouldMux_T_3 = and(loadMemEnable, _io_shouldMux_T_2) @[Decoder.scala 35:33]
    io.shouldMux <= _io_shouldMux_T_3 @[Decoder.scala 35:16]
    boolean <= io.shouldMux @[Decoder.scala 36:11]
    pcReg <= io.pcIn @[Decoder.scala 38:9]
    io.pcOut <= io.pcIn @[Decoder.scala 39:12]
    node muxInstr = mux(io.shouldMux, UInt<5>("h13"), io.instrIn) @[Decoder.scala 41:21]
    instr <= muxInstr @[Decoder.scala 44:9]
    node _io_opcode_T = bits(instr, 6, 0) @[Decoder.scala 45:21]
    io.opcode <= _io_opcode_T @[Decoder.scala 45:13]
    node _io_rdOutput_T = bits(instr, 11, 7) @[Decoder.scala 46:23]
    io.rdOutput <= _io_rdOutput_T @[Decoder.scala 46:15]
    node _io_funct3_T = bits(instr, 14, 12) @[Decoder.scala 47:21]
    io.funct3 <= _io_funct3_T @[Decoder.scala 47:13]
    node _io_rs1_T = bits(instr, 19, 15) @[Decoder.scala 48:18]
    io.rs1 <= _io_rs1_T @[Decoder.scala 48:10]
    node _io_rs2_T = bits(instr, 24, 20) @[Decoder.scala 50:18]
    io.rs2 <= _io_rs2_T @[Decoder.scala 50:10]
    node _io_funct7_T = bits(instr, 31, 25) @[Decoder.scala 51:21]
    io.funct7 <= _io_funct7_T @[Decoder.scala 51:13]
    node _io_imm_I_T = bits(instr, 31, 20) @[Decoder.scala 52:20]
    node _io_imm_I_T_1 = asSInt(_io_imm_I_T) @[Decoder.scala 52:29]
    io.imm_I <= _io_imm_I_T_1 @[Decoder.scala 52:12]
    node _io_imm_S_T = bits(instr, 31, 25) @[Decoder.scala 53:22]
    node _io_imm_S_T_1 = shl(_io_imm_S_T, 5) @[Decoder.scala 53:31]
    node _io_imm_S_T_2 = bits(instr, 11, 7) @[Decoder.scala 53:44]
    node _io_imm_S_T_3 = or(_io_imm_S_T_1, _io_imm_S_T_2) @[Decoder.scala 53:37]
    node _io_imm_S_T_4 = asSInt(_io_imm_S_T_3) @[Decoder.scala 53:53]
    io.imm_S <= _io_imm_S_T_4 @[Decoder.scala 53:12]
    node _io_imm_B_T = bits(instr, 31, 31) @[Decoder.scala 54:22]
    node _io_imm_B_T_1 = shl(_io_imm_B_T, 12) @[Decoder.scala 54:27]
    node _io_imm_B_T_2 = bits(instr, 7, 7) @[Decoder.scala 54:42]
    node _io_imm_B_T_3 = shl(_io_imm_B_T_2, 11) @[Decoder.scala 54:46]
    node _io_imm_B_T_4 = or(_io_imm_B_T_1, _io_imm_B_T_3) @[Decoder.scala 54:34]
    node _io_imm_B_T_5 = bits(instr, 30, 25) @[Decoder.scala 54:61]
    node _io_imm_B_T_6 = shl(_io_imm_B_T_5, 5) @[Decoder.scala 54:70]
    node _io_imm_B_T_7 = or(_io_imm_B_T_4, _io_imm_B_T_6) @[Decoder.scala 54:53]
    node _io_imm_B_T_8 = bits(instr, 11, 8) @[Decoder.scala 54:84]
    node _io_imm_B_T_9 = shl(_io_imm_B_T_8, 1) @[Decoder.scala 54:92]
    node _io_imm_B_T_10 = or(_io_imm_B_T_7, _io_imm_B_T_9) @[Decoder.scala 54:76]
    node _io_imm_B_T_11 = asSInt(_io_imm_B_T_10) @[Decoder.scala 54:99]
    io.imm_B <= _io_imm_B_T_11 @[Decoder.scala 54:12]
    node _io_imm_U_T = bits(instr, 31, 12) @[Decoder.scala 55:20]
    io.imm_U <= _io_imm_U_T @[Decoder.scala 55:12]
    node _io_imm_J_T = bits(instr, 31, 31) @[Decoder.scala 56:23]
    node _io_imm_J_T_1 = shl(_io_imm_J_T, 20) @[Decoder.scala 56:28]
    node _io_imm_J_T_2 = bits(instr, 19, 12) @[Decoder.scala 56:43]
    node _io_imm_J_T_3 = shl(_io_imm_J_T_2, 12) @[Decoder.scala 56:52]
    node _io_imm_J_T_4 = or(_io_imm_J_T_1, _io_imm_J_T_3) @[Decoder.scala 56:35]
    node _io_imm_J_T_5 = bits(instr, 20, 20) @[Decoder.scala 56:67]
    node _io_imm_J_T_6 = shl(_io_imm_J_T_5, 11) @[Decoder.scala 56:72]
    node _io_imm_J_T_7 = or(_io_imm_J_T_4, _io_imm_J_T_6) @[Decoder.scala 56:59]
    node _io_imm_J_T_8 = bits(instr, 30, 21) @[Decoder.scala 56:87]
    node _io_imm_J_T_9 = shl(_io_imm_J_T_8, 1) @[Decoder.scala 56:96]
    node _io_imm_J_T_10 = or(_io_imm_J_T_7, _io_imm_J_T_9) @[Decoder.scala 56:79]
    node _io_imm_J_T_11 = asSInt(_io_imm_J_T_10) @[Decoder.scala 56:104]
    io.imm_J <= _io_imm_J_T_11 @[Decoder.scala 56:12]

  module Executer :
    input clock : Clock
    input reset : Reset
    output io : { flip opcode : UInt<7>, flip funct3 : UInt<3>, flip funct7 : UInt<7>, flip rdIn : UInt<5>, flip rs1 : UInt<5>, flip rs2 : UInt<5>, flip imm_I : SInt<12>, flip imm_S : SInt<12>, flip imm_B : SInt<13>, flip imm_U : UInt<32>, flip imm_J : SInt<21>, imm : SInt<32>, funct3out : UInt<3>, funct7out : UInt<7>, flip x : SInt<32>[32], flip ALUIn : SInt<32>, group : UInt<4>, operand1 : SInt<32>, operand2 : SInt<32>, flip rdLastRegMemIn : UInt<5>, flip aluLastRegMemIn : SInt<32>, flip rdLoadRegMemIn : UInt<5>, flip aluLoadRegMemIn : SInt<32>, flip loadEnable : UInt<1>, flip pcIn : SInt<32>, pcOut : SInt<32>}

    reg opcodeReg : UInt<7>, clock with :
      reset => (reset, UInt<7>("h0")) @[Executer.scala 40:26]
    reg rdReg : UInt<5>, clock with :
      reset => (reset, UInt<5>("h0")) @[Executer.scala 41:22]
    reg funct3Reg : UInt<3>, clock with :
      reset => (reset, UInt<3>("h0")) @[Executer.scala 42:26]
    reg rs1Reg : UInt<5>, clock with :
      reset => (reset, UInt<5>("h0")) @[Executer.scala 43:23]
    reg rs2Reg : UInt<5>, clock with :
      reset => (reset, UInt<5>("h0")) @[Executer.scala 44:23]
    reg imm_IReg : SInt<12>, clock with :
      reset => (reset, asSInt(UInt<12>("h0"))) @[Executer.scala 45:25]
    reg imm_SReg : SInt<12>, clock with :
      reset => (reset, asSInt(UInt<12>("h0"))) @[Executer.scala 46:25]
    reg imm_BReg : SInt<13>, clock with :
      reset => (reset, asSInt(UInt<13>("h0"))) @[Executer.scala 47:25]
    reg imm_UReg : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[Executer.scala 48:25]
    reg imm_JReg : SInt<21>, clock with :
      reset => (reset, asSInt(UInt<21>("h0"))) @[Executer.scala 49:25]
    reg funct7Reg : UInt<7>, clock with :
      reset => (reset, UInt<7>("h0")) @[Executer.scala 50:26]
    reg pcReg : SInt<32>, clock with :
      reset => (reset, asSInt(UInt<32>("h0"))) @[Executer.scala 52:22]
    reg branchEnableReg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[Executer.scala 53:32]
    reg branchOutReg : SInt<32>, clock with :
      reset => (reset, asSInt(UInt<32>("h0"))) @[Executer.scala 54:29]
    reg rdLastRegEx : UInt<5>, clock with :
      reset => (reset, UInt<5>("h0")) @[Executer.scala 56:28]
    reg aluLastRegEx : SInt<32>, clock with :
      reset => (reset, asSInt(UInt<32>("h0"))) @[Executer.scala 57:29]
    reg ALUreg : SInt<32>, clock with :
      reset => (reset, asSInt(UInt<32>("h0"))) @[Executer.scala 60:23]
    opcodeReg <= io.opcode @[Executer.scala 63:13]
    funct3Reg <= io.funct3 @[Executer.scala 64:13]
    rs1Reg <= io.rs1 @[Executer.scala 65:10]
    rs2Reg <= io.rs2 @[Executer.scala 66:10]
    imm_IReg <= io.imm_I @[Executer.scala 67:12]
    imm_SReg <= io.imm_S @[Executer.scala 68:12]
    imm_BReg <= io.imm_B @[Executer.scala 69:12]
    imm_UReg <= io.imm_U @[Executer.scala 70:12]
    imm_JReg <= io.imm_J @[Executer.scala 71:12]
    funct7Reg <= io.funct7 @[Executer.scala 72:13]
    io.funct7out <= funct7Reg @[Executer.scala 73:16]
    io.funct3out <= funct3Reg @[Executer.scala 74:16]
    branchEnableReg <= UInt<1>("h0") @[Executer.scala 77:19]
    node _lastMemBool1_T = eq(io.rdLastRegMemIn, rs1Reg) @[Executer.scala 78:40]
    node _lastMemBool1_T_1 = neq(rs1Reg, UInt<1>("h0")) @[Executer.scala 78:62]
    node lastMemBool1 = and(_lastMemBool1_T, _lastMemBool1_T_1) @[Executer.scala 78:51]
    node _lastMemBool2_T = eq(io.rdLastRegMemIn, rs2Reg) @[Executer.scala 79:40]
    node _lastMemBool2_T_1 = neq(rs2Reg, UInt<1>("h0")) @[Executer.scala 79:62]
    node lastMemBool2 = and(_lastMemBool2_T, _lastMemBool2_T_1) @[Executer.scala 79:51]
    node _loadMemBool1_T = eq(io.rdLoadRegMemIn, rs1Reg) @[Executer.scala 80:57]
    node loadMemBool1 = and(io.loadEnable, _loadMemBool1_T) @[Executer.scala 80:36]
    node _loadMemBool2_T = eq(io.rdLoadRegMemIn, rs2Reg) @[Executer.scala 81:57]
    node loadMemBool2 = and(io.loadEnable, _loadMemBool2_T) @[Executer.scala 81:36]
    node _lastExBool1_T = eq(rdLastRegEx, rs1Reg) @[Executer.scala 82:34]
    node _lastExBool1_T_1 = neq(rs1Reg, UInt<1>("h0")) @[Executer.scala 82:57]
    node lastExBool1 = and(_lastExBool1_T, _lastExBool1_T_1) @[Executer.scala 82:46]
    node _lastExBool2_T = eq(rdLastRegEx, rs2Reg) @[Executer.scala 83:34]
    node _lastExBool2_T_1 = neq(rs2Reg, UInt<1>("h0")) @[Executer.scala 83:57]
    node lastExBool2 = and(_lastExBool2_T, _lastExBool2_T_1) @[Executer.scala 83:46]
    node _rs1Wire_T = mux(loadMemBool1, io.aluLoadRegMemIn, io.aluLastRegMemIn) @[Executer.scala 85:69]
    node _rs1Wire_T_1 = mux(lastMemBool1, _rs1Wire_T, io.x[rs1Reg]) @[Executer.scala 85:51]
    node rs1Wire = mux(lastExBool1, aluLastRegEx, _rs1Wire_T_1) @[Executer.scala 85:20]
    node _rs2Wire_T = mux(loadMemBool2, io.aluLoadRegMemIn, io.aluLastRegMemIn) @[Executer.scala 86:69]
    node _rs2Wire_T_1 = mux(lastMemBool2, _rs2Wire_T, io.x[rs2Reg]) @[Executer.scala 86:51]
    node rs2Wire = mux(lastExBool2, aluLastRegEx, _rs2Wire_T_1) @[Executer.scala 86:20]
    pcReg <= io.pcIn @[Executer.scala 87:9]
    branchOutReg <= pcReg @[Executer.scala 90:16]
    io.imm <= imm_IReg @[Executer.scala 91:10]
    io.operand1 <= rs1Wire @[Executer.scala 93:15]
    io.operand2 <= asSInt(UInt<1>("h0")) @[Executer.scala 94:15]
    io.group <= UInt<1>("h0") @[Executer.scala 95:12]
    node _T = eq(UInt<6>("h33"), opcodeReg) @[Executer.scala 96:21]
    when _T : @[Executer.scala 96:21]
      io.operand2 <= rs2Wire @[Executer.scala 98:19]
      io.group <= UInt<1>("h1") @[Executer.scala 99:16]
    else :
      node _T_1 = eq(UInt<5>("h13"), opcodeReg) @[Executer.scala 96:21]
      when _T_1 : @[Executer.scala 96:21]
        io.group <= UInt<1>("h1") @[Executer.scala 102:16]
        io.operand2 <= imm_IReg @[Executer.scala 103:19]
        io.funct7out <= UInt<1>("h0") @[Executer.scala 104:20]
        node _T_2 = eq(UInt<1>("h1"), funct3Reg) @[Executer.scala 105:25]
        when _T_2 : @[Executer.scala 105:25]
          io.funct7out <= funct7Reg @[Executer.scala 107:24]
          node _io_operand2_T = asSInt(rs2Reg) @[Executer.scala 108:33]
          io.operand2 <= _io_operand2_T @[Executer.scala 108:23]
        else :
          node _T_3 = eq(UInt<3>("h5"), funct3Reg) @[Executer.scala 105:25]
          when _T_3 : @[Executer.scala 105:25]
            io.funct7out <= funct7Reg @[Executer.scala 111:24]
            node _io_operand2_T_1 = asSInt(rs2Reg) @[Executer.scala 112:33]
            io.operand2 <= _io_operand2_T_1 @[Executer.scala 112:23]
      else :
        node _T_4 = eq(UInt<2>("h3"), opcodeReg) @[Executer.scala 96:21]
        when _T_4 : @[Executer.scala 96:21]
          io.group <= UInt<2>("h2") @[Executer.scala 117:16]
          io.operand2 <= rs2Wire @[Executer.scala 118:19]
          io.imm <= imm_IReg @[Executer.scala 119:14]
        else :
          node _T_5 = eq(UInt<6>("h23"), opcodeReg) @[Executer.scala 96:21]
          when _T_5 : @[Executer.scala 96:21]
            io.group <= UInt<2>("h3") @[Executer.scala 122:16]
            io.operand2 <= rs2Wire @[Executer.scala 123:19]
            io.imm <= imm_SReg @[Executer.scala 124:14]
          else :
            node _T_6 = eq(UInt<7>("h63"), opcodeReg) @[Executer.scala 96:21]
            when _T_6 : @[Executer.scala 96:21]
              io.group <= UInt<3>("h4") @[Executer.scala 127:16]
              io.operand2 <= rs2Wire @[Executer.scala 128:19]
              io.imm <= imm_BReg @[Executer.scala 129:14]
            else :
              node _T_7 = eq(UInt<7>("h6f"), opcodeReg) @[Executer.scala 96:21]
              when _T_7 : @[Executer.scala 96:21]
                io.group <= UInt<3>("h5") @[Executer.scala 132:16]
                io.imm <= imm_JReg @[Executer.scala 133:14]
              else :
                node _T_8 = eq(UInt<7>("h67"), opcodeReg) @[Executer.scala 96:21]
                when _T_8 : @[Executer.scala 96:21]
                  io.group <= UInt<3>("h6") @[Executer.scala 136:16]
                  io.imm <= imm_IReg @[Executer.scala 137:14]
                else :
                  node _T_9 = eq(UInt<6>("h37"), opcodeReg) @[Executer.scala 96:21]
                  when _T_9 : @[Executer.scala 96:21]
                    io.group <= UInt<3>("h7") @[Executer.scala 140:16]
                    node _io_imm_T = asSInt(imm_UReg) @[Executer.scala 141:26]
                    io.imm <= _io_imm_T @[Executer.scala 141:14]
                  else :
                    node _T_10 = eq(UInt<5>("h17"), opcodeReg) @[Executer.scala 96:21]
                    when _T_10 : @[Executer.scala 96:21]
                      io.group <= UInt<4>("h8") @[Executer.scala 144:16]
                      node _io_imm_T_1 = asSInt(imm_UReg) @[Executer.scala 145:26]
                      io.imm <= _io_imm_T_1 @[Executer.scala 145:14]
    rdLastRegEx <= io.rdIn @[Executer.scala 149:15]
    aluLastRegEx <= io.ALUIn @[Executer.scala 150:16]
    io.pcOut <= pcReg @[Executer.scala 151:12]

  module ALU :
    input clock : Clock
    input reset : Reset
    output io : { flip funct3 : UInt<3>, flip funct7 : UInt<7>, flip imm : SInt<32>, flip pcIn : SInt<32>, flip group : UInt<4>, flip operand2 : SInt<32>, flip operand1 : SInt<32>, branchOut : SInt<32>, branchEnable : UInt<1>, ALUout : SInt<32>, pcOut : SInt<32>, rdAddr : UInt<10>, wrAddr : UInt<10>, wrEna : UInt<1>, rdEna : UInt<1>, memOp : UInt<3>, rdOut : UInt<5>, flip rdIn : UInt<5>}

    reg cntReg : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[ALU.scala 38:23]
    io.wrEna <= UInt<1>("h0") @[ALU.scala 39:12]
    io.rdEna <= UInt<1>("h0") @[ALU.scala 40:12]
    io.rdAddr <= UInt<1>("h0") @[ALU.scala 41:13]
    io.wrAddr <= UInt<1>("h0") @[ALU.scala 42:13]
    io.memOp <= UInt<1>("h0") @[ALU.scala 43:12]
    io.ALUout <= asSInt(UInt<1>("h0")) @[ALU.scala 45:13]
    io.branchOut <= asSInt(UInt<1>("h0")) @[ALU.scala 46:16]
    io.branchEnable <= UInt<1>("h0") @[ALU.scala 47:19]
    io.pcOut <= io.pcIn @[ALU.scala 48:12]
    reg branchedLastTime : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[ALU.scala 49:33]
    branchedLastTime <= io.branchEnable @[ALU.scala 49:33]
    node _T = eq(UInt<1>("h1"), io.group) @[ALU.scala 51:17]
    when _T : @[ALU.scala 51:17]
      node _T_1 = eq(UInt<1>("h0"), io.funct3) @[ALU.scala 53:22]
      when _T_1 : @[ALU.scala 53:22]
        node _io_ALUout_T = add(io.operand1, io.operand2) @[ALU.scala 55:40]
        node _io_ALUout_T_1 = tail(_io_ALUout_T, 1) @[ALU.scala 55:40]
        node _io_ALUout_T_2 = asSInt(_io_ALUout_T_1) @[ALU.scala 55:40]
        io.ALUout <= _io_ALUout_T_2 @[ALU.scala 55:21]
        node _T_2 = eq(UInt<6>("h20"), io.funct7) @[ALU.scala 56:26]
        when _T_2 : @[ALU.scala 56:26]
          node _io_ALUout_T_3 = sub(io.operand1, io.operand2) @[ALU.scala 58:44]
          node _io_ALUout_T_4 = tail(_io_ALUout_T_3, 1) @[ALU.scala 58:44]
          node _io_ALUout_T_5 = asSInt(_io_ALUout_T_4) @[ALU.scala 58:44]
          io.ALUout <= _io_ALUout_T_5 @[ALU.scala 58:25]
      else :
        node _T_3 = eq(UInt<3>("h4"), io.funct3) @[ALU.scala 53:22]
        when _T_3 : @[ALU.scala 53:22]
          node _io_ALUout_T_6 = xor(io.operand1, io.operand2) @[ALU.scala 63:40]
          node _io_ALUout_T_7 = asSInt(_io_ALUout_T_6) @[ALU.scala 63:40]
          io.ALUout <= _io_ALUout_T_7 @[ALU.scala 63:21]
        else :
          node _T_4 = eq(UInt<3>("h6"), io.funct3) @[ALU.scala 53:22]
          when _T_4 : @[ALU.scala 53:22]
            node _io_ALUout_T_8 = or(io.operand1, io.operand2) @[ALU.scala 66:40]
            node _io_ALUout_T_9 = asSInt(_io_ALUout_T_8) @[ALU.scala 66:40]
            io.ALUout <= _io_ALUout_T_9 @[ALU.scala 66:21]
          else :
            node _T_5 = eq(UInt<3>("h7"), io.funct3) @[ALU.scala 53:22]
            when _T_5 : @[ALU.scala 53:22]
              node _io_ALUout_T_10 = and(io.operand1, io.operand2) @[ALU.scala 69:40]
              node _io_ALUout_T_11 = asSInt(_io_ALUout_T_10) @[ALU.scala 69:40]
              io.ALUout <= _io_ALUout_T_11 @[ALU.scala 69:21]
            else :
              node _T_6 = eq(UInt<1>("h1"), io.funct3) @[ALU.scala 53:22]
              when _T_6 : @[ALU.scala 53:22]
                node _io_ALUout_T_12 = asUInt(io.operand1) @[ALU.scala 72:34]
                node _io_ALUout_T_13 = asUInt(io.operand2) @[ALU.scala 72:53]
                node _io_ALUout_T_14 = bits(_io_ALUout_T_13, 18, 0) @[ALU.scala 72:59]
                node _io_ALUout_T_15 = dshl(_io_ALUout_T_12, _io_ALUout_T_14) @[ALU.scala 72:41]
                node _io_ALUout_T_16 = asSInt(_io_ALUout_T_15) @[ALU.scala 72:68]
                io.ALUout <= _io_ALUout_T_16 @[ALU.scala 72:21]
              else :
                node _T_7 = eq(UInt<3>("h5"), io.funct3) @[ALU.scala 53:22]
                when _T_7 : @[ALU.scala 53:22]
                  node _io_ALUout_T_17 = asUInt(io.operand1) @[ALU.scala 75:34]
                  node _io_ALUout_T_18 = asUInt(io.operand2) @[ALU.scala 75:53]
                  node _io_ALUout_T_19 = dshr(_io_ALUout_T_17, _io_ALUout_T_18) @[ALU.scala 75:41]
                  node _io_ALUout_T_20 = asSInt(_io_ALUout_T_19) @[ALU.scala 75:61]
                  io.ALUout <= _io_ALUout_T_20 @[ALU.scala 75:21]
                  node _T_8 = eq(io.funct7, UInt<6>("h20")) @[ALU.scala 76:23]
                  when _T_8 : @[ALU.scala 76:35]
                    node _io_ALUout_T_21 = asUInt(io.operand2) @[ALU.scala 77:47]
                    node _io_ALUout_T_22 = dshr(io.operand1, _io_ALUout_T_21) @[ALU.scala 77:35]
                    io.ALUout <= _io_ALUout_T_22 @[ALU.scala 77:23]
                else :
                  node _T_9 = eq(UInt<2>("h2"), io.funct3) @[ALU.scala 53:22]
                  when _T_9 : @[ALU.scala 53:22]
                    node _io_ALUout_T_23 = lt(io.operand1, io.operand2) @[ALU.scala 81:44]
                    node _io_ALUout_T_24 = mux(_io_ALUout_T_23, asSInt(UInt<2>("h1")), asSInt(UInt<1>("h0"))) @[ALU.scala 81:27]
                    io.ALUout <= _io_ALUout_T_24 @[ALU.scala 81:21]
                  else :
                    node _T_10 = eq(UInt<2>("h3"), io.funct3) @[ALU.scala 53:22]
                    when _T_10 : @[ALU.scala 53:22]
                      node _io_ALUout_T_25 = asUInt(io.operand1) @[ALU.scala 84:37]
                      node _io_ALUout_T_26 = asUInt(io.operand2) @[ALU.scala 84:55]
                      node _io_ALUout_T_27 = lt(_io_ALUout_T_25, _io_ALUout_T_26) @[ALU.scala 84:44]
                      node _io_ALUout_T_28 = mux(_io_ALUout_T_27, asSInt(UInt<2>("h1")), asSInt(UInt<1>("h0"))) @[ALU.scala 84:27]
                      io.ALUout <= _io_ALUout_T_28 @[ALU.scala 84:21]
    else :
      node _T_11 = eq(UInt<2>("h2"), io.group) @[ALU.scala 51:17]
      when _T_11 : @[ALU.scala 51:17]
        node _io_rdAddr_T = add(io.operand1, io.imm) @[ALU.scala 89:30]
        node _io_rdAddr_T_1 = tail(_io_rdAddr_T, 1) @[ALU.scala 89:30]
        node _io_rdAddr_T_2 = asSInt(_io_rdAddr_T_1) @[ALU.scala 89:30]
        node _io_rdAddr_T_3 = bits(_io_rdAddr_T_2, 9, 0) @[ALU.scala 89:36]
        io.rdAddr <= _io_rdAddr_T_3 @[ALU.scala 89:17]
        io.rdEna <= UInt<1>("h1") @[ALU.scala 90:16]
        node _T_12 = eq(UInt<1>("h0"), io.funct3) @[ALU.scala 91:22]
        when _T_12 : @[ALU.scala 91:22]
          io.memOp <= UInt<1>("h1") @[ALU.scala 94:20]
        else :
          node _T_13 = eq(UInt<1>("h1"), io.funct3) @[ALU.scala 91:22]
          when _T_13 : @[ALU.scala 91:22]
            io.memOp <= UInt<2>("h2") @[ALU.scala 97:20]
          else :
            node _T_14 = eq(UInt<2>("h2"), io.funct3) @[ALU.scala 91:22]
            when _T_14 : @[ALU.scala 91:22]
              io.memOp <= UInt<2>("h3") @[ALU.scala 100:20]
            else :
              node _T_15 = eq(UInt<3>("h4"), io.funct3) @[ALU.scala 91:22]
              when _T_15 : @[ALU.scala 91:22]
                io.memOp <= UInt<3>("h4") @[ALU.scala 103:20]
              else :
                node _T_16 = eq(UInt<3>("h5"), io.funct3) @[ALU.scala 91:22]
                when _T_16 : @[ALU.scala 91:22]
                  io.memOp <= UInt<3>("h5") @[ALU.scala 106:20]
      else :
        node _T_17 = eq(UInt<2>("h3"), io.group) @[ALU.scala 51:17]
        when _T_17 : @[ALU.scala 51:17]
          io.ALUout <= io.operand2 @[ALU.scala 111:17]
          node _io_wrAddr_T = add(io.operand1, io.imm) @[ALU.scala 112:30]
          node _io_wrAddr_T_1 = tail(_io_wrAddr_T, 1) @[ALU.scala 112:30]
          node _io_wrAddr_T_2 = asSInt(_io_wrAddr_T_1) @[ALU.scala 112:30]
          node _io_wrAddr_T_3 = bits(_io_wrAddr_T_2, 9, 0) @[ALU.scala 112:36]
          io.wrAddr <= _io_wrAddr_T_3 @[ALU.scala 112:17]
          io.wrEna <= UInt<1>("h1") @[ALU.scala 113:16]
          node _T_18 = eq(UInt<1>("h0"), io.funct3) @[ALU.scala 114:22]
          when _T_18 : @[ALU.scala 114:22]
            io.memOp <= UInt<1>("h1") @[ALU.scala 116:20]
          else :
            node _T_19 = eq(UInt<1>("h1"), io.funct3) @[ALU.scala 114:22]
            when _T_19 : @[ALU.scala 114:22]
              io.memOp <= UInt<2>("h2") @[ALU.scala 119:20]
            else :
              node _T_20 = eq(UInt<2>("h2"), io.funct3) @[ALU.scala 114:22]
              when _T_20 : @[ALU.scala 114:22]
                io.memOp <= UInt<2>("h3") @[ALU.scala 122:20]
        else :
          node _T_21 = eq(UInt<3>("h4"), io.group) @[ALU.scala 51:17]
          when _T_21 : @[ALU.scala 51:17]
            node _T_22 = eq(UInt<1>("h0"), io.funct3) @[ALU.scala 127:22]
            when _T_22 : @[ALU.scala 127:22]
              node _T_23 = eq(io.operand1, io.operand2) @[ALU.scala 129:25]
              when _T_23 : @[ALU.scala 129:39]
                node _io_branchEnable_T = gt(cntReg, UInt<1>("h0")) @[ALU.scala 130:43]
                node _io_branchEnable_T_1 = mux(_io_branchEnable_T, UInt<1>("h0"), UInt<1>("h1")) @[ALU.scala 130:35]
                io.branchEnable <= _io_branchEnable_T_1 @[ALU.scala 130:29]
                node _io_branchOut_T = add(io.pcIn, io.imm) @[ALU.scala 131:35]
                node _io_branchOut_T_1 = tail(_io_branchOut_T, 1) @[ALU.scala 131:35]
                node _io_branchOut_T_2 = asSInt(_io_branchOut_T_1) @[ALU.scala 131:35]
                node _io_branchOut_T_3 = sub(_io_branchOut_T_2, asSInt(UInt<4>("h4"))) @[ALU.scala 131:41]
                node _io_branchOut_T_4 = tail(_io_branchOut_T_3, 1) @[ALU.scala 131:41]
                node _io_branchOut_T_5 = asSInt(_io_branchOut_T_4) @[ALU.scala 131:41]
                io.branchOut <= _io_branchOut_T_5 @[ALU.scala 131:26]
            else :
              node _T_24 = eq(UInt<1>("h1"), io.funct3) @[ALU.scala 127:22]
              when _T_24 : @[ALU.scala 127:22]
                node _T_25 = neq(io.operand1, io.operand2) @[ALU.scala 135:25]
                when _T_25 : @[ALU.scala 135:39]
                  io.branchEnable <= UInt<1>("h1") @[ALU.scala 136:29]
                  node _io_branchOut_T_6 = add(io.pcIn, io.imm) @[ALU.scala 137:35]
                  node _io_branchOut_T_7 = tail(_io_branchOut_T_6, 1) @[ALU.scala 137:35]
                  node _io_branchOut_T_8 = asSInt(_io_branchOut_T_7) @[ALU.scala 137:35]
                  node _io_branchOut_T_9 = sub(_io_branchOut_T_8, asSInt(UInt<4>("h4"))) @[ALU.scala 137:41]
                  node _io_branchOut_T_10 = tail(_io_branchOut_T_9, 1) @[ALU.scala 137:41]
                  node _io_branchOut_T_11 = asSInt(_io_branchOut_T_10) @[ALU.scala 137:41]
                  io.branchOut <= _io_branchOut_T_11 @[ALU.scala 137:26]
              else :
                node _T_26 = eq(UInt<3>("h4"), io.funct3) @[ALU.scala 127:22]
                when _T_26 : @[ALU.scala 127:22]
                  node _T_27 = lt(io.operand1, io.operand2) @[ALU.scala 142:25]
                  when _T_27 : @[ALU.scala 142:37]
                    io.branchEnable <= UInt<1>("h1") @[ALU.scala 143:29]
                    node _io_branchOut_T_12 = add(io.pcIn, io.imm) @[ALU.scala 144:35]
                    node _io_branchOut_T_13 = tail(_io_branchOut_T_12, 1) @[ALU.scala 144:35]
                    node _io_branchOut_T_14 = asSInt(_io_branchOut_T_13) @[ALU.scala 144:35]
                    node _io_branchOut_T_15 = sub(_io_branchOut_T_14, asSInt(UInt<4>("h4"))) @[ALU.scala 144:41]
                    node _io_branchOut_T_16 = tail(_io_branchOut_T_15, 1) @[ALU.scala 144:41]
                    node _io_branchOut_T_17 = asSInt(_io_branchOut_T_16) @[ALU.scala 144:41]
                    io.branchOut <= _io_branchOut_T_17 @[ALU.scala 144:26]
                else :
                  node _T_28 = eq(UInt<3>("h5"), io.funct3) @[ALU.scala 127:22]
                  when _T_28 : @[ALU.scala 127:22]
                    node _T_29 = geq(io.operand1, io.operand2) @[ALU.scala 148:25]
                    when _T_29 : @[ALU.scala 148:38]
                      io.branchEnable <= UInt<1>("h1") @[ALU.scala 149:29]
                      node _io_branchOut_T_18 = add(io.pcIn, io.imm) @[ALU.scala 150:35]
                      node _io_branchOut_T_19 = tail(_io_branchOut_T_18, 1) @[ALU.scala 150:35]
                      node _io_branchOut_T_20 = asSInt(_io_branchOut_T_19) @[ALU.scala 150:35]
                      node _io_branchOut_T_21 = sub(_io_branchOut_T_20, asSInt(UInt<4>("h4"))) @[ALU.scala 150:41]
                      node _io_branchOut_T_22 = tail(_io_branchOut_T_21, 1) @[ALU.scala 150:41]
                      node _io_branchOut_T_23 = asSInt(_io_branchOut_T_22) @[ALU.scala 150:41]
                      io.branchOut <= _io_branchOut_T_23 @[ALU.scala 150:26]
                  else :
                    node _T_30 = eq(UInt<3>("h6"), io.funct3) @[ALU.scala 127:22]
                    when _T_30 : @[ALU.scala 127:22]
                      node _T_31 = lt(io.operand1, io.operand2) @[ALU.scala 155:25]
                      when _T_31 : @[ALU.scala 155:37]
                        io.branchEnable <= UInt<1>("h1") @[ALU.scala 156:29]
                        node _io_branchOut_T_24 = add(io.pcIn, io.imm) @[ALU.scala 157:35]
                        node _io_branchOut_T_25 = tail(_io_branchOut_T_24, 1) @[ALU.scala 157:35]
                        node _io_branchOut_T_26 = asSInt(_io_branchOut_T_25) @[ALU.scala 157:35]
                        node _io_branchOut_T_27 = sub(_io_branchOut_T_26, asSInt(UInt<4>("h4"))) @[ALU.scala 157:41]
                        node _io_branchOut_T_28 = tail(_io_branchOut_T_27, 1) @[ALU.scala 157:41]
                        node _io_branchOut_T_29 = asSInt(_io_branchOut_T_28) @[ALU.scala 157:41]
                        io.branchOut <= _io_branchOut_T_29 @[ALU.scala 157:26]
                    else :
                      node _T_32 = eq(UInt<3>("h7"), io.funct3) @[ALU.scala 127:22]
                      when _T_32 : @[ALU.scala 127:22]
                        node _T_33 = asUInt(io.operand1) @[ALU.scala 161:25]
                        node _T_34 = asUInt(io.operand2) @[ALU.scala 161:44]
                        node _T_35 = geq(_T_33, _T_34) @[ALU.scala 161:32]
                        when _T_35 : @[ALU.scala 161:52]
                          io.branchEnable <= UInt<1>("h1") @[ALU.scala 162:29]
                          node _io_branchOut_T_30 = add(io.pcIn, io.imm) @[ALU.scala 163:35]
                          node _io_branchOut_T_31 = tail(_io_branchOut_T_30, 1) @[ALU.scala 163:35]
                          node _io_branchOut_T_32 = asSInt(_io_branchOut_T_31) @[ALU.scala 163:35]
                          node _io_branchOut_T_33 = sub(_io_branchOut_T_32, asSInt(UInt<4>("h4"))) @[ALU.scala 163:41]
                          node _io_branchOut_T_34 = tail(_io_branchOut_T_33, 1) @[ALU.scala 163:41]
                          node _io_branchOut_T_35 = asSInt(_io_branchOut_T_34) @[ALU.scala 163:41]
                          io.branchOut <= _io_branchOut_T_35 @[ALU.scala 163:26]
          else :
            node _T_36 = eq(UInt<3>("h5"), io.group) @[ALU.scala 51:17]
            when _T_36 : @[ALU.scala 51:17]
              node _io_branchOut_T_36 = add(io.pcIn, io.imm) @[ALU.scala 169:29]
              node _io_branchOut_T_37 = tail(_io_branchOut_T_36, 1) @[ALU.scala 169:29]
              node _io_branchOut_T_38 = asSInt(_io_branchOut_T_37) @[ALU.scala 169:29]
              node _io_branchOut_T_39 = sub(_io_branchOut_T_38, asSInt(UInt<4>("h4"))) @[ALU.scala 169:35]
              node _io_branchOut_T_40 = tail(_io_branchOut_T_39, 1) @[ALU.scala 169:35]
              node _io_branchOut_T_41 = asSInt(_io_branchOut_T_40) @[ALU.scala 169:35]
              io.branchOut <= _io_branchOut_T_41 @[ALU.scala 169:20]
              io.branchEnable <= UInt<1>("h1") @[ALU.scala 170:23]
              io.ALUout <= io.pcIn @[ALU.scala 171:17]
            else :
              node _T_37 = eq(UInt<3>("h6"), io.group) @[ALU.scala 51:17]
              when _T_37 : @[ALU.scala 51:17]
                io.branchEnable <= UInt<1>("h1") @[ALU.scala 174:23]
                node _io_branchOut_T_42 = add(io.operand1, io.imm) @[ALU.scala 175:32]
                node _io_branchOut_T_43 = tail(_io_branchOut_T_42, 1) @[ALU.scala 175:32]
                node _io_branchOut_T_44 = asSInt(_io_branchOut_T_43) @[ALU.scala 175:32]
                io.branchOut <= _io_branchOut_T_44 @[ALU.scala 175:20]
                io.ALUout <= io.pcIn @[ALU.scala 176:17]
              else :
                node _T_38 = eq(UInt<3>("h7"), io.group) @[ALU.scala 51:17]
                when _T_38 : @[ALU.scala 51:17]
                  node _io_ALUout_T_29 = bits(io.imm, 19, 0) @[ALU.scala 179:26]
                  node _io_ALUout_T_30 = shl(_io_ALUout_T_29, 12) @[ALU.scala 179:34]
                  node _io_ALUout_T_31 = asSInt(_io_ALUout_T_30) @[ALU.scala 179:41]
                  io.ALUout <= _io_ALUout_T_31 @[ALU.scala 179:17]
                else :
                  node _T_39 = eq(UInt<4>("h8"), io.group) @[ALU.scala 51:17]
                  when _T_39 : @[ALU.scala 51:17]
                    node _io_ALUout_T_32 = bits(io.imm, 19, 0) @[ALU.scala 182:34]
                    node _io_ALUout_T_33 = shl(_io_ALUout_T_32, 12) @[ALU.scala 182:42]
                    node _io_ALUout_T_34 = asSInt(_io_ALUout_T_33) @[ALU.scala 182:49]
                    node _io_ALUout_T_35 = add(io.pcIn, _io_ALUout_T_34) @[ALU.scala 182:26]
                    node _io_ALUout_T_36 = tail(_io_ALUout_T_35, 1) @[ALU.scala 182:26]
                    node _io_ALUout_T_37 = asSInt(_io_ALUout_T_36) @[ALU.scala 182:26]
                    io.ALUout <= _io_ALUout_T_37 @[ALU.scala 182:17]
    node _cntNext_T = geq(io.imm, asSInt(UInt<5>("hc"))) @[ALU.scala 189:50]
    node _cntNext_T_1 = and(io.branchEnable, _cntNext_T) @[ALU.scala 189:39]
    node _cntNext_T_2 = leq(io.imm, asSInt(UInt<1>("h0"))) @[ALU.scala 189:93]
    node _cntNext_T_3 = and(io.branchEnable, _cntNext_T_2) @[ALU.scala 189:82]
    node _cntNext_T_4 = or(_cntNext_T_1, _cntNext_T_3) @[ALU.scala 189:61]
    node _cntNext_T_5 = eq(io.imm, asSInt(UInt<5>("h8"))) @[ALU.scala 189:140]
    node _cntNext_T_6 = and(io.branchEnable, _cntNext_T_5) @[ALU.scala 189:129]
    node _cntNext_T_7 = gt(cntReg, UInt<1>("h0")) @[ALU.scala 189:166]
    node _cntNext_T_8 = sub(cntReg, UInt<1>("h1")) @[ALU.scala 189:180]
    node _cntNext_T_9 = tail(_cntNext_T_8, 1) @[ALU.scala 189:180]
    node _cntNext_T_10 = mux(_cntNext_T_7, _cntNext_T_9, UInt<1>("h0")) @[ALU.scala 189:158]
    node _cntNext_T_11 = mux(_cntNext_T_6, UInt<1>("h1"), _cntNext_T_10) @[ALU.scala 189:112]
    node cntNext = mux(_cntNext_T_4, UInt<2>("h2"), _cntNext_T_11) @[ALU.scala 189:20]
    node _rdReg_T = gt(cntReg, UInt<1>("h0")) @[ALU.scala 191:35]
    node _rdReg_T_1 = mux(_rdReg_T, UInt<1>("h0"), io.rdIn) @[ALU.scala 191:26]
    reg rdReg : UInt, clock with :
      reset => (UInt<1>("h0"), rdReg) @[ALU.scala 191:22]
    rdReg <= _rdReg_T_1 @[ALU.scala 191:22]
    node _cntNext2_T = gt(cntNext, UInt<1>("h0")) @[ALU.scala 193:30]
    node _cntNext2_T_1 = sub(cntNext, UInt<1>("h1")) @[ALU.scala 193:45]
    node _cntNext2_T_2 = tail(_cntNext2_T_1, 1) @[ALU.scala 193:45]
    node cntNext2 = mux(_cntNext2_T, _cntNext2_T_2, cntNext) @[ALU.scala 193:21]
    cntReg <= cntNext2 @[ALU.scala 195:10]
    reg rdJarReg : UInt, clock with :
      reset => (UInt<1>("h0"), rdJarReg) @[ALU.scala 198:25]
    rdJarReg <= io.rdIn @[ALU.scala 198:25]
    node _io_rdOut_T = eq(io.group, UInt<3>("h6")) @[ALU.scala 199:25]
    node _io_rdOut_T_1 = eq(io.group, UInt<3>("h5")) @[ALU.scala 199:42]
    node _io_rdOut_T_2 = or(_io_rdOut_T, _io_rdOut_T_1) @[ALU.scala 199:33]
    node _io_rdOut_T_3 = mux(_io_rdOut_T_2, rdJarReg, rdReg) @[ALU.scala 199:18]
    io.rdOut <= _io_rdOut_T_3 @[ALU.scala 199:12]

  module Memorizer :
    input clock : Clock
    input reset : Reset
    output io : { flip ALUinput : SInt<32>, flip rdInput : UInt<5>, flip rdAddr : UInt<10>, flip wrAddr : UInt<10>, flip wrData : UInt<32>, flip wrEna : UInt<1>, flip rdEna : UInt<1>, flip memOp : UInt<3>, rdLastRegMemOut : UInt<5>, aluLastRegMemOut : SInt<32>, rdLoadRegMemOut : UInt<5>, aluLoadRegMemOut : SInt<32>, loadEnabler : UInt<1>, rdData : SInt<32>, rdEnaOut : UInt<1>, wrEnaOut : UInt<1>, rdOutput : UInt<5>, ALUoutput : SInt<32>}

    reg rdReg : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[Memorizer.scala 30:22]
    rdReg <= io.rdInput @[Memorizer.scala 30:22]
    reg ALUreg : SInt, clock with :
      reset => (reset, asSInt(UInt<1>("h0"))) @[Memorizer.scala 31:23]
    ALUreg <= io.ALUinput @[Memorizer.scala 31:23]
    io.rdOutput <= rdReg @[Memorizer.scala 32:15]
    io.ALUoutput <= ALUreg @[Memorizer.scala 33:16]
    reg rdLastRegMem : UInt<5>, clock with :
      reset => (reset, UInt<5>("h0")) @[Memorizer.scala 36:29]
    reg aluLastRegMem : SInt<32>, clock with :
      reset => (reset, asSInt(UInt<32>("h0"))) @[Memorizer.scala 37:30]
    rdLastRegMem <= io.rdOutput @[Memorizer.scala 39:16]
    aluLastRegMem <= io.ALUoutput @[Memorizer.scala 40:17]
    io.rdLastRegMemOut <= rdLastRegMem @[Memorizer.scala 41:22]
    io.aluLastRegMemOut <= aluLastRegMem @[Memorizer.scala 42:23]
    reg wrEnaReg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[Memorizer.scala 44:25]
    wrEnaReg <= io.wrEna @[Memorizer.scala 44:25]
    reg rdEnaReg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[Memorizer.scala 45:25]
    rdEnaReg <= io.rdEna @[Memorizer.scala 45:25]
    reg wrDataReg : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[Memorizer.scala 46:26]
    wrDataReg <= io.wrData @[Memorizer.scala 46:26]
    reg wrAddrReg : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[Memorizer.scala 47:26]
    wrAddrReg <= io.wrAddr @[Memorizer.scala 47:26]
    reg memOpReg : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[Memorizer.scala 48:25]
    memOpReg <= io.memOp @[Memorizer.scala 48:25]
    smem mem_0 : UInt<8> [1024] @[Memorizer.scala 50:16]
    smem mem_1 : UInt<8> [1024] @[Memorizer.scala 50:16]
    smem mem_2 : UInt<8> [1024] @[Memorizer.scala 50:16]
    smem mem_3 : UInt<8> [1024] @[Memorizer.scala 50:16]
    io.wrEnaOut <= wrEnaReg @[Memorizer.scala 52:15]
    io.rdEnaOut <= rdEnaReg @[Memorizer.scala 53:15]
    node readAddress = shr(io.rdAddr, 2) @[Memorizer.scala 55:31]
    node writeAddress = shr(wrAddrReg, 2) @[Memorizer.scala 56:32]
    node _offset_T = bits(io.rdAddr, 1, 0) @[Memorizer.scala 58:33]
    reg offset : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[Memorizer.scala 58:23]
    offset <= _offset_T @[Memorizer.scala 58:23]
    node writeByte_0 = bits(wrDataReg, 7, 0) @[Memorizer.scala 60:14]
    node writeByte_1 = bits(wrDataReg, 15, 8) @[Memorizer.scala 61:14]
    node writeByte_2 = bits(wrDataReg, 23, 16) @[Memorizer.scala 62:14]
    node writeByte_3 = bits(wrDataReg, 31, 24) @[Memorizer.scala 63:14]
    wire _readByte_WIRE : UInt @[Memorizer.scala 66:16]
    _readByte_WIRE is invalid @[Memorizer.scala 66:16]
    when UInt<1>("h1") : @[Memorizer.scala 66:16]
      _readByte_WIRE <= readAddress @[Memorizer.scala 66:16]
      node _readByte_T = or(_readByte_WIRE, UInt<10>("h0")) @[Memorizer.scala 66:16]
      node _readByte_T_1 = bits(_readByte_T, 9, 0) @[Memorizer.scala 66:16]
      read mport readByte_0 = mem_0[_readByte_T_1], clock @[Memorizer.scala 66:16]
    wire _readByte_WIRE_1 : UInt @[Memorizer.scala 67:16]
    _readByte_WIRE_1 is invalid @[Memorizer.scala 67:16]
    when UInt<1>("h1") : @[Memorizer.scala 67:16]
      _readByte_WIRE_1 <= readAddress @[Memorizer.scala 67:16]
      node _readByte_T_2 = or(_readByte_WIRE_1, UInt<10>("h0")) @[Memorizer.scala 67:16]
      node _readByte_T_3 = bits(_readByte_T_2, 9, 0) @[Memorizer.scala 67:16]
      read mport readByte_1 = mem_1[_readByte_T_3], clock @[Memorizer.scala 67:16]
    wire _readByte_WIRE_2 : UInt @[Memorizer.scala 68:16]
    _readByte_WIRE_2 is invalid @[Memorizer.scala 68:16]
    when UInt<1>("h1") : @[Memorizer.scala 68:16]
      _readByte_WIRE_2 <= readAddress @[Memorizer.scala 68:16]
      node _readByte_T_4 = or(_readByte_WIRE_2, UInt<10>("h0")) @[Memorizer.scala 68:16]
      node _readByte_T_5 = bits(_readByte_T_4, 9, 0) @[Memorizer.scala 68:16]
      read mport readByte_2 = mem_2[_readByte_T_5], clock @[Memorizer.scala 68:16]
    wire _readByte_WIRE_3 : UInt @[Memorizer.scala 69:16]
    _readByte_WIRE_3 is invalid @[Memorizer.scala 69:16]
    when UInt<1>("h1") : @[Memorizer.scala 69:16]
      _readByte_WIRE_3 <= readAddress @[Memorizer.scala 69:16]
      node _readByte_T_6 = or(_readByte_WIRE_3, UInt<10>("h0")) @[Memorizer.scala 69:16]
      node _readByte_T_7 = bits(_readByte_T_6, 9, 0) @[Memorizer.scala 69:16]
      read mport readByte_3 = mem_3[_readByte_T_7], clock @[Memorizer.scala 69:16]
    io.rdData <= asSInt(UInt<1>("h0")) @[Memorizer.scala 72:13]
    io.rdLoadRegMemOut <= UInt<1>("h0") @[Memorizer.scala 73:22]
    io.aluLoadRegMemOut <= asSInt(UInt<1>("h0")) @[Memorizer.scala 74:23]
    node _T = eq(UInt<1>("h0"), memOpReg) @[Memorizer.scala 76:20]
    when _T : @[Memorizer.scala 76:20]
      io.rdData <= asSInt(UInt<15>("h270f")) @[Memorizer.scala 78:17]
    else :
      node _T_1 = eq(UInt<1>("h1"), memOpReg) @[Memorizer.scala 76:20]
      when _T_1 : @[Memorizer.scala 76:20]
        node _T_2 = eq(offset, UInt<1>("h0")) @[Memorizer.scala 82:21]
        when _T_2 : @[Memorizer.scala 82:30]
          node _io_rdData_T = asSInt(readByte_0) @[Memorizer.scala 83:36]
          io.rdData <= _io_rdData_T @[Memorizer.scala 83:21]
          when wrEnaReg : @[Memorizer.scala 85:26]
            node _T_3 = or(writeAddress, UInt<10>("h0"))
            node _T_4 = bits(_T_3, 9, 0)
            write mport MPORT = mem_0[_T_4], clock
            MPORT <= writeByte_0
        node _T_5 = eq(offset, UInt<1>("h1")) @[Memorizer.scala 82:21]
        when _T_5 : @[Memorizer.scala 82:30]
          node _io_rdData_T_1 = asSInt(readByte_1) @[Memorizer.scala 83:36]
          io.rdData <= _io_rdData_T_1 @[Memorizer.scala 83:21]
          when wrEnaReg : @[Memorizer.scala 85:26]
            node _T_6 = or(writeAddress, UInt<10>("h0"))
            node _T_7 = bits(_T_6, 9, 0)
            write mport MPORT_1 = mem_1[_T_7], clock
            MPORT_1 <= writeByte_0
        node _T_8 = eq(offset, UInt<2>("h2")) @[Memorizer.scala 82:21]
        when _T_8 : @[Memorizer.scala 82:30]
          node _io_rdData_T_2 = asSInt(readByte_2) @[Memorizer.scala 83:36]
          io.rdData <= _io_rdData_T_2 @[Memorizer.scala 83:21]
          when wrEnaReg : @[Memorizer.scala 85:26]
            node _T_9 = or(writeAddress, UInt<10>("h0"))
            node _T_10 = bits(_T_9, 9, 0)
            write mport MPORT_2 = mem_2[_T_10], clock
            MPORT_2 <= writeByte_0
        node _T_11 = eq(offset, UInt<2>("h3")) @[Memorizer.scala 82:21]
        when _T_11 : @[Memorizer.scala 82:30]
          node _io_rdData_T_3 = asSInt(readByte_3) @[Memorizer.scala 83:36]
          io.rdData <= _io_rdData_T_3 @[Memorizer.scala 83:21]
          when wrEnaReg : @[Memorizer.scala 85:26]
            node _T_12 = or(writeAddress, UInt<10>("h0"))
            node _T_13 = bits(_T_12, 9, 0)
            write mport MPORT_3 = mem_3[_T_13], clock
            MPORT_3 <= writeByte_0
      else :
        node _T_14 = eq(UInt<2>("h2"), memOpReg) @[Memorizer.scala 76:20]
        when _T_14 : @[Memorizer.scala 76:20]
          node _T_15 = eq(offset, UInt<1>("h0")) @[Memorizer.scala 93:21]
          when _T_15 : @[Memorizer.scala 93:30]
            node _io_rdData_T_4 = cat(readByte_1, readByte_0) @[Cat.scala 33:92]
            node _io_rdData_T_5 = asSInt(_io_rdData_T_4) @[Memorizer.scala 94:58]
            io.rdData <= _io_rdData_T_5 @[Memorizer.scala 94:21]
            when wrEnaReg : @[Memorizer.scala 96:26]
              node _T_16 = or(writeAddress, UInt<10>("h0"))
              node _T_17 = bits(_T_16, 9, 0)
              write mport MPORT_4 = mem_0[_T_17], clock
              MPORT_4 <= writeByte_0
              node _T_18 = or(writeAddress, UInt<10>("h0"))
              node _T_19 = bits(_T_18, 9, 0)
              write mport MPORT_5 = mem_1[_T_19], clock
              MPORT_5 <= writeByte_1
          node _T_20 = eq(offset, UInt<1>("h1")) @[Memorizer.scala 93:21]
          when _T_20 : @[Memorizer.scala 93:30]
            node _io_rdData_T_6 = cat(readByte_2, readByte_1) @[Cat.scala 33:92]
            node _io_rdData_T_7 = asSInt(_io_rdData_T_6) @[Memorizer.scala 94:58]
            io.rdData <= _io_rdData_T_7 @[Memorizer.scala 94:21]
            when wrEnaReg : @[Memorizer.scala 96:26]
              node _T_21 = or(writeAddress, UInt<10>("h0"))
              node _T_22 = bits(_T_21, 9, 0)
              write mport MPORT_6 = mem_1[_T_22], clock
              MPORT_6 <= writeByte_0
              node _T_23 = or(writeAddress, UInt<10>("h0"))
              node _T_24 = bits(_T_23, 9, 0)
              write mport MPORT_7 = mem_2[_T_24], clock
              MPORT_7 <= writeByte_1
          node _T_25 = eq(offset, UInt<2>("h2")) @[Memorizer.scala 93:21]
          when _T_25 : @[Memorizer.scala 93:30]
            node _io_rdData_T_8 = cat(readByte_3, readByte_2) @[Cat.scala 33:92]
            node _io_rdData_T_9 = asSInt(_io_rdData_T_8) @[Memorizer.scala 94:58]
            io.rdData <= _io_rdData_T_9 @[Memorizer.scala 94:21]
            when wrEnaReg : @[Memorizer.scala 96:26]
              node _T_26 = or(writeAddress, UInt<10>("h0"))
              node _T_27 = bits(_T_26, 9, 0)
              write mport MPORT_8 = mem_2[_T_27], clock
              MPORT_8 <= writeByte_0
              node _T_28 = or(writeAddress, UInt<10>("h0"))
              node _T_29 = bits(_T_28, 9, 0)
              write mport MPORT_9 = mem_3[_T_29], clock
              MPORT_9 <= writeByte_1
        else :
          node _T_30 = eq(UInt<2>("h3"), memOpReg) @[Memorizer.scala 76:20]
          when _T_30 : @[Memorizer.scala 76:20]
            node io_rdData_lo = cat(readByte_1, readByte_0) @[Cat.scala 33:92]
            node io_rdData_hi = cat(readByte_3, readByte_2) @[Cat.scala 33:92]
            node _io_rdData_T_10 = cat(io_rdData_hi, io_rdData_lo) @[Cat.scala 33:92]
            node _io_rdData_T_11 = asSInt(_io_rdData_T_10) @[Memorizer.scala 104:76]
            io.rdData <= _io_rdData_T_11 @[Memorizer.scala 104:17]
            when wrEnaReg : @[Memorizer.scala 106:22]
              node _T_31 = or(writeAddress, UInt<10>("h0"))
              node _T_32 = bits(_T_31, 9, 0)
              write mport MPORT_10 = mem_0[_T_32], clock
              MPORT_10 <= writeByte_0
              node _T_33 = or(writeAddress, UInt<10>("h0"))
              node _T_34 = bits(_T_33, 9, 0)
              write mport MPORT_11 = mem_1[_T_34], clock
              MPORT_11 <= writeByte_1
              node _T_35 = or(writeAddress, UInt<10>("h0"))
              node _T_36 = bits(_T_35, 9, 0)
              write mport MPORT_12 = mem_2[_T_36], clock
              MPORT_12 <= writeByte_2
              node _T_37 = or(writeAddress, UInt<10>("h0"))
              node _T_38 = bits(_T_37, 9, 0)
              write mport MPORT_13 = mem_3[_T_38], clock
              MPORT_13 <= writeByte_3
          else :
            node _T_39 = eq(UInt<3>("h4"), memOpReg) @[Memorizer.scala 76:20]
            when _T_39 : @[Memorizer.scala 76:20]
              node _T_40 = eq(offset, UInt<1>("h0")) @[Memorizer.scala 115:21]
              when _T_40 : @[Memorizer.scala 115:30]
                node _io_rdData_T_12 = cat(UInt<24>("h0"), readByte_0) @[Cat.scala 33:92]
                node _io_rdData_T_13 = asSInt(_io_rdData_T_12) @[Memorizer.scala 116:52]
                io.rdData <= _io_rdData_T_13 @[Memorizer.scala 116:21]
              node _T_41 = eq(offset, UInt<1>("h1")) @[Memorizer.scala 115:21]
              when _T_41 : @[Memorizer.scala 115:30]
                node _io_rdData_T_14 = cat(UInt<24>("h0"), readByte_1) @[Cat.scala 33:92]
                node _io_rdData_T_15 = asSInt(_io_rdData_T_14) @[Memorizer.scala 116:52]
                io.rdData <= _io_rdData_T_15 @[Memorizer.scala 116:21]
              node _T_42 = eq(offset, UInt<2>("h2")) @[Memorizer.scala 115:21]
              when _T_42 : @[Memorizer.scala 115:30]
                node _io_rdData_T_16 = cat(UInt<24>("h0"), readByte_2) @[Cat.scala 33:92]
                node _io_rdData_T_17 = asSInt(_io_rdData_T_16) @[Memorizer.scala 116:52]
                io.rdData <= _io_rdData_T_17 @[Memorizer.scala 116:21]
              node _T_43 = eq(offset, UInt<2>("h3")) @[Memorizer.scala 115:21]
              when _T_43 : @[Memorizer.scala 115:30]
                node _io_rdData_T_18 = cat(UInt<24>("h0"), readByte_3) @[Cat.scala 33:92]
                node _io_rdData_T_19 = asSInt(_io_rdData_T_18) @[Memorizer.scala 116:52]
                io.rdData <= _io_rdData_T_19 @[Memorizer.scala 116:21]
            else :
              node _T_44 = eq(UInt<3>("h5"), memOpReg) @[Memorizer.scala 76:20]
              when _T_44 : @[Memorizer.scala 76:20]
                node _T_45 = eq(offset, UInt<1>("h0")) @[Memorizer.scala 122:21]
                when _T_45 : @[Memorizer.scala 122:30]
                  node io_rdData_hi_1 = cat(UInt<16>("h0"), readByte_1) @[Cat.scala 33:92]
                  node _io_rdData_T_20 = cat(io_rdData_hi_1, readByte_0) @[Cat.scala 33:92]
                  node _io_rdData_T_21 = asSInt(_io_rdData_T_20) @[Memorizer.scala 123:69]
                  io.rdData <= _io_rdData_T_21 @[Memorizer.scala 123:21]
                node _T_46 = eq(offset, UInt<1>("h1")) @[Memorizer.scala 122:21]
                when _T_46 : @[Memorizer.scala 122:30]
                  node io_rdData_hi_2 = cat(UInt<16>("h0"), readByte_2) @[Cat.scala 33:92]
                  node _io_rdData_T_22 = cat(io_rdData_hi_2, readByte_1) @[Cat.scala 33:92]
                  node _io_rdData_T_23 = asSInt(_io_rdData_T_22) @[Memorizer.scala 123:69]
                  io.rdData <= _io_rdData_T_23 @[Memorizer.scala 123:21]
                node _T_47 = eq(offset, UInt<2>("h2")) @[Memorizer.scala 122:21]
                when _T_47 : @[Memorizer.scala 122:30]
                  node io_rdData_hi_3 = cat(UInt<16>("h0"), readByte_3) @[Cat.scala 33:92]
                  node _io_rdData_T_24 = cat(io_rdData_hi_3, readByte_2) @[Cat.scala 33:92]
                  node _io_rdData_T_25 = asSInt(_io_rdData_T_24) @[Memorizer.scala 123:69]
                  io.rdData <= _io_rdData_T_25 @[Memorizer.scala 123:21]
    reg rdLoadRegger : UInt<5>, clock with :
      reset => (reset, UInt<5>("h0")) @[Memorizer.scala 128:29]
    reg aluLoadRegger : SInt<32>, clock with :
      reset => (reset, asSInt(UInt<32>("h0"))) @[Memorizer.scala 129:30]
    reg enabler : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[Memorizer.scala 130:24]
    enabler <= rdEnaReg @[Memorizer.scala 131:11]
    io.loadEnabler <= enabler @[Memorizer.scala 132:18]
    rdLoadRegger <= rdReg @[Memorizer.scala 133:16]
    aluLoadRegger <= io.rdData @[Memorizer.scala 134:17]
    io.rdLoadRegMemOut <= rdLoadRegger @[Memorizer.scala 135:22]
    io.aluLoadRegMemOut <= aluLoadRegger @[Memorizer.scala 136:23]

  module Write_backer :
    input clock : Clock
    input reset : Reset
    output io : { flip ALUinput : SInt<32>, ALUoutput : SInt<32>, flip rdInput : UInt<5>, rdOut : UInt<5>, flip rdEnaIn : UInt<1>, flip wrEnaIn : UInt<1>, flip rdData : SInt<32>}

    reg rdReg : UInt<5>, clock with :
      reset => (reset, UInt<5>("h0")) @[Write_backer.scala 15:22]
    reg ALUreg : SInt<32>, clock with :
      reset => (reset, asSInt(UInt<32>("h0"))) @[Write_backer.scala 16:23]
    reg rdDataReg : SInt<32>, clock with :
      reset => (reset, asSInt(UInt<32>("h0"))) @[Write_backer.scala 17:26]
    reg rdEnaInReg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[Write_backer.scala 18:27]
    reg wrEnaInReg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[Write_backer.scala 19:27]
    rdReg <= io.rdInput @[Write_backer.scala 21:9]
    ALUreg <= io.ALUinput @[Write_backer.scala 22:10]
    rdDataReg <= io.rdData @[Write_backer.scala 23:13]
    rdEnaInReg <= io.rdEnaIn @[Write_backer.scala 24:14]
    wrEnaInReg <= io.wrEnaIn @[Write_backer.scala 25:14]
    node _io_ALUoutput_T = mux(rdEnaInReg, rdDataReg, ALUreg) @[Write_backer.scala 28:22]
    io.ALUoutput <= _io_ALUoutput_T @[Write_backer.scala 28:16]
    io.rdOut <= rdReg @[Write_backer.scala 29:12]
    node _T = eq(rdReg, UInt<1>("h0")) @[Write_backer.scala 31:28]
    node _T_1 = or(wrEnaInReg, _T) @[Write_backer.scala 31:19]
    when _T_1 : @[Write_backer.scala 31:37]
      io.ALUoutput <= asSInt(UInt<1>("h0")) @[Write_backer.scala 32:18]
      io.rdOut <= UInt<1>("h0") @[Write_backer.scala 33:14]


  module SevSeg :
    input clock : Clock
    input reset : Reset
    output io : { flip in : UInt<4>, out : UInt<7>}

    wire sevSeg : UInt @[SevSeg.scala 10:27]
    sevSeg <= UInt<1>("h0") @[SevSeg.scala 10:27]
    node _T = eq(UInt<1>("h0"), io.in) @[SevSeg.scala 14:17]
    when _T : @[SevSeg.scala 14:17]
      sevSeg <= UInt<6>("h3f") @[SevSeg.scala 15:21]
    else :
      node _T_1 = eq(UInt<1>("h1"), io.in) @[SevSeg.scala 14:17]
      when _T_1 : @[SevSeg.scala 14:17]
        sevSeg <= UInt<3>("h6") @[SevSeg.scala 16:21]
      else :
        node _T_2 = eq(UInt<2>("h2"), io.in) @[SevSeg.scala 14:17]
        when _T_2 : @[SevSeg.scala 14:17]
          sevSeg <= UInt<7>("h5b") @[SevSeg.scala 17:21]
        else :
          node _T_3 = eq(UInt<2>("h3"), io.in) @[SevSeg.scala 14:17]
          when _T_3 : @[SevSeg.scala 14:17]
            sevSeg <= UInt<7>("h4f") @[SevSeg.scala 18:21]
          else :
            node _T_4 = eq(UInt<3>("h4"), io.in) @[SevSeg.scala 14:17]
            when _T_4 : @[SevSeg.scala 14:17]
              sevSeg <= UInt<7>("h66") @[SevSeg.scala 19:21]
            else :
              node _T_5 = eq(UInt<3>("h5"), io.in) @[SevSeg.scala 14:17]
              when _T_5 : @[SevSeg.scala 14:17]
                sevSeg <= UInt<7>("h6d") @[SevSeg.scala 20:21]
              else :
                node _T_6 = eq(UInt<3>("h6"), io.in) @[SevSeg.scala 14:17]
                when _T_6 : @[SevSeg.scala 14:17]
                  sevSeg <= UInt<7>("h7d") @[SevSeg.scala 21:21]
                else :
                  node _T_7 = eq(UInt<3>("h7"), io.in) @[SevSeg.scala 14:17]
                  when _T_7 : @[SevSeg.scala 14:17]
                    sevSeg <= UInt<3>("h7") @[SevSeg.scala 22:21]
                  else :
                    node _T_8 = eq(UInt<4>("h8"), io.in) @[SevSeg.scala 14:17]
                    when _T_8 : @[SevSeg.scala 14:17]
                      sevSeg <= UInt<7>("h7f") @[SevSeg.scala 23:21]
                    else :
                      node _T_9 = eq(UInt<4>("h9"), io.in) @[SevSeg.scala 14:17]
                      when _T_9 : @[SevSeg.scala 14:17]
                        sevSeg <= UInt<7>("h67") @[SevSeg.scala 24:21]
                      else :
                        node _T_10 = eq(UInt<4>("ha"), io.in) @[SevSeg.scala 14:17]
                        when _T_10 : @[SevSeg.scala 14:17]
                          sevSeg <= UInt<7>("h77") @[SevSeg.scala 25:22]
                        else :
                          node _T_11 = eq(UInt<4>("hb"), io.in) @[SevSeg.scala 14:17]
                          when _T_11 : @[SevSeg.scala 14:17]
                            sevSeg <= UInt<7>("h7c") @[SevSeg.scala 26:22]
                          else :
                            node _T_12 = eq(UInt<4>("hc"), io.in) @[SevSeg.scala 14:17]
                            when _T_12 : @[SevSeg.scala 14:17]
                              sevSeg <= UInt<6>("h39") @[SevSeg.scala 27:22]
                            else :
                              node _T_13 = eq(UInt<4>("hd"), io.in) @[SevSeg.scala 14:17]
                              when _T_13 : @[SevSeg.scala 14:17]
                                sevSeg <= UInt<7>("h5e") @[SevSeg.scala 28:22]
                              else :
                                node _T_14 = eq(UInt<4>("he"), io.in) @[SevSeg.scala 14:17]
                                when _T_14 : @[SevSeg.scala 14:17]
                                  sevSeg <= UInt<7>("h79") @[SevSeg.scala 29:22]
                                else :
                                  node _T_15 = eq(UInt<4>("hf"), io.in) @[SevSeg.scala 14:17]
                                  when _T_15 : @[SevSeg.scala 14:17]
                                    sevSeg <= UInt<7>("h71") @[SevSeg.scala 30:22]
    io.out <= sevSeg @[SevSeg.scala 32:10]

  module DisplayMux :
    input clock : Clock
    input reset : Reset
    output io : { flip xReg : SInt<32>, seg : UInt<7>, an : UInt<8>}

    wire sevSeg : UInt<7> @[DisplayMux.scala 11:27]
    sevSeg <= UInt<7>("h7f") @[DisplayMux.scala 11:27]
    wire select : UInt<8> @[DisplayMux.scala 12:27]
    select <= UInt<8>("h1") @[DisplayMux.scala 12:27]
    reg cnt3_cntReg : UInt<17>, clock with :
      reset => (reset, UInt<17>("h0")) @[DisplayMux.scala 16:25]
    node _cnt3_cntReg_T = eq(cnt3_cntReg, UInt<17>("h186a0")) @[DisplayMux.scala 17:38]
    node _cnt3_cntReg_T_1 = add(cnt3_cntReg, UInt<1>("h1")) @[DisplayMux.scala 17:59]
    node _cnt3_cntReg_T_2 = tail(_cnt3_cntReg_T_1, 1) @[DisplayMux.scala 17:59]
    node _cnt3_cntReg_T_3 = mux(_cnt3_cntReg_T, UInt<1>("h0"), _cnt3_cntReg_T_2) @[DisplayMux.scala 17:30]
    node _cnt3_cntReg_T_4 = mux(UInt<1>("h1"), _cnt3_cntReg_T_3, cnt3_cntReg) @[DisplayMux.scala 17:18]
    cnt3_cntReg <= _cnt3_cntReg_T_4 @[DisplayMux.scala 17:12]
    node _cnt3_T = eq(cnt3_cntReg, UInt<17>("h186a0")) @[DisplayMux.scala 22:49]
    reg cnt3 : UInt<3>, clock with :
      reset => (reset, UInt<3>("h0")) @[DisplayMux.scala 16:25]
    node _cnt3_cntReg_T_5 = eq(cnt3, UInt<3>("h7")) @[DisplayMux.scala 17:38]
    node _cnt3_cntReg_T_6 = add(cnt3, UInt<1>("h1")) @[DisplayMux.scala 17:59]
    node _cnt3_cntReg_T_7 = tail(_cnt3_cntReg_T_6, 1) @[DisplayMux.scala 17:59]
    node _cnt3_cntReg_T_8 = mux(_cnt3_cntReg_T_5, UInt<1>("h0"), _cnt3_cntReg_T_7) @[DisplayMux.scala 17:30]
    node _cnt3_cntReg_T_9 = mux(_cnt3_T, _cnt3_cntReg_T_8, cnt3) @[DisplayMux.scala 17:18]
    cnt3 <= _cnt3_cntReg_T_9 @[DisplayMux.scala 17:12]
    inst dec of SevSeg @[DisplayMux.scala 24:19]
    dec.clock <= clock
    dec.reset <= reset
    dec.io.in <= UInt<1>("h0") @[DisplayMux.scala 27:13]
    node _T = eq(UInt<1>("h0"), cnt3) @[DisplayMux.scala 29:16]
    when _T : @[DisplayMux.scala 29:16]
      node _dec_io_in_T = bits(io.xReg, 3, 0) @[DisplayMux.scala 30:35]
      dec.io.in <= _dec_io_in_T @[DisplayMux.scala 30:25]
    else :
      node _T_1 = eq(UInt<1>("h1"), cnt3) @[DisplayMux.scala 29:16]
      when _T_1 : @[DisplayMux.scala 29:16]
        node _dec_io_in_T_1 = bits(io.xReg, 7, 4) @[DisplayMux.scala 31:35]
        dec.io.in <= _dec_io_in_T_1 @[DisplayMux.scala 31:25]
      else :
        node _T_2 = eq(UInt<2>("h2"), cnt3) @[DisplayMux.scala 29:16]
        when _T_2 : @[DisplayMux.scala 29:16]
          node _dec_io_in_T_2 = bits(io.xReg, 11, 8) @[DisplayMux.scala 32:35]
          dec.io.in <= _dec_io_in_T_2 @[DisplayMux.scala 32:25]
        else :
          node _T_3 = eq(UInt<2>("h3"), cnt3) @[DisplayMux.scala 29:16]
          when _T_3 : @[DisplayMux.scala 29:16]
            node _dec_io_in_T_3 = bits(io.xReg, 15, 12) @[DisplayMux.scala 33:35]
            dec.io.in <= _dec_io_in_T_3 @[DisplayMux.scala 33:25]
          else :
            node _T_4 = eq(UInt<3>("h4"), cnt3) @[DisplayMux.scala 29:16]
            when _T_4 : @[DisplayMux.scala 29:16]
              node _dec_io_in_T_4 = bits(io.xReg, 19, 16) @[DisplayMux.scala 34:35]
              dec.io.in <= _dec_io_in_T_4 @[DisplayMux.scala 34:25]
            else :
              node _T_5 = eq(UInt<3>("h5"), cnt3) @[DisplayMux.scala 29:16]
              when _T_5 : @[DisplayMux.scala 29:16]
                node _dec_io_in_T_5 = bits(io.xReg, 23, 20) @[DisplayMux.scala 35:35]
                dec.io.in <= _dec_io_in_T_5 @[DisplayMux.scala 35:25]
              else :
                node _T_6 = eq(UInt<3>("h6"), cnt3) @[DisplayMux.scala 29:16]
                when _T_6 : @[DisplayMux.scala 29:16]
                  node _dec_io_in_T_6 = bits(io.xReg, 27, 24) @[DisplayMux.scala 36:35]
                  dec.io.in <= _dec_io_in_T_6 @[DisplayMux.scala 36:25]
                else :
                  node _T_7 = eq(UInt<3>("h7"), cnt3) @[DisplayMux.scala 29:16]
                  when _T_7 : @[DisplayMux.scala 29:16]
                    node _dec_io_in_T_7 = bits(io.xReg, 31, 28) @[DisplayMux.scala 37:35]
                    dec.io.in <= _dec_io_in_T_7 @[DisplayMux.scala 37:25]
    sevSeg <= dec.io.out @[DisplayMux.scala 41:10]
    node _T_8 = eq(UInt<1>("h0"), cnt3) @[DisplayMux.scala 43:16]
    when _T_8 : @[DisplayMux.scala 43:16]
      select <= UInt<1>("h1") @[DisplayMux.scala 44:22]
    else :
      node _T_9 = eq(UInt<1>("h1"), cnt3) @[DisplayMux.scala 43:16]
      when _T_9 : @[DisplayMux.scala 43:16]
        select <= UInt<2>("h2") @[DisplayMux.scala 45:22]
      else :
        node _T_10 = eq(UInt<2>("h2"), cnt3) @[DisplayMux.scala 43:16]
        when _T_10 : @[DisplayMux.scala 43:16]
          select <= UInt<3>("h4") @[DisplayMux.scala 46:22]
        else :
          node _T_11 = eq(UInt<2>("h3"), cnt3) @[DisplayMux.scala 43:16]
          when _T_11 : @[DisplayMux.scala 43:16]
            select <= UInt<4>("h8") @[DisplayMux.scala 47:22]
          else :
            node _T_12 = eq(UInt<3>("h4"), cnt3) @[DisplayMux.scala 43:16]
            when _T_12 : @[DisplayMux.scala 43:16]
              select <= UInt<5>("h10") @[DisplayMux.scala 48:22]
            else :
              node _T_13 = eq(UInt<3>("h5"), cnt3) @[DisplayMux.scala 43:16]
              when _T_13 : @[DisplayMux.scala 43:16]
                select <= UInt<6>("h20") @[DisplayMux.scala 49:22]
              else :
                node _T_14 = eq(UInt<3>("h6"), cnt3) @[DisplayMux.scala 43:16]
                when _T_14 : @[DisplayMux.scala 43:16]
                  select <= UInt<7>("h40") @[DisplayMux.scala 50:22]
                else :
                  node _T_15 = eq(UInt<3>("h7"), cnt3) @[DisplayMux.scala 43:16]
                  when _T_15 : @[DisplayMux.scala 43:16]
                    select <= UInt<8>("h80") @[DisplayMux.scala 51:22]
    node _io_seg_T = not(sevSeg) @[DisplayMux.scala 55:13]
    io.seg <= _io_seg_T @[DisplayMux.scala 55:10]
    node _io_an_T = not(select) @[DisplayMux.scala 56:12]
    io.an <= _io_an_T @[DisplayMux.scala 56:9]

  module Food :
    input clock : Clock
    input reset : UInt<1>
    output io : { seg : UInt<7>, an : UInt<8>, flip switchin : UInt<1>, flip switchin2 : UInt<1>, flip switchin3 : UInt<1>, flip switchin4 : UInt<1>, flip switchin5 : UInt<1>}

    wire _x_WIRE : SInt<32>[32] @[Food.scala 24:26]
    _x_WIRE[0] <= asSInt(UInt<32>("h0")) @[Food.scala 24:26]
    _x_WIRE[1] <= asSInt(UInt<32>("h0")) @[Food.scala 24:26]
    _x_WIRE[2] <= asSInt(UInt<32>("h0")) @[Food.scala 24:26]
    _x_WIRE[3] <= asSInt(UInt<32>("h0")) @[Food.scala 24:26]
    _x_WIRE[4] <= asSInt(UInt<32>("h0")) @[Food.scala 24:26]
    _x_WIRE[5] <= asSInt(UInt<32>("h0")) @[Food.scala 24:26]
    _x_WIRE[6] <= asSInt(UInt<32>("h0")) @[Food.scala 24:26]
    _x_WIRE[7] <= asSInt(UInt<32>("h0")) @[Food.scala 24:26]
    _x_WIRE[8] <= asSInt(UInt<32>("h0")) @[Food.scala 24:26]
    _x_WIRE[9] <= asSInt(UInt<32>("h0")) @[Food.scala 24:26]
    _x_WIRE[10] <= asSInt(UInt<32>("h0")) @[Food.scala 24:26]
    _x_WIRE[11] <= asSInt(UInt<32>("h0")) @[Food.scala 24:26]
    _x_WIRE[12] <= asSInt(UInt<32>("h0")) @[Food.scala 24:26]
    _x_WIRE[13] <= asSInt(UInt<32>("h0")) @[Food.scala 24:26]
    _x_WIRE[14] <= asSInt(UInt<32>("h0")) @[Food.scala 24:26]
    _x_WIRE[15] <= asSInt(UInt<32>("h0")) @[Food.scala 24:26]
    _x_WIRE[16] <= asSInt(UInt<32>("h0")) @[Food.scala 24:26]
    _x_WIRE[17] <= asSInt(UInt<32>("h0")) @[Food.scala 24:26]
    _x_WIRE[18] <= asSInt(UInt<32>("h0")) @[Food.scala 24:26]
    _x_WIRE[19] <= asSInt(UInt<32>("h0")) @[Food.scala 24:26]
    _x_WIRE[20] <= asSInt(UInt<32>("h0")) @[Food.scala 24:26]
    _x_WIRE[21] <= asSInt(UInt<32>("h0")) @[Food.scala 24:26]
    _x_WIRE[22] <= asSInt(UInt<32>("h0")) @[Food.scala 24:26]
    _x_WIRE[23] <= asSInt(UInt<32>("h0")) @[Food.scala 24:26]
    _x_WIRE[24] <= asSInt(UInt<32>("h0")) @[Food.scala 24:26]
    _x_WIRE[25] <= asSInt(UInt<32>("h0")) @[Food.scala 24:26]
    _x_WIRE[26] <= asSInt(UInt<32>("h0")) @[Food.scala 24:26]
    _x_WIRE[27] <= asSInt(UInt<32>("h0")) @[Food.scala 24:26]
    _x_WIRE[28] <= asSInt(UInt<32>("h0")) @[Food.scala 24:26]
    _x_WIRE[29] <= asSInt(UInt<32>("h0")) @[Food.scala 24:26]
    _x_WIRE[30] <= asSInt(UInt<32>("h0")) @[Food.scala 24:26]
    _x_WIRE[31] <= asSInt(UInt<32>("h0")) @[Food.scala 24:26]
    reg x : SInt<32>[32], clock with :
      reset => (reset, _x_WIRE) @[Food.scala 24:18]
    inst fetcher of Fetcher @[Food.scala 25:23]
    fetcher.clock <= clock
    fetcher.reset <= reset
    inst decoder of Decoder @[Food.scala 26:23]
    decoder.clock <= clock
    decoder.reset <= reset
    inst executer of Executer @[Food.scala 27:24]
    executer.clock <= clock
    executer.reset <= reset
    inst ALU of ALU @[Food.scala 28:19]
    ALU.clock <= clock
    ALU.reset <= reset
    inst memorizer of Memorizer @[Food.scala 29:25]
    memorizer.clock <= clock
    memorizer.reset <= reset
    inst write_backer of Write_backer @[Food.scala 30:28]
    write_backer.clock <= clock
    write_backer.reset <= reset
    inst Disp of DisplayMux @[Food.scala 31:20]
    Disp.clock <= clock
    Disp.reset <= reset
    wire _instrReg_WIRE : UInt<32>[18] @[Food.scala 32:33]
    _instrReg_WIRE[0] <= UInt<32>("hdeadc0b7") @[Food.scala 32:33]
    _instrReg_WIRE[1] <= UInt<32>("heef08093") @[Food.scala 32:33]
    _instrReg_WIRE[2] <= UInt<32>("h800113") @[Food.scala 32:33]
    _instrReg_WIRE[3] <= UInt<32>("h112023") @[Food.scala 32:33]
    _instrReg_WIRE[4] <= UInt<32>("h12183") @[Food.scala 32:33]
    _instrReg_WIRE[5] <= UInt<32>("h308a63") @[Food.scala 32:33]
    _instrReg_WIRE[6] <= UInt<32>("h63") @[Food.scala 32:33]
    _instrReg_WIRE[7] <= UInt<32>("h700093") @[Food.scala 32:33]
    _instrReg_WIRE[8] <= UInt<32>("h10283") @[Food.scala 32:33]
    _instrReg_WIRE[9] <= UInt<32>("h628863") @[Food.scala 32:33]
    _instrReg_WIRE[10] <= UInt<32>("ha00213") @[Food.scala 32:33]
    _instrReg_WIRE[11] <= UInt<32>("h10303") @[Food.scala 32:33]
    _instrReg_WIRE[12] <= UInt<32>("hff1ff56f") @[Food.scala 32:33]
    _instrReg_WIRE[13] <= UInt<32>("h900493") @[Food.scala 32:33]
    _instrReg_WIRE[14] <= UInt<32>("hfe000ee3") @[Food.scala 32:33]
    _instrReg_WIRE[15] <= UInt<32>("h63") @[Food.scala 32:33]
    _instrReg_WIRE[16] <= UInt<32>("h13") @[Food.scala 32:33]
    _instrReg_WIRE[17] <= UInt<32>("h13") @[Food.scala 32:33]
    reg instrReg : UInt<32>[18], clock with :
      reset => (reset, _instrReg_WIRE) @[Food.scala 32:25]
    fetcher.io.instrIn[0] <= instrReg[0] @[Food.scala 54:22]
    fetcher.io.instrIn[1] <= instrReg[1] @[Food.scala 54:22]
    fetcher.io.instrIn[2] <= instrReg[2] @[Food.scala 54:22]
    fetcher.io.instrIn[3] <= instrReg[3] @[Food.scala 54:22]
    fetcher.io.instrIn[4] <= instrReg[4] @[Food.scala 54:22]
    fetcher.io.instrIn[5] <= instrReg[5] @[Food.scala 54:22]
    fetcher.io.instrIn[6] <= instrReg[6] @[Food.scala 54:22]
    fetcher.io.instrIn[7] <= instrReg[7] @[Food.scala 54:22]
    fetcher.io.instrIn[8] <= instrReg[8] @[Food.scala 54:22]
    fetcher.io.instrIn[9] <= instrReg[9] @[Food.scala 54:22]
    fetcher.io.instrIn[10] <= instrReg[10] @[Food.scala 54:22]
    fetcher.io.instrIn[11] <= instrReg[11] @[Food.scala 54:22]
    fetcher.io.instrIn[12] <= instrReg[12] @[Food.scala 54:22]
    fetcher.io.instrIn[13] <= instrReg[13] @[Food.scala 54:22]
    fetcher.io.instrIn[14] <= instrReg[14] @[Food.scala 54:22]
    fetcher.io.instrIn[15] <= instrReg[15] @[Food.scala 54:22]
    fetcher.io.instrIn[16] <= instrReg[16] @[Food.scala 54:22]
    fetcher.io.instrIn[17] <= instrReg[17] @[Food.scala 54:22]
    decoder.io.instrIn <= fetcher.io.instrOut @[Food.scala 57:22]
    decoder.io.pcIn <= fetcher.io.pcOut @[Food.scala 59:19]
    executer.io.pcIn <= decoder.io.pcOut @[Food.scala 60:20]
    executer.io.rdIn <= ALU.io.rdOut @[Food.scala 62:20]
    fetcher.io.branchIn <= ALU.io.branchOut @[Food.scala 64:23]
    fetcher.io.branchEnable <= ALU.io.branchEnable @[Food.scala 65:27]
    decoder.io.rdRegEx <= ALU.io.rdOut @[Food.scala 68:22]
    decoder.io.LoadMemEnable <= ALU.io.rdEna @[Food.scala 70:28]
    fetcher.io.shouldMux <= decoder.io.shouldMux @[Food.scala 72:24]
    executer.io.x[0] <= x[0] @[Food.scala 75:17]
    executer.io.x[1] <= x[1] @[Food.scala 75:17]
    executer.io.x[2] <= x[2] @[Food.scala 75:17]
    executer.io.x[3] <= x[3] @[Food.scala 75:17]
    executer.io.x[4] <= x[4] @[Food.scala 75:17]
    executer.io.x[5] <= x[5] @[Food.scala 75:17]
    executer.io.x[6] <= x[6] @[Food.scala 75:17]
    executer.io.x[7] <= x[7] @[Food.scala 75:17]
    executer.io.x[8] <= x[8] @[Food.scala 75:17]
    executer.io.x[9] <= x[9] @[Food.scala 75:17]
    executer.io.x[10] <= x[10] @[Food.scala 75:17]
    executer.io.x[11] <= x[11] @[Food.scala 75:17]
    executer.io.x[12] <= x[12] @[Food.scala 75:17]
    executer.io.x[13] <= x[13] @[Food.scala 75:17]
    executer.io.x[14] <= x[14] @[Food.scala 75:17]
    executer.io.x[15] <= x[15] @[Food.scala 75:17]
    executer.io.x[16] <= x[16] @[Food.scala 75:17]
    executer.io.x[17] <= x[17] @[Food.scala 75:17]
    executer.io.x[18] <= x[18] @[Food.scala 75:17]
    executer.io.x[19] <= x[19] @[Food.scala 75:17]
    executer.io.x[20] <= x[20] @[Food.scala 75:17]
    executer.io.x[21] <= x[21] @[Food.scala 75:17]
    executer.io.x[22] <= x[22] @[Food.scala 75:17]
    executer.io.x[23] <= x[23] @[Food.scala 75:17]
    executer.io.x[24] <= x[24] @[Food.scala 75:17]
    executer.io.x[25] <= x[25] @[Food.scala 75:17]
    executer.io.x[26] <= x[26] @[Food.scala 75:17]
    executer.io.x[27] <= x[27] @[Food.scala 75:17]
    executer.io.x[28] <= x[28] @[Food.scala 75:17]
    executer.io.x[29] <= x[29] @[Food.scala 75:17]
    executer.io.x[30] <= x[30] @[Food.scala 75:17]
    executer.io.x[31] <= x[31] @[Food.scala 75:17]
    executer.io.opcode <= decoder.io.opcode @[Food.scala 76:22]
    ALU.io.rdIn <= decoder.io.rdOutput @[Food.scala 77:15]
    executer.io.rs1 <= decoder.io.rs1 @[Food.scala 78:19]
    executer.io.rs2 <= decoder.io.rs2 @[Food.scala 79:19]
    executer.io.imm_I <= decoder.io.imm_I @[Food.scala 80:21]
    executer.io.imm_B <= decoder.io.imm_B @[Food.scala 81:21]
    executer.io.imm_J <= decoder.io.imm_J @[Food.scala 82:21]
    executer.io.imm_S <= decoder.io.imm_S @[Food.scala 83:21]
    executer.io.imm_U <= decoder.io.imm_U @[Food.scala 84:21]
    executer.io.funct3 <= decoder.io.funct3 @[Food.scala 85:22]
    executer.io.funct7 <= decoder.io.funct7 @[Food.scala 86:22]
    executer.io.rdLastRegMemIn <= memorizer.io.rdLastRegMemOut @[Food.scala 89:30]
    executer.io.aluLastRegMemIn <= memorizer.io.aluLastRegMemOut @[Food.scala 91:31]
    executer.io.rdLoadRegMemIn <= memorizer.io.rdLoadRegMemOut @[Food.scala 93:30]
    executer.io.aluLoadRegMemIn <= memorizer.io.aluLoadRegMemOut @[Food.scala 94:31]
    executer.io.loadEnable <= memorizer.io.loadEnabler @[Food.scala 95:26]
    ALU.io.funct3 <= executer.io.funct3out @[Food.scala 97:17]
    ALU.io.funct7 <= executer.io.funct7out @[Food.scala 98:17]
    ALU.io.pcIn <= executer.io.pcOut @[Food.scala 99:15]
    ALU.io.group <= executer.io.group @[Food.scala 100:16]
    ALU.io.operand1 <= executer.io.operand1 @[Food.scala 101:19]
    ALU.io.operand2 <= executer.io.operand2 @[Food.scala 102:19]
    ALU.io.imm <= executer.io.imm @[Food.scala 103:14]
    executer.io.ALUIn <= ALU.io.ALUout @[Food.scala 106:21]
    memorizer.io.memOp <= ALU.io.memOp @[Food.scala 107:22]
    memorizer.io.rdInput <= ALU.io.rdOut @[Food.scala 108:24]
    memorizer.io.ALUinput <= ALU.io.ALUout @[Food.scala 109:25]
    memorizer.io.rdEna <= ALU.io.rdEna @[Food.scala 110:22]
    memorizer.io.wrEna <= ALU.io.wrEna @[Food.scala 111:22]
    memorizer.io.rdAddr <= ALU.io.rdAddr @[Food.scala 112:23]
    memorizer.io.wrAddr <= ALU.io.wrAddr @[Food.scala 113:23]
    node _memorizer_io_wrData_T = asUInt(ALU.io.ALUout) @[Food.scala 114:40]
    memorizer.io.wrData <= _memorizer_io_wrData_T @[Food.scala 114:23]
    write_backer.io.rdData <= memorizer.io.rdData @[Food.scala 117:26]
    write_backer.io.rdEnaIn <= memorizer.io.rdEnaOut @[Food.scala 118:27]
    write_backer.io.rdInput <= memorizer.io.rdOutput @[Food.scala 119:27]
    write_backer.io.ALUinput <= memorizer.io.ALUoutput @[Food.scala 120:28]
    write_backer.io.wrEnaIn <= memorizer.io.wrEnaOut @[Food.scala 121:27]
    x[write_backer.io.rdOut] <= write_backer.io.ALUoutput @[Food.scala 124:28]
    node switches_lo = cat(io.switchin4, io.switchin5) @[Cat.scala 33:92]
    node switches_hi_hi = cat(io.switchin, io.switchin2) @[Cat.scala 33:92]
    node switches_hi = cat(switches_hi_hi, io.switchin3) @[Cat.scala 33:92]
    node switches = cat(switches_hi, switches_lo) @[Cat.scala 33:92]
    Disp.io.xReg <= x[switches] @[Food.scala 129:16]
    io.seg <= Disp.io.seg @[Food.scala 130:10]
    io.an <= Disp.io.an @[Food.scala 131:9]
    x[write_backer.io.rdOut] <= write_backer.io.ALUoutput @[Food.scala 134:28]

