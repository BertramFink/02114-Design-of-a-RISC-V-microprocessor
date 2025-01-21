circuit Food :
  module Fetcher :
    input clock : Clock
    input reset : Reset
    output io : { flip input : UInt<32>[13], instruction : UInt<32>, index : SInt<29>, flip branchIn : SInt<32>, flip shouldMux : UInt<1>, pcOut : SInt<32>, flip branchEnable : UInt<1>}

    reg pcReg : SInt<32>, clock with :
      reset => (reset, asSInt(UInt<32>("hfffffffc"))) @[Fetcher.scala 20:22]
    reg instruction : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[Fetcher.scala 21:28]
    reg branchEnableReg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[Fetcher.scala 23:32]
    reg branchInReg : SInt<32>, clock with :
      reset => (reset, asSInt(UInt<32>("h0"))) @[Fetcher.scala 24:28]
    branchInReg <= io.branchIn @[Fetcher.scala 27:15]
    branchEnableReg <= io.branchEnable @[Fetcher.scala 28:19]
    node _pcPlusReg_T = add(pcReg, asSInt(UInt<4>("h4"))) @[Fetcher.scala 32:85]
    node _pcPlusReg_T_1 = tail(_pcPlusReg_T, 1) @[Fetcher.scala 32:85]
    node _pcPlusReg_T_2 = asSInt(_pcPlusReg_T_1) @[Fetcher.scala 32:85]
    node _pcPlusReg_T_3 = mux(io.branchEnable, io.branchIn, _pcPlusReg_T_2) @[Fetcher.scala 32:46]
    node pcPlusReg = mux(io.shouldMux, pcReg, _pcPlusReg_T_3) @[Fetcher.scala 32:22]
    pcReg <= pcPlusReg @[Fetcher.scala 34:8]
    node index = shr(pcPlusReg, 2) @[Fetcher.scala 37:28]
    node _instruction_T = bits(index, 29, 0) @[Fetcher.scala 40:32]
    node _instruction_T_1 = bits(_instruction_T, 3, 0)
    instruction <= io.input[_instruction_T_1] @[Fetcher.scala 40:15]
    io.instruction <= instruction @[Fetcher.scala 42:18]
    io.index <= index @[Fetcher.scala 43:12]
    io.pcOut <= pcReg @[Fetcher.scala 44:12]

  module Decoder :
    input clock : Clock
    input reset : Reset
    output io : { flip instruction : UInt<32>, opcode : UInt<7>, rdOutput : UInt<5>, funct3 : UInt<3>, funct7 : UInt<7>, rs1 : UInt<5>, rs2 : UInt<5>, imm_I : SInt<12>, imm_S : SInt<12>, imm_B : SInt<13>, imm_U : UInt<32>, imm_J : SInt<21>, flip rdRegEx : UInt<5>, flip LoadMemEnable : UInt<1>, flip pcIn : SInt<32>, pcOut : SInt<32>, shouldMux : UInt<1>}

    node poop1 = bits(io.instruction, 19, 15) @[Decoder.scala 33:27]
    node poop2 = bits(io.instruction, 24, 20) @[Decoder.scala 34:29]
    reg instruction : UInt<32>, clock with :
      reset => (reset, UInt<32>("h0")) @[Decoder.scala 37:28]
    node _loadMemEnable_T = bits(instruction, 6, 0) @[Decoder.scala 38:35]
    node loadMemEnable = eq(_loadMemEnable_T, UInt<2>("h3")) @[Decoder.scala 38:49]
    node _io_shouldMux_T = eq(poop1, io.rdOutput) @[Decoder.scala 41:44]
    node _io_shouldMux_T_1 = eq(poop2, io.rdOutput) @[Decoder.scala 41:71]
    node _io_shouldMux_T_2 = or(_io_shouldMux_T, _io_shouldMux_T_1) @[Decoder.scala 41:61]
    node _io_shouldMux_T_3 = and(loadMemEnable, _io_shouldMux_T_2) @[Decoder.scala 41:33]
    io.shouldMux <= _io_shouldMux_T_3 @[Decoder.scala 41:16]
    reg boolean : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[Decoder.scala 42:24]
    boolean <= io.shouldMux @[Decoder.scala 43:11]
    node muxedInstr = mux(io.shouldMux, UInt<5>("h13"), io.instruction) @[Decoder.scala 44:23]
    reg pcReg : SInt<32>, clock with :
      reset => (reset, asSInt(UInt<32>("h0"))) @[Decoder.scala 48:22]
    pcReg <= io.pcIn @[Decoder.scala 50:9]
    io.pcOut <= io.pcIn @[Decoder.scala 51:12]
    instruction <= muxedInstr @[Decoder.scala 55:15]
    node _io_opcode_T = bits(instruction, 6, 0) @[Decoder.scala 56:27]
    io.opcode <= _io_opcode_T @[Decoder.scala 56:13]
    node _io_rdOutput_T = bits(instruction, 11, 7) @[Decoder.scala 57:33]
    io.rdOutput <= _io_rdOutput_T @[Decoder.scala 57:19]
    node _io_funct3_T = bits(instruction, 14, 12) @[Decoder.scala 58:27]
    io.funct3 <= _io_funct3_T @[Decoder.scala 58:13]
    node _io_rs1_T = bits(instruction, 19, 15) @[Decoder.scala 59:27]
    io.rs1 <= _io_rs1_T @[Decoder.scala 59:13]
    node _io_rs2_T = bits(instruction, 24, 20) @[Decoder.scala 61:27]
    io.rs2 <= _io_rs2_T @[Decoder.scala 61:13]
    node _io_funct7_T = bits(instruction, 31, 25) @[Decoder.scala 62:27]
    io.funct7 <= _io_funct7_T @[Decoder.scala 62:13]
    node _io_imm_I_T = bits(instruction, 31, 20) @[Decoder.scala 63:27]
    node _io_imm_I_T_1 = asSInt(_io_imm_I_T) @[Decoder.scala 63:36]
    io.imm_I <= _io_imm_I_T_1 @[Decoder.scala 63:13]
    node _io_imm_S_T = bits(instruction, 31, 25) @[Decoder.scala 64:29]
    node _io_imm_S_T_1 = shl(_io_imm_S_T, 5) @[Decoder.scala 64:38]
    node _io_imm_S_T_2 = bits(instruction, 11, 7) @[Decoder.scala 64:57]
    node _io_imm_S_T_3 = or(_io_imm_S_T_1, _io_imm_S_T_2) @[Decoder.scala 64:44]
    node _io_imm_S_T_4 = asSInt(_io_imm_S_T_3) @[Decoder.scala 64:66]
    io.imm_S <= _io_imm_S_T_4 @[Decoder.scala 64:13]
    node _io_imm_B_T = bits(instruction, 31, 31) @[Decoder.scala 65:29]
    node _io_imm_B_T_1 = shl(_io_imm_B_T, 12) @[Decoder.scala 65:34]
    node _io_imm_B_T_2 = bits(instruction, 7, 7) @[Decoder.scala 65:55]
    node _io_imm_B_T_3 = shl(_io_imm_B_T_2, 11) @[Decoder.scala 65:59]
    node _io_imm_B_T_4 = or(_io_imm_B_T_1, _io_imm_B_T_3) @[Decoder.scala 65:41]
    node _io_imm_B_T_5 = bits(instruction, 30, 25) @[Decoder.scala 65:80]
    node _io_imm_B_T_6 = shl(_io_imm_B_T_5, 5) @[Decoder.scala 65:89]
    node _io_imm_B_T_7 = or(_io_imm_B_T_4, _io_imm_B_T_6) @[Decoder.scala 65:66]
    node _io_imm_B_T_8 = bits(instruction, 11, 8) @[Decoder.scala 65:109]
    node _io_imm_B_T_9 = shl(_io_imm_B_T_8, 1) @[Decoder.scala 65:117]
    node _io_imm_B_T_10 = or(_io_imm_B_T_7, _io_imm_B_T_9) @[Decoder.scala 65:95]
    node _io_imm_B_T_11 = asSInt(_io_imm_B_T_10) @[Decoder.scala 65:124]
    io.imm_B <= _io_imm_B_T_11 @[Decoder.scala 65:13]
    node _io_imm_U_T = bits(instruction, 31, 12) @[Decoder.scala 66:27]
    io.imm_U <= _io_imm_U_T @[Decoder.scala 66:13]
    node _io_imm_J_T = bits(instruction, 31, 31) @[Decoder.scala 67:30]
    node _io_imm_J_T_1 = shl(_io_imm_J_T, 20) @[Decoder.scala 67:35]
    node _io_imm_J_T_2 = bits(instruction, 19, 12) @[Decoder.scala 67:56]
    node _io_imm_J_T_3 = shl(_io_imm_J_T_2, 12) @[Decoder.scala 67:65]
    node _io_imm_J_T_4 = or(_io_imm_J_T_1, _io_imm_J_T_3) @[Decoder.scala 67:42]
    node _io_imm_J_T_5 = bits(instruction, 20, 20) @[Decoder.scala 67:86]
    node _io_imm_J_T_6 = shl(_io_imm_J_T_5, 11) @[Decoder.scala 67:91]
    node _io_imm_J_T_7 = or(_io_imm_J_T_4, _io_imm_J_T_6) @[Decoder.scala 67:72]
    node _io_imm_J_T_8 = bits(instruction, 30, 21) @[Decoder.scala 67:112]
    node _io_imm_J_T_9 = shl(_io_imm_J_T_8, 1) @[Decoder.scala 67:121]
    node _io_imm_J_T_10 = or(_io_imm_J_T_7, _io_imm_J_T_9) @[Decoder.scala 67:98]
    node _io_imm_J_T_11 = asSInt(_io_imm_J_T_10) @[Decoder.scala 67:129]
    io.imm_J <= _io_imm_J_T_11 @[Decoder.scala 67:13]

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
    node _rs1Wire_T = eq(io.rdLastRegMemIn, rs1Reg) @[Executer.scala 81:40]
    node _rs1Wire_T_1 = neq(rs1Reg, UInt<1>("h0")) @[Executer.scala 81:63]
    node _rs1Wire_T_2 = and(_rs1Wire_T, _rs1Wire_T_1) @[Executer.scala 81:52]
    node _rs1Wire_T_3 = eq(io.rdLastRegMemIn, rs1Reg) @[Executer.scala 81:110]
    node _rs1Wire_T_4 = neq(rs1Reg, UInt<1>("h0")) @[Executer.scala 81:133]
    node _rs1Wire_T_5 = and(_rs1Wire_T_3, _rs1Wire_T_4) @[Executer.scala 81:122]
    node _rs1Wire_T_6 = eq(io.rdLoadRegMemIn, rs1Reg) @[Executer.scala 81:182]
    node _rs1Wire_T_7 = and(io.loadEnable, _rs1Wire_T_6) @[Executer.scala 81:161]
    node _rs1Wire_T_8 = mux(_rs1Wire_T_7, io.aluLoadRegMemIn, io.aluLastRegMemIn) @[Executer.scala 81:146]
    node _rs1Wire_T_9 = mux(_rs1Wire_T_5, _rs1Wire_T_8, io.x[rs1Reg]) @[Executer.scala 81:90]
    node rs1Wire = mux(_rs1Wire_T_2, aluLastRegEx, _rs1Wire_T_9) @[Executer.scala 81:20]
    node _rs2Wire_T = eq(io.rdLastRegMemIn, rs2Reg) @[Executer.scala 82:40]
    node _rs2Wire_T_1 = neq(rs2Reg, UInt<1>("h0")) @[Executer.scala 82:63]
    node _rs2Wire_T_2 = and(_rs2Wire_T, _rs2Wire_T_1) @[Executer.scala 82:52]
    node _rs2Wire_T_3 = eq(io.rdLastRegMemIn, rs2Reg) @[Executer.scala 82:110]
    node _rs2Wire_T_4 = neq(rs2Reg, UInt<1>("h0")) @[Executer.scala 82:133]
    node _rs2Wire_T_5 = and(_rs2Wire_T_3, _rs2Wire_T_4) @[Executer.scala 82:122]
    node _rs2Wire_T_6 = eq(io.rdLoadRegMemIn, rs2Reg) @[Executer.scala 82:182]
    node _rs2Wire_T_7 = and(io.loadEnable, _rs2Wire_T_6) @[Executer.scala 82:161]
    node _rs2Wire_T_8 = mux(_rs2Wire_T_7, io.aluLoadRegMemIn, io.aluLastRegMemIn) @[Executer.scala 82:146]
    node _rs2Wire_T_9 = mux(_rs2Wire_T_5, _rs2Wire_T_8, io.x[rs2Reg]) @[Executer.scala 82:90]
    node rs2Wire = mux(_rs2Wire_T_2, aluLastRegEx, _rs2Wire_T_9) @[Executer.scala 82:20]
    branchOutReg <= pcReg @[Executer.scala 86:16]
    io.imm <= imm_IReg @[Executer.scala 87:10]
    io.operand1 <= rs1Wire @[Executer.scala 89:15]
    io.operand2 <= asSInt(UInt<1>("h0")) @[Executer.scala 90:15]
    io.group <= UInt<1>("h0") @[Executer.scala 91:12]
    node _T = eq(UInt<6>("h33"), opcodeReg) @[Executer.scala 92:21]
    when _T : @[Executer.scala 92:21]
      io.operand2 <= rs2Wire @[Executer.scala 94:19]
      io.group <= UInt<1>("h1") @[Executer.scala 95:16]
    else :
      node _T_1 = eq(UInt<5>("h13"), opcodeReg) @[Executer.scala 92:21]
      when _T_1 : @[Executer.scala 92:21]
        io.group <= UInt<1>("h1") @[Executer.scala 98:16]
        io.operand2 <= imm_IReg @[Executer.scala 99:19]
        io.funct7out <= UInt<1>("h0") @[Executer.scala 100:20]
        node _T_2 = eq(UInt<1>("h1"), funct3Reg) @[Executer.scala 101:25]
        when _T_2 : @[Executer.scala 101:25]
          io.funct7out <= funct7Reg @[Executer.scala 103:24]
          node _io_operand2_T = asSInt(rs2Reg) @[Executer.scala 104:33]
          io.operand2 <= _io_operand2_T @[Executer.scala 104:23]
        else :
          node _T_3 = eq(UInt<3>("h5"), funct3Reg) @[Executer.scala 101:25]
          when _T_3 : @[Executer.scala 101:25]
            io.funct7out <= funct7Reg @[Executer.scala 107:24]
            node _io_operand2_T_1 = asSInt(rs2Reg) @[Executer.scala 108:33]
            io.operand2 <= _io_operand2_T_1 @[Executer.scala 108:23]
      else :
        node _T_4 = eq(UInt<2>("h3"), opcodeReg) @[Executer.scala 92:21]
        when _T_4 : @[Executer.scala 92:21]
          io.group <= UInt<2>("h2") @[Executer.scala 113:16]
          io.operand2 <= rs2Wire @[Executer.scala 114:19]
          io.imm <= imm_IReg @[Executer.scala 115:14]
        else :
          node _T_5 = eq(UInt<6>("h23"), opcodeReg) @[Executer.scala 92:21]
          when _T_5 : @[Executer.scala 92:21]
            io.group <= UInt<2>("h3") @[Executer.scala 118:16]
            io.operand2 <= rs2Wire @[Executer.scala 119:19]
            io.imm <= imm_SReg @[Executer.scala 120:14]
          else :
            node _T_6 = eq(UInt<7>("h63"), opcodeReg) @[Executer.scala 92:21]
            when _T_6 : @[Executer.scala 92:21]
              io.group <= UInt<3>("h4") @[Executer.scala 123:16]
              io.operand2 <= rs2Wire @[Executer.scala 124:19]
              io.imm <= imm_BReg @[Executer.scala 125:14]
            else :
              node _T_7 = eq(UInt<7>("h6f"), opcodeReg) @[Executer.scala 92:21]
              when _T_7 : @[Executer.scala 92:21]
                io.group <= UInt<3>("h5") @[Executer.scala 128:16]
                io.imm <= imm_JReg @[Executer.scala 129:14]
              else :
                node _T_8 = eq(UInt<7>("h67"), opcodeReg) @[Executer.scala 92:21]
                when _T_8 : @[Executer.scala 92:21]
                  io.group <= UInt<3>("h6") @[Executer.scala 132:16]
                  io.imm <= imm_IReg @[Executer.scala 133:14]
                else :
                  node _T_9 = eq(UInt<6>("h37"), opcodeReg) @[Executer.scala 92:21]
                  when _T_9 : @[Executer.scala 92:21]
                    io.group <= UInt<3>("h7") @[Executer.scala 136:16]
                    node _io_imm_T = asSInt(imm_UReg) @[Executer.scala 137:26]
                    io.imm <= _io_imm_T @[Executer.scala 137:14]
                  else :
                    node _T_10 = eq(UInt<5>("h17"), opcodeReg) @[Executer.scala 92:21]
                    when _T_10 : @[Executer.scala 92:21]
                      io.group <= UInt<4>("h8") @[Executer.scala 140:16]
                      node _io_imm_T_1 = asSInt(imm_UReg) @[Executer.scala 141:26]
                      io.imm <= _io_imm_T_1 @[Executer.scala 141:14]
    rdLastRegEx <= rdReg @[Executer.scala 145:15]
    aluLastRegEx <= io.ALUIn @[Executer.scala 146:16]
    io.pcOut <= pcReg @[Executer.scala 149:12]

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
                    node _io_ALUout_T_21 = asUInt(io.operand2) @[ALU.scala 79:49]
                    node _io_ALUout_T_22 = dshr(io.operand1, _io_ALUout_T_21) @[ALU.scala 79:37]
                    io.ALUout <= _io_ALUout_T_22 @[ALU.scala 79:25]
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
                      node _T_31 = lt(io.operand1, io.operand2) @[ALU.scala 161:27]
                      when _T_31 : @[ALU.scala 161:39]
                        io.branchEnable <= UInt<1>("h1") @[ALU.scala 162:31]
                        node _io_branchOut_T_24 = add(io.pcIn, io.imm) @[ALU.scala 163:37]
                        node _io_branchOut_T_25 = tail(_io_branchOut_T_24, 1) @[ALU.scala 163:37]
                        node _io_branchOut_T_26 = asSInt(_io_branchOut_T_25) @[ALU.scala 163:37]
                        node _io_branchOut_T_27 = sub(_io_branchOut_T_26, asSInt(UInt<4>("h4"))) @[ALU.scala 163:43]
                        node _io_branchOut_T_28 = tail(_io_branchOut_T_27, 1) @[ALU.scala 163:43]
                        node _io_branchOut_T_29 = asSInt(_io_branchOut_T_28) @[ALU.scala 163:43]
                        io.branchOut <= _io_branchOut_T_29 @[ALU.scala 163:28]
                    else :
                      node _T_32 = eq(UInt<3>("h7"), io.funct3) @[ALU.scala 133:22]
                      when _T_32 : @[ALU.scala 133:22]
                        node _T_33 = asUInt(io.operand1) @[ALU.scala 167:27]
                        node _T_34 = asUInt(io.operand2) @[ALU.scala 167:46]
                        node _T_35 = geq(_T_33, _T_34) @[ALU.scala 167:34]
                        when _T_35 : @[ALU.scala 167:54]
                          io.branchEnable <= UInt<1>("h1") @[ALU.scala 168:31]
                          node _io_branchOut_T_30 = add(io.pcIn, io.imm) @[ALU.scala 169:37]
                          node _io_branchOut_T_31 = tail(_io_branchOut_T_30, 1) @[ALU.scala 169:37]
                          node _io_branchOut_T_32 = asSInt(_io_branchOut_T_31) @[ALU.scala 169:37]
                          node _io_branchOut_T_33 = sub(_io_branchOut_T_32, asSInt(UInt<4>("h4"))) @[ALU.scala 169:43]
                          node _io_branchOut_T_34 = tail(_io_branchOut_T_33, 1) @[ALU.scala 169:43]
                          node _io_branchOut_T_35 = asSInt(_io_branchOut_T_34) @[ALU.scala 169:43]
                          io.branchOut <= _io_branchOut_T_35 @[ALU.scala 169:28]
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
    node _cntNext_T = geq(io.imm, asSInt(UInt<5>("hc"))) @[ALU.scala 194:48]
    node _cntNext_T_1 = and(io.branchEnable, _cntNext_T) @[ALU.scala 194:37]
    node _cntNext_T_2 = eq(io.imm, asSInt(UInt<5>("h8"))) @[ALU.scala 194:94]
    node _cntNext_T_3 = and(io.branchEnable, _cntNext_T_2) @[ALU.scala 194:83]
    node _cntNext_T_4 = gt(cntReg, UInt<1>("h0")) @[ALU.scala 194:120]
    node _cntNext_T_5 = sub(cntReg, UInt<1>("h1")) @[ALU.scala 194:134]
    node _cntNext_T_6 = tail(_cntNext_T_5, 1) @[ALU.scala 194:134]
    node _cntNext_T_7 = mux(_cntNext_T_4, _cntNext_T_6, UInt<1>("h0")) @[ALU.scala 194:112]
    node _cntNext_T_8 = mux(_cntNext_T_3, UInt<1>("h1"), _cntNext_T_7) @[ALU.scala 194:66]
    node cntNext = mux(_cntNext_T_1, UInt<2>("h2"), _cntNext_T_8) @[ALU.scala 194:20]
    node _rdReg_T = gt(cntReg, UInt<1>("h0")) @[ALU.scala 195:34]
    node _rdReg_T_1 = gt(io.imm, asSInt(UInt<4>("h4"))) @[ALU.scala 195:54]
    node _rdReg_T_2 = and(_rdReg_T_1, io.branchEnable) @[ALU.scala 195:60]
    node _rdReg_T_3 = mux(_rdReg_T_2, UInt<1>("h0"), io.rdIn) @[ALU.scala 195:49]
    node _rdReg_T_4 = mux(_rdReg_T, UInt<1>("h0"), _rdReg_T_3) @[ALU.scala 195:26]
    reg rdReg : UInt, clock with :
      reset => (UInt<1>("h0"), rdReg) @[ALU.scala 195:22]
    rdReg <= _rdReg_T_4 @[ALU.scala 195:22]
    node _cntNext2_T = gt(cntNext, UInt<1>("h0")) @[ALU.scala 196:30]
    node _cntNext2_T_1 = sub(cntNext, UInt<1>("h1")) @[ALU.scala 196:45]
    node _cntNext2_T_2 = tail(_cntNext2_T_1, 1) @[ALU.scala 196:45]
    node cntNext2 = mux(_cntNext2_T, _cntNext2_T_2, cntNext) @[ALU.scala 196:21]
    io.rdOut <= rdReg @[ALU.scala 198:11]

  module Memorizer :
    input clock : Clock
    input reset : Reset
    output io : { flip ALUinput : SInt<32>, flip rdInput : UInt<5>, flip rdAddr : UInt<10>, flip wrAddr : UInt<10>, flip wrData : UInt<32>, flip wrEna : UInt<1>, flip rdEna : UInt<1>, flip memOp : UInt<3>, rdLastRegMemOut : UInt<5>, aluLastRegMemOut : SInt<32>, rdLoadRegMemOut : UInt<5>, aluLoadRegMemOut : SInt<32>, loadEnabler : UInt<1>, rdData : SInt<32>, rdEnaOut : UInt<1>, wrEnaOut : UInt<1>, rdOutput : UInt<5>, ALUoutput : SInt<32>}

    reg rdReg : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[Memorizer.scala 37:22]
    rdReg <= io.rdInput @[Memorizer.scala 37:22]
    reg ALUreg : SInt, clock with :
      reset => (reset, asSInt(UInt<1>("h0"))) @[Memorizer.scala 38:23]
    ALUreg <= io.ALUinput @[Memorizer.scala 38:23]
    io.rdOutput <= rdReg @[Memorizer.scala 39:15]
    io.ALUoutput <= ALUreg @[Memorizer.scala 40:16]
    reg rdLastRegMem : UInt<5>, clock with :
      reset => (reset, UInt<5>("h0")) @[Memorizer.scala 43:29]
    reg aluLastRegMem : SInt<32>, clock with :
      reset => (reset, asSInt(UInt<32>("h0"))) @[Memorizer.scala 44:30]
    rdLastRegMem <= io.rdOutput @[Memorizer.scala 46:16]
    aluLastRegMem <= io.ALUoutput @[Memorizer.scala 47:17]
    io.rdLastRegMemOut <= rdLastRegMem @[Memorizer.scala 48:22]
    io.aluLastRegMemOut <= aluLastRegMem @[Memorizer.scala 49:23]
    reg wrEnaReg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[Memorizer.scala 51:25]
    wrEnaReg <= io.wrEna @[Memorizer.scala 51:25]
    reg rdEnaReg : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[Memorizer.scala 52:25]
    rdEnaReg <= io.rdEna @[Memorizer.scala 52:25]
    reg wrDataReg : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[Memorizer.scala 53:26]
    wrDataReg <= io.wrData @[Memorizer.scala 53:26]
    reg rdAddrReg : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[Memorizer.scala 54:26]
    rdAddrReg <= io.rdAddr @[Memorizer.scala 54:26]
    reg wrAddrReg : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[Memorizer.scala 55:26]
    wrAddrReg <= io.wrAddr @[Memorizer.scala 55:26]
    reg memOpReg : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[Memorizer.scala 56:25]
    memOpReg <= io.memOp @[Memorizer.scala 56:25]
    smem mem : UInt<8> [1024] @[Memorizer.scala 57:24]
    io.wrEnaOut <= wrEnaReg @[Memorizer.scala 58:15]
    io.rdEnaOut <= rdEnaReg @[Memorizer.scala 59:15]
    wire _readByte0_WIRE : UInt @[Memorizer.scala 60:28]
    _readByte0_WIRE is invalid @[Memorizer.scala 60:28]
    when UInt<1>("h1") : @[Memorizer.scala 60:28]
      _readByte0_WIRE <= io.rdAddr @[Memorizer.scala 60:28]
      node _readByte0_T = or(_readByte0_WIRE, UInt<10>("h0")) @[Memorizer.scala 60:28]
      node _readByte0_T_1 = bits(_readByte0_T, 9, 0) @[Memorizer.scala 60:28]
      read mport readByte0 = mem[_readByte0_T_1], clock @[Memorizer.scala 60:28]
    node _readByte1_T = add(io.rdAddr, UInt<1>("h1")) @[Memorizer.scala 61:39]
    node _readByte1_T_1 = tail(_readByte1_T, 1) @[Memorizer.scala 61:39]
    wire _readByte1_WIRE : UInt @[Memorizer.scala 61:28]
    _readByte1_WIRE is invalid @[Memorizer.scala 61:28]
    when UInt<1>("h1") : @[Memorizer.scala 61:28]
      _readByte1_WIRE <= _readByte1_T_1 @[Memorizer.scala 61:28]
      node _readByte1_T_2 = or(_readByte1_WIRE, UInt<10>("h0")) @[Memorizer.scala 61:28]
      node _readByte1_T_3 = bits(_readByte1_T_2, 9, 0) @[Memorizer.scala 61:28]
      read mport readByte1 = mem[_readByte1_T_3], clock @[Memorizer.scala 61:28]
    node _readByte2_T = add(io.rdAddr, UInt<2>("h2")) @[Memorizer.scala 62:39]
    node _readByte2_T_1 = tail(_readByte2_T, 1) @[Memorizer.scala 62:39]
    wire _readByte2_WIRE : UInt @[Memorizer.scala 62:28]
    _readByte2_WIRE is invalid @[Memorizer.scala 62:28]
    when UInt<1>("h1") : @[Memorizer.scala 62:28]
      _readByte2_WIRE <= _readByte2_T_1 @[Memorizer.scala 62:28]
      node _readByte2_T_2 = or(_readByte2_WIRE, UInt<10>("h0")) @[Memorizer.scala 62:28]
      node _readByte2_T_3 = bits(_readByte2_T_2, 9, 0) @[Memorizer.scala 62:28]
      read mport readByte2 = mem[_readByte2_T_3], clock @[Memorizer.scala 62:28]
    node _readByte3_T = add(io.rdAddr, UInt<2>("h3")) @[Memorizer.scala 63:39]
    node _readByte3_T_1 = tail(_readByte3_T, 1) @[Memorizer.scala 63:39]
    wire _readByte3_WIRE : UInt @[Memorizer.scala 63:28]
    _readByte3_WIRE is invalid @[Memorizer.scala 63:28]
    when UInt<1>("h1") : @[Memorizer.scala 63:28]
      _readByte3_WIRE <= _readByte3_T_1 @[Memorizer.scala 63:28]
      node _readByte3_T_2 = or(_readByte3_WIRE, UInt<10>("h0")) @[Memorizer.scala 63:28]
      node _readByte3_T_3 = bits(_readByte3_T_2, 9, 0) @[Memorizer.scala 63:28]
      read mport readByte3 = mem[_readByte3_T_3], clock @[Memorizer.scala 63:28]
    node writeByte0 = bits(wrDataReg, 7, 0) @[Memorizer.scala 64:29]
    node writeByte1 = bits(wrDataReg, 15, 8) @[Memorizer.scala 65:28]
    node writeByte2 = bits(wrDataReg, 23, 16) @[Memorizer.scala 66:28]
    node writeByte3 = bits(wrDataReg, 31, 24) @[Memorizer.scala 67:28]
    wire _io_rdData_WIRE : UInt @[Memorizer.scala 69:24]
    _io_rdData_WIRE is invalid @[Memorizer.scala 69:24]
    when UInt<1>("h1") : @[Memorizer.scala 69:24]
      _io_rdData_WIRE <= io.rdAddr @[Memorizer.scala 69:24]
      node _io_rdData_T = or(_io_rdData_WIRE, UInt<10>("h0")) @[Memorizer.scala 69:24]
      node _io_rdData_T_1 = bits(_io_rdData_T, 9, 0) @[Memorizer.scala 69:24]
      read mport io_rdData_MPORT = mem[_io_rdData_T_1], clock @[Memorizer.scala 69:24]
    node _io_rdData_T_2 = asSInt(io_rdData_MPORT) @[Memorizer.scala 69:36]
    io.rdData <= _io_rdData_T_2 @[Memorizer.scala 69:13]
    io.rdLoadRegMemOut <= UInt<1>("h0") @[Memorizer.scala 70:22]
    io.aluLoadRegMemOut <= asSInt(UInt<1>("h0")) @[Memorizer.scala 71:23]
    node _T = eq(UInt<1>("h0"), memOpReg) @[Memorizer.scala 72:20]
    when _T : @[Memorizer.scala 72:20]
      io.rdData <= asSInt(UInt<4>("h4")) @[Memorizer.scala 74:17]
    else :
      node _T_1 = eq(UInt<1>("h1"), memOpReg) @[Memorizer.scala 72:20]
      when _T_1 : @[Memorizer.scala 72:20]
        node _io_rdData_T_3 = asSInt(readByte0) @[Memorizer.scala 77:30]
        io.rdData <= _io_rdData_T_3 @[Memorizer.scala 77:17]
        when wrEnaReg : @[Memorizer.scala 78:22]
          node _T_2 = or(wrAddrReg, UInt<10>("h0"))
          node _T_3 = bits(_T_2, 9, 0)
          write mport MPORT = mem[_T_3], clock
          MPORT <= writeByte0
      else :
        node _T_4 = eq(UInt<2>("h2"), memOpReg) @[Memorizer.scala 72:20]
        when _T_4 : @[Memorizer.scala 72:20]
          node _io_rdData_T_4 = cat(readByte1, readByte0) @[Cat.scala 33:92]
          node _io_rdData_T_5 = asSInt(_io_rdData_T_4) @[Memorizer.scala 83:47]
          io.rdData <= _io_rdData_T_5 @[Memorizer.scala 83:17]
          when wrEnaReg : @[Memorizer.scala 84:22]
            node _T_5 = or(wrAddrReg, UInt<10>("h0"))
            node _T_6 = bits(_T_5, 9, 0)
            write mport MPORT_1 = mem[_T_6], clock
            MPORT_1 <= writeByte0
            node _T_7 = add(wrAddrReg, UInt<1>("h1")) @[Memorizer.scala 86:29]
            node _T_8 = tail(_T_7, 1) @[Memorizer.scala 86:29]
            node _T_9 = or(_T_8, UInt<10>("h0"))
            node _T_10 = bits(_T_9, 9, 0)
            write mport MPORT_2 = mem[_T_10], clock
            MPORT_2 <= writeByte1
        else :
          node _T_11 = eq(UInt<2>("h3"), memOpReg) @[Memorizer.scala 72:20]
          when _T_11 : @[Memorizer.scala 72:20]
            node io_rdData_lo = cat(readByte1, readByte0) @[Cat.scala 33:92]
            node io_rdData_hi = cat(readByte3, readByte2) @[Cat.scala 33:92]
            node _io_rdData_T_6 = cat(io_rdData_hi, io_rdData_lo) @[Cat.scala 33:92]
            node _io_rdData_T_7 = asSInt(_io_rdData_T_6) @[Memorizer.scala 90:68]
            io.rdData <= _io_rdData_T_7 @[Memorizer.scala 90:17]
            when wrEnaReg : @[Memorizer.scala 91:22]
              node _T_12 = or(wrAddrReg, UInt<10>("h0"))
              node _T_13 = bits(_T_12, 9, 0)
              write mport MPORT_3 = mem[_T_13], clock
              MPORT_3 <= writeByte0
              node _T_14 = add(wrAddrReg, UInt<1>("h1")) @[Memorizer.scala 93:29]
              node _T_15 = tail(_T_14, 1) @[Memorizer.scala 93:29]
              node _T_16 = or(_T_15, UInt<10>("h0"))
              node _T_17 = bits(_T_16, 9, 0)
              write mport MPORT_4 = mem[_T_17], clock
              MPORT_4 <= writeByte1
              node _T_18 = add(wrAddrReg, UInt<2>("h2")) @[Memorizer.scala 94:28]
              node _T_19 = tail(_T_18, 1) @[Memorizer.scala 94:28]
              node _T_20 = or(_T_19, UInt<10>("h0"))
              node _T_21 = bits(_T_20, 9, 0)
              write mport MPORT_5 = mem[_T_21], clock
              MPORT_5 <= writeByte2
              node _T_22 = add(wrAddrReg, UInt<2>("h3")) @[Memorizer.scala 95:29]
              node _T_23 = tail(_T_22, 1) @[Memorizer.scala 95:29]
              node _T_24 = or(_T_23, UInt<10>("h0"))
              node _T_25 = bits(_T_24, 9, 0)
              write mport MPORT_6 = mem[_T_25], clock
              MPORT_6 <= writeByte3
          else :
            node _T_26 = eq(UInt<3>("h4"), memOpReg) @[Memorizer.scala 72:20]
            when _T_26 : @[Memorizer.scala 72:20]
              node _io_rdData_T_8 = cat(UInt<24>("h0"), readByte0) @[Cat.scala 33:92]
              node _io_rdData_T_9 = asSInt(_io_rdData_T_8) @[Memorizer.scala 100:46]
              io.rdData <= _io_rdData_T_9 @[Memorizer.scala 100:17]
            else :
              node _T_27 = eq(UInt<3>("h5"), memOpReg) @[Memorizer.scala 72:20]
              when _T_27 : @[Memorizer.scala 72:20]
                node io_rdData_hi_1 = cat(UInt<16>("h0"), readByte1) @[Cat.scala 33:92]
                node _io_rdData_T_10 = cat(io_rdData_hi_1, readByte0) @[Cat.scala 33:92]
                node _io_rdData_T_11 = asSInt(_io_rdData_T_10) @[Memorizer.scala 103:58]
                io.rdData <= _io_rdData_T_11 @[Memorizer.scala 103:17]
    reg rdLoadRegger : UInt<5>, clock with :
      reset => (reset, UInt<5>("h0")) @[Memorizer.scala 106:29]
    reg aluLoadRegger : SInt<32>, clock with :
      reset => (reset, asSInt(UInt<32>("h0"))) @[Memorizer.scala 107:30]
    reg enabler : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[Memorizer.scala 108:24]
    enabler <= rdEnaReg @[Memorizer.scala 109:11]
    io.loadEnabler <= enabler @[Memorizer.scala 110:18]
    rdLoadRegger <= rdReg @[Memorizer.scala 111:16]
    aluLoadRegger <= io.rdData @[Memorizer.scala 112:16]
    io.rdLoadRegMemOut <= rdLoadRegger @[Memorizer.scala 113:22]
    io.aluLoadRegMemOut <= aluLoadRegger @[Memorizer.scala 114:23]

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

    wire _x_WIRE : SInt<32>[32] @[Food.scala 14:26]
    _x_WIRE[0] <= asSInt(UInt<32>("h0")) @[Food.scala 14:26]
    _x_WIRE[1] <= asSInt(UInt<32>("h0")) @[Food.scala 14:26]
    _x_WIRE[2] <= asSInt(UInt<32>("h0")) @[Food.scala 14:26]
    _x_WIRE[3] <= asSInt(UInt<32>("h0")) @[Food.scala 14:26]
    _x_WIRE[4] <= asSInt(UInt<32>("h0")) @[Food.scala 14:26]
    _x_WIRE[5] <= asSInt(UInt<32>("h0")) @[Food.scala 14:26]
    _x_WIRE[6] <= asSInt(UInt<32>("h0")) @[Food.scala 14:26]
    _x_WIRE[7] <= asSInt(UInt<32>("h0")) @[Food.scala 14:26]
    _x_WIRE[8] <= asSInt(UInt<32>("h0")) @[Food.scala 14:26]
    _x_WIRE[9] <= asSInt(UInt<32>("h0")) @[Food.scala 14:26]
    _x_WIRE[10] <= asSInt(UInt<32>("h0")) @[Food.scala 14:26]
    _x_WIRE[11] <= asSInt(UInt<32>("h0")) @[Food.scala 14:26]
    _x_WIRE[12] <= asSInt(UInt<32>("h0")) @[Food.scala 14:26]
    _x_WIRE[13] <= asSInt(UInt<32>("h0")) @[Food.scala 14:26]
    _x_WIRE[14] <= asSInt(UInt<32>("h0")) @[Food.scala 14:26]
    _x_WIRE[15] <= asSInt(UInt<32>("h0")) @[Food.scala 14:26]
    _x_WIRE[16] <= asSInt(UInt<32>("h0")) @[Food.scala 14:26]
    _x_WIRE[17] <= asSInt(UInt<32>("h0")) @[Food.scala 14:26]
    _x_WIRE[18] <= asSInt(UInt<32>("h0")) @[Food.scala 14:26]
    _x_WIRE[19] <= asSInt(UInt<32>("h0")) @[Food.scala 14:26]
    _x_WIRE[20] <= asSInt(UInt<32>("h0")) @[Food.scala 14:26]
    _x_WIRE[21] <= asSInt(UInt<32>("h0")) @[Food.scala 14:26]
    _x_WIRE[22] <= asSInt(UInt<32>("h0")) @[Food.scala 14:26]
    _x_WIRE[23] <= asSInt(UInt<32>("h0")) @[Food.scala 14:26]
    _x_WIRE[24] <= asSInt(UInt<32>("h0")) @[Food.scala 14:26]
    _x_WIRE[25] <= asSInt(UInt<32>("h0")) @[Food.scala 14:26]
    _x_WIRE[26] <= asSInt(UInt<32>("h0")) @[Food.scala 14:26]
    _x_WIRE[27] <= asSInt(UInt<32>("h0")) @[Food.scala 14:26]
    _x_WIRE[28] <= asSInt(UInt<32>("h0")) @[Food.scala 14:26]
    _x_WIRE[29] <= asSInt(UInt<32>("h0")) @[Food.scala 14:26]
    _x_WIRE[30] <= asSInt(UInt<32>("h0")) @[Food.scala 14:26]
    _x_WIRE[31] <= asSInt(UInt<32>("h0")) @[Food.scala 14:26]
    reg x : SInt<32>[32], clock with :
      reset => (reset, _x_WIRE) @[Food.scala 14:18]
    inst fetcher of Fetcher @[Food.scala 15:29]
    fetcher.clock <= clock
    fetcher.reset <= reset
    inst decoder of Decoder @[Food.scala 16:29]
    decoder.clock <= clock
    decoder.reset <= reset
    inst executer of Executer @[Food.scala 17:29]
    executer.clock <= clock
    executer.reset <= reset
    inst ALU of ALU @[Food.scala 18:29]
    ALU.clock <= clock
    ALU.reset <= reset
    inst memorizer of Memorizer @[Food.scala 19:29]
    memorizer.clock <= clock
    memorizer.reset <= reset
    inst write_backer of Write_backer @[Food.scala 20:29]
    write_backer.clock <= clock
    write_backer.reset <= reset
    inst Disp of DisplayMux @[Food.scala 21:20]
    Disp.clock <= clock
    Disp.reset <= reset
    wire _instrReg_WIRE : UInt<32>[13] @[Food.scala 22:38]
    _instrReg_WIRE[0] <= UInt<32>("h200113") @[Food.scala 22:38]
    _instrReg_WIRE[1] <= UInt<32>("ha00193") @[Food.scala 22:38]
    _instrReg_WIRE[2] <= UInt<32>("h310663") @[Food.scala 22:38]
    _instrReg_WIRE[3] <= UInt<32>("h200293") @[Food.scala 22:38]
    _instrReg_WIRE[4] <= UInt<32>("h210263") @[Food.scala 22:38]
    _instrReg_WIRE[5] <= UInt<32>("hc00113") @[Food.scala 22:38]
    _instrReg_WIRE[6] <= UInt<32>("h211a63") @[Food.scala 22:38]
    _instrReg_WIRE[7] <= UInt<32>("h300293") @[Food.scala 22:38]
    _instrReg_WIRE[8] <= UInt<32>("h311663") @[Food.scala 22:38]
    _instrReg_WIRE[9] <= UInt<32>("ha00213") @[Food.scala 22:38]
    _instrReg_WIRE[10] <= UInt<32>("ha00293") @[Food.scala 22:38]
    _instrReg_WIRE[11] <= UInt<32>("h100113") @[Food.scala 22:38]
    _instrReg_WIRE[12] <= UInt<32>("he00293") @[Food.scala 22:38]
    reg instrReg : UInt<32>[13], clock with :
      reset => (reset, _instrReg_WIRE) @[Food.scala 22:30]
    fetcher.io.input[0] <= instrReg[0] @[Food.scala 39:23]
    fetcher.io.input[1] <= instrReg[1] @[Food.scala 39:23]
    fetcher.io.input[2] <= instrReg[2] @[Food.scala 39:23]
    fetcher.io.input[3] <= instrReg[3] @[Food.scala 39:23]
    fetcher.io.input[4] <= instrReg[4] @[Food.scala 39:23]
    fetcher.io.input[5] <= instrReg[5] @[Food.scala 39:23]
    fetcher.io.input[6] <= instrReg[6] @[Food.scala 39:23]
    fetcher.io.input[7] <= instrReg[7] @[Food.scala 39:23]
    fetcher.io.input[8] <= instrReg[8] @[Food.scala 39:23]
    fetcher.io.input[9] <= instrReg[9] @[Food.scala 39:23]
    fetcher.io.input[10] <= instrReg[10] @[Food.scala 39:23]
    fetcher.io.input[11] <= instrReg[11] @[Food.scala 39:23]
    fetcher.io.input[12] <= instrReg[12] @[Food.scala 39:23]
    fetcher.io.branchIn <= ALU.io.branchOut @[Food.scala 40:23]
    fetcher.io.branchEnable <= ALU.io.branchEnable @[Food.scala 41:27]
    decoder.io.instruction <= fetcher.io.instruction @[Food.scala 43:26]
    decoder.io.pcIn <= fetcher.io.pcOut @[Food.scala 45:19]
    executer.io.pcIn <= decoder.io.pcOut @[Food.scala 46:20]
    executer.io.rdIn <= ALU.io.rdOut @[Food.scala 48:20]
    decoder.io.rdRegEx <= ALU.io.rdOut @[Food.scala 51:22]
    decoder.io.LoadMemEnable <= ALU.io.rdEna @[Food.scala 53:28]
    fetcher.io.shouldMux <= decoder.io.shouldMux @[Food.scala 55:24]
    executer.io.x[0] <= x[0] @[Food.scala 60:17]
    executer.io.x[1] <= x[1] @[Food.scala 60:17]
    executer.io.x[2] <= x[2] @[Food.scala 60:17]
    executer.io.x[3] <= x[3] @[Food.scala 60:17]
    executer.io.x[4] <= x[4] @[Food.scala 60:17]
    executer.io.x[5] <= x[5] @[Food.scala 60:17]
    executer.io.x[6] <= x[6] @[Food.scala 60:17]
    executer.io.x[7] <= x[7] @[Food.scala 60:17]
    executer.io.x[8] <= x[8] @[Food.scala 60:17]
    executer.io.x[9] <= x[9] @[Food.scala 60:17]
    executer.io.x[10] <= x[10] @[Food.scala 60:17]
    executer.io.x[11] <= x[11] @[Food.scala 60:17]
    executer.io.x[12] <= x[12] @[Food.scala 60:17]
    executer.io.x[13] <= x[13] @[Food.scala 60:17]
    executer.io.x[14] <= x[14] @[Food.scala 60:17]
    executer.io.x[15] <= x[15] @[Food.scala 60:17]
    executer.io.x[16] <= x[16] @[Food.scala 60:17]
    executer.io.x[17] <= x[17] @[Food.scala 60:17]
    executer.io.x[18] <= x[18] @[Food.scala 60:17]
    executer.io.x[19] <= x[19] @[Food.scala 60:17]
    executer.io.x[20] <= x[20] @[Food.scala 60:17]
    executer.io.x[21] <= x[21] @[Food.scala 60:17]
    executer.io.x[22] <= x[22] @[Food.scala 60:17]
    executer.io.x[23] <= x[23] @[Food.scala 60:17]
    executer.io.x[24] <= x[24] @[Food.scala 60:17]
    executer.io.x[25] <= x[25] @[Food.scala 60:17]
    executer.io.x[26] <= x[26] @[Food.scala 60:17]
    executer.io.x[27] <= x[27] @[Food.scala 60:17]
    executer.io.x[28] <= x[28] @[Food.scala 60:17]
    executer.io.x[29] <= x[29] @[Food.scala 60:17]
    executer.io.x[30] <= x[30] @[Food.scala 60:17]
    executer.io.x[31] <= x[31] @[Food.scala 60:17]
    executer.io.opcode <= decoder.io.opcode @[Food.scala 61:22]
    ALU.io.rdIn <= decoder.io.rdOutput @[Food.scala 62:15]
    executer.io.rs1 <= decoder.io.rs1 @[Food.scala 63:19]
    executer.io.rs2 <= decoder.io.rs2 @[Food.scala 64:19]
    executer.io.imm_I <= decoder.io.imm_I @[Food.scala 65:21]
    executer.io.imm_B <= decoder.io.imm_B @[Food.scala 66:21]
    executer.io.imm_J <= decoder.io.imm_J @[Food.scala 67:21]
    executer.io.imm_S <= decoder.io.imm_S @[Food.scala 68:21]
    executer.io.imm_U <= decoder.io.imm_U @[Food.scala 69:21]
    executer.io.funct3 <= decoder.io.funct3 @[Food.scala 70:22]
    executer.io.funct7 <= decoder.io.funct7 @[Food.scala 71:22]
    executer.io.rdLastRegMemIn <= memorizer.io.rdLastRegMemOut @[Food.scala 74:30]
    executer.io.aluLastRegMemIn <= memorizer.io.aluLastRegMemOut @[Food.scala 76:31]
    executer.io.rdLoadRegMemIn <= memorizer.io.rdLoadRegMemOut @[Food.scala 78:30]
    executer.io.aluLoadRegMemIn <= memorizer.io.aluLoadRegMemOut @[Food.scala 79:31]
    executer.io.loadEnable <= memorizer.io.loadEnabler @[Food.scala 80:26]
    ALU.io.funct3 <= executer.io.funct3out @[Food.scala 82:17]
    ALU.io.funct7 <= executer.io.funct7out @[Food.scala 83:17]
    ALU.io.pcIn <= executer.io.pcOut @[Food.scala 84:15]
    ALU.io.group <= executer.io.group @[Food.scala 85:16]
    ALU.io.operand1 <= executer.io.operand1 @[Food.scala 86:19]
    ALU.io.operand2 <= executer.io.operand2 @[Food.scala 87:19]
    ALU.io.imm <= executer.io.imm @[Food.scala 88:14]
    executer.io.ALUIn <= ALU.io.ALUout @[Food.scala 91:21]
    memorizer.io.memOp <= ALU.io.memOp @[Food.scala 94:22]
    memorizer.io.rdInput <= ALU.io.rdOut @[Food.scala 95:24]
    memorizer.io.ALUinput <= ALU.io.ALUout @[Food.scala 96:25]
    memorizer.io.rdEna <= ALU.io.rdEna @[Food.scala 97:22]
    memorizer.io.wrEna <= ALU.io.wrEna @[Food.scala 98:22]
    memorizer.io.rdAddr <= ALU.io.rdAddr @[Food.scala 99:23]
    memorizer.io.wrAddr <= ALU.io.wrAddr @[Food.scala 100:23]
    node _memorizer_io_wrData_T = asUInt(ALU.io.ALUout) @[Food.scala 101:40]
    memorizer.io.wrData <= _memorizer_io_wrData_T @[Food.scala 101:23]
    write_backer.io.rdData <= memorizer.io.rdData @[Food.scala 104:26]
    write_backer.io.rdEnaIn <= memorizer.io.rdEnaOut @[Food.scala 105:27]
    write_backer.io.rdInput <= memorizer.io.rdOutput @[Food.scala 106:27]
    write_backer.io.ALUinput <= memorizer.io.ALUoutput @[Food.scala 107:28]
    write_backer.io.wrEnaIn <= memorizer.io.wrEnaOut @[Food.scala 108:27]
    x[17] <= asSInt(UInt<5>("hf")) @[Food.scala 110:9]
    Disp.io.xReg <= x[17] @[Food.scala 111:16]
    io.seg <= Disp.io.seg @[Food.scala 112:10]
    io.an <= Disp.io.an @[Food.scala 113:9]
    x[write_backer.io.rdOut] <= write_backer.io.ALUoutput @[Food.scala 116:28]

