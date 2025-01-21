circuit Food :
  module Fetcher :
    input clock : Clock
    input reset : Reset
    output io : { flip instrIn : UInt<32>[9], flip branchIn : SInt<32>, flip branchEnable : UInt<1>, flip shouldMux : UInt<1>, instrOut : UInt<32>, pcOut : SInt<32>}

    reg pcReg : SInt<32>, clock with :
      reset => (reset, asSInt(UInt<32>("hfffffffc"))) @[Fetcher.scala 15:22]
    reg instr : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[Fetcher.scala 16:22]
    reg branchEnableReg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[Fetcher.scala 18:32]
    reg branchInReg : SInt<32>, clock with :
      reset => (reset, asSInt(UInt<32>("h0"))) @[Fetcher.scala 19:28]
    branchInReg <= io.branchIn @[Fetcher.scala 21:15]
    branchEnableReg <= io.branchEnable @[Fetcher.scala 22:19]
    node _pcPlusReg_T = add(pcReg, asSInt(UInt<4>("h4"))) @[Fetcher.scala 24:85]
    node _pcPlusReg_T_1 = tail(_pcPlusReg_T, 1) @[Fetcher.scala 24:85]
    node _pcPlusReg_T_2 = asSInt(_pcPlusReg_T_1) @[Fetcher.scala 24:85]
    node _pcPlusReg_T_3 = mux(io.branchEnable, io.branchIn, _pcPlusReg_T_2) @[Fetcher.scala 24:46]
    node pcPlusReg = mux(io.shouldMux, pcReg, _pcPlusReg_T_3) @[Fetcher.scala 24:22]
    node index = shr(pcPlusReg, 2) @[Fetcher.scala 25:28]
    pcReg <= pcPlusReg @[Fetcher.scala 27:8]
    node _instr_T = bits(index, 29, 0) @[Fetcher.scala 28:28]
    node _instr_T_1 = bits(_instr_T, 3, 0)
    instr <= io.instrIn[_instr_T_1] @[Fetcher.scala 28:9]
    io.instrOut <= instr @[Fetcher.scala 30:15]
    io.pcOut <= pcReg @[Fetcher.scala 31:12]

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
    node _io_rdOutput_T = bits(instr, 11, 7) @[Decoder.scala 46:26]
    io.rdOutput <= _io_rdOutput_T @[Decoder.scala 46:18]
    node _io_funct3_T = bits(instr, 14, 12) @[Decoder.scala 47:21]
    io.funct3 <= _io_funct3_T @[Decoder.scala 47:13]
    node _io_rs1_T = bits(instr, 19, 15) @[Decoder.scala 48:21]
    io.rs1 <= _io_rs1_T @[Decoder.scala 48:13]
    node _io_rs2_T = bits(instr, 24, 20) @[Decoder.scala 50:21]
    io.rs2 <= _io_rs2_T @[Decoder.scala 50:13]
    node _io_funct7_T = bits(instr, 31, 25) @[Decoder.scala 51:21]
    io.funct7 <= _io_funct7_T @[Decoder.scala 51:13]
    node _io_imm_I_T = bits(instr, 31, 20) @[Decoder.scala 52:21]
    node _io_imm_I_T_1 = asSInt(_io_imm_I_T) @[Decoder.scala 52:30]
    io.imm_I <= _io_imm_I_T_1 @[Decoder.scala 52:13]
    node _io_imm_S_T = bits(instr, 31, 25) @[Decoder.scala 53:23]
    node _io_imm_S_T_1 = shl(_io_imm_S_T, 5) @[Decoder.scala 53:32]
    node _io_imm_S_T_2 = bits(instr, 11, 7) @[Decoder.scala 53:45]
    node _io_imm_S_T_3 = or(_io_imm_S_T_1, _io_imm_S_T_2) @[Decoder.scala 53:38]
    node _io_imm_S_T_4 = asSInt(_io_imm_S_T_3) @[Decoder.scala 53:54]
    io.imm_S <= _io_imm_S_T_4 @[Decoder.scala 53:13]
    node _io_imm_B_T = bits(instr, 31, 31) @[Decoder.scala 54:23]
    node _io_imm_B_T_1 = shl(_io_imm_B_T, 12) @[Decoder.scala 54:28]
    node _io_imm_B_T_2 = bits(instr, 7, 7) @[Decoder.scala 54:43]
    node _io_imm_B_T_3 = shl(_io_imm_B_T_2, 11) @[Decoder.scala 54:47]
    node _io_imm_B_T_4 = or(_io_imm_B_T_1, _io_imm_B_T_3) @[Decoder.scala 54:35]
    node _io_imm_B_T_5 = bits(instr, 30, 25) @[Decoder.scala 54:62]
    node _io_imm_B_T_6 = shl(_io_imm_B_T_5, 5) @[Decoder.scala 54:71]
    node _io_imm_B_T_7 = or(_io_imm_B_T_4, _io_imm_B_T_6) @[Decoder.scala 54:54]
    node _io_imm_B_T_8 = bits(instr, 11, 8) @[Decoder.scala 54:85]
    node _io_imm_B_T_9 = shl(_io_imm_B_T_8, 1) @[Decoder.scala 54:93]
    node _io_imm_B_T_10 = or(_io_imm_B_T_7, _io_imm_B_T_9) @[Decoder.scala 54:77]
    node _io_imm_B_T_11 = asSInt(_io_imm_B_T_10) @[Decoder.scala 54:100]
    io.imm_B <= _io_imm_B_T_11 @[Decoder.scala 54:13]
    node _io_imm_U_T = bits(instr, 31, 12) @[Decoder.scala 55:21]
    io.imm_U <= _io_imm_U_T @[Decoder.scala 55:13]
    node _io_imm_J_T = bits(instr, 31, 31) @[Decoder.scala 56:24]
    node _io_imm_J_T_1 = shl(_io_imm_J_T, 20) @[Decoder.scala 56:29]
    node _io_imm_J_T_2 = bits(instr, 19, 12) @[Decoder.scala 56:44]
    node _io_imm_J_T_3 = shl(_io_imm_J_T_2, 12) @[Decoder.scala 56:53]
    node _io_imm_J_T_4 = or(_io_imm_J_T_1, _io_imm_J_T_3) @[Decoder.scala 56:36]
    node _io_imm_J_T_5 = bits(instr, 20, 20) @[Decoder.scala 56:68]
    node _io_imm_J_T_6 = shl(_io_imm_J_T_5, 11) @[Decoder.scala 56:73]
    node _io_imm_J_T_7 = or(_io_imm_J_T_4, _io_imm_J_T_6) @[Decoder.scala 56:60]
    node _io_imm_J_T_8 = bits(instr, 30, 21) @[Decoder.scala 56:88]
    node _io_imm_J_T_9 = shl(_io_imm_J_T_8, 1) @[Decoder.scala 56:97]
    node _io_imm_J_T_10 = or(_io_imm_J_T_7, _io_imm_J_T_9) @[Decoder.scala 56:80]
    node _io_imm_J_T_11 = asSInt(_io_imm_J_T_10) @[Decoder.scala 56:105]
    io.imm_J <= _io_imm_J_T_11 @[Decoder.scala 56:13]

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
    pcReg <= io.pcIn @[Executer.scala 78:9]
    branchEnableReg <= UInt<1>("h0") @[Executer.scala 79:19]
    node _lastMemBool1_T = eq(io.rdLastRegMemIn, rs1Reg) @[Executer.scala 80:40]
    node _lastMemBool1_T_1 = neq(rs1Reg, UInt<1>("h0")) @[Executer.scala 80:62]
    node lastMemBool1 = and(_lastMemBool1_T, _lastMemBool1_T_1) @[Executer.scala 80:51]
    node _lastMemBool2_T = eq(io.rdLastRegMemIn, rs2Reg) @[Executer.scala 81:40]
    node _lastMemBool2_T_1 = neq(rs2Reg, UInt<1>("h0")) @[Executer.scala 81:62]
    node lastMemBool2 = and(_lastMemBool2_T, _lastMemBool2_T_1) @[Executer.scala 81:51]
    node _loadMemBool1_T = eq(io.rdLoadRegMemIn, rs1Reg) @[Executer.scala 82:57]
    node loadMemBool1 = and(io.loadEnable, _loadMemBool1_T) @[Executer.scala 82:36]
    node _loadMemBool2_T = eq(io.rdLoadRegMemIn, rs2Reg) @[Executer.scala 83:57]
    node loadMemBool2 = and(io.loadEnable, _loadMemBool2_T) @[Executer.scala 83:36]
    node _lastExBool1_T = eq(rdLastRegEx, rs1Reg) @[Executer.scala 84:34]
    node _lastExBool1_T_1 = neq(rs1Reg, UInt<1>("h0")) @[Executer.scala 84:57]
    node lastExBool1 = and(_lastExBool1_T, _lastExBool1_T_1) @[Executer.scala 84:46]
    node _lastExBool2_T = eq(rdLastRegEx, rs2Reg) @[Executer.scala 85:34]
    node _lastExBool2_T_1 = neq(rs2Reg, UInt<1>("h0")) @[Executer.scala 85:57]
    node lastExBool2 = and(_lastExBool2_T, _lastExBool2_T_1) @[Executer.scala 85:46]
    node _rs1Wire_T = mux(loadMemBool1, io.aluLoadRegMemIn, io.aluLastRegMemIn) @[Executer.scala 87:69]
    node _rs1Wire_T_1 = mux(lastMemBool1, _rs1Wire_T, io.x[rs1Reg]) @[Executer.scala 87:51]
    node rs1Wire = mux(lastExBool1, aluLastRegEx, _rs1Wire_T_1) @[Executer.scala 87:20]
    node _rs2Wire_T = mux(loadMemBool2, io.aluLoadRegMemIn, io.aluLastRegMemIn) @[Executer.scala 88:69]
    node _rs2Wire_T_1 = mux(lastMemBool2, _rs2Wire_T, io.x[rs2Reg]) @[Executer.scala 88:51]
    node rs2Wire = mux(lastExBool2, aluLastRegEx, _rs2Wire_T_1) @[Executer.scala 88:20]
    branchOutReg <= pcReg @[Executer.scala 92:16]
    io.imm <= imm_IReg @[Executer.scala 93:10]
    io.operand1 <= rs1Wire @[Executer.scala 95:15]
    io.operand2 <= asSInt(UInt<1>("h0")) @[Executer.scala 96:15]
    io.group <= UInt<1>("h0") @[Executer.scala 97:12]
    node _T = eq(UInt<6>("h33"), opcodeReg) @[Executer.scala 98:21]
    when _T : @[Executer.scala 98:21]
      io.operand2 <= rs2Wire @[Executer.scala 100:19]
      io.group <= UInt<1>("h1") @[Executer.scala 101:16]
    else :
      node _T_1 = eq(UInt<5>("h13"), opcodeReg) @[Executer.scala 98:21]
      when _T_1 : @[Executer.scala 98:21]
        io.group <= UInt<1>("h1") @[Executer.scala 104:16]
        io.operand2 <= imm_IReg @[Executer.scala 105:19]
        io.funct7out <= UInt<1>("h0") @[Executer.scala 106:20]
        node _T_2 = eq(UInt<1>("h1"), funct3Reg) @[Executer.scala 107:25]
        when _T_2 : @[Executer.scala 107:25]
          io.funct7out <= funct7Reg @[Executer.scala 109:24]
          node _io_operand2_T = asSInt(rs2Reg) @[Executer.scala 110:33]
          io.operand2 <= _io_operand2_T @[Executer.scala 110:23]
        else :
          node _T_3 = eq(UInt<3>("h5"), funct3Reg) @[Executer.scala 107:25]
          when _T_3 : @[Executer.scala 107:25]
            io.funct7out <= funct7Reg @[Executer.scala 113:24]
            node _io_operand2_T_1 = asSInt(rs2Reg) @[Executer.scala 114:33]
            io.operand2 <= _io_operand2_T_1 @[Executer.scala 114:23]
      else :
        node _T_4 = eq(UInt<2>("h3"), opcodeReg) @[Executer.scala 98:21]
        when _T_4 : @[Executer.scala 98:21]
          io.group <= UInt<2>("h2") @[Executer.scala 119:16]
          io.operand2 <= rs2Wire @[Executer.scala 120:19]
          io.imm <= imm_IReg @[Executer.scala 121:14]
        else :
          node _T_5 = eq(UInt<6>("h23"), opcodeReg) @[Executer.scala 98:21]
          when _T_5 : @[Executer.scala 98:21]
            io.group <= UInt<2>("h3") @[Executer.scala 124:16]
            io.operand2 <= rs2Wire @[Executer.scala 125:19]
            io.imm <= imm_SReg @[Executer.scala 126:14]
          else :
            node _T_6 = eq(UInt<7>("h63"), opcodeReg) @[Executer.scala 98:21]
            when _T_6 : @[Executer.scala 98:21]
              io.group <= UInt<3>("h4") @[Executer.scala 129:16]
              io.operand2 <= rs2Wire @[Executer.scala 130:19]
              io.imm <= imm_BReg @[Executer.scala 131:14]
            else :
              node _T_7 = eq(UInt<7>("h6f"), opcodeReg) @[Executer.scala 98:21]
              when _T_7 : @[Executer.scala 98:21]
                io.group <= UInt<3>("h5") @[Executer.scala 134:16]
                io.imm <= imm_JReg @[Executer.scala 135:14]
              else :
                node _T_8 = eq(UInt<7>("h67"), opcodeReg) @[Executer.scala 98:21]
                when _T_8 : @[Executer.scala 98:21]
                  io.group <= UInt<3>("h6") @[Executer.scala 138:16]
                  io.imm <= imm_IReg @[Executer.scala 139:14]
                else :
                  node _T_9 = eq(UInt<6>("h37"), opcodeReg) @[Executer.scala 98:21]
                  when _T_9 : @[Executer.scala 98:21]
                    io.group <= UInt<3>("h7") @[Executer.scala 142:16]
                    node _io_imm_T = asSInt(imm_UReg) @[Executer.scala 143:26]
                    io.imm <= _io_imm_T @[Executer.scala 143:14]
                  else :
                    node _T_10 = eq(UInt<5>("h17"), opcodeReg) @[Executer.scala 98:21]
                    when _T_10 : @[Executer.scala 98:21]
                      io.group <= UInt<4>("h8") @[Executer.scala 146:16]
                      node _io_imm_T_1 = asSInt(imm_UReg) @[Executer.scala 147:26]
                      io.imm <= _io_imm_T_1 @[Executer.scala 147:14]
    rdLastRegEx <= io.rdIn @[Executer.scala 152:15]
    aluLastRegEx <= io.ALUIn @[Executer.scala 153:16]
    io.pcOut <= pcReg @[Executer.scala 156:12]

  module ALU :
    input clock : Clock
    input reset : Reset
    output io : { flip funct3 : UInt<3>, flip funct7 : UInt<7>, flip imm : SInt<32>, flip pcIn : SInt<32>, flip group : UInt<4>, flip operand2 : SInt<32>, flip operand1 : SInt<32>, branchOut : SInt<32>, branchEnable : UInt<1>, ALUout : SInt<32>, pcOut : SInt<32>, rdAddr : UInt<10>, wrAddr : UInt<10>, wrEna : UInt<1>, rdEna : UInt<1>, memOp : UInt<3>, rdOut : UInt<5>, flip rdIn : UInt<5>}

    io.wrEna <= UInt<1>("h0") @[ALU.scala 38:12]
    io.rdEna <= UInt<1>("h0") @[ALU.scala 39:12]
    io.rdAddr <= UInt<1>("h0") @[ALU.scala 40:13]
    io.wrAddr <= UInt<1>("h0") @[ALU.scala 41:13]
    io.memOp <= UInt<1>("h0") @[ALU.scala 42:12]
    io.ALUout <= asSInt(UInt<1>("h0")) @[ALU.scala 44:13]
    io.branchOut <= asSInt(UInt<1>("h0")) @[ALU.scala 45:16]
    io.branchEnable <= UInt<1>("h0") @[ALU.scala 46:19]
    io.pcOut <= io.pcIn @[ALU.scala 47:12]
    node _T = eq(UInt<1>("h1"), io.group) @[ALU.scala 50:17]
    when _T : @[ALU.scala 50:17]
      node _T_1 = eq(UInt<1>("h0"), io.funct3) @[ALU.scala 52:22]
      when _T_1 : @[ALU.scala 52:22]
        node _io_ALUout_T = add(io.operand1, io.operand2) @[ALU.scala 54:40]
        node _io_ALUout_T_1 = tail(_io_ALUout_T, 1) @[ALU.scala 54:40]
        node _io_ALUout_T_2 = asSInt(_io_ALUout_T_1) @[ALU.scala 54:40]
        io.ALUout <= _io_ALUout_T_2 @[ALU.scala 54:21]
        node _T_2 = eq(UInt<6>("h20"), io.funct7) @[ALU.scala 55:26]
        when _T_2 : @[ALU.scala 55:26]
          node _io_ALUout_T_3 = sub(io.operand1, io.operand2) @[ALU.scala 57:44]
          node _io_ALUout_T_4 = tail(_io_ALUout_T_3, 1) @[ALU.scala 57:44]
          node _io_ALUout_T_5 = asSInt(_io_ALUout_T_4) @[ALU.scala 57:44]
          io.ALUout <= _io_ALUout_T_5 @[ALU.scala 57:25]
      else :
        node _T_3 = eq(UInt<3>("h4"), io.funct3) @[ALU.scala 52:22]
        when _T_3 : @[ALU.scala 52:22]
          node _io_ALUout_T_6 = xor(io.operand1, io.operand2) @[ALU.scala 62:40]
          node _io_ALUout_T_7 = asSInt(_io_ALUout_T_6) @[ALU.scala 62:40]
          io.ALUout <= _io_ALUout_T_7 @[ALU.scala 62:21]
        else :
          node _T_4 = eq(UInt<3>("h6"), io.funct3) @[ALU.scala 52:22]
          when _T_4 : @[ALU.scala 52:22]
            node _io_ALUout_T_8 = or(io.operand1, io.operand2) @[ALU.scala 65:40]
            node _io_ALUout_T_9 = asSInt(_io_ALUout_T_8) @[ALU.scala 65:40]
            io.ALUout <= _io_ALUout_T_9 @[ALU.scala 65:21]
          else :
            node _T_5 = eq(UInt<3>("h7"), io.funct3) @[ALU.scala 52:22]
            when _T_5 : @[ALU.scala 52:22]
              node _io_ALUout_T_10 = and(io.operand1, io.operand2) @[ALU.scala 68:40]
              node _io_ALUout_T_11 = asSInt(_io_ALUout_T_10) @[ALU.scala 68:40]
              io.ALUout <= _io_ALUout_T_11 @[ALU.scala 68:21]
            else :
              node _T_6 = eq(UInt<1>("h1"), io.funct3) @[ALU.scala 52:22]
              when _T_6 : @[ALU.scala 52:22]
                node _io_ALUout_T_12 = asUInt(io.operand1) @[ALU.scala 72:34]
                node _io_ALUout_T_13 = asUInt(io.operand2) @[ALU.scala 72:53]
                node _io_ALUout_T_14 = bits(_io_ALUout_T_13, 18, 0) @[ALU.scala 72:59]
                node _io_ALUout_T_15 = dshl(_io_ALUout_T_12, _io_ALUout_T_14) @[ALU.scala 72:41]
                node _io_ALUout_T_16 = asSInt(_io_ALUout_T_15) @[ALU.scala 72:67]
                io.ALUout <= _io_ALUout_T_16 @[ALU.scala 72:21]
              else :
                node _T_7 = eq(UInt<3>("h5"), io.funct3) @[ALU.scala 52:22]
                when _T_7 : @[ALU.scala 52:22]
                  node _io_ALUout_T_17 = asUInt(io.operand1) @[ALU.scala 76:34]
                  node _io_ALUout_T_18 = asUInt(io.operand2) @[ALU.scala 76:53]
                  node _io_ALUout_T_19 = dshr(_io_ALUout_T_17, _io_ALUout_T_18) @[ALU.scala 76:41]
                  node _io_ALUout_T_20 = asSInt(_io_ALUout_T_19) @[ALU.scala 76:61]
                  io.ALUout <= _io_ALUout_T_20 @[ALU.scala 76:21]
                  node _T_8 = eq(io.funct7, UInt<6>("h20")) @[ALU.scala 78:22]
                  when _T_8 : @[ALU.scala 78:34]
                    node _io_ALUout_T_21 = asUInt(io.operand2) @[ALU.scala 79:47]
                    node _io_ALUout_T_22 = dshr(io.operand1, _io_ALUout_T_21) @[ALU.scala 79:35]
                    io.ALUout <= _io_ALUout_T_22 @[ALU.scala 79:23]
                else :
                  node _T_9 = eq(UInt<2>("h2"), io.funct3) @[ALU.scala 52:22]
                  when _T_9 : @[ALU.scala 52:22]
                    node _io_ALUout_T_23 = lt(io.operand1, io.operand2) @[ALU.scala 85:44]
                    node _io_ALUout_T_24 = mux(_io_ALUout_T_23, asSInt(UInt<2>("h1")), asSInt(UInt<1>("h0"))) @[ALU.scala 85:27]
                    io.ALUout <= _io_ALUout_T_24 @[ALU.scala 85:21]
                  else :
                    node _T_10 = eq(UInt<2>("h3"), io.funct3) @[ALU.scala 52:22]
                    when _T_10 : @[ALU.scala 52:22]
                      node _io_ALUout_T_25 = asUInt(io.operand1) @[ALU.scala 88:37]
                      node _io_ALUout_T_26 = asUInt(io.operand2) @[ALU.scala 88:55]
                      node _io_ALUout_T_27 = lt(_io_ALUout_T_25, _io_ALUout_T_26) @[ALU.scala 88:44]
                      node _io_ALUout_T_28 = mux(_io_ALUout_T_27, asSInt(UInt<2>("h1")), asSInt(UInt<1>("h0"))) @[ALU.scala 88:27]
                      io.ALUout <= _io_ALUout_T_28 @[ALU.scala 88:21]
    else :
      node _T_11 = eq(UInt<2>("h2"), io.group) @[ALU.scala 50:17]
      when _T_11 : @[ALU.scala 50:17]
        node _io_rdAddr_T = add(io.operand1, io.imm) @[ALU.scala 93:30]
        node _io_rdAddr_T_1 = tail(_io_rdAddr_T, 1) @[ALU.scala 93:30]
        node _io_rdAddr_T_2 = asSInt(_io_rdAddr_T_1) @[ALU.scala 93:30]
        node _io_rdAddr_T_3 = bits(_io_rdAddr_T_2, 9, 0) @[ALU.scala 93:36]
        io.rdAddr <= _io_rdAddr_T_3 @[ALU.scala 93:17]
        io.rdEna <= UInt<1>("h1") @[ALU.scala 94:16]
        node _T_12 = eq(UInt<1>("h0"), io.funct3) @[ALU.scala 95:22]
        when _T_12 : @[ALU.scala 95:22]
          io.memOp <= UInt<1>("h1") @[ALU.scala 98:20]
        else :
          node _T_13 = eq(UInt<1>("h1"), io.funct3) @[ALU.scala 95:22]
          when _T_13 : @[ALU.scala 95:22]
            io.memOp <= UInt<2>("h2") @[ALU.scala 101:20]
          else :
            node _T_14 = eq(UInt<2>("h2"), io.funct3) @[ALU.scala 95:22]
            when _T_14 : @[ALU.scala 95:22]
              io.memOp <= UInt<2>("h3") @[ALU.scala 104:20]
            else :
              node _T_15 = eq(UInt<3>("h4"), io.funct3) @[ALU.scala 95:22]
              when _T_15 : @[ALU.scala 95:22]
                io.memOp <= UInt<3>("h4") @[ALU.scala 107:20]
              else :
                node _T_16 = eq(UInt<3>("h5"), io.funct3) @[ALU.scala 95:22]
                when _T_16 : @[ALU.scala 95:22]
                  io.memOp <= UInt<3>("h5") @[ALU.scala 110:20]
      else :
        node _T_17 = eq(UInt<2>("h3"), io.group) @[ALU.scala 50:17]
        when _T_17 : @[ALU.scala 50:17]
          io.ALUout <= io.operand2 @[ALU.scala 116:17]
          node _io_wrAddr_T = add(io.operand1, io.imm) @[ALU.scala 117:30]
          node _io_wrAddr_T_1 = tail(_io_wrAddr_T, 1) @[ALU.scala 117:30]
          node _io_wrAddr_T_2 = asSInt(_io_wrAddr_T_1) @[ALU.scala 117:30]
          node _io_wrAddr_T_3 = bits(_io_wrAddr_T_2, 9, 0) @[ALU.scala 117:36]
          io.wrAddr <= _io_wrAddr_T_3 @[ALU.scala 117:17]
          io.wrEna <= UInt<1>("h1") @[ALU.scala 118:16]
          node _T_18 = eq(UInt<1>("h0"), io.funct3) @[ALU.scala 119:22]
          when _T_18 : @[ALU.scala 119:22]
            io.memOp <= UInt<1>("h1") @[ALU.scala 121:20]
          else :
            node _T_19 = eq(UInt<1>("h1"), io.funct3) @[ALU.scala 119:22]
            when _T_19 : @[ALU.scala 119:22]
              io.memOp <= UInt<2>("h2") @[ALU.scala 124:20]
            else :
              node _T_20 = eq(UInt<2>("h2"), io.funct3) @[ALU.scala 119:22]
              when _T_20 : @[ALU.scala 119:22]
                io.memOp <= UInt<2>("h3") @[ALU.scala 127:20]
        else :
          node _T_21 = eq(UInt<3>("h4"), io.group) @[ALU.scala 50:17]
          when _T_21 : @[ALU.scala 50:17]
            node _T_22 = eq(UInt<1>("h0"), io.funct3) @[ALU.scala 133:22]
            when _T_22 : @[ALU.scala 133:22]
              node _T_23 = eq(io.operand1, io.operand2) @[ALU.scala 135:25]
              when _T_23 : @[ALU.scala 135:39]
                io.branchEnable <= UInt<1>("h1") @[ALU.scala 136:29]
                node _io_branchOut_T = add(io.pcIn, io.imm) @[ALU.scala 137:35]
                node _io_branchOut_T_1 = tail(_io_branchOut_T, 1) @[ALU.scala 137:35]
                node _io_branchOut_T_2 = asSInt(_io_branchOut_T_1) @[ALU.scala 137:35]
                node _io_branchOut_T_3 = sub(_io_branchOut_T_2, asSInt(UInt<4>("h4"))) @[ALU.scala 137:41]
                node _io_branchOut_T_4 = tail(_io_branchOut_T_3, 1) @[ALU.scala 137:41]
                node _io_branchOut_T_5 = asSInt(_io_branchOut_T_4) @[ALU.scala 137:41]
                io.branchOut <= _io_branchOut_T_5 @[ALU.scala 137:26]
            else :
              node _T_24 = eq(UInt<1>("h1"), io.funct3) @[ALU.scala 133:22]
              when _T_24 : @[ALU.scala 133:22]
                node _T_25 = neq(io.operand1, io.operand2) @[ALU.scala 141:25]
                when _T_25 : @[ALU.scala 141:39]
                  io.branchEnable <= UInt<1>("h1") @[ALU.scala 142:29]
                  node _io_branchOut_T_6 = add(io.pcIn, io.imm) @[ALU.scala 143:35]
                  node _io_branchOut_T_7 = tail(_io_branchOut_T_6, 1) @[ALU.scala 143:35]
                  node _io_branchOut_T_8 = asSInt(_io_branchOut_T_7) @[ALU.scala 143:35]
                  node _io_branchOut_T_9 = sub(_io_branchOut_T_8, asSInt(UInt<4>("h4"))) @[ALU.scala 143:41]
                  node _io_branchOut_T_10 = tail(_io_branchOut_T_9, 1) @[ALU.scala 143:41]
                  node _io_branchOut_T_11 = asSInt(_io_branchOut_T_10) @[ALU.scala 143:41]
                  io.branchOut <= _io_branchOut_T_11 @[ALU.scala 143:26]
              else :
                node _T_26 = eq(UInt<3>("h4"), io.funct3) @[ALU.scala 133:22]
                when _T_26 : @[ALU.scala 133:22]
                  node _T_27 = lt(io.operand1, io.operand2) @[ALU.scala 148:25]
                  when _T_27 : @[ALU.scala 148:37]
                    io.branchEnable <= UInt<1>("h1") @[ALU.scala 149:29]
                    node _io_branchOut_T_12 = add(io.pcIn, io.imm) @[ALU.scala 150:35]
                    node _io_branchOut_T_13 = tail(_io_branchOut_T_12, 1) @[ALU.scala 150:35]
                    node _io_branchOut_T_14 = asSInt(_io_branchOut_T_13) @[ALU.scala 150:35]
                    node _io_branchOut_T_15 = sub(_io_branchOut_T_14, asSInt(UInt<4>("h4"))) @[ALU.scala 150:41]
                    node _io_branchOut_T_16 = tail(_io_branchOut_T_15, 1) @[ALU.scala 150:41]
                    node _io_branchOut_T_17 = asSInt(_io_branchOut_T_16) @[ALU.scala 150:41]
                    io.branchOut <= _io_branchOut_T_17 @[ALU.scala 150:26]
                else :
                  node _T_28 = eq(UInt<3>("h5"), io.funct3) @[ALU.scala 133:22]
                  when _T_28 : @[ALU.scala 133:22]
                    node _T_29 = geq(io.operand1, io.operand2) @[ALU.scala 154:25]
                    when _T_29 : @[ALU.scala 154:38]
                      io.branchEnable <= UInt<1>("h1") @[ALU.scala 155:29]
                      node _io_branchOut_T_18 = add(io.pcIn, io.imm) @[ALU.scala 156:35]
                      node _io_branchOut_T_19 = tail(_io_branchOut_T_18, 1) @[ALU.scala 156:35]
                      node _io_branchOut_T_20 = asSInt(_io_branchOut_T_19) @[ALU.scala 156:35]
                      node _io_branchOut_T_21 = sub(_io_branchOut_T_20, asSInt(UInt<4>("h4"))) @[ALU.scala 156:41]
                      node _io_branchOut_T_22 = tail(_io_branchOut_T_21, 1) @[ALU.scala 156:41]
                      node _io_branchOut_T_23 = asSInt(_io_branchOut_T_22) @[ALU.scala 156:41]
                      io.branchOut <= _io_branchOut_T_23 @[ALU.scala 156:26]
                  else :
                    node _T_30 = eq(UInt<3>("h6"), io.funct3) @[ALU.scala 133:22]
                    when _T_30 : @[ALU.scala 133:22]
                      node _T_31 = lt(io.operand1, io.operand2) @[ALU.scala 161:25]
                      when _T_31 : @[ALU.scala 161:37]
                        io.branchEnable <= UInt<1>("h1") @[ALU.scala 162:29]
                        node _io_branchOut_T_24 = add(io.pcIn, io.imm) @[ALU.scala 163:35]
                        node _io_branchOut_T_25 = tail(_io_branchOut_T_24, 1) @[ALU.scala 163:35]
                        node _io_branchOut_T_26 = asSInt(_io_branchOut_T_25) @[ALU.scala 163:35]
                        node _io_branchOut_T_27 = sub(_io_branchOut_T_26, asSInt(UInt<4>("h4"))) @[ALU.scala 163:41]
                        node _io_branchOut_T_28 = tail(_io_branchOut_T_27, 1) @[ALU.scala 163:41]
                        node _io_branchOut_T_29 = asSInt(_io_branchOut_T_28) @[ALU.scala 163:41]
                        io.branchOut <= _io_branchOut_T_29 @[ALU.scala 163:26]
                    else :
                      node _T_32 = eq(UInt<3>("h7"), io.funct3) @[ALU.scala 133:22]
                      when _T_32 : @[ALU.scala 133:22]
                        node _T_33 = asUInt(io.operand1) @[ALU.scala 167:25]
                        node _T_34 = asUInt(io.operand2) @[ALU.scala 167:44]
                        node _T_35 = geq(_T_33, _T_34) @[ALU.scala 167:32]
                        when _T_35 : @[ALU.scala 167:52]
                          io.branchEnable <= UInt<1>("h1") @[ALU.scala 168:29]
                          node _io_branchOut_T_30 = add(io.pcIn, io.imm) @[ALU.scala 169:35]
                          node _io_branchOut_T_31 = tail(_io_branchOut_T_30, 1) @[ALU.scala 169:35]
                          node _io_branchOut_T_32 = asSInt(_io_branchOut_T_31) @[ALU.scala 169:35]
                          node _io_branchOut_T_33 = sub(_io_branchOut_T_32, asSInt(UInt<4>("h4"))) @[ALU.scala 169:41]
                          node _io_branchOut_T_34 = tail(_io_branchOut_T_33, 1) @[ALU.scala 169:41]
                          node _io_branchOut_T_35 = asSInt(_io_branchOut_T_34) @[ALU.scala 169:41]
                          io.branchOut <= _io_branchOut_T_35 @[ALU.scala 169:26]
          else :
            node _T_36 = eq(UInt<3>("h5"), io.group) @[ALU.scala 50:17]
            when _T_36 : @[ALU.scala 50:17]
              node _io_branchOut_T_36 = add(io.pcIn, io.imm) @[ALU.scala 176:29]
              node _io_branchOut_T_37 = tail(_io_branchOut_T_36, 1) @[ALU.scala 176:29]
              node _io_branchOut_T_38 = asSInt(_io_branchOut_T_37) @[ALU.scala 176:29]
              io.branchOut <= _io_branchOut_T_38 @[ALU.scala 176:20]
            else :
              node _T_37 = eq(UInt<3>("h6"), io.group) @[ALU.scala 50:17]
              when _T_37 : @[ALU.scala 50:17]
                node _io_branchOut_T_39 = add(io.operand1, io.imm) @[ALU.scala 180:32]
                node _io_branchOut_T_40 = tail(_io_branchOut_T_39, 1) @[ALU.scala 180:32]
                node _io_branchOut_T_41 = asSInt(_io_branchOut_T_40) @[ALU.scala 180:32]
                io.branchOut <= _io_branchOut_T_41 @[ALU.scala 180:20]
              else :
                node _T_38 = eq(UInt<3>("h7"), io.group) @[ALU.scala 50:17]
                when _T_38 : @[ALU.scala 50:17]
                  node _io_ALUout_T_29 = bits(io.imm, 19, 0) @[ALU.scala 183:26]
                  node _io_ALUout_T_30 = shl(_io_ALUout_T_29, 12) @[ALU.scala 183:34]
                  node _io_ALUout_T_31 = asSInt(_io_ALUout_T_30) @[ALU.scala 183:41]
                  io.ALUout <= _io_ALUout_T_31 @[ALU.scala 183:17]
                else :
                  node _T_39 = eq(UInt<4>("h8"), io.group) @[ALU.scala 50:17]
                  when _T_39 : @[ALU.scala 50:17]
                    node _io_ALUout_T_32 = bits(io.imm, 19, 0) @[ALU.scala 186:34]
                    node _io_ALUout_T_33 = shl(_io_ALUout_T_32, 12) @[ALU.scala 186:42]
                    node _io_ALUout_T_34 = asSInt(_io_ALUout_T_33) @[ALU.scala 186:49]
                    node _io_ALUout_T_35 = add(io.pcIn, _io_ALUout_T_34) @[ALU.scala 186:26]
                    node _io_ALUout_T_36 = tail(_io_ALUout_T_35, 1) @[ALU.scala 186:26]
                    node _io_ALUout_T_37 = asSInt(_io_ALUout_T_36) @[ALU.scala 186:26]
                    io.ALUout <= _io_ALUout_T_37 @[ALU.scala 186:17]
    reg cntReg : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[ALU.scala 192:23]
    node _cntNext_T = geq(io.imm, asSInt(UInt<5>("hc"))) @[ALU.scala 194:50]
    node _cntNext_T_1 = and(io.branchEnable, _cntNext_T) @[ALU.scala 194:39]
    node _cntNext_T_2 = eq(io.imm, asSInt(UInt<1>("h0"))) @[ALU.scala 194:93]
    node _cntNext_T_3 = and(io.branchEnable, _cntNext_T_2) @[ALU.scala 194:82]
    node _cntNext_T_4 = or(_cntNext_T_1, _cntNext_T_3) @[ALU.scala 194:61]
    node _cntNext_T_5 = eq(io.imm, asSInt(UInt<5>("h8"))) @[ALU.scala 194:141]
    node _cntNext_T_6 = and(io.branchEnable, _cntNext_T_5) @[ALU.scala 194:130]
    node _cntNext_T_7 = gt(cntReg, UInt<1>("h0")) @[ALU.scala 194:167]
    node _cntNext_T_8 = sub(cntReg, UInt<1>("h1")) @[ALU.scala 194:181]
    node _cntNext_T_9 = tail(_cntNext_T_8, 1) @[ALU.scala 194:181]
    node _cntNext_T_10 = mux(_cntNext_T_7, _cntNext_T_9, UInt<1>("h0")) @[ALU.scala 194:159]
    node _cntNext_T_11 = mux(_cntNext_T_6, UInt<1>("h1"), _cntNext_T_10) @[ALU.scala 194:113]
    node cntNext = mux(_cntNext_T_4, UInt<2>("h2"), _cntNext_T_11) @[ALU.scala 194:20]
    node _rdReg_T = gt(cntReg, UInt<1>("h0")) @[ALU.scala 195:34]
    node _rdReg_T_1 = gt(io.imm, asSInt(UInt<4>("h4"))) @[ALU.scala 195:55]
    node _rdReg_T_2 = and(_rdReg_T_1, io.branchEnable) @[ALU.scala 195:61]
    node _rdReg_T_3 = eq(io.imm, asSInt(UInt<1>("h0"))) @[ALU.scala 195:89]
    node _rdReg_T_4 = and(_rdReg_T_3, io.branchEnable) @[ALU.scala 195:97]
    node _rdReg_T_5 = or(_rdReg_T_2, _rdReg_T_4) @[ALU.scala 195:81]
    node _rdReg_T_6 = mux(_rdReg_T_5, UInt<1>("h0"), io.rdIn) @[ALU.scala 195:49]
    node _rdReg_T_7 = mux(_rdReg_T, UInt<1>("h0"), _rdReg_T_6) @[ALU.scala 195:26]
    reg rdReg : UInt, clock with :
      reset => (UInt<1>("h0"), rdReg) @[ALU.scala 195:22]
    rdReg <= _rdReg_T_7 @[ALU.scala 195:22]
    node _cntNext2_T = gt(cntNext, UInt<1>("h0")) @[ALU.scala 196:30]
    node _cntNext2_T_1 = sub(cntNext, UInt<1>("h1")) @[ALU.scala 196:45]
    node _cntNext2_T_2 = tail(_cntNext2_T_1, 1) @[ALU.scala 196:45]
    node cntNext2 = mux(_cntNext2_T, _cntNext2_T_2, cntNext) @[ALU.scala 196:21]
    cntReg <= cntNext2 @[ALU.scala 197:10]
    io.rdOut <= rdReg @[ALU.scala 199:11]

  module Memorizer :
    input clock : Clock
    input reset : Reset
    output io : { flip ALUinput : SInt<32>, flip rdInput : UInt<5>, flip rdAddr : UInt<10>, flip wrAddr : UInt<10>, flip wrData : UInt<32>, flip wrEna : UInt<1>, flip rdEna : UInt<1>, flip memOp : UInt<3>, rdLastRegMemOut : UInt<5>, aluLastRegMemOut : SInt<32>, rdLoadRegMemOut : UInt<5>, aluLoadRegMemOut : SInt<32>, loadEnabler : UInt<1>, rdData : SInt<32>, rdEnaOut : UInt<1>, wrEnaOut : UInt<1>, rdOutput : UInt<5>, ALUoutput : SInt<32>}

    reg rdReg : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[Memorizer.scala 32:22]
    rdReg <= io.rdInput @[Memorizer.scala 32:22]
    reg ALUreg : SInt, clock with :
      reset => (reset, asSInt(UInt<1>("h0"))) @[Memorizer.scala 33:23]
    ALUreg <= io.ALUinput @[Memorizer.scala 33:23]
    io.rdOutput <= rdReg @[Memorizer.scala 34:15]
    io.ALUoutput <= ALUreg @[Memorizer.scala 35:16]
    reg rdLastRegMem : UInt<5>, clock with :
      reset => (reset, UInt<5>("h0")) @[Memorizer.scala 38:29]
    reg aluLastRegMem : SInt<32>, clock with :
      reset => (reset, asSInt(UInt<32>("h0"))) @[Memorizer.scala 39:30]
    rdLastRegMem <= io.rdOutput @[Memorizer.scala 41:16]
    aluLastRegMem <= io.ALUoutput @[Memorizer.scala 42:17]
    io.rdLastRegMemOut <= rdLastRegMem @[Memorizer.scala 43:22]
    io.aluLastRegMemOut <= aluLastRegMem @[Memorizer.scala 44:23]
    reg wrEnaReg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[Memorizer.scala 46:25]
    wrEnaReg <= io.wrEna @[Memorizer.scala 46:25]
    reg rdEnaReg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[Memorizer.scala 47:25]
    rdEnaReg <= io.rdEna @[Memorizer.scala 47:25]
    reg wrDataReg : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[Memorizer.scala 48:26]
    wrDataReg <= io.wrData @[Memorizer.scala 48:26]
    reg rdAddrReg : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[Memorizer.scala 49:26]
    rdAddrReg <= io.rdAddr @[Memorizer.scala 49:26]
    reg wrAddrReg : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[Memorizer.scala 50:26]
    wrAddrReg <= io.wrAddr @[Memorizer.scala 50:26]
    reg memOpReg : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[Memorizer.scala 51:25]
    memOpReg <= io.memOp @[Memorizer.scala 51:25]
    smem mem_0 : UInt<8> [1024] @[Memorizer.scala 52:38]
    smem mem_1 : UInt<8> [1024] @[Memorizer.scala 52:38]
    smem mem_2 : UInt<8> [1024] @[Memorizer.scala 52:38]
    smem mem_3 : UInt<8> [1024] @[Memorizer.scala 52:38]
    io.wrEnaOut <= wrEnaReg @[Memorizer.scala 53:15]
    io.rdEnaOut <= rdEnaReg @[Memorizer.scala 54:15]
    node _readByte0_T = shr(io.rdAddr, 2) @[Memorizer.scala 56:41]
    wire _readByte0_WIRE : UInt @[Memorizer.scala 56:31]
    _readByte0_WIRE is invalid @[Memorizer.scala 56:31]
    when UInt<1>("h1") : @[Memorizer.scala 56:31]
      _readByte0_WIRE <= _readByte0_T @[Memorizer.scala 56:31]
      node _readByte0_T_1 = or(_readByte0_WIRE, UInt<10>("h0")) @[Memorizer.scala 56:31]
      node _readByte0_T_2 = bits(_readByte0_T_1, 9, 0) @[Memorizer.scala 56:31]
      read mport readByte0 = mem_0[_readByte0_T_2], clock @[Memorizer.scala 56:31]
    node _readByte1_T = shr(io.rdAddr, 2) @[Memorizer.scala 57:41]
    wire _readByte1_WIRE : UInt @[Memorizer.scala 57:31]
    _readByte1_WIRE is invalid @[Memorizer.scala 57:31]
    when UInt<1>("h1") : @[Memorizer.scala 57:31]
      _readByte1_WIRE <= _readByte1_T @[Memorizer.scala 57:31]
      node _readByte1_T_1 = or(_readByte1_WIRE, UInt<10>("h0")) @[Memorizer.scala 57:31]
      node _readByte1_T_2 = bits(_readByte1_T_1, 9, 0) @[Memorizer.scala 57:31]
      read mport readByte1 = mem_1[_readByte1_T_2], clock @[Memorizer.scala 57:31]
    node _readByte2_T = shr(io.rdAddr, 2) @[Memorizer.scala 58:41]
    wire _readByte2_WIRE : UInt @[Memorizer.scala 58:31]
    _readByte2_WIRE is invalid @[Memorizer.scala 58:31]
    when UInt<1>("h1") : @[Memorizer.scala 58:31]
      _readByte2_WIRE <= _readByte2_T @[Memorizer.scala 58:31]
      node _readByte2_T_1 = or(_readByte2_WIRE, UInt<10>("h0")) @[Memorizer.scala 58:31]
      node _readByte2_T_2 = bits(_readByte2_T_1, 9, 0) @[Memorizer.scala 58:31]
      read mport readByte2 = mem_2[_readByte2_T_2], clock @[Memorizer.scala 58:31]
    node _readByte3_T = shr(io.rdAddr, 2) @[Memorizer.scala 59:41]
    wire _readByte3_WIRE : UInt @[Memorizer.scala 59:31]
    _readByte3_WIRE is invalid @[Memorizer.scala 59:31]
    when UInt<1>("h1") : @[Memorizer.scala 59:31]
      _readByte3_WIRE <= _readByte3_T @[Memorizer.scala 59:31]
      node _readByte3_T_1 = or(_readByte3_WIRE, UInt<10>("h0")) @[Memorizer.scala 59:31]
      node _readByte3_T_2 = bits(_readByte3_T_1, 9, 0) @[Memorizer.scala 59:31]
      read mport readByte3 = mem_3[_readByte3_T_2], clock @[Memorizer.scala 59:31]
    node _offset_T = bits(io.rdAddr, 1, 0) @[Memorizer.scala 60:34]
    reg offset : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[Memorizer.scala 60:24]
    offset <= _offset_T @[Memorizer.scala 60:24]
    node writeByte3 = bits(wrDataReg, 31, 24) @[Memorizer.scala 63:28]
    node writeByte2 = bits(wrDataReg, 23, 16) @[Memorizer.scala 64:28]
    node writeByte1 = bits(wrDataReg, 15, 8) @[Memorizer.scala 65:28]
    node writeByte0 = bits(wrDataReg, 7, 0) @[Memorizer.scala 66:28]
    io.rdData <= asSInt(UInt<1>("h0")) @[Memorizer.scala 68:13]
    io.rdLoadRegMemOut <= UInt<1>("h0") @[Memorizer.scala 69:22]
    io.aluLoadRegMemOut <= asSInt(UInt<1>("h0")) @[Memorizer.scala 70:23]
    node _T = eq(UInt<1>("h0"), memOpReg) @[Memorizer.scala 71:20]
    when _T : @[Memorizer.scala 71:20]
      io.rdData <= asSInt(UInt<4>("h4")) @[Memorizer.scala 73:17]
    else :
      node _T_1 = eq(UInt<1>("h1"), memOpReg) @[Memorizer.scala 71:20]
      when _T_1 : @[Memorizer.scala 71:20]
        node _io_rdData_T = asSInt(readByte0) @[Memorizer.scala 76:30]
        io.rdData <= _io_rdData_T @[Memorizer.scala 76:17]
        when wrEnaReg : @[Memorizer.scala 77:22]
          io.rdData <= asSInt(UInt<1>("h0")) @[Memorizer.scala 78:19]
          node _T_2 = eq(UInt<1>("h0"), offset) @[Memorizer.scala 79:24]
          when _T_2 : @[Memorizer.scala 79:24]
            node _T_3 = shr(wrAddrReg, 2) @[Memorizer.scala 81:35]
            node _T_4 = or(_T_3, UInt<10>("h0"))
            node _T_5 = bits(_T_4, 9, 0)
            write mport MPORT = mem_0[_T_5], clock
            MPORT <= writeByte0
          else :
            node _T_6 = eq(UInt<1>("h1"), offset) @[Memorizer.scala 79:24]
            when _T_6 : @[Memorizer.scala 79:24]
              node _T_7 = shr(wrAddrReg, 2) @[Memorizer.scala 84:35]
              node _T_8 = or(_T_7, UInt<10>("h0"))
              node _T_9 = bits(_T_8, 9, 0)
              write mport MPORT_1 = mem_1[_T_9], clock
              MPORT_1 <= writeByte0
            else :
              node _T_10 = eq(UInt<2>("h2"), offset) @[Memorizer.scala 79:24]
              when _T_10 : @[Memorizer.scala 79:24]
                node _T_11 = shr(wrAddrReg, 2) @[Memorizer.scala 87:35]
                node _T_12 = or(_T_11, UInt<10>("h0"))
                node _T_13 = bits(_T_12, 9, 0)
                write mport MPORT_2 = mem_2[_T_13], clock
                MPORT_2 <= writeByte0
              else :
                node _T_14 = eq(UInt<2>("h3"), offset) @[Memorizer.scala 79:24]
                when _T_14 : @[Memorizer.scala 79:24]
                  node _T_15 = shr(wrAddrReg, 2) @[Memorizer.scala 90:35]
                  node _T_16 = or(_T_15, UInt<10>("h0"))
                  node _T_17 = bits(_T_16, 9, 0)
                  write mport MPORT_3 = mem_3[_T_17], clock
                  MPORT_3 <= writeByte0
      else :
        node _T_18 = eq(UInt<2>("h2"), memOpReg) @[Memorizer.scala 71:20]
        when _T_18 : @[Memorizer.scala 71:20]
          node _io_rdData_T_1 = cat(readByte1, readByte0) @[Cat.scala 33:92]
          node _io_rdData_T_2 = asSInt(_io_rdData_T_1) @[Memorizer.scala 96:47]
          io.rdData <= _io_rdData_T_2 @[Memorizer.scala 96:17]
          when wrEnaReg : @[Memorizer.scala 97:22]
            io.rdData <= asSInt(UInt<1>("h0")) @[Memorizer.scala 98:19]
            node _T_19 = eq(UInt<1>("h0"), offset) @[Memorizer.scala 99:24]
            when _T_19 : @[Memorizer.scala 99:24]
              node _T_20 = shr(wrAddrReg, 2) @[Memorizer.scala 101:35]
              node _T_21 = or(_T_20, UInt<10>("h0"))
              node _T_22 = bits(_T_21, 9, 0)
              write mport MPORT_4 = mem_0[_T_22], clock
              MPORT_4 <= writeByte0
              node _T_23 = shr(wrAddrReg, 2) @[Memorizer.scala 102:35]
              node _T_24 = or(_T_23, UInt<10>("h0"))
              node _T_25 = bits(_T_24, 9, 0)
              write mport MPORT_5 = mem_1[_T_25], clock
              MPORT_5 <= writeByte1
            else :
              node _T_26 = eq(UInt<1>("h1"), offset) @[Memorizer.scala 99:24]
              when _T_26 : @[Memorizer.scala 99:24]
                node _T_27 = shr(wrAddrReg, 2) @[Memorizer.scala 105:35]
                node _T_28 = or(_T_27, UInt<10>("h0"))
                node _T_29 = bits(_T_28, 9, 0)
                write mport MPORT_6 = mem_1[_T_29], clock
                MPORT_6 <= writeByte0
                node _T_30 = shr(wrAddrReg, 2) @[Memorizer.scala 106:35]
                node _T_31 = or(_T_30, UInt<10>("h0"))
                node _T_32 = bits(_T_31, 9, 0)
                write mport MPORT_7 = mem_2[_T_32], clock
                MPORT_7 <= writeByte1
              else :
                node _T_33 = eq(UInt<2>("h2"), offset) @[Memorizer.scala 99:24]
                when _T_33 : @[Memorizer.scala 99:24]
                  node _T_34 = shr(wrAddrReg, 2) @[Memorizer.scala 109:35]
                  node _T_35 = or(_T_34, UInt<10>("h0"))
                  node _T_36 = bits(_T_35, 9, 0)
                  write mport MPORT_8 = mem_2[_T_36], clock
                  MPORT_8 <= writeByte0
                  node _T_37 = shr(wrAddrReg, 2) @[Memorizer.scala 110:35]
                  node _T_38 = or(_T_37, UInt<10>("h0"))
                  node _T_39 = bits(_T_38, 9, 0)
                  write mport MPORT_9 = mem_3[_T_39], clock
                  MPORT_9 <= writeByte1
                else :
                  node _T_40 = eq(UInt<2>("h3"), offset) @[Memorizer.scala 99:24]
                  when _T_40 : @[Memorizer.scala 99:24]
                    node _T_41 = shr(wrAddrReg, 2) @[Memorizer.scala 113:35]
                    node _T_42 = or(_T_41, UInt<10>("h0"))
                    node _T_43 = bits(_T_42, 9, 0)
                    write mport MPORT_10 = mem_3[_T_43], clock
                    MPORT_10 <= writeByte0
        else :
          node _T_44 = eq(UInt<2>("h3"), memOpReg) @[Memorizer.scala 71:20]
          when _T_44 : @[Memorizer.scala 71:20]
            io.rdData <= asSInt(UInt<1>("h0")) @[Memorizer.scala 121:17]
            node _T_45 = eq(UInt<1>("h0"), offset) @[Memorizer.scala 122:22]
            when _T_45 : @[Memorizer.scala 122:22]
              node io_rdData_lo = cat(readByte1, readByte0) @[Cat.scala 33:92]
              node io_rdData_hi = cat(readByte3, readByte2) @[Cat.scala 33:92]
              node _io_rdData_T_3 = cat(io_rdData_hi, io_rdData_lo) @[Cat.scala 33:92]
              node _io_rdData_T_4 = asSInt(_io_rdData_T_3) @[Memorizer.scala 124:72]
              io.rdData <= _io_rdData_T_4 @[Memorizer.scala 124:21]
              when wrEnaReg : @[Memorizer.scala 126:26]
                node _T_46 = shr(wrAddrReg, 2) @[Memorizer.scala 128:36]
                node _T_47 = or(_T_46, UInt<10>("h0"))
                node _T_48 = bits(_T_47, 9, 0)
                write mport MPORT_11 = mem_0[_T_48], clock
                MPORT_11 <= writeByte0
                node _T_49 = shr(wrAddrReg, 2) @[Memorizer.scala 129:36]
                node _T_50 = or(_T_49, UInt<10>("h0"))
                node _T_51 = bits(_T_50, 9, 0)
                write mport MPORT_12 = mem_1[_T_51], clock
                MPORT_12 <= writeByte1
                node _T_52 = shr(wrAddrReg, 2) @[Memorizer.scala 130:36]
                node _T_53 = or(_T_52, UInt<10>("h0"))
                node _T_54 = bits(_T_53, 9, 0)
                write mport MPORT_13 = mem_2[_T_54], clock
                MPORT_13 <= writeByte2
                node _T_55 = shr(wrAddrReg, 2) @[Memorizer.scala 131:36]
                node _T_56 = or(_T_55, UInt<10>("h0"))
                node _T_57 = bits(_T_56, 9, 0)
                write mport MPORT_14 = mem_3[_T_57], clock
                MPORT_14 <= writeByte3
            else :
              node _T_58 = eq(UInt<1>("h1"), offset) @[Memorizer.scala 122:22]
              when _T_58 : @[Memorizer.scala 122:22]
                node io_rdData_lo_1 = cat(readByte2, readByte1) @[Cat.scala 33:92]
                node io_rdData_hi_1 = cat(UInt<8>("h0"), readByte3) @[Cat.scala 33:92]
                node _io_rdData_T_5 = cat(io_rdData_hi_1, io_rdData_lo_1) @[Cat.scala 33:92]
                node _io_rdData_T_6 = asSInt(_io_rdData_T_5) @[Memorizer.scala 135:70]
                io.rdData <= _io_rdData_T_6 @[Memorizer.scala 135:21]
                when wrEnaReg : @[Memorizer.scala 136:26]
                  node _T_59 = shr(wrAddrReg, 2) @[Memorizer.scala 138:36]
                  node _T_60 = or(_T_59, UInt<10>("h0"))
                  node _T_61 = bits(_T_60, 9, 0)
                  write mport MPORT_15 = mem_1[_T_61], clock
                  MPORT_15 <= writeByte0
                  node _T_62 = shr(wrAddrReg, 2) @[Memorizer.scala 139:36]
                  node _T_63 = or(_T_62, UInt<10>("h0"))
                  node _T_64 = bits(_T_63, 9, 0)
                  write mport MPORT_16 = mem_2[_T_64], clock
                  MPORT_16 <= writeByte1
                  node _T_65 = shr(wrAddrReg, 2) @[Memorizer.scala 140:36]
                  node _T_66 = or(_T_65, UInt<10>("h0"))
                  node _T_67 = bits(_T_66, 9, 0)
                  write mport MPORT_17 = mem_3[_T_67], clock
                  MPORT_17 <= writeByte2
              else :
                node _T_68 = eq(UInt<2>("h2"), offset) @[Memorizer.scala 122:22]
                when _T_68 : @[Memorizer.scala 122:22]
                  node _io_rdData_T_7 = cat(readByte3, readByte2) @[Cat.scala 33:92]
                  node _io_rdData_T_8 = asSInt(_io_rdData_T_7) @[Memorizer.scala 145:50]
                  io.rdData <= _io_rdData_T_8 @[Memorizer.scala 145:21]
                  when wrEnaReg : @[Memorizer.scala 147:26]
                    node _T_69 = shr(wrAddrReg, 2) @[Memorizer.scala 149:36]
                    node _T_70 = or(_T_69, UInt<10>("h0"))
                    node _T_71 = bits(_T_70, 9, 0)
                    write mport MPORT_18 = mem_2[_T_71], clock
                    MPORT_18 <= writeByte0
                    node _T_72 = shr(wrAddrReg, 2) @[Memorizer.scala 150:36]
                    node _T_73 = or(_T_72, UInt<10>("h0"))
                    node _T_74 = bits(_T_73, 9, 0)
                    write mport MPORT_19 = mem_3[_T_74], clock
                    MPORT_19 <= writeByte1
                else :
                  node _T_75 = eq(UInt<2>("h3"), offset) @[Memorizer.scala 122:22]
                  when _T_75 : @[Memorizer.scala 122:22]
                    node _io_rdData_T_9 = asSInt(readByte3) @[Memorizer.scala 154:34]
                    io.rdData <= _io_rdData_T_9 @[Memorizer.scala 154:21]
                    when wrEnaReg : @[Memorizer.scala 155:26]
                      node _T_76 = shr(wrAddrReg, 2) @[Memorizer.scala 157:36]
                      node _T_77 = or(_T_76, UInt<10>("h0"))
                      node _T_78 = bits(_T_77, 9, 0)
                      write mport MPORT_20 = mem_3[_T_78], clock
                      MPORT_20 <= writeByte0
          else :
            node _T_79 = eq(UInt<3>("h4"), memOpReg) @[Memorizer.scala 71:20]
            when _T_79 : @[Memorizer.scala 71:20]
              node _io_rdData_T_10 = cat(UInt<24>("h0"), readByte0) @[Cat.scala 33:92]
              node _io_rdData_T_11 = asSInt(_io_rdData_T_10) @[Memorizer.scala 165:46]
              io.rdData <= _io_rdData_T_11 @[Memorizer.scala 165:17]
            else :
              node _T_80 = eq(UInt<3>("h5"), memOpReg) @[Memorizer.scala 71:20]
              when _T_80 : @[Memorizer.scala 71:20]
                node io_rdData_hi_2 = cat(UInt<16>("h0"), readByte1) @[Cat.scala 33:92]
                node _io_rdData_T_12 = cat(io_rdData_hi_2, readByte0) @[Cat.scala 33:92]
                node _io_rdData_T_13 = asSInt(_io_rdData_T_12) @[Memorizer.scala 168:58]
                io.rdData <= _io_rdData_T_13 @[Memorizer.scala 168:17]
    reg rdLoadRegger : UInt<5>, clock with :
      reset => (reset, UInt<5>("h0")) @[Memorizer.scala 171:29]
    reg aluLoadRegger : SInt<32>, clock with :
      reset => (reset, asSInt(UInt<32>("h0"))) @[Memorizer.scala 172:30]
    reg enabler : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[Memorizer.scala 173:24]
    enabler <= rdEnaReg @[Memorizer.scala 174:11]
    io.loadEnabler <= enabler @[Memorizer.scala 175:18]
    rdLoadRegger <= rdReg @[Memorizer.scala 176:16]
    aluLoadRegger <= io.rdData @[Memorizer.scala 177:16]
    io.rdLoadRegMemOut <= rdLoadRegger @[Memorizer.scala 178:22]
    io.aluLoadRegMemOut <= aluLoadRegger @[Memorizer.scala 179:23]

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
    node _T_2 = eq(rdReg, UInt<6>("h20")) @[Write_backer.scala 31:45]
    node _T_3 = or(_T_1, _T_2) @[Write_backer.scala 31:36]
    when _T_3 : @[Write_backer.scala 31:55]
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
          node _dec_io_in_T_2 = bits(io.xReg, 11, 5) @[DisplayMux.scala 32:35]
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
    output io : { seg : UInt<7>, an : UInt<8>}

    wire _x_WIRE : SInt<32>[32] @[Food.scala 17:26]
    _x_WIRE[0] <= asSInt(UInt<32>("h0")) @[Food.scala 17:26]
    _x_WIRE[1] <= asSInt(UInt<32>("h0")) @[Food.scala 17:26]
    _x_WIRE[2] <= asSInt(UInt<32>("h0")) @[Food.scala 17:26]
    _x_WIRE[3] <= asSInt(UInt<32>("h0")) @[Food.scala 17:26]
    _x_WIRE[4] <= asSInt(UInt<32>("h0")) @[Food.scala 17:26]
    _x_WIRE[5] <= asSInt(UInt<32>("h0")) @[Food.scala 17:26]
    _x_WIRE[6] <= asSInt(UInt<32>("h0")) @[Food.scala 17:26]
    _x_WIRE[7] <= asSInt(UInt<32>("h0")) @[Food.scala 17:26]
    _x_WIRE[8] <= asSInt(UInt<32>("h0")) @[Food.scala 17:26]
    _x_WIRE[9] <= asSInt(UInt<32>("h0")) @[Food.scala 17:26]
    _x_WIRE[10] <= asSInt(UInt<32>("h0")) @[Food.scala 17:26]
    _x_WIRE[11] <= asSInt(UInt<32>("h0")) @[Food.scala 17:26]
    _x_WIRE[12] <= asSInt(UInt<32>("h0")) @[Food.scala 17:26]
    _x_WIRE[13] <= asSInt(UInt<32>("h0")) @[Food.scala 17:26]
    _x_WIRE[14] <= asSInt(UInt<32>("h0")) @[Food.scala 17:26]
    _x_WIRE[15] <= asSInt(UInt<32>("h0")) @[Food.scala 17:26]
    _x_WIRE[16] <= asSInt(UInt<32>("h0")) @[Food.scala 17:26]
    _x_WIRE[17] <= asSInt(UInt<32>("h0")) @[Food.scala 17:26]
    _x_WIRE[18] <= asSInt(UInt<32>("h0")) @[Food.scala 17:26]
    _x_WIRE[19] <= asSInt(UInt<32>("h0")) @[Food.scala 17:26]
    _x_WIRE[20] <= asSInt(UInt<32>("h0")) @[Food.scala 17:26]
    _x_WIRE[21] <= asSInt(UInt<32>("h0")) @[Food.scala 17:26]
    _x_WIRE[22] <= asSInt(UInt<32>("h0")) @[Food.scala 17:26]
    _x_WIRE[23] <= asSInt(UInt<32>("h0")) @[Food.scala 17:26]
    _x_WIRE[24] <= asSInt(UInt<32>("h0")) @[Food.scala 17:26]
    _x_WIRE[25] <= asSInt(UInt<32>("h0")) @[Food.scala 17:26]
    _x_WIRE[26] <= asSInt(UInt<32>("h0")) @[Food.scala 17:26]
    _x_WIRE[27] <= asSInt(UInt<32>("h0")) @[Food.scala 17:26]
    _x_WIRE[28] <= asSInt(UInt<32>("h0")) @[Food.scala 17:26]
    _x_WIRE[29] <= asSInt(UInt<32>("h0")) @[Food.scala 17:26]
    _x_WIRE[30] <= asSInt(UInt<32>("h0")) @[Food.scala 17:26]
    _x_WIRE[31] <= asSInt(UInt<32>("h0")) @[Food.scala 17:26]
    reg x : SInt<32>[32], clock with :
      reset => (reset, _x_WIRE) @[Food.scala 17:18]
    inst fetcher of Fetcher @[Food.scala 18:29]
    fetcher.clock <= clock
    fetcher.reset <= reset
    inst decoder of Decoder @[Food.scala 19:29]
    decoder.clock <= clock
    decoder.reset <= reset
    inst executer of Executer @[Food.scala 20:29]
    executer.clock <= clock
    executer.reset <= reset
    inst ALU of ALU @[Food.scala 21:29]
    ALU.clock <= clock
    ALU.reset <= reset
    inst memorizer of Memorizer @[Food.scala 22:29]
    memorizer.clock <= clock
    memorizer.reset <= reset
    inst write_backer of Write_backer @[Food.scala 23:29]
    write_backer.clock <= clock
    write_backer.reset <= reset
    inst Disp of DisplayMux @[Food.scala 24:29]
    Disp.clock <= clock
    Disp.reset <= reset
    wire _instrReg_WIRE : UInt<32>[9] @[Food.scala 25:38]
    _instrReg_WIRE[0] <= UInt<32>("hdeadc0b7") @[Food.scala 25:38]
    _instrReg_WIRE[1] <= UInt<32>("heef08093") @[Food.scala 25:38]
    _instrReg_WIRE[2] <= UInt<32>("h102023") @[Food.scala 25:38]
    _instrReg_WIRE[3] <= UInt<32>("h2103") @[Food.scala 25:38]
    _instrReg_WIRE[4] <= UInt<32>("ha55b08b7") @[Food.scala 25:38]
    _instrReg_WIRE[5] <= UInt<32>("hb588893") @[Food.scala 25:38]
    _instrReg_WIRE[6] <= UInt<32>("h63") @[Food.scala 25:38]
    _instrReg_WIRE[7] <= UInt<32>("h100093") @[Food.scala 25:38]
    _instrReg_WIRE[8] <= UInt<32>("h13") @[Food.scala 25:38]
    reg instrReg : UInt<32>[9], clock with :
      reset => (reset, _instrReg_WIRE) @[Food.scala 25:30]
    fetcher.io.instrIn[0] <= instrReg[0] @[Food.scala 37:25]
    fetcher.io.instrIn[1] <= instrReg[1] @[Food.scala 37:25]
    fetcher.io.instrIn[2] <= instrReg[2] @[Food.scala 37:25]
    fetcher.io.instrIn[3] <= instrReg[3] @[Food.scala 37:25]
    fetcher.io.instrIn[4] <= instrReg[4] @[Food.scala 37:25]
    fetcher.io.instrIn[5] <= instrReg[5] @[Food.scala 37:25]
    fetcher.io.instrIn[6] <= instrReg[6] @[Food.scala 37:25]
    fetcher.io.instrIn[7] <= instrReg[7] @[Food.scala 37:25]
    fetcher.io.instrIn[8] <= instrReg[8] @[Food.scala 37:25]
    decoder.io.instrIn <= fetcher.io.instrOut @[Food.scala 39:24]
    decoder.io.pcIn <= fetcher.io.pcOut @[Food.scala 41:19]
    executer.io.pcIn <= decoder.io.pcOut @[Food.scala 42:20]
    executer.io.rdIn <= ALU.io.rdOut @[Food.scala 44:20]
    fetcher.io.branchIn <= ALU.io.branchOut @[Food.scala 46:23]
    fetcher.io.branchEnable <= ALU.io.branchEnable @[Food.scala 47:27]
    decoder.io.rdRegEx <= ALU.io.rdOut @[Food.scala 50:22]
    decoder.io.LoadMemEnable <= ALU.io.rdEna @[Food.scala 52:28]
    fetcher.io.shouldMux <= decoder.io.shouldMux @[Food.scala 54:24]
    executer.io.x[0] <= x[0] @[Food.scala 59:17]
    executer.io.x[1] <= x[1] @[Food.scala 59:17]
    executer.io.x[2] <= x[2] @[Food.scala 59:17]
    executer.io.x[3] <= x[3] @[Food.scala 59:17]
    executer.io.x[4] <= x[4] @[Food.scala 59:17]
    executer.io.x[5] <= x[5] @[Food.scala 59:17]
    executer.io.x[6] <= x[6] @[Food.scala 59:17]
    executer.io.x[7] <= x[7] @[Food.scala 59:17]
    executer.io.x[8] <= x[8] @[Food.scala 59:17]
    executer.io.x[9] <= x[9] @[Food.scala 59:17]
    executer.io.x[10] <= x[10] @[Food.scala 59:17]
    executer.io.x[11] <= x[11] @[Food.scala 59:17]
    executer.io.x[12] <= x[12] @[Food.scala 59:17]
    executer.io.x[13] <= x[13] @[Food.scala 59:17]
    executer.io.x[14] <= x[14] @[Food.scala 59:17]
    executer.io.x[15] <= x[15] @[Food.scala 59:17]
    executer.io.x[16] <= x[16] @[Food.scala 59:17]
    executer.io.x[17] <= x[17] @[Food.scala 59:17]
    executer.io.x[18] <= x[18] @[Food.scala 59:17]
    executer.io.x[19] <= x[19] @[Food.scala 59:17]
    executer.io.x[20] <= x[20] @[Food.scala 59:17]
    executer.io.x[21] <= x[21] @[Food.scala 59:17]
    executer.io.x[22] <= x[22] @[Food.scala 59:17]
    executer.io.x[23] <= x[23] @[Food.scala 59:17]
    executer.io.x[24] <= x[24] @[Food.scala 59:17]
    executer.io.x[25] <= x[25] @[Food.scala 59:17]
    executer.io.x[26] <= x[26] @[Food.scala 59:17]
    executer.io.x[27] <= x[27] @[Food.scala 59:17]
    executer.io.x[28] <= x[28] @[Food.scala 59:17]
    executer.io.x[29] <= x[29] @[Food.scala 59:17]
    executer.io.x[30] <= x[30] @[Food.scala 59:17]
    executer.io.x[31] <= x[31] @[Food.scala 59:17]
    executer.io.opcode <= decoder.io.opcode @[Food.scala 60:22]
    ALU.io.rdIn <= decoder.io.rdOutput @[Food.scala 61:15]
    executer.io.rs1 <= decoder.io.rs1 @[Food.scala 62:19]
    executer.io.rs2 <= decoder.io.rs2 @[Food.scala 63:19]
    executer.io.imm_I <= decoder.io.imm_I @[Food.scala 64:21]
    executer.io.imm_B <= decoder.io.imm_B @[Food.scala 65:21]
    executer.io.imm_J <= decoder.io.imm_J @[Food.scala 66:21]
    executer.io.imm_S <= decoder.io.imm_S @[Food.scala 67:21]
    executer.io.imm_U <= decoder.io.imm_U @[Food.scala 68:21]
    executer.io.funct3 <= decoder.io.funct3 @[Food.scala 69:22]
    executer.io.funct7 <= decoder.io.funct7 @[Food.scala 70:22]
    executer.io.rdLastRegMemIn <= memorizer.io.rdLastRegMemOut @[Food.scala 73:30]
    executer.io.aluLastRegMemIn <= memorizer.io.aluLastRegMemOut @[Food.scala 75:31]
    executer.io.rdLoadRegMemIn <= memorizer.io.rdLoadRegMemOut @[Food.scala 77:30]
    executer.io.aluLoadRegMemIn <= memorizer.io.aluLoadRegMemOut @[Food.scala 78:31]
    executer.io.loadEnable <= memorizer.io.loadEnabler @[Food.scala 79:26]
    ALU.io.funct3 <= executer.io.funct3out @[Food.scala 81:17]
    ALU.io.funct7 <= executer.io.funct7out @[Food.scala 82:17]
    ALU.io.pcIn <= executer.io.pcOut @[Food.scala 83:15]
    ALU.io.group <= executer.io.group @[Food.scala 84:16]
    ALU.io.operand1 <= executer.io.operand1 @[Food.scala 85:19]
    ALU.io.operand2 <= executer.io.operand2 @[Food.scala 86:19]
    ALU.io.imm <= executer.io.imm @[Food.scala 87:14]
    executer.io.ALUIn <= ALU.io.ALUout @[Food.scala 90:21]
    memorizer.io.memOp <= ALU.io.memOp @[Food.scala 93:22]
    memorizer.io.rdInput <= ALU.io.rdOut @[Food.scala 94:24]
    memorizer.io.ALUinput <= ALU.io.ALUout @[Food.scala 95:25]
    memorizer.io.rdEna <= ALU.io.rdEna @[Food.scala 96:22]
    memorizer.io.wrEna <= ALU.io.wrEna @[Food.scala 97:22]
    memorizer.io.rdAddr <= ALU.io.rdAddr @[Food.scala 98:23]
    memorizer.io.wrAddr <= ALU.io.wrAddr @[Food.scala 99:23]
    node _memorizer_io_wrData_T = asUInt(ALU.io.ALUout) @[Food.scala 100:40]
    memorizer.io.wrData <= _memorizer_io_wrData_T @[Food.scala 100:23]
    write_backer.io.rdData <= memorizer.io.rdData @[Food.scala 105:26]
    write_backer.io.rdEnaIn <= memorizer.io.rdEnaOut @[Food.scala 106:27]
    write_backer.io.rdInput <= memorizer.io.rdOutput @[Food.scala 107:27]
    write_backer.io.ALUinput <= memorizer.io.ALUoutput @[Food.scala 108:28]
    write_backer.io.wrEnaIn <= memorizer.io.wrEnaOut @[Food.scala 109:27]
    x[write_backer.io.rdOut] <= write_backer.io.ALUoutput @[Food.scala 112:28]
    node _T = eq(x[2], asSInt(UInt<31>("h5eadbeef"))) @[Food.scala 115:13]
    when _T : @[Food.scala 115:30]
      x[3] <= asSInt(UInt<31>("h5eadbeef")) @[Food.scala 116:9]
    Disp.io.xReg <= x[17] @[Food.scala 124:16]
    io.seg <= Disp.io.seg @[Food.scala 125:10]
    io.an <= Disp.io.an @[Food.scala 126:9]
    x[write_backer.io.rdOut] <= write_backer.io.ALUoutput @[Food.scala 129:28]

