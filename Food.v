module Fetcher(
  input         clock,
  input         reset,
  input  [31:0] io_branchIn,
  input         io_branchEnable,
  input         io_shouldMux,
  output [31:0] io_instrOut,
  output [31:0] io_pcOut
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] pcReg; // @[Fetcher.scala 15:22]
  reg [31:0] instrReg; // @[Fetcher.scala 16:25]
  wire [31:0] _pcPlusReg_T_2 = $signed(io_branchIn) + 32'sh4; // @[Fetcher.scala 67:77]
  wire [31:0] _pcPlusReg_T_5 = $signed(pcReg) + 32'sh4; // @[Fetcher.scala 67:90]
  wire [31:0] _pcPlusReg_T_6 = io_branchEnable ? $signed(_pcPlusReg_T_2) : $signed(_pcPlusReg_T_5); // @[Fetcher.scala 67:47]
  wire [31:0] pcPlusReg = io_shouldMux ? $signed(pcReg) : $signed(_pcPlusReg_T_6); // @[Fetcher.scala 67:22]
  wire [29:0] _instrReg_T = pcPlusReg[31:2]; // @[Fetcher.scala 71:26]
  wire [31:0] _GEN_1 = 6'h1 == _instrReg_T[5:0] ? 32'h10113 : 32'h100137; // @[Fetcher.scala 71:{12,12}]
  wire [31:0] _GEN_2 = 6'h2 == _instrReg_T[5:0] ? 32'h60000ef : _GEN_1; // @[Fetcher.scala 71:{12,12}]
  wire [31:0] _GEN_3 = 6'h3 == _instrReg_T[5:0] ? 32'ha00893 : _GEN_2; // @[Fetcher.scala 71:{12,12}]
  wire [31:0] _GEN_4 = 6'h4 == _instrReg_T[5:0] ? 32'h63 : _GEN_3; // @[Fetcher.scala 71:{12,12}]
  wire [31:0] _GEN_5 = 6'h5 == _instrReg_T[5:0] ? 32'hfe010113 : _GEN_4; // @[Fetcher.scala 71:{12,12}]
  wire [31:0] _GEN_6 = 6'h6 == _instrReg_T[5:0] ? 32'h112e23 : _GEN_5; // @[Fetcher.scala 71:{12,12}]
  wire [31:0] _GEN_7 = 6'h7 == _instrReg_T[5:0] ? 32'h812c23 : _GEN_6; // @[Fetcher.scala 71:{12,12}]
  wire [31:0] _GEN_8 = 6'h8 == _instrReg_T[5:0] ? 32'h2010413 : _GEN_7; // @[Fetcher.scala 71:{12,12}]
  wire [31:0] _GEN_9 = 6'h9 == _instrReg_T[5:0] ? 32'hfea42623 : _GEN_8; // @[Fetcher.scala 71:{12,12}]
  wire [31:0] _GEN_10 = 6'ha == _instrReg_T[5:0] ? 32'hfec42783 : _GEN_9; // @[Fetcher.scala 71:{12,12}]
  wire [31:0] _GEN_11 = 6'hb == _instrReg_T[5:0] ? 32'hf04663 : _GEN_10; // @[Fetcher.scala 71:{12,12}]
  wire [31:0] _GEN_12 = 6'hc == _instrReg_T[5:0] ? 32'h100793 : _GEN_11; // @[Fetcher.scala 71:{12,12}]
  wire [31:0] _GEN_13 = 6'hd == _instrReg_T[5:0] ? 32'h200006f : _GEN_12; // @[Fetcher.scala 71:{12,12}]
  wire [31:0] _GEN_14 = 6'he == _instrReg_T[5:0] ? 32'hfec42783 : _GEN_13; // @[Fetcher.scala 71:{12,12}]
  wire [31:0] _GEN_15 = 6'hf == _instrReg_T[5:0] ? 32'hfff78793 : _GEN_14; // @[Fetcher.scala 71:{12,12}]
  wire [31:0] _GEN_16 = 6'h10 == _instrReg_T[5:0] ? 32'h78513 : _GEN_15; // @[Fetcher.scala 71:{12,12}]
  wire [31:0] _GEN_17 = 6'h11 == _instrReg_T[5:0] ? 32'h317 : _GEN_16; // @[Fetcher.scala 71:{12,12}]
  wire [31:0] _GEN_18 = 6'h12 == _instrReg_T[5:0] ? 32'hfd0300e7 : _GEN_17; // @[Fetcher.scala 71:{12,12}]
  wire [31:0] _GEN_19 = 6'h13 == _instrReg_T[5:0] ? 32'h50793 : _GEN_18; // @[Fetcher.scala 71:{12,12}]
  wire [31:0] _GEN_20 = 6'h14 == _instrReg_T[5:0] ? 32'h178793 : _GEN_19; // @[Fetcher.scala 71:{12,12}]
  wire [31:0] _GEN_21 = 6'h15 == _instrReg_T[5:0] ? 32'h78513 : _GEN_20; // @[Fetcher.scala 71:{12,12}]
  wire [31:0] _GEN_22 = 6'h16 == _instrReg_T[5:0] ? 32'h1c12083 : _GEN_21; // @[Fetcher.scala 71:{12,12}]
  wire [31:0] _GEN_23 = 6'h17 == _instrReg_T[5:0] ? 32'h1812403 : _GEN_22; // @[Fetcher.scala 71:{12,12}]
  wire [31:0] _GEN_24 = 6'h18 == _instrReg_T[5:0] ? 32'h2010113 : _GEN_23; // @[Fetcher.scala 71:{12,12}]
  wire [31:0] _GEN_25 = 6'h19 == _instrReg_T[5:0] ? 32'h8067 : _GEN_24; // @[Fetcher.scala 71:{12,12}]
  wire [31:0] _GEN_26 = 6'h1a == _instrReg_T[5:0] ? 32'hff010113 : _GEN_25; // @[Fetcher.scala 71:{12,12}]
  wire [31:0] _GEN_27 = 6'h1b == _instrReg_T[5:0] ? 32'h112623 : _GEN_26; // @[Fetcher.scala 71:{12,12}]
  wire [31:0] _GEN_28 = 6'h1c == _instrReg_T[5:0] ? 32'h812423 : _GEN_27; // @[Fetcher.scala 71:{12,12}]
  wire [31:0] _GEN_29 = 6'h1d == _instrReg_T[5:0] ? 32'h1010413 : _GEN_28; // @[Fetcher.scala 71:{12,12}]
  wire [31:0] _GEN_30 = 6'h1e == _instrReg_T[5:0] ? 32'h6400513 : _GEN_29; // @[Fetcher.scala 71:{12,12}]
  wire [31:0] _GEN_31 = 6'h1f == _instrReg_T[5:0] ? 32'h317 : _GEN_30; // @[Fetcher.scala 71:{12,12}]
  wire [31:0] _GEN_32 = 6'h20 == _instrReg_T[5:0] ? 32'hf98300e7 : _GEN_31; // @[Fetcher.scala 71:{12,12}]
  wire [31:0] _GEN_33 = 6'h21 == _instrReg_T[5:0] ? 32'h50793 : _GEN_32; // @[Fetcher.scala 71:{12,12}]
  wire [31:0] _GEN_34 = 6'h22 == _instrReg_T[5:0] ? 32'h78513 : _GEN_33; // @[Fetcher.scala 71:{12,12}]
  wire [31:0] _GEN_35 = 6'h23 == _instrReg_T[5:0] ? 32'hc12083 : _GEN_34; // @[Fetcher.scala 71:{12,12}]
  assign io_instrOut = instrReg; // @[Fetcher.scala 73:15]
  assign io_pcOut = pcReg; // @[Fetcher.scala 74:12]
  always @(posedge clock) begin
    if (reset) begin // @[Fetcher.scala 15:22]
      pcReg <= -32'sh4; // @[Fetcher.scala 15:22]
    end else if (!(io_shouldMux)) begin // @[Fetcher.scala 67:22]
      if (io_branchEnable) begin // @[Fetcher.scala 67:47]
        pcReg <= _pcPlusReg_T_2;
      end else begin
        pcReg <= _pcPlusReg_T_5;
      end
    end
    if (reset) begin // @[Fetcher.scala 16:25]
      instrReg <= 32'h0; // @[Fetcher.scala 16:25]
    end else if (6'h26 == _instrReg_T[5:0]) begin // @[Fetcher.scala 71:12]
      instrReg <= 32'h8067; // @[Fetcher.scala 71:12]
    end else if (6'h25 == _instrReg_T[5:0]) begin // @[Fetcher.scala 71:12]
      instrReg <= 32'h1010113; // @[Fetcher.scala 71:12]
    end else if (6'h24 == _instrReg_T[5:0]) begin // @[Fetcher.scala 71:12]
      instrReg <= 32'h812403; // @[Fetcher.scala 71:12]
    end else begin
      instrReg <= _GEN_35;
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  pcReg = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  instrReg = _RAND_1[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Decoder(
  input         clock,
  input         reset,
  input  [31:0] io_instrIn,
  output [6:0]  io_opcode,
  output [4:0]  io_rdOutput,
  output [2:0]  io_funct3,
  output [6:0]  io_funct7,
  output [4:0]  io_rs1,
  output [4:0]  io_rs2,
  output [11:0] io_imm_I,
  output [11:0] io_imm_S,
  output [12:0] io_imm_B,
  output [31:0] io_imm_U,
  output [20:0] io_imm_J,
  input  [31:0] io_pcIn,
  output [31:0] io_pcOut,
  output        io_shouldMux
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  wire [4:0] rs1Reg = io_instrIn[19:15]; // @[Decoder.scala 27:26]
  wire [4:0] rs2Reg = io_instrIn[24:20]; // @[Decoder.scala 28:26]
  reg [31:0] instr; // @[Decoder.scala 31:22]
  wire  loadMemEnable = instr[6:0] == 7'h3; // @[Decoder.scala 32:43]
  wire [11:0] _io_imm_S_T_1 = {instr[31:25], 5'h0}; // @[Decoder.scala 53:31]
  wire [11:0] _GEN_0 = {{7'd0}, instr[11:7]}; // @[Decoder.scala 53:37]
  wire [12:0] _io_imm_B_T_1 = {instr[31], 12'h0}; // @[Decoder.scala 54:27]
  wire [11:0] _io_imm_B_T_3 = {instr[7], 11'h0}; // @[Decoder.scala 54:46]
  wire [12:0] _GEN_1 = {{1'd0}, _io_imm_B_T_3}; // @[Decoder.scala 54:34]
  wire [12:0] _io_imm_B_T_4 = _io_imm_B_T_1 | _GEN_1; // @[Decoder.scala 54:34]
  wire [10:0] _io_imm_B_T_6 = {instr[30:25], 5'h0}; // @[Decoder.scala 54:70]
  wire [12:0] _GEN_2 = {{2'd0}, _io_imm_B_T_6}; // @[Decoder.scala 54:53]
  wire [12:0] _io_imm_B_T_7 = _io_imm_B_T_4 | _GEN_2; // @[Decoder.scala 54:53]
  wire [4:0] _io_imm_B_T_9 = {instr[11:8], 1'h0}; // @[Decoder.scala 54:92]
  wire [12:0] _GEN_3 = {{8'd0}, _io_imm_B_T_9}; // @[Decoder.scala 54:76]
  wire [20:0] _io_imm_J_T_1 = {instr[31], 20'h0}; // @[Decoder.scala 56:28]
  wire [19:0] _io_imm_J_T_3 = {instr[19:12], 12'h0}; // @[Decoder.scala 56:52]
  wire [20:0] _GEN_4 = {{1'd0}, _io_imm_J_T_3}; // @[Decoder.scala 56:35]
  wire [20:0] _io_imm_J_T_4 = _io_imm_J_T_1 | _GEN_4; // @[Decoder.scala 56:35]
  wire [11:0] _io_imm_J_T_6 = {instr[20], 11'h0}; // @[Decoder.scala 56:72]
  wire [20:0] _GEN_5 = {{9'd0}, _io_imm_J_T_6}; // @[Decoder.scala 56:59]
  wire [20:0] _io_imm_J_T_7 = _io_imm_J_T_4 | _GEN_5; // @[Decoder.scala 56:59]
  wire [10:0] _io_imm_J_T_9 = {instr[30:21], 1'h0}; // @[Decoder.scala 56:96]
  wire [20:0] _GEN_6 = {{10'd0}, _io_imm_J_T_9}; // @[Decoder.scala 56:79]
  assign io_opcode = instr[6:0]; // @[Decoder.scala 45:21]
  assign io_rdOutput = instr[11:7]; // @[Decoder.scala 46:23]
  assign io_funct3 = instr[14:12]; // @[Decoder.scala 47:21]
  assign io_funct7 = instr[31:25]; // @[Decoder.scala 51:21]
  assign io_rs1 = instr[19:15]; // @[Decoder.scala 48:18]
  assign io_rs2 = instr[24:20]; // @[Decoder.scala 50:18]
  assign io_imm_I = instr[31:20]; // @[Decoder.scala 52:29]
  assign io_imm_S = _io_imm_S_T_1 | _GEN_0; // @[Decoder.scala 53:53]
  assign io_imm_B = _io_imm_B_T_7 | _GEN_3; // @[Decoder.scala 54:99]
  assign io_imm_U = {{12'd0}, instr[31:12]}; // @[Decoder.scala 55:12]
  assign io_imm_J = _io_imm_J_T_7 | _GEN_6; // @[Decoder.scala 56:104]
  assign io_pcOut = io_pcIn; // @[Decoder.scala 39:12]
  assign io_shouldMux = loadMemEnable & (rs1Reg == io_rdOutput | rs2Reg == io_rdOutput); // @[Decoder.scala 35:33]
  always @(posedge clock) begin
    if (reset) begin // @[Decoder.scala 31:22]
      instr <= 32'h0; // @[Decoder.scala 31:22]
    end else if (io_shouldMux) begin // @[Decoder.scala 41:21]
      instr <= 32'h13;
    end else begin
      instr <= io_instrIn;
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  instr = _RAND_0[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Executer(
  input         clock,
  input         reset,
  input  [6:0]  io_opcode,
  input  [2:0]  io_funct3,
  input  [6:0]  io_funct7,
  input  [4:0]  io_rdIn,
  input  [4:0]  io_rs1,
  input  [4:0]  io_rs2,
  input  [11:0] io_imm_I,
  input  [11:0] io_imm_S,
  input  [12:0] io_imm_B,
  input  [31:0] io_imm_U,
  input  [20:0] io_imm_J,
  output [31:0] io_imm,
  output [2:0]  io_funct3out,
  output [6:0]  io_funct7out,
  input  [31:0] io_x_0,
  input  [31:0] io_x_1,
  input  [31:0] io_x_2,
  input  [31:0] io_x_3,
  input  [31:0] io_x_4,
  input  [31:0] io_x_5,
  input  [31:0] io_x_6,
  input  [31:0] io_x_7,
  input  [31:0] io_x_8,
  input  [31:0] io_x_9,
  input  [31:0] io_x_10,
  input  [31:0] io_x_11,
  input  [31:0] io_x_12,
  input  [31:0] io_x_13,
  input  [31:0] io_x_14,
  input  [31:0] io_x_15,
  input  [31:0] io_x_16,
  input  [31:0] io_x_17,
  input  [31:0] io_x_18,
  input  [31:0] io_x_19,
  input  [31:0] io_x_20,
  input  [31:0] io_x_21,
  input  [31:0] io_x_22,
  input  [31:0] io_x_23,
  input  [31:0] io_x_24,
  input  [31:0] io_x_25,
  input  [31:0] io_x_26,
  input  [31:0] io_x_27,
  input  [31:0] io_x_28,
  input  [31:0] io_x_29,
  input  [31:0] io_x_30,
  input  [31:0] io_x_31,
  input  [31:0] io_ALUIn,
  output [3:0]  io_group,
  output [31:0] io_operand1,
  output [31:0] io_operand2,
  input  [4:0]  io_rdLastRegMemIn,
  input  [31:0] io_aluLastRegMemIn,
  input  [4:0]  io_rdLoadRegMemIn,
  input  [31:0] io_aluLoadRegMemIn,
  input         io_loadEnable,
  input  [31:0] io_pcIn,
  output [31:0] io_pcOut
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
`endif // RANDOMIZE_REG_INIT
  reg [6:0] opcodeReg; // @[Executer.scala 40:26]
  reg [2:0] funct3Reg; // @[Executer.scala 42:26]
  reg [4:0] rs1Reg; // @[Executer.scala 43:23]
  reg [4:0] rs2Reg; // @[Executer.scala 44:23]
  reg [11:0] imm_IReg; // @[Executer.scala 45:25]
  reg [11:0] imm_SReg; // @[Executer.scala 46:25]
  reg [12:0] imm_BReg; // @[Executer.scala 47:25]
  reg [31:0] imm_UReg; // @[Executer.scala 48:25]
  reg [20:0] imm_JReg; // @[Executer.scala 49:25]
  reg [6:0] funct7Reg; // @[Executer.scala 50:26]
  reg [31:0] pcReg; // @[Executer.scala 52:22]
  reg [4:0] rdLastRegEx; // @[Executer.scala 56:28]
  reg [31:0] aluLastRegEx; // @[Executer.scala 57:29]
  wire  _lastMemBool1_T_1 = rs1Reg != 5'h0; // @[Executer.scala 78:62]
  wire  lastMemBool1 = io_rdLastRegMemIn == rs1Reg & rs1Reg != 5'h0; // @[Executer.scala 78:51]
  wire  _lastMemBool2_T_1 = rs2Reg != 5'h0; // @[Executer.scala 79:62]
  wire  lastMemBool2 = io_rdLastRegMemIn == rs2Reg & rs2Reg != 5'h0; // @[Executer.scala 79:51]
  wire  loadMemBool1 = io_loadEnable & io_rdLoadRegMemIn == rs1Reg; // @[Executer.scala 80:36]
  wire  loadMemBool2 = io_loadEnable & io_rdLoadRegMemIn == rs2Reg; // @[Executer.scala 81:36]
  wire  lastExBool1 = rdLastRegEx == rs1Reg & _lastMemBool1_T_1; // @[Executer.scala 82:46]
  wire  lastExBool2 = rdLastRegEx == rs2Reg & _lastMemBool2_T_1; // @[Executer.scala 83:46]
  wire [31:0] _rs1Wire_T = loadMemBool1 ? $signed(io_aluLoadRegMemIn) : $signed(io_aluLastRegMemIn); // @[Executer.scala 85:69]
  wire [31:0] _GEN_1 = 5'h1 == rs1Reg ? $signed(io_x_1) : $signed(io_x_0); // @[Executer.scala 85:{51,51}]
  wire [31:0] _GEN_2 = 5'h2 == rs1Reg ? $signed(io_x_2) : $signed(_GEN_1); // @[Executer.scala 85:{51,51}]
  wire [31:0] _GEN_3 = 5'h3 == rs1Reg ? $signed(io_x_3) : $signed(_GEN_2); // @[Executer.scala 85:{51,51}]
  wire [31:0] _GEN_4 = 5'h4 == rs1Reg ? $signed(io_x_4) : $signed(_GEN_3); // @[Executer.scala 85:{51,51}]
  wire [31:0] _GEN_5 = 5'h5 == rs1Reg ? $signed(io_x_5) : $signed(_GEN_4); // @[Executer.scala 85:{51,51}]
  wire [31:0] _GEN_6 = 5'h6 == rs1Reg ? $signed(io_x_6) : $signed(_GEN_5); // @[Executer.scala 85:{51,51}]
  wire [31:0] _GEN_7 = 5'h7 == rs1Reg ? $signed(io_x_7) : $signed(_GEN_6); // @[Executer.scala 85:{51,51}]
  wire [31:0] _GEN_8 = 5'h8 == rs1Reg ? $signed(io_x_8) : $signed(_GEN_7); // @[Executer.scala 85:{51,51}]
  wire [31:0] _GEN_9 = 5'h9 == rs1Reg ? $signed(io_x_9) : $signed(_GEN_8); // @[Executer.scala 85:{51,51}]
  wire [31:0] _GEN_10 = 5'ha == rs1Reg ? $signed(io_x_10) : $signed(_GEN_9); // @[Executer.scala 85:{51,51}]
  wire [31:0] _GEN_11 = 5'hb == rs1Reg ? $signed(io_x_11) : $signed(_GEN_10); // @[Executer.scala 85:{51,51}]
  wire [31:0] _GEN_12 = 5'hc == rs1Reg ? $signed(io_x_12) : $signed(_GEN_11); // @[Executer.scala 85:{51,51}]
  wire [31:0] _GEN_13 = 5'hd == rs1Reg ? $signed(io_x_13) : $signed(_GEN_12); // @[Executer.scala 85:{51,51}]
  wire [31:0] _GEN_14 = 5'he == rs1Reg ? $signed(io_x_14) : $signed(_GEN_13); // @[Executer.scala 85:{51,51}]
  wire [31:0] _GEN_15 = 5'hf == rs1Reg ? $signed(io_x_15) : $signed(_GEN_14); // @[Executer.scala 85:{51,51}]
  wire [31:0] _GEN_16 = 5'h10 == rs1Reg ? $signed(io_x_16) : $signed(_GEN_15); // @[Executer.scala 85:{51,51}]
  wire [31:0] _GEN_17 = 5'h11 == rs1Reg ? $signed(io_x_17) : $signed(_GEN_16); // @[Executer.scala 85:{51,51}]
  wire [31:0] _GEN_18 = 5'h12 == rs1Reg ? $signed(io_x_18) : $signed(_GEN_17); // @[Executer.scala 85:{51,51}]
  wire [31:0] _GEN_19 = 5'h13 == rs1Reg ? $signed(io_x_19) : $signed(_GEN_18); // @[Executer.scala 85:{51,51}]
  wire [31:0] _GEN_20 = 5'h14 == rs1Reg ? $signed(io_x_20) : $signed(_GEN_19); // @[Executer.scala 85:{51,51}]
  wire [31:0] _GEN_21 = 5'h15 == rs1Reg ? $signed(io_x_21) : $signed(_GEN_20); // @[Executer.scala 85:{51,51}]
  wire [31:0] _GEN_22 = 5'h16 == rs1Reg ? $signed(io_x_22) : $signed(_GEN_21); // @[Executer.scala 85:{51,51}]
  wire [31:0] _GEN_23 = 5'h17 == rs1Reg ? $signed(io_x_23) : $signed(_GEN_22); // @[Executer.scala 85:{51,51}]
  wire [31:0] _GEN_24 = 5'h18 == rs1Reg ? $signed(io_x_24) : $signed(_GEN_23); // @[Executer.scala 85:{51,51}]
  wire [31:0] _GEN_25 = 5'h19 == rs1Reg ? $signed(io_x_25) : $signed(_GEN_24); // @[Executer.scala 85:{51,51}]
  wire [31:0] _GEN_26 = 5'h1a == rs1Reg ? $signed(io_x_26) : $signed(_GEN_25); // @[Executer.scala 85:{51,51}]
  wire [31:0] _GEN_27 = 5'h1b == rs1Reg ? $signed(io_x_27) : $signed(_GEN_26); // @[Executer.scala 85:{51,51}]
  wire [31:0] _GEN_28 = 5'h1c == rs1Reg ? $signed(io_x_28) : $signed(_GEN_27); // @[Executer.scala 85:{51,51}]
  wire [31:0] _GEN_29 = 5'h1d == rs1Reg ? $signed(io_x_29) : $signed(_GEN_28); // @[Executer.scala 85:{51,51}]
  wire [31:0] _GEN_30 = 5'h1e == rs1Reg ? $signed(io_x_30) : $signed(_GEN_29); // @[Executer.scala 85:{51,51}]
  wire [31:0] _GEN_31 = 5'h1f == rs1Reg ? $signed(io_x_31) : $signed(_GEN_30); // @[Executer.scala 85:{51,51}]
  wire [31:0] _rs1Wire_T_1 = lastMemBool1 ? $signed(_rs1Wire_T) : $signed(_GEN_31); // @[Executer.scala 85:51]
  wire [31:0] _rs2Wire_T = loadMemBool2 ? $signed(io_aluLoadRegMemIn) : $signed(io_aluLastRegMemIn); // @[Executer.scala 86:69]
  wire [31:0] _GEN_33 = 5'h1 == rs2Reg ? $signed(io_x_1) : $signed(io_x_0); // @[Executer.scala 86:{51,51}]
  wire [31:0] _GEN_34 = 5'h2 == rs2Reg ? $signed(io_x_2) : $signed(_GEN_33); // @[Executer.scala 86:{51,51}]
  wire [31:0] _GEN_35 = 5'h3 == rs2Reg ? $signed(io_x_3) : $signed(_GEN_34); // @[Executer.scala 86:{51,51}]
  wire [31:0] _GEN_36 = 5'h4 == rs2Reg ? $signed(io_x_4) : $signed(_GEN_35); // @[Executer.scala 86:{51,51}]
  wire [31:0] _GEN_37 = 5'h5 == rs2Reg ? $signed(io_x_5) : $signed(_GEN_36); // @[Executer.scala 86:{51,51}]
  wire [31:0] _GEN_38 = 5'h6 == rs2Reg ? $signed(io_x_6) : $signed(_GEN_37); // @[Executer.scala 86:{51,51}]
  wire [31:0] _GEN_39 = 5'h7 == rs2Reg ? $signed(io_x_7) : $signed(_GEN_38); // @[Executer.scala 86:{51,51}]
  wire [31:0] _GEN_40 = 5'h8 == rs2Reg ? $signed(io_x_8) : $signed(_GEN_39); // @[Executer.scala 86:{51,51}]
  wire [31:0] _GEN_41 = 5'h9 == rs2Reg ? $signed(io_x_9) : $signed(_GEN_40); // @[Executer.scala 86:{51,51}]
  wire [31:0] _GEN_42 = 5'ha == rs2Reg ? $signed(io_x_10) : $signed(_GEN_41); // @[Executer.scala 86:{51,51}]
  wire [31:0] _GEN_43 = 5'hb == rs2Reg ? $signed(io_x_11) : $signed(_GEN_42); // @[Executer.scala 86:{51,51}]
  wire [31:0] _GEN_44 = 5'hc == rs2Reg ? $signed(io_x_12) : $signed(_GEN_43); // @[Executer.scala 86:{51,51}]
  wire [31:0] _GEN_45 = 5'hd == rs2Reg ? $signed(io_x_13) : $signed(_GEN_44); // @[Executer.scala 86:{51,51}]
  wire [31:0] _GEN_46 = 5'he == rs2Reg ? $signed(io_x_14) : $signed(_GEN_45); // @[Executer.scala 86:{51,51}]
  wire [31:0] _GEN_47 = 5'hf == rs2Reg ? $signed(io_x_15) : $signed(_GEN_46); // @[Executer.scala 86:{51,51}]
  wire [31:0] _GEN_48 = 5'h10 == rs2Reg ? $signed(io_x_16) : $signed(_GEN_47); // @[Executer.scala 86:{51,51}]
  wire [31:0] _GEN_49 = 5'h11 == rs2Reg ? $signed(io_x_17) : $signed(_GEN_48); // @[Executer.scala 86:{51,51}]
  wire [31:0] _GEN_50 = 5'h12 == rs2Reg ? $signed(io_x_18) : $signed(_GEN_49); // @[Executer.scala 86:{51,51}]
  wire [31:0] _GEN_51 = 5'h13 == rs2Reg ? $signed(io_x_19) : $signed(_GEN_50); // @[Executer.scala 86:{51,51}]
  wire [31:0] _GEN_52 = 5'h14 == rs2Reg ? $signed(io_x_20) : $signed(_GEN_51); // @[Executer.scala 86:{51,51}]
  wire [31:0] _GEN_53 = 5'h15 == rs2Reg ? $signed(io_x_21) : $signed(_GEN_52); // @[Executer.scala 86:{51,51}]
  wire [31:0] _GEN_54 = 5'h16 == rs2Reg ? $signed(io_x_22) : $signed(_GEN_53); // @[Executer.scala 86:{51,51}]
  wire [31:0] _GEN_55 = 5'h17 == rs2Reg ? $signed(io_x_23) : $signed(_GEN_54); // @[Executer.scala 86:{51,51}]
  wire [31:0] _GEN_56 = 5'h18 == rs2Reg ? $signed(io_x_24) : $signed(_GEN_55); // @[Executer.scala 86:{51,51}]
  wire [31:0] _GEN_57 = 5'h19 == rs2Reg ? $signed(io_x_25) : $signed(_GEN_56); // @[Executer.scala 86:{51,51}]
  wire [31:0] _GEN_58 = 5'h1a == rs2Reg ? $signed(io_x_26) : $signed(_GEN_57); // @[Executer.scala 86:{51,51}]
  wire [31:0] _GEN_59 = 5'h1b == rs2Reg ? $signed(io_x_27) : $signed(_GEN_58); // @[Executer.scala 86:{51,51}]
  wire [31:0] _GEN_60 = 5'h1c == rs2Reg ? $signed(io_x_28) : $signed(_GEN_59); // @[Executer.scala 86:{51,51}]
  wire [31:0] _GEN_61 = 5'h1d == rs2Reg ? $signed(io_x_29) : $signed(_GEN_60); // @[Executer.scala 86:{51,51}]
  wire [31:0] _GEN_62 = 5'h1e == rs2Reg ? $signed(io_x_30) : $signed(_GEN_61); // @[Executer.scala 86:{51,51}]
  wire [31:0] _GEN_63 = 5'h1f == rs2Reg ? $signed(io_x_31) : $signed(_GEN_62); // @[Executer.scala 86:{51,51}]
  wire [31:0] _rs2Wire_T_1 = lastMemBool2 ? $signed(_rs2Wire_T) : $signed(_GEN_63); // @[Executer.scala 86:51]
  wire [31:0] rs2Wire = lastExBool2 ? $signed(aluLastRegEx) : $signed(_rs2Wire_T_1); // @[Executer.scala 86:20]
  wire [4:0] _io_operand2_T = rs2Reg; // @[Executer.scala 108:33]
  wire [6:0] _GEN_64 = 3'h5 == funct3Reg ? funct7Reg : 7'h0; // @[Executer.scala 104:20 105:25 111:24]
  wire [11:0] _GEN_65 = 3'h5 == funct3Reg ? $signed({{7{_io_operand2_T[4]}},_io_operand2_T}) : $signed(imm_IReg); // @[Executer.scala 103:19 105:25 112:23]
  wire [6:0] _GEN_66 = 3'h1 == funct3Reg ? funct7Reg : _GEN_64; // @[Executer.scala 105:25 107:24]
  wire [11:0] _GEN_67 = 3'h1 == funct3Reg ? $signed({{7{_io_operand2_T[4]}},_io_operand2_T}) : $signed(_GEN_65); // @[Executer.scala 105:25 108:23]
  wire [3:0] _GEN_68 = 7'h17 == opcodeReg ? 4'h8 : 4'h0; // @[Executer.scala 144:16 95:12 96:21]
  wire [31:0] _GEN_69 = 7'h17 == opcodeReg ? $signed(imm_UReg) : $signed({{20{imm_IReg[11]}},imm_IReg}); // @[Executer.scala 145:14 91:10 96:21]
  wire [3:0] _GEN_70 = 7'h37 == opcodeReg ? 4'h7 : _GEN_68; // @[Executer.scala 140:16 96:21]
  wire [31:0] _GEN_71 = 7'h37 == opcodeReg ? $signed(imm_UReg) : $signed(_GEN_69); // @[Executer.scala 141:14 96:21]
  wire [3:0] _GEN_72 = 7'h67 == opcodeReg ? 4'h6 : _GEN_70; // @[Executer.scala 136:16 96:21]
  wire [31:0] _GEN_73 = 7'h67 == opcodeReg ? $signed({{20{imm_IReg[11]}},imm_IReg}) : $signed(_GEN_71); // @[Executer.scala 137:14 96:21]
  wire [3:0] _GEN_74 = 7'h6f == opcodeReg ? 4'h5 : _GEN_72; // @[Executer.scala 132:16 96:21]
  wire [31:0] _GEN_75 = 7'h6f == opcodeReg ? $signed({{11{imm_JReg[20]}},imm_JReg}) : $signed(_GEN_73); // @[Executer.scala 133:14 96:21]
  wire [3:0] _GEN_76 = 7'h63 == opcodeReg ? 4'h4 : _GEN_74; // @[Executer.scala 127:16 96:21]
  wire [31:0] _GEN_77 = 7'h63 == opcodeReg ? $signed(rs2Wire) : $signed(32'sh0); // @[Executer.scala 128:19 94:15 96:21]
  wire [31:0] _GEN_78 = 7'h63 == opcodeReg ? $signed({{19{imm_BReg[12]}},imm_BReg}) : $signed(_GEN_75); // @[Executer.scala 129:14 96:21]
  wire [3:0] _GEN_79 = 7'h23 == opcodeReg ? 4'h3 : _GEN_76; // @[Executer.scala 122:16 96:21]
  wire [31:0] _GEN_80 = 7'h23 == opcodeReg ? $signed(rs2Wire) : $signed(_GEN_77); // @[Executer.scala 123:19 96:21]
  wire [31:0] _GEN_81 = 7'h23 == opcodeReg ? $signed({{20{imm_SReg[11]}},imm_SReg}) : $signed(_GEN_78); // @[Executer.scala 124:14 96:21]
  wire [3:0] _GEN_82 = 7'h3 == opcodeReg ? 4'h2 : _GEN_79; // @[Executer.scala 117:16 96:21]
  wire [31:0] _GEN_83 = 7'h3 == opcodeReg ? $signed(rs2Wire) : $signed(_GEN_80); // @[Executer.scala 118:19 96:21]
  wire [31:0] _GEN_84 = 7'h3 == opcodeReg ? $signed({{20{imm_IReg[11]}},imm_IReg}) : $signed(_GEN_81); // @[Executer.scala 119:14 96:21]
  wire [3:0] _GEN_85 = 7'h13 == opcodeReg ? 4'h1 : _GEN_82; // @[Executer.scala 102:16 96:21]
  wire [31:0] _GEN_86 = 7'h13 == opcodeReg ? $signed({{20{_GEN_67[11]}},_GEN_67}) : $signed(_GEN_83); // @[Executer.scala 96:21]
  wire [6:0] _GEN_87 = 7'h13 == opcodeReg ? _GEN_66 : funct7Reg; // @[Executer.scala 73:16 96:21]
  wire [31:0] _GEN_88 = 7'h13 == opcodeReg ? $signed({{20{imm_IReg[11]}},imm_IReg}) : $signed(_GEN_84); // @[Executer.scala 91:10 96:21]
  assign io_imm = 7'h33 == opcodeReg ? $signed({{20{imm_IReg[11]}},imm_IReg}) : $signed(_GEN_88); // @[Executer.scala 91:10 96:21]
  assign io_funct3out = funct3Reg; // @[Executer.scala 74:16]
  assign io_funct7out = 7'h33 == opcodeReg ? funct7Reg : _GEN_87; // @[Executer.scala 73:16 96:21]
  assign io_group = 7'h33 == opcodeReg ? 4'h1 : _GEN_85; // @[Executer.scala 96:21 99:16]
  assign io_operand1 = lastExBool1 ? $signed(aluLastRegEx) : $signed(_rs1Wire_T_1); // @[Executer.scala 85:20]
  assign io_operand2 = 7'h33 == opcodeReg ? $signed(rs2Wire) : $signed(_GEN_86); // @[Executer.scala 96:21 98:19]
  assign io_pcOut = pcReg; // @[Executer.scala 151:12]
  always @(posedge clock) begin
    if (reset) begin // @[Executer.scala 40:26]
      opcodeReg <= 7'h0; // @[Executer.scala 40:26]
    end else begin
      opcodeReg <= io_opcode; // @[Executer.scala 63:13]
    end
    if (reset) begin // @[Executer.scala 42:26]
      funct3Reg <= 3'h0; // @[Executer.scala 42:26]
    end else begin
      funct3Reg <= io_funct3; // @[Executer.scala 64:13]
    end
    if (reset) begin // @[Executer.scala 43:23]
      rs1Reg <= 5'h0; // @[Executer.scala 43:23]
    end else begin
      rs1Reg <= io_rs1; // @[Executer.scala 65:10]
    end
    if (reset) begin // @[Executer.scala 44:23]
      rs2Reg <= 5'h0; // @[Executer.scala 44:23]
    end else begin
      rs2Reg <= io_rs2; // @[Executer.scala 66:10]
    end
    if (reset) begin // @[Executer.scala 45:25]
      imm_IReg <= 12'sh0; // @[Executer.scala 45:25]
    end else begin
      imm_IReg <= io_imm_I; // @[Executer.scala 67:12]
    end
    if (reset) begin // @[Executer.scala 46:25]
      imm_SReg <= 12'sh0; // @[Executer.scala 46:25]
    end else begin
      imm_SReg <= io_imm_S; // @[Executer.scala 68:12]
    end
    if (reset) begin // @[Executer.scala 47:25]
      imm_BReg <= 13'sh0; // @[Executer.scala 47:25]
    end else begin
      imm_BReg <= io_imm_B; // @[Executer.scala 69:12]
    end
    if (reset) begin // @[Executer.scala 48:25]
      imm_UReg <= 32'h0; // @[Executer.scala 48:25]
    end else begin
      imm_UReg <= io_imm_U; // @[Executer.scala 70:12]
    end
    if (reset) begin // @[Executer.scala 49:25]
      imm_JReg <= 21'sh0; // @[Executer.scala 49:25]
    end else begin
      imm_JReg <= io_imm_J; // @[Executer.scala 71:12]
    end
    if (reset) begin // @[Executer.scala 50:26]
      funct7Reg <= 7'h0; // @[Executer.scala 50:26]
    end else begin
      funct7Reg <= io_funct7; // @[Executer.scala 72:13]
    end
    if (reset) begin // @[Executer.scala 52:22]
      pcReg <= 32'sh0; // @[Executer.scala 52:22]
    end else begin
      pcReg <= io_pcIn; // @[Executer.scala 87:9]
    end
    if (reset) begin // @[Executer.scala 56:28]
      rdLastRegEx <= 5'h0; // @[Executer.scala 56:28]
    end else begin
      rdLastRegEx <= io_rdIn; // @[Executer.scala 149:15]
    end
    if (reset) begin // @[Executer.scala 57:29]
      aluLastRegEx <= 32'sh0; // @[Executer.scala 57:29]
    end else begin
      aluLastRegEx <= io_ALUIn; // @[Executer.scala 150:16]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  opcodeReg = _RAND_0[6:0];
  _RAND_1 = {1{`RANDOM}};
  funct3Reg = _RAND_1[2:0];
  _RAND_2 = {1{`RANDOM}};
  rs1Reg = _RAND_2[4:0];
  _RAND_3 = {1{`RANDOM}};
  rs2Reg = _RAND_3[4:0];
  _RAND_4 = {1{`RANDOM}};
  imm_IReg = _RAND_4[11:0];
  _RAND_5 = {1{`RANDOM}};
  imm_SReg = _RAND_5[11:0];
  _RAND_6 = {1{`RANDOM}};
  imm_BReg = _RAND_6[12:0];
  _RAND_7 = {1{`RANDOM}};
  imm_UReg = _RAND_7[31:0];
  _RAND_8 = {1{`RANDOM}};
  imm_JReg = _RAND_8[20:0];
  _RAND_9 = {1{`RANDOM}};
  funct7Reg = _RAND_9[6:0];
  _RAND_10 = {1{`RANDOM}};
  pcReg = _RAND_10[31:0];
  _RAND_11 = {1{`RANDOM}};
  rdLastRegEx = _RAND_11[4:0];
  _RAND_12 = {1{`RANDOM}};
  aluLastRegEx = _RAND_12[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module ALU(
  input         clock,
  input         reset,
  input  [2:0]  io_funct3,
  input  [6:0]  io_funct7,
  input  [31:0] io_imm,
  input  [31:0] io_pcIn,
  input  [3:0]  io_group,
  input  [31:0] io_operand2,
  input  [31:0] io_operand1,
  output [31:0] io_branchOut,
  output        io_branchEnable,
  output [31:0] io_ALUout,
  output [9:0]  io_rdAddr,
  output [9:0]  io_wrAddr,
  output        io_wrEna,
  output        io_rdEna,
  output [2:0]  io_memOp,
  output [4:0]  io_rdOut,
  input  [4:0]  io_rdIn
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  reg [1:0] cntReg; // @[ALU.scala 38:23]
  wire  _cntReg2_T = cntReg > 2'h0; // @[ALU.scala 39:32]
  reg  cntReg2; // @[ALU.scala 39:24]
  wire  _T_1 = 3'h0 == io_funct3; // @[ALU.scala 56:22]
  wire [31:0] _io_ALUout_T_2 = $signed(io_operand1) + $signed(io_operand2); // @[ALU.scala 58:40]
  wire [31:0] _io_ALUout_T_5 = $signed(io_operand1) - $signed(io_operand2); // @[ALU.scala 61:44]
  wire [31:0] _GEN_0 = 7'h20 == io_funct7 ? $signed(_io_ALUout_T_5) : $signed(_io_ALUout_T_2); // @[ALU.scala 58:21 59:26 61:25]
  wire  _T_3 = 3'h4 == io_funct3; // @[ALU.scala 56:22]
  wire [31:0] _io_ALUout_T_7 = $signed(io_operand1) ^ $signed(io_operand2); // @[ALU.scala 66:40]
  wire  _T_4 = 3'h6 == io_funct3; // @[ALU.scala 56:22]
  wire [31:0] _io_ALUout_T_9 = $signed(io_operand1) | $signed(io_operand2); // @[ALU.scala 69:40]
  wire  _T_5 = 3'h7 == io_funct3; // @[ALU.scala 56:22]
  wire [31:0] _io_ALUout_T_11 = $signed(io_operand1) & $signed(io_operand2); // @[ALU.scala 72:40]
  wire  _T_6 = 3'h1 == io_funct3; // @[ALU.scala 56:22]
  wire [31:0] _io_ALUout_T_12 = io_operand1; // @[ALU.scala 75:34]
  wire [31:0] _io_ALUout_T_13 = io_operand2; // @[ALU.scala 75:53]
  wire [524318:0] _GEN_58 = {{524287'd0}, _io_ALUout_T_12}; // @[ALU.scala 75:41]
  wire [524318:0] _io_ALUout_T_16 = _GEN_58 << _io_ALUout_T_13[18:0]; // @[ALU.scala 75:68]
  wire  _T_7 = 3'h5 == io_funct3; // @[ALU.scala 56:22]
  wire [31:0] _io_ALUout_T_20 = io_operand1 >> io_operand2; // @[ALU.scala 78:61]
  wire [31:0] _io_ALUout_T_22 = $signed(io_operand1) >>> io_operand2; // @[ALU.scala 80:35]
  wire [31:0] _GEN_1 = io_funct7 == 7'h20 ? $signed(_io_ALUout_T_22) : $signed(_io_ALUout_T_20); // @[ALU.scala 78:21 79:35 80:23]
  wire  _T_9 = 3'h2 == io_funct3; // @[ALU.scala 56:22]
  wire  _io_ALUout_T_23 = $signed(io_operand1) < $signed(io_operand2); // @[ALU.scala 84:44]
  wire [1:0] _io_ALUout_T_24 = $signed(io_operand1) < $signed(io_operand2) ? $signed(2'sh1) : $signed(2'sh0); // @[ALU.scala 84:27]
  wire  _io_ALUout_T_27 = io_operand1 < io_operand2; // @[ALU.scala 87:44]
  wire [1:0] _io_ALUout_T_28 = io_operand1 < io_operand2 ? $signed(2'sh1) : $signed(2'sh0); // @[ALU.scala 87:27]
  wire [1:0] _GEN_2 = 3'h3 == io_funct3 ? $signed(_io_ALUout_T_28) : $signed(2'sh0); // @[ALU.scala 46:13 56:22 87:21]
  wire [1:0] _GEN_3 = 3'h2 == io_funct3 ? $signed(_io_ALUout_T_24) : $signed(_GEN_2); // @[ALU.scala 56:22 84:21]
  wire [31:0] _GEN_4 = 3'h5 == io_funct3 ? $signed(_GEN_1) : $signed({{30{_GEN_3[1]}},_GEN_3}); // @[ALU.scala 56:22]
  wire [524318:0] _GEN_5 = 3'h1 == io_funct3 ? $signed(_io_ALUout_T_16) : $signed({{524287{_GEN_4[31]}},_GEN_4}); // @[ALU.scala 56:22 75:21]
  wire [524318:0] _GEN_6 = 3'h7 == io_funct3 ? $signed({{524287{_io_ALUout_T_11[31]}},_io_ALUout_T_11}) : $signed(_GEN_5
    ); // @[ALU.scala 56:22 72:21]
  wire [524318:0] _GEN_7 = 3'h6 == io_funct3 ? $signed({{524287{_io_ALUout_T_9[31]}},_io_ALUout_T_9}) : $signed(_GEN_6); // @[ALU.scala 56:22 69:21]
  wire [524318:0] _GEN_8 = 3'h4 == io_funct3 ? $signed({{524287{_io_ALUout_T_7[31]}},_io_ALUout_T_7}) : $signed(_GEN_7); // @[ALU.scala 56:22 66:21]
  wire [524318:0] _GEN_9 = 3'h0 == io_funct3 ? $signed({{524287{_GEN_0[31]}},_GEN_0}) : $signed(_GEN_8); // @[ALU.scala 56:22]
  wire [31:0] _io_rdAddr_T_2 = $signed(io_operand1) + $signed(io_imm); // @[ALU.scala 92:30]
  wire [2:0] _GEN_10 = _T_7 ? 3'h5 : 3'h0; // @[ALU.scala 109:20 44:12 94:22]
  wire [2:0] _GEN_11 = _T_3 ? 3'h4 : _GEN_10; // @[ALU.scala 106:20 94:22]
  wire [2:0] _GEN_12 = _T_9 ? 3'h3 : _GEN_11; // @[ALU.scala 103:20 94:22]
  wire [2:0] _GEN_13 = _T_6 ? 3'h2 : _GEN_12; // @[ALU.scala 100:20 94:22]
  wire [2:0] _GEN_14 = _T_1 ? 3'h1 : _GEN_13; // @[ALU.scala 94:22 97:20]
  wire [1:0] _GEN_15 = _T_9 ? 2'h3 : 2'h0; // @[ALU.scala 117:22 125:20 44:12]
  wire [1:0] _GEN_16 = _T_6 ? 2'h2 : _GEN_15; // @[ALU.scala 117:22 122:20]
  wire [1:0] _GEN_17 = _T_1 ? 2'h1 : _GEN_16; // @[ALU.scala 117:22 119:20]
  wire  _io_branchEnable_T_1 = _cntReg2_T | cntReg2; // @[ALU.scala 133:49]
  wire  _io_branchEnable_T_2 = _cntReg2_T | cntReg2 ? 1'h0 : 1'h1; // @[ALU.scala 133:35]
  wire [31:0] _io_branchOut_T_2 = $signed(io_pcIn) + $signed(io_imm); // @[ALU.scala 134:35]
  wire [31:0] _io_branchOut_T_5 = $signed(_io_branchOut_T_2) - 32'sh8; // @[ALU.scala 134:41]
  wire  _GEN_18 = $signed(io_operand1) == $signed(io_operand2) & _io_branchEnable_T_2; // @[ALU.scala 132:39 133:29 48:19]
  wire [31:0] _GEN_19 = $signed(io_operand1) == $signed(io_operand2) ? $signed(_io_branchOut_T_5) : $signed(32'sh0); // @[ALU.scala 132:39 134:26 47:16]
  wire  _GEN_20 = $signed(io_operand1) != $signed(io_operand2) & _io_branchEnable_T_2; // @[ALU.scala 138:39 139:29 48:19]
  wire [31:0] _GEN_21 = $signed(io_operand1) != $signed(io_operand2) ? $signed(_io_branchOut_T_5) : $signed(32'sh0); // @[ALU.scala 138:39 140:26 47:16]
  wire  _GEN_22 = _io_ALUout_T_23 & _io_branchEnable_T_2; // @[ALU.scala 145:37 146:29 48:19]
  wire [31:0] _GEN_23 = _io_ALUout_T_23 ? $signed(_io_branchOut_T_5) : $signed(32'sh0); // @[ALU.scala 145:37 147:26 47:16]
  wire  _GEN_24 = $signed(io_operand1) >= $signed(io_operand2) & _io_branchEnable_T_2; // @[ALU.scala 151:38 152:29 48:19]
  wire [31:0] _GEN_25 = $signed(io_operand1) >= $signed(io_operand2) ? $signed(_io_branchOut_T_5) : $signed(32'sh0); // @[ALU.scala 151:38 153:26 47:16]
  wire  _GEN_26 = _io_ALUout_T_27 & _io_branchEnable_T_2; // @[ALU.scala 158:51 159:29 48:19]
  wire [31:0] _GEN_27 = _io_ALUout_T_27 ? $signed(_io_branchOut_T_5) : $signed(32'sh0); // @[ALU.scala 158:51 160:26 47:16]
  wire  _GEN_28 = io_operand1 >= io_operand2 & _io_branchEnable_T_2; // @[ALU.scala 164:52 165:29 48:19]
  wire [31:0] _GEN_29 = io_operand1 >= io_operand2 ? $signed(_io_branchOut_T_5) : $signed(32'sh0); // @[ALU.scala 164:52 166:26 47:16]
  wire  _GEN_30 = _T_5 & _GEN_28; // @[ALU.scala 130:22 48:19]
  wire [31:0] _GEN_31 = _T_5 ? $signed(_GEN_29) : $signed(32'sh0); // @[ALU.scala 130:22 47:16]
  wire  _GEN_32 = _T_4 ? _GEN_26 : _GEN_30; // @[ALU.scala 130:22]
  wire [31:0] _GEN_33 = _T_4 ? $signed(_GEN_27) : $signed(_GEN_31); // @[ALU.scala 130:22]
  wire  _GEN_34 = _T_7 ? _GEN_24 : _GEN_32; // @[ALU.scala 130:22]
  wire [31:0] _GEN_35 = _T_7 ? $signed(_GEN_25) : $signed(_GEN_33); // @[ALU.scala 130:22]
  wire  _GEN_36 = _T_3 ? _GEN_22 : _GEN_34; // @[ALU.scala 130:22]
  wire [31:0] _GEN_37 = _T_3 ? $signed(_GEN_23) : $signed(_GEN_35); // @[ALU.scala 130:22]
  wire  _GEN_38 = _T_6 ? _GEN_20 : _GEN_36; // @[ALU.scala 130:22]
  wire [31:0] _GEN_39 = _T_6 ? $signed(_GEN_21) : $signed(_GEN_37); // @[ALU.scala 130:22]
  wire  _GEN_40 = _T_1 ? _GEN_18 : _GEN_38; // @[ALU.scala 130:22]
  wire [31:0] _GEN_41 = _T_1 ? $signed(_GEN_19) : $signed(_GEN_39); // @[ALU.scala 130:22]
  wire [31:0] _io_branchOut_T_47 = $signed(_io_rdAddr_T_2) - 32'sh4; // @[ALU.scala 179:38]
  wire [31:0] _io_ALUout_T_31 = {io_imm[19:0], 12'h0}; // @[ALU.scala 185:41]
  wire [31:0] _io_ALUout_T_37 = $signed(io_pcIn) + $signed(_io_ALUout_T_31); // @[ALU.scala 188:26]
  wire [31:0] _GEN_42 = 4'h8 == io_group ? $signed(_io_ALUout_T_37) : $signed(32'sh0); // @[ALU.scala 188:17 46:13 54:17]
  wire [31:0] _GEN_43 = 4'h7 == io_group ? $signed(_io_ALUout_T_31) : $signed(_GEN_42); // @[ALU.scala 185:17 54:17]
  wire  _GEN_44 = 4'h6 == io_group & _io_branchEnable_T_2; // @[ALU.scala 54:17 178:23 48:19]
  wire [31:0] _GEN_45 = 4'h6 == io_group ? $signed(_io_branchOut_T_47) : $signed(32'sh0); // @[ALU.scala 54:17 179:20 47:16]
  wire [31:0] _GEN_46 = 4'h6 == io_group ? $signed(io_pcIn) : $signed(_GEN_43); // @[ALU.scala 180:17 54:17]
  wire  _GEN_47 = 4'h6 == io_group & io_branchEnable; // @[ALU.scala 181:12 54:17 52:8]
  wire [31:0] _GEN_48 = 4'h5 == io_group ? $signed(_io_branchOut_T_5) : $signed(_GEN_45); // @[ALU.scala 54:17 172:20]
  wire  _GEN_49 = 4'h5 == io_group ? _io_branchEnable_T_2 : _GEN_44; // @[ALU.scala 54:17 173:23]
  wire [31:0] _GEN_50 = 4'h5 == io_group ? $signed(io_pcIn) : $signed(_GEN_46); // @[ALU.scala 174:17 54:17]
  wire  _GEN_51 = 4'h5 == io_group ? io_branchEnable : _GEN_47; // @[ALU.scala 175:12 54:17]
  wire  _GEN_52 = 4'h4 == io_group ? _GEN_40 : _GEN_49; // @[ALU.scala 54:17]
  wire [31:0] _GEN_53 = 4'h4 == io_group ? $signed(_GEN_41) : $signed(_GEN_48); // @[ALU.scala 54:17]
  wire [31:0] _GEN_54 = 4'h4 == io_group ? $signed(32'sh0) : $signed(_GEN_50); // @[ALU.scala 46:13 54:17]
  wire  _GEN_55 = 4'h4 == io_group ? 1'h0 : _GEN_51; // @[ALU.scala 54:17 52:8]
  wire [31:0] _GEN_56 = 4'h3 == io_group ? $signed(io_operand2) : $signed(_GEN_54); // @[ALU.scala 114:17 54:17]
  wire [9:0] _GEN_57 = 4'h3 == io_group ? _io_rdAddr_T_2[9:0] : 10'h0; // @[ALU.scala 115:17 43:13 54:17]
  wire [1:0] _GEN_59 = 4'h3 == io_group ? _GEN_17 : 2'h0; // @[ALU.scala 44:12 54:17]
  wire  _GEN_60 = 4'h3 == io_group ? 1'h0 : _GEN_52; // @[ALU.scala 54:17 48:19]
  wire [31:0] _GEN_61 = 4'h3 == io_group ? $signed(32'sh0) : $signed(_GEN_53); // @[ALU.scala 47:16 54:17]
  wire  _GEN_62 = 4'h3 == io_group ? 1'h0 : _GEN_55; // @[ALU.scala 54:17 52:8]
  wire [9:0] _GEN_63 = 4'h2 == io_group ? _io_rdAddr_T_2[9:0] : 10'h0; // @[ALU.scala 42:13 54:17 92:17]
  wire [2:0] _GEN_65 = 4'h2 == io_group ? _GEN_14 : {{1'd0}, _GEN_59}; // @[ALU.scala 54:17]
  wire [31:0] _GEN_66 = 4'h2 == io_group ? $signed(32'sh0) : $signed(_GEN_56); // @[ALU.scala 46:13 54:17]
  wire [9:0] _GEN_67 = 4'h2 == io_group ? 10'h0 : _GEN_57; // @[ALU.scala 43:13 54:17]
  wire  _GEN_68 = 4'h2 == io_group ? 1'h0 : 4'h3 == io_group; // @[ALU.scala 40:12 54:17]
  wire  _GEN_69 = 4'h2 == io_group ? 1'h0 : _GEN_60; // @[ALU.scala 54:17 48:19]
  wire [31:0] _GEN_70 = 4'h2 == io_group ? $signed(32'sh0) : $signed(_GEN_61); // @[ALU.scala 47:16 54:17]
  wire  _GEN_71 = 4'h2 == io_group ? 1'h0 : _GEN_62; // @[ALU.scala 54:17 52:8]
  wire [524318:0] _GEN_72 = 4'h1 == io_group ? $signed(_GEN_9) : $signed({{524287{_GEN_66[31]}},_GEN_66}); // @[ALU.scala 54:17]
  wire  _GEN_74 = 4'h1 == io_group ? 1'h0 : 4'h2 == io_group; // @[ALU.scala 41:12 54:17]
  wire  _GEN_77 = 4'h1 == io_group ? 1'h0 : _GEN_68; // @[ALU.scala 40:12 54:17]
  wire  jump = 4'h1 == io_group ? 1'h0 : _GEN_71; // @[ALU.scala 54:17 52:8]
  wire [1:0] _cntNext_T_10 = cntReg - 2'h1; // @[ALU.scala 193:186]
  wire [1:0] _cntNext_T_11 = _cntReg2_T ? _cntNext_T_10 : 2'h0; // @[ALU.scala 193:164]
  wire [1:0] _cntNext_T_12 = io_branchEnable & $signed(io_imm) == 32'sh8 ? 2'h2 : _cntNext_T_11; // @[ALU.scala 193:118]
  wire [1:0] cntNext = jump | io_branchEnable & $signed(io_imm) >= 32'shc | io_branchEnable & $signed(io_imm) <= 32'sh0
     ? 2'h2 : _cntNext_T_12; // @[ALU.scala 193:20]
  reg [4:0] rdReg; // @[ALU.scala 195:22]
  wire [1:0] _cntNext2_T_2 = cntNext - 2'h1; // @[ALU.scala 198:45]
  assign io_branchOut = 4'h1 == io_group ? $signed(32'sh0) : $signed(_GEN_70); // @[ALU.scala 47:16 54:17]
  assign io_branchEnable = 4'h1 == io_group ? 1'h0 : _GEN_69; // @[ALU.scala 54:17 48:19]
  assign io_ALUout = _GEN_72[31:0];
  assign io_rdAddr = 4'h1 == io_group ? 10'h0 : _GEN_63; // @[ALU.scala 42:13 54:17]
  assign io_wrAddr = 4'h1 == io_group ? 10'h0 : _GEN_67; // @[ALU.scala 43:13 54:17]
  assign io_wrEna = _io_branchEnable_T_1 ? 1'h0 : _GEN_77; // @[ALU.scala 207:33 208:14]
  assign io_rdEna = _io_branchEnable_T_1 ? 1'h0 : _GEN_74; // @[ALU.scala 207:33 209:14]
  assign io_memOp = 4'h1 == io_group ? 3'h0 : _GEN_65; // @[ALU.scala 44:12 54:17]
  assign io_rdOut = _cntReg2_T | io_group == 4'h4 ? 5'h0 : rdReg; // @[ALU.scala 205:18]
  always @(posedge clock) begin
    if (reset) begin // @[ALU.scala 38:23]
      cntReg <= 2'h0; // @[ALU.scala 38:23]
    end else if (cntNext > 2'h0) begin // @[ALU.scala 198:21]
      cntReg <= _cntNext2_T_2;
    end else if (jump | io_branchEnable & $signed(io_imm) >= 32'shc | io_branchEnable & $signed(io_imm) <= 32'sh0) begin // @[ALU.scala 193:20]
      cntReg <= 2'h2;
    end else if (io_branchEnable & $signed(io_imm) == 32'sh8) begin // @[ALU.scala 193:118]
      cntReg <= 2'h2;
    end else begin
      cntReg <= _cntNext_T_11;
    end
    cntReg2 <= cntReg > 2'h0; // @[ALU.scala 39:32]
    if (_cntReg2_T) begin // @[ALU.scala 195:26]
      rdReg <= 5'h0;
    end else begin
      rdReg <= io_rdIn;
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  cntReg = _RAND_0[1:0];
  _RAND_1 = {1{`RANDOM}};
  cntReg2 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  rdReg = _RAND_2[4:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Memorizer(
  input         clock,
  input         reset,
  input  [31:0] io_ALUinput,
  input  [4:0]  io_rdInput,
  input  [9:0]  io_rdAddr,
  input  [9:0]  io_wrAddr,
  input  [31:0] io_wrData,
  input         io_wrEna,
  input         io_rdEna,
  input  [2:0]  io_memOp,
  output [4:0]  io_rdLastRegMemOut,
  output [31:0] io_aluLastRegMemOut,
  output [4:0]  io_rdLoadRegMemOut,
  output [31:0] io_aluLoadRegMemOut,
  output        io_loadEnabler,
  output [31:0] io_rdData,
  output        io_rdEnaOut,
  output        io_wrEnaOut,
  output [4:0]  io_rdOutput,
  output [31:0] io_ALUoutput
);
`ifdef RANDOMIZE_GARBAGE_ASSIGN
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_13;
`endif // RANDOMIZE_GARBAGE_ASSIGN
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_12;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_22;
  reg [31:0] _RAND_23;
  reg [31:0] _RAND_24;
  reg [31:0] _RAND_25;
  reg [31:0] _RAND_26;
  reg [31:0] _RAND_27;
  reg [31:0] _RAND_28;
`endif // RANDOMIZE_REG_INIT
  reg [7:0] mem_0 [0:1079999]; // @[Memorizer.scala 50:16]
  wire  mem_0_readByte_0_en; // @[Memorizer.scala 50:16]
  wire [20:0] mem_0_readByte_0_addr; // @[Memorizer.scala 50:16]
  wire [7:0] mem_0_readByte_0_data; // @[Memorizer.scala 50:16]
  wire [7:0] mem_0_MPORT_data; // @[Memorizer.scala 50:16]
  wire [20:0] mem_0_MPORT_addr; // @[Memorizer.scala 50:16]
  wire  mem_0_MPORT_mask; // @[Memorizer.scala 50:16]
  wire  mem_0_MPORT_en; // @[Memorizer.scala 50:16]
  wire [7:0] mem_0_MPORT_4_data; // @[Memorizer.scala 50:16]
  wire [20:0] mem_0_MPORT_4_addr; // @[Memorizer.scala 50:16]
  wire  mem_0_MPORT_4_mask; // @[Memorizer.scala 50:16]
  wire  mem_0_MPORT_4_en; // @[Memorizer.scala 50:16]
  wire [7:0] mem_0_MPORT_10_data; // @[Memorizer.scala 50:16]
  wire [20:0] mem_0_MPORT_10_addr; // @[Memorizer.scala 50:16]
  wire  mem_0_MPORT_10_mask; // @[Memorizer.scala 50:16]
  wire  mem_0_MPORT_10_en; // @[Memorizer.scala 50:16]
  reg  mem_0_readByte_0_en_pipe_0;
  reg [20:0] mem_0_readByte_0_addr_pipe_0;
  reg [7:0] mem_1 [0:1079999]; // @[Memorizer.scala 50:16]
  wire  mem_1_readByte_1_en; // @[Memorizer.scala 50:16]
  wire [20:0] mem_1_readByte_1_addr; // @[Memorizer.scala 50:16]
  wire [7:0] mem_1_readByte_1_data; // @[Memorizer.scala 50:16]
  wire [7:0] mem_1_MPORT_1_data; // @[Memorizer.scala 50:16]
  wire [20:0] mem_1_MPORT_1_addr; // @[Memorizer.scala 50:16]
  wire  mem_1_MPORT_1_mask; // @[Memorizer.scala 50:16]
  wire  mem_1_MPORT_1_en; // @[Memorizer.scala 50:16]
  wire [7:0] mem_1_MPORT_5_data; // @[Memorizer.scala 50:16]
  wire [20:0] mem_1_MPORT_5_addr; // @[Memorizer.scala 50:16]
  wire  mem_1_MPORT_5_mask; // @[Memorizer.scala 50:16]
  wire  mem_1_MPORT_5_en; // @[Memorizer.scala 50:16]
  wire [7:0] mem_1_MPORT_6_data; // @[Memorizer.scala 50:16]
  wire [20:0] mem_1_MPORT_6_addr; // @[Memorizer.scala 50:16]
  wire  mem_1_MPORT_6_mask; // @[Memorizer.scala 50:16]
  wire  mem_1_MPORT_6_en; // @[Memorizer.scala 50:16]
  wire [7:0] mem_1_MPORT_11_data; // @[Memorizer.scala 50:16]
  wire [20:0] mem_1_MPORT_11_addr; // @[Memorizer.scala 50:16]
  wire  mem_1_MPORT_11_mask; // @[Memorizer.scala 50:16]
  wire  mem_1_MPORT_11_en; // @[Memorizer.scala 50:16]
  reg  mem_1_readByte_1_en_pipe_0;
  reg [20:0] mem_1_readByte_1_addr_pipe_0;
  reg [7:0] mem_2 [0:1079999]; // @[Memorizer.scala 50:16]
  wire  mem_2_readByte_2_en; // @[Memorizer.scala 50:16]
  wire [20:0] mem_2_readByte_2_addr; // @[Memorizer.scala 50:16]
  wire [7:0] mem_2_readByte_2_data; // @[Memorizer.scala 50:16]
  wire [7:0] mem_2_MPORT_2_data; // @[Memorizer.scala 50:16]
  wire [20:0] mem_2_MPORT_2_addr; // @[Memorizer.scala 50:16]
  wire  mem_2_MPORT_2_mask; // @[Memorizer.scala 50:16]
  wire  mem_2_MPORT_2_en; // @[Memorizer.scala 50:16]
  wire [7:0] mem_2_MPORT_7_data; // @[Memorizer.scala 50:16]
  wire [20:0] mem_2_MPORT_7_addr; // @[Memorizer.scala 50:16]
  wire  mem_2_MPORT_7_mask; // @[Memorizer.scala 50:16]
  wire  mem_2_MPORT_7_en; // @[Memorizer.scala 50:16]
  wire [7:0] mem_2_MPORT_8_data; // @[Memorizer.scala 50:16]
  wire [20:0] mem_2_MPORT_8_addr; // @[Memorizer.scala 50:16]
  wire  mem_2_MPORT_8_mask; // @[Memorizer.scala 50:16]
  wire  mem_2_MPORT_8_en; // @[Memorizer.scala 50:16]
  wire [7:0] mem_2_MPORT_12_data; // @[Memorizer.scala 50:16]
  wire [20:0] mem_2_MPORT_12_addr; // @[Memorizer.scala 50:16]
  wire  mem_2_MPORT_12_mask; // @[Memorizer.scala 50:16]
  wire  mem_2_MPORT_12_en; // @[Memorizer.scala 50:16]
  reg  mem_2_readByte_2_en_pipe_0;
  reg [20:0] mem_2_readByte_2_addr_pipe_0;
  reg [7:0] mem_3 [0:1079999]; // @[Memorizer.scala 50:16]
  wire  mem_3_readByte_3_en; // @[Memorizer.scala 50:16]
  wire [20:0] mem_3_readByte_3_addr; // @[Memorizer.scala 50:16]
  wire [7:0] mem_3_readByte_3_data; // @[Memorizer.scala 50:16]
  wire [7:0] mem_3_MPORT_3_data; // @[Memorizer.scala 50:16]
  wire [20:0] mem_3_MPORT_3_addr; // @[Memorizer.scala 50:16]
  wire  mem_3_MPORT_3_mask; // @[Memorizer.scala 50:16]
  wire  mem_3_MPORT_3_en; // @[Memorizer.scala 50:16]
  wire [7:0] mem_3_MPORT_9_data; // @[Memorizer.scala 50:16]
  wire [20:0] mem_3_MPORT_9_addr; // @[Memorizer.scala 50:16]
  wire  mem_3_MPORT_9_mask; // @[Memorizer.scala 50:16]
  wire  mem_3_MPORT_9_en; // @[Memorizer.scala 50:16]
  wire [7:0] mem_3_MPORT_13_data; // @[Memorizer.scala 50:16]
  wire [20:0] mem_3_MPORT_13_addr; // @[Memorizer.scala 50:16]
  wire  mem_3_MPORT_13_mask; // @[Memorizer.scala 50:16]
  wire  mem_3_MPORT_13_en; // @[Memorizer.scala 50:16]
  reg  mem_3_readByte_3_en_pipe_0;
  reg [20:0] mem_3_readByte_3_addr_pipe_0;
  reg [4:0] rdReg; // @[Memorizer.scala 30:22]
  reg [31:0] ALUreg; // @[Memorizer.scala 31:23]
  reg [4:0] rdLastRegMem; // @[Memorizer.scala 36:29]
  reg [31:0] aluLastRegMem; // @[Memorizer.scala 37:30]
  reg  wrEnaReg; // @[Memorizer.scala 44:25]
  reg  rdEnaReg; // @[Memorizer.scala 45:25]
  reg [31:0] wrDataReg; // @[Memorizer.scala 46:26]
  reg [9:0] wrAddrReg; // @[Memorizer.scala 47:26]
  reg [2:0] memOpReg; // @[Memorizer.scala 48:25]
  wire [7:0] readAddress = io_rdAddr[9:2]; // @[Memorizer.scala 55:31]
  wire [7:0] writeAddress = wrAddrReg[9:2]; // @[Memorizer.scala 56:32]
  reg [1:0] offset; // @[Memorizer.scala 58:23]
  wire  _T = 3'h0 == memOpReg; // @[Memorizer.scala 76:20]
  wire  _T_2 = offset == 2'h0; // @[Memorizer.scala 82:21]
  wire [7:0] _GEN_12 = offset == 2'h0 ? $signed(mem_0_readByte_0_data) : $signed(8'sh0); // @[Memorizer.scala 72:13 82:30 83:21]
  wire  _GEN_15 = offset == 2'h0 & wrEnaReg; // @[Memorizer.scala 50:16 82:30]
  wire  _T_5 = offset == 2'h1; // @[Memorizer.scala 82:21]
  wire [7:0] _GEN_19 = offset == 2'h1 ? $signed(mem_1_readByte_1_data) : $signed(_GEN_12); // @[Memorizer.scala 82:30 83:21]
  wire  _GEN_22 = offset == 2'h1 & wrEnaReg; // @[Memorizer.scala 50:16 82:30]
  wire  _T_8 = offset == 2'h2; // @[Memorizer.scala 82:21]
  wire [7:0] _GEN_26 = offset == 2'h2 ? $signed(mem_2_readByte_2_data) : $signed(_GEN_19); // @[Memorizer.scala 82:30 83:21]
  wire  _GEN_29 = offset == 2'h2 & wrEnaReg; // @[Memorizer.scala 50:16 82:30]
  wire  _T_11 = offset == 2'h3; // @[Memorizer.scala 82:21]
  wire [7:0] _GEN_33 = offset == 2'h3 ? $signed(mem_3_readByte_3_data) : $signed(_GEN_26); // @[Memorizer.scala 82:30 83:21]
  wire  _GEN_36 = offset == 2'h3 & wrEnaReg; // @[Memorizer.scala 50:16 82:30]
  wire [15:0] _io_rdData_T_5 = {mem_1_readByte_1_data,mem_0_readByte_0_data}; // @[Memorizer.scala 94:58]
  wire [15:0] _GEN_42 = _T_2 ? $signed(_io_rdData_T_5) : $signed(16'sh0); // @[Memorizer.scala 72:13 93:30 94:21]
  wire [15:0] _io_rdData_T_7 = {mem_2_readByte_2_data,mem_1_readByte_1_data}; // @[Memorizer.scala 94:58]
  wire [15:0] _GEN_52 = _T_5 ? $signed(_io_rdData_T_7) : $signed(_GEN_42); // @[Memorizer.scala 93:30 94:21]
  wire [15:0] _io_rdData_T_9 = {mem_3_readByte_3_data,mem_2_readByte_2_data}; // @[Memorizer.scala 94:58]
  wire [15:0] _GEN_62 = _T_8 ? $signed(_io_rdData_T_9) : $signed(_GEN_52); // @[Memorizer.scala 93:30 94:21]
  wire [31:0] _io_rdData_T_11 = {mem_3_readByte_3_data,mem_2_readByte_2_data,mem_1_readByte_1_data,mem_0_readByte_0_data
    }; // @[Memorizer.scala 104:76]
  wire [31:0] _io_rdData_T_13 = {24'h0,mem_0_readByte_0_data}; // @[Memorizer.scala 116:52]
  wire [31:0] _GEN_76 = _T_2 ? $signed(_io_rdData_T_13) : $signed(32'sh0); // @[Memorizer.scala 115:30 116:21 72:13]
  wire [31:0] _io_rdData_T_15 = {24'h0,mem_1_readByte_1_data}; // @[Memorizer.scala 116:52]
  wire [31:0] _GEN_77 = _T_5 ? $signed(_io_rdData_T_15) : $signed(_GEN_76); // @[Memorizer.scala 115:30 116:21]
  wire [31:0] _io_rdData_T_17 = {24'h0,mem_2_readByte_2_data}; // @[Memorizer.scala 116:52]
  wire [31:0] _GEN_78 = _T_8 ? $signed(_io_rdData_T_17) : $signed(_GEN_77); // @[Memorizer.scala 115:30 116:21]
  wire [31:0] _io_rdData_T_19 = {24'h0,mem_3_readByte_3_data}; // @[Memorizer.scala 116:52]
  wire [31:0] _GEN_79 = _T_11 ? $signed(_io_rdData_T_19) : $signed(_GEN_78); // @[Memorizer.scala 115:30 116:21]
  wire [31:0] _io_rdData_T_21 = {16'h0,mem_1_readByte_1_data,mem_0_readByte_0_data}; // @[Memorizer.scala 123:69]
  wire [31:0] _GEN_80 = _T_2 ? $signed(_io_rdData_T_21) : $signed(32'sh0); // @[Memorizer.scala 122:30 123:21 72:13]
  wire [31:0] _io_rdData_T_23 = {16'h0,mem_2_readByte_2_data,mem_1_readByte_1_data}; // @[Memorizer.scala 123:69]
  wire [31:0] _GEN_81 = _T_5 ? $signed(_io_rdData_T_23) : $signed(_GEN_80); // @[Memorizer.scala 122:30 123:21]
  wire [31:0] _io_rdData_T_25 = {16'h0,mem_3_readByte_3_data,mem_2_readByte_2_data}; // @[Memorizer.scala 123:69]
  wire [31:0] _GEN_82 = _T_8 ? $signed(_io_rdData_T_25) : $signed(_GEN_81); // @[Memorizer.scala 122:30 123:21]
  wire [31:0] _GEN_83 = 3'h5 == memOpReg ? $signed(_GEN_82) : $signed(32'sh0); // @[Memorizer.scala 72:13 76:20]
  wire [31:0] _GEN_84 = 3'h4 == memOpReg ? $signed(_GEN_79) : $signed(_GEN_83); // @[Memorizer.scala 76:20]
  wire [31:0] _GEN_85 = 3'h3 == memOpReg ? $signed(_io_rdData_T_11) : $signed(_GEN_84); // @[Memorizer.scala 104:17 76:20]
  wire [31:0] _GEN_97 = 3'h2 == memOpReg ? $signed({{16{_GEN_62[15]}},_GEN_62}) : $signed(_GEN_85); // @[Memorizer.scala 76:20]
  wire  _GEN_121 = 3'h2 == memOpReg ? 1'h0 : 3'h3 == memOpReg & wrEnaReg; // @[Memorizer.scala 50:16 76:20]
  wire [31:0] _GEN_130 = 3'h1 == memOpReg ? $signed({{24{_GEN_33[7]}},_GEN_33}) : $signed(_GEN_97); // @[Memorizer.scala 76:20]
  wire  _GEN_133 = 3'h1 == memOpReg & _GEN_15; // @[Memorizer.scala 50:16 76:20]
  wire  _GEN_138 = 3'h1 == memOpReg & _GEN_22; // @[Memorizer.scala 50:16 76:20]
  wire  _GEN_143 = 3'h1 == memOpReg & _GEN_29; // @[Memorizer.scala 50:16 76:20]
  wire  _GEN_148 = 3'h1 == memOpReg & _GEN_36; // @[Memorizer.scala 50:16 76:20]
  wire  _GEN_153 = 3'h1 == memOpReg ? 1'h0 : 3'h2 == memOpReg & _GEN_15; // @[Memorizer.scala 50:16 76:20]
  wire  _GEN_160 = 3'h1 == memOpReg ? 1'h0 : 3'h2 == memOpReg & _GEN_22; // @[Memorizer.scala 50:16 76:20]
  wire  _GEN_167 = 3'h1 == memOpReg ? 1'h0 : 3'h2 == memOpReg & _GEN_29; // @[Memorizer.scala 50:16 76:20]
  wire  _GEN_174 = 3'h1 == memOpReg ? 1'h0 : _GEN_121; // @[Memorizer.scala 50:16 76:20]
  reg [4:0] rdLoadRegger; // @[Memorizer.scala 128:29]
  reg [31:0] aluLoadRegger; // @[Memorizer.scala 129:30]
  reg  enabler; // @[Memorizer.scala 130:24]
  assign mem_0_readByte_0_en = mem_0_readByte_0_en_pipe_0;
  assign mem_0_readByte_0_addr = mem_0_readByte_0_addr_pipe_0;
  `ifndef RANDOMIZE_GARBAGE_ASSIGN
  assign mem_0_readByte_0_data = mem_0[mem_0_readByte_0_addr]; // @[Memorizer.scala 50:16]
  `else
  assign mem_0_readByte_0_data = mem_0_readByte_0_addr >= 21'h107ac0 ? _RAND_1[7:0] : mem_0[mem_0_readByte_0_addr]; // @[Memorizer.scala 50:16]
  `endif // RANDOMIZE_GARBAGE_ASSIGN
  assign mem_0_MPORT_data = wrDataReg[7:0];
  assign mem_0_MPORT_addr = {{13'd0}, writeAddress};
  assign mem_0_MPORT_mask = 1'h1;
  assign mem_0_MPORT_en = _T ? 1'h0 : _GEN_133;
  assign mem_0_MPORT_4_data = wrDataReg[7:0];
  assign mem_0_MPORT_4_addr = {{13'd0}, writeAddress};
  assign mem_0_MPORT_4_mask = 1'h1;
  assign mem_0_MPORT_4_en = _T ? 1'h0 : _GEN_153;
  assign mem_0_MPORT_10_data = wrDataReg[7:0];
  assign mem_0_MPORT_10_addr = {{13'd0}, writeAddress};
  assign mem_0_MPORT_10_mask = 1'h1;
  assign mem_0_MPORT_10_en = _T ? 1'h0 : _GEN_174;
  assign mem_1_readByte_1_en = mem_1_readByte_1_en_pipe_0;
  assign mem_1_readByte_1_addr = mem_1_readByte_1_addr_pipe_0;
  `ifndef RANDOMIZE_GARBAGE_ASSIGN
  assign mem_1_readByte_1_data = mem_1[mem_1_readByte_1_addr]; // @[Memorizer.scala 50:16]
  `else
  assign mem_1_readByte_1_data = mem_1_readByte_1_addr >= 21'h107ac0 ? _RAND_5[7:0] : mem_1[mem_1_readByte_1_addr]; // @[Memorizer.scala 50:16]
  `endif // RANDOMIZE_GARBAGE_ASSIGN
  assign mem_1_MPORT_1_data = wrDataReg[7:0];
  assign mem_1_MPORT_1_addr = {{13'd0}, writeAddress};
  assign mem_1_MPORT_1_mask = 1'h1;
  assign mem_1_MPORT_1_en = _T ? 1'h0 : _GEN_138;
  assign mem_1_MPORT_5_data = wrDataReg[15:8];
  assign mem_1_MPORT_5_addr = {{13'd0}, writeAddress};
  assign mem_1_MPORT_5_mask = 1'h1;
  assign mem_1_MPORT_5_en = _T ? 1'h0 : _GEN_153;
  assign mem_1_MPORT_6_data = wrDataReg[7:0];
  assign mem_1_MPORT_6_addr = {{13'd0}, writeAddress};
  assign mem_1_MPORT_6_mask = 1'h1;
  assign mem_1_MPORT_6_en = _T ? 1'h0 : _GEN_160;
  assign mem_1_MPORT_11_data = wrDataReg[15:8];
  assign mem_1_MPORT_11_addr = {{13'd0}, writeAddress};
  assign mem_1_MPORT_11_mask = 1'h1;
  assign mem_1_MPORT_11_en = _T ? 1'h0 : _GEN_174;
  assign mem_2_readByte_2_en = mem_2_readByte_2_en_pipe_0;
  assign mem_2_readByte_2_addr = mem_2_readByte_2_addr_pipe_0;
  `ifndef RANDOMIZE_GARBAGE_ASSIGN
  assign mem_2_readByte_2_data = mem_2[mem_2_readByte_2_addr]; // @[Memorizer.scala 50:16]
  `else
  assign mem_2_readByte_2_data = mem_2_readByte_2_addr >= 21'h107ac0 ? _RAND_9[7:0] : mem_2[mem_2_readByte_2_addr]; // @[Memorizer.scala 50:16]
  `endif // RANDOMIZE_GARBAGE_ASSIGN
  assign mem_2_MPORT_2_data = wrDataReg[7:0];
  assign mem_2_MPORT_2_addr = {{13'd0}, writeAddress};
  assign mem_2_MPORT_2_mask = 1'h1;
  assign mem_2_MPORT_2_en = _T ? 1'h0 : _GEN_143;
  assign mem_2_MPORT_7_data = wrDataReg[15:8];
  assign mem_2_MPORT_7_addr = {{13'd0}, writeAddress};
  assign mem_2_MPORT_7_mask = 1'h1;
  assign mem_2_MPORT_7_en = _T ? 1'h0 : _GEN_160;
  assign mem_2_MPORT_8_data = wrDataReg[7:0];
  assign mem_2_MPORT_8_addr = {{13'd0}, writeAddress};
  assign mem_2_MPORT_8_mask = 1'h1;
  assign mem_2_MPORT_8_en = _T ? 1'h0 : _GEN_167;
  assign mem_2_MPORT_12_data = wrDataReg[23:16];
  assign mem_2_MPORT_12_addr = {{13'd0}, writeAddress};
  assign mem_2_MPORT_12_mask = 1'h1;
  assign mem_2_MPORT_12_en = _T ? 1'h0 : _GEN_174;
  assign mem_3_readByte_3_en = mem_3_readByte_3_en_pipe_0;
  assign mem_3_readByte_3_addr = mem_3_readByte_3_addr_pipe_0;
  `ifndef RANDOMIZE_GARBAGE_ASSIGN
  assign mem_3_readByte_3_data = mem_3[mem_3_readByte_3_addr]; // @[Memorizer.scala 50:16]
  `else
  assign mem_3_readByte_3_data = mem_3_readByte_3_addr >= 21'h107ac0 ? _RAND_13[7:0] : mem_3[mem_3_readByte_3_addr]; // @[Memorizer.scala 50:16]
  `endif // RANDOMIZE_GARBAGE_ASSIGN
  assign mem_3_MPORT_3_data = wrDataReg[7:0];
  assign mem_3_MPORT_3_addr = {{13'd0}, writeAddress};
  assign mem_3_MPORT_3_mask = 1'h1;
  assign mem_3_MPORT_3_en = _T ? 1'h0 : _GEN_148;
  assign mem_3_MPORT_9_data = wrDataReg[15:8];
  assign mem_3_MPORT_9_addr = {{13'd0}, writeAddress};
  assign mem_3_MPORT_9_mask = 1'h1;
  assign mem_3_MPORT_9_en = _T ? 1'h0 : _GEN_167;
  assign mem_3_MPORT_13_data = wrDataReg[31:24];
  assign mem_3_MPORT_13_addr = {{13'd0}, writeAddress};
  assign mem_3_MPORT_13_mask = 1'h1;
  assign mem_3_MPORT_13_en = _T ? 1'h0 : _GEN_174;
  assign io_rdLastRegMemOut = rdLastRegMem; // @[Memorizer.scala 41:22]
  assign io_aluLastRegMemOut = aluLastRegMem; // @[Memorizer.scala 42:23]
  assign io_rdLoadRegMemOut = rdLoadRegger; // @[Memorizer.scala 135:22]
  assign io_aluLoadRegMemOut = aluLoadRegger; // @[Memorizer.scala 136:23]
  assign io_loadEnabler = enabler; // @[Memorizer.scala 132:18]
  assign io_rdData = 3'h0 == memOpReg ? $signed(32'sh270f) : $signed(_GEN_130); // @[Memorizer.scala 76:20 78:17]
  assign io_rdEnaOut = rdEnaReg; // @[Memorizer.scala 53:15]
  assign io_wrEnaOut = wrEnaReg; // @[Memorizer.scala 52:15]
  assign io_rdOutput = rdReg; // @[Memorizer.scala 32:15]
  assign io_ALUoutput = ALUreg; // @[Memorizer.scala 33:16]
  always @(posedge clock) begin
    if (mem_0_MPORT_en & mem_0_MPORT_mask) begin
      mem_0[mem_0_MPORT_addr] <= mem_0_MPORT_data; // @[Memorizer.scala 50:16]
    end
    if (mem_0_MPORT_4_en & mem_0_MPORT_4_mask) begin
      mem_0[mem_0_MPORT_4_addr] <= mem_0_MPORT_4_data; // @[Memorizer.scala 50:16]
    end
    if (mem_0_MPORT_10_en & mem_0_MPORT_10_mask) begin
      mem_0[mem_0_MPORT_10_addr] <= mem_0_MPORT_10_data; // @[Memorizer.scala 50:16]
    end
    mem_0_readByte_0_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      mem_0_readByte_0_addr_pipe_0 <= {{13'd0}, readAddress};
    end
    if (mem_1_MPORT_1_en & mem_1_MPORT_1_mask) begin
      mem_1[mem_1_MPORT_1_addr] <= mem_1_MPORT_1_data; // @[Memorizer.scala 50:16]
    end
    if (mem_1_MPORT_5_en & mem_1_MPORT_5_mask) begin
      mem_1[mem_1_MPORT_5_addr] <= mem_1_MPORT_5_data; // @[Memorizer.scala 50:16]
    end
    if (mem_1_MPORT_6_en & mem_1_MPORT_6_mask) begin
      mem_1[mem_1_MPORT_6_addr] <= mem_1_MPORT_6_data; // @[Memorizer.scala 50:16]
    end
    if (mem_1_MPORT_11_en & mem_1_MPORT_11_mask) begin
      mem_1[mem_1_MPORT_11_addr] <= mem_1_MPORT_11_data; // @[Memorizer.scala 50:16]
    end
    mem_1_readByte_1_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      mem_1_readByte_1_addr_pipe_0 <= {{13'd0}, readAddress};
    end
    if (mem_2_MPORT_2_en & mem_2_MPORT_2_mask) begin
      mem_2[mem_2_MPORT_2_addr] <= mem_2_MPORT_2_data; // @[Memorizer.scala 50:16]
    end
    if (mem_2_MPORT_7_en & mem_2_MPORT_7_mask) begin
      mem_2[mem_2_MPORT_7_addr] <= mem_2_MPORT_7_data; // @[Memorizer.scala 50:16]
    end
    if (mem_2_MPORT_8_en & mem_2_MPORT_8_mask) begin
      mem_2[mem_2_MPORT_8_addr] <= mem_2_MPORT_8_data; // @[Memorizer.scala 50:16]
    end
    if (mem_2_MPORT_12_en & mem_2_MPORT_12_mask) begin
      mem_2[mem_2_MPORT_12_addr] <= mem_2_MPORT_12_data; // @[Memorizer.scala 50:16]
    end
    mem_2_readByte_2_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      mem_2_readByte_2_addr_pipe_0 <= {{13'd0}, readAddress};
    end
    if (mem_3_MPORT_3_en & mem_3_MPORT_3_mask) begin
      mem_3[mem_3_MPORT_3_addr] <= mem_3_MPORT_3_data; // @[Memorizer.scala 50:16]
    end
    if (mem_3_MPORT_9_en & mem_3_MPORT_9_mask) begin
      mem_3[mem_3_MPORT_9_addr] <= mem_3_MPORT_9_data; // @[Memorizer.scala 50:16]
    end
    if (mem_3_MPORT_13_en & mem_3_MPORT_13_mask) begin
      mem_3[mem_3_MPORT_13_addr] <= mem_3_MPORT_13_data; // @[Memorizer.scala 50:16]
    end
    mem_3_readByte_3_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      mem_3_readByte_3_addr_pipe_0 <= {{13'd0}, readAddress};
    end
    if (reset) begin // @[Memorizer.scala 30:22]
      rdReg <= 5'h0; // @[Memorizer.scala 30:22]
    end else begin
      rdReg <= io_rdInput; // @[Memorizer.scala 30:22]
    end
    if (reset) begin // @[Memorizer.scala 31:23]
      ALUreg <= 32'sh0; // @[Memorizer.scala 31:23]
    end else begin
      ALUreg <= io_ALUinput; // @[Memorizer.scala 31:23]
    end
    if (reset) begin // @[Memorizer.scala 36:29]
      rdLastRegMem <= 5'h0; // @[Memorizer.scala 36:29]
    end else begin
      rdLastRegMem <= io_rdOutput; // @[Memorizer.scala 39:16]
    end
    if (reset) begin // @[Memorizer.scala 37:30]
      aluLastRegMem <= 32'sh0; // @[Memorizer.scala 37:30]
    end else begin
      aluLastRegMem <= io_ALUoutput; // @[Memorizer.scala 40:17]
    end
    if (reset) begin // @[Memorizer.scala 44:25]
      wrEnaReg <= 1'h0; // @[Memorizer.scala 44:25]
    end else begin
      wrEnaReg <= io_wrEna; // @[Memorizer.scala 44:25]
    end
    if (reset) begin // @[Memorizer.scala 45:25]
      rdEnaReg <= 1'h0; // @[Memorizer.scala 45:25]
    end else begin
      rdEnaReg <= io_rdEna; // @[Memorizer.scala 45:25]
    end
    if (reset) begin // @[Memorizer.scala 46:26]
      wrDataReg <= 32'h0; // @[Memorizer.scala 46:26]
    end else begin
      wrDataReg <= io_wrData; // @[Memorizer.scala 46:26]
    end
    if (reset) begin // @[Memorizer.scala 47:26]
      wrAddrReg <= 10'h0; // @[Memorizer.scala 47:26]
    end else begin
      wrAddrReg <= io_wrAddr; // @[Memorizer.scala 47:26]
    end
    if (reset) begin // @[Memorizer.scala 48:25]
      memOpReg <= 3'h0; // @[Memorizer.scala 48:25]
    end else begin
      memOpReg <= io_memOp; // @[Memorizer.scala 48:25]
    end
    if (reset) begin // @[Memorizer.scala 58:23]
      offset <= 2'h0; // @[Memorizer.scala 58:23]
    end else begin
      offset <= io_rdAddr[1:0]; // @[Memorizer.scala 58:23]
    end
    if (reset) begin // @[Memorizer.scala 128:29]
      rdLoadRegger <= 5'h0; // @[Memorizer.scala 128:29]
    end else begin
      rdLoadRegger <= rdReg; // @[Memorizer.scala 133:16]
    end
    if (reset) begin // @[Memorizer.scala 129:30]
      aluLoadRegger <= 32'sh0; // @[Memorizer.scala 129:30]
    end else begin
      aluLoadRegger <= io_rdData; // @[Memorizer.scala 134:17]
    end
    if (reset) begin // @[Memorizer.scala 130:24]
      enabler <= 1'h0; // @[Memorizer.scala 130:24]
    end else begin
      enabler <= rdEnaReg; // @[Memorizer.scala 131:11]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_GARBAGE_ASSIGN
  _RAND_1 = {1{`RANDOM}};
  _RAND_5 = {1{`RANDOM}};
  _RAND_9 = {1{`RANDOM}};
  _RAND_13 = {1{`RANDOM}};
`endif // RANDOMIZE_GARBAGE_ASSIGN
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 1080000; initvar = initvar+1)
    mem_0[initvar] = _RAND_0[7:0];
  _RAND_4 = {1{`RANDOM}};
  for (initvar = 0; initvar < 1080000; initvar = initvar+1)
    mem_1[initvar] = _RAND_4[7:0];
  _RAND_8 = {1{`RANDOM}};
  for (initvar = 0; initvar < 1080000; initvar = initvar+1)
    mem_2[initvar] = _RAND_8[7:0];
  _RAND_12 = {1{`RANDOM}};
  for (initvar = 0; initvar < 1080000; initvar = initvar+1)
    mem_3[initvar] = _RAND_12[7:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  mem_0_readByte_0_en_pipe_0 = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  mem_0_readByte_0_addr_pipe_0 = _RAND_3[20:0];
  _RAND_6 = {1{`RANDOM}};
  mem_1_readByte_1_en_pipe_0 = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  mem_1_readByte_1_addr_pipe_0 = _RAND_7[20:0];
  _RAND_10 = {1{`RANDOM}};
  mem_2_readByte_2_en_pipe_0 = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  mem_2_readByte_2_addr_pipe_0 = _RAND_11[20:0];
  _RAND_14 = {1{`RANDOM}};
  mem_3_readByte_3_en_pipe_0 = _RAND_14[0:0];
  _RAND_15 = {1{`RANDOM}};
  mem_3_readByte_3_addr_pipe_0 = _RAND_15[20:0];
  _RAND_16 = {1{`RANDOM}};
  rdReg = _RAND_16[4:0];
  _RAND_17 = {1{`RANDOM}};
  ALUreg = _RAND_17[31:0];
  _RAND_18 = {1{`RANDOM}};
  rdLastRegMem = _RAND_18[4:0];
  _RAND_19 = {1{`RANDOM}};
  aluLastRegMem = _RAND_19[31:0];
  _RAND_20 = {1{`RANDOM}};
  wrEnaReg = _RAND_20[0:0];
  _RAND_21 = {1{`RANDOM}};
  rdEnaReg = _RAND_21[0:0];
  _RAND_22 = {1{`RANDOM}};
  wrDataReg = _RAND_22[31:0];
  _RAND_23 = {1{`RANDOM}};
  wrAddrReg = _RAND_23[9:0];
  _RAND_24 = {1{`RANDOM}};
  memOpReg = _RAND_24[2:0];
  _RAND_25 = {1{`RANDOM}};
  offset = _RAND_25[1:0];
  _RAND_26 = {1{`RANDOM}};
  rdLoadRegger = _RAND_26[4:0];
  _RAND_27 = {1{`RANDOM}};
  aluLoadRegger = _RAND_27[31:0];
  _RAND_28 = {1{`RANDOM}};
  enabler = _RAND_28[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Write_backer(
  input         clock,
  input         reset,
  input  [31:0] io_ALUinput,
  output [31:0] io_ALUoutput,
  input  [4:0]  io_rdInput,
  output [4:0]  io_rdOut,
  input         io_rdEnaIn,
  input         io_wrEnaIn,
  input  [31:0] io_rdData
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
`endif // RANDOMIZE_REG_INIT
  reg [4:0] rdReg; // @[Write_backer.scala 15:22]
  reg [31:0] ALUreg; // @[Write_backer.scala 16:23]
  reg [31:0] rdDataReg; // @[Write_backer.scala 17:26]
  reg  rdEnaInReg; // @[Write_backer.scala 18:27]
  reg  wrEnaInReg; // @[Write_backer.scala 19:27]
  wire [31:0] _io_ALUoutput_T = rdEnaInReg ? $signed(rdDataReg) : $signed(ALUreg); // @[Write_backer.scala 28:22]
  assign io_ALUoutput = wrEnaInReg | rdReg == 5'h0 ? $signed(32'sh0) : $signed(_io_ALUoutput_T); // @[Write_backer.scala 28:16 31:37 32:18]
  assign io_rdOut = wrEnaInReg | rdReg == 5'h0 ? 5'h0 : rdReg; // @[Write_backer.scala 29:12 31:37 33:14]
  always @(posedge clock) begin
    if (reset) begin // @[Write_backer.scala 15:22]
      rdReg <= 5'h0; // @[Write_backer.scala 15:22]
    end else begin
      rdReg <= io_rdInput; // @[Write_backer.scala 21:9]
    end
    if (reset) begin // @[Write_backer.scala 16:23]
      ALUreg <= 32'sh0; // @[Write_backer.scala 16:23]
    end else begin
      ALUreg <= io_ALUinput; // @[Write_backer.scala 22:10]
    end
    if (reset) begin // @[Write_backer.scala 17:26]
      rdDataReg <= 32'sh0; // @[Write_backer.scala 17:26]
    end else begin
      rdDataReg <= io_rdData; // @[Write_backer.scala 23:13]
    end
    if (reset) begin // @[Write_backer.scala 18:27]
      rdEnaInReg <= 1'h0; // @[Write_backer.scala 18:27]
    end else begin
      rdEnaInReg <= io_rdEnaIn; // @[Write_backer.scala 24:14]
    end
    if (reset) begin // @[Write_backer.scala 19:27]
      wrEnaInReg <= 1'h0; // @[Write_backer.scala 19:27]
    end else begin
      wrEnaInReg <= io_wrEnaIn; // @[Write_backer.scala 25:14]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  rdReg = _RAND_0[4:0];
  _RAND_1 = {1{`RANDOM}};
  ALUreg = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  rdDataReg = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  rdEnaInReg = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  wrEnaInReg = _RAND_4[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module SevSeg(
  input  [3:0] io_in,
  output [6:0] io_out
);
  wire [6:0] _GEN_0 = 4'hf == io_in ? 7'h71 : 7'h0; // @[SevSeg.scala 14:17 30:22 10:27]
  wire [6:0] _GEN_1 = 4'he == io_in ? 7'h79 : _GEN_0; // @[SevSeg.scala 14:17 29:22]
  wire [6:0] _GEN_2 = 4'hd == io_in ? 7'h5e : _GEN_1; // @[SevSeg.scala 14:17 28:22]
  wire [6:0] _GEN_3 = 4'hc == io_in ? 7'h39 : _GEN_2; // @[SevSeg.scala 14:17 27:22]
  wire [6:0] _GEN_4 = 4'hb == io_in ? 7'h7c : _GEN_3; // @[SevSeg.scala 14:17 26:22]
  wire [6:0] _GEN_5 = 4'ha == io_in ? 7'h77 : _GEN_4; // @[SevSeg.scala 14:17 25:22]
  wire [6:0] _GEN_6 = 4'h9 == io_in ? 7'h67 : _GEN_5; // @[SevSeg.scala 14:17 24:21]
  wire [6:0] _GEN_7 = 4'h8 == io_in ? 7'h7f : _GEN_6; // @[SevSeg.scala 14:17 23:21]
  wire [6:0] _GEN_8 = 4'h7 == io_in ? 7'h7 : _GEN_7; // @[SevSeg.scala 14:17 22:21]
  wire [6:0] _GEN_9 = 4'h6 == io_in ? 7'h7d : _GEN_8; // @[SevSeg.scala 14:17 21:21]
  wire [6:0] _GEN_10 = 4'h5 == io_in ? 7'h6d : _GEN_9; // @[SevSeg.scala 14:17 20:21]
  wire [6:0] _GEN_11 = 4'h4 == io_in ? 7'h66 : _GEN_10; // @[SevSeg.scala 14:17 19:21]
  wire [6:0] _GEN_12 = 4'h3 == io_in ? 7'h4f : _GEN_11; // @[SevSeg.scala 14:17 18:21]
  wire [6:0] _GEN_13 = 4'h2 == io_in ? 7'h5b : _GEN_12; // @[SevSeg.scala 14:17 17:21]
  wire [6:0] _GEN_14 = 4'h1 == io_in ? 7'h6 : _GEN_13; // @[SevSeg.scala 14:17 16:21]
  assign io_out = 4'h0 == io_in ? 7'h3f : _GEN_14; // @[SevSeg.scala 14:17 15:21]
endmodule
module DisplayMux(
  input         clock,
  input         reset,
  input  [31:0] io_xReg,
  output [6:0]  io_seg,
  output [7:0]  io_an
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  wire [3:0] dec_io_in; // @[DisplayMux.scala 24:19]
  wire [6:0] dec_io_out; // @[DisplayMux.scala 24:19]
  reg [16:0] cnt3_cntReg; // @[DisplayMux.scala 16:25]
  wire [16:0] _cnt3_cntReg_T_2 = cnt3_cntReg + 17'h1; // @[DisplayMux.scala 17:59]
  reg [2:0] cnt3; // @[DisplayMux.scala 16:25]
  wire [2:0] _cnt3_cntReg_T_7 = cnt3 + 3'h1; // @[DisplayMux.scala 17:59]
  wire  _T = 3'h0 == cnt3; // @[DisplayMux.scala 29:16]
  wire  _T_1 = 3'h1 == cnt3; // @[DisplayMux.scala 29:16]
  wire  _T_2 = 3'h2 == cnt3; // @[DisplayMux.scala 29:16]
  wire  _T_3 = 3'h3 == cnt3; // @[DisplayMux.scala 29:16]
  wire  _T_4 = 3'h4 == cnt3; // @[DisplayMux.scala 29:16]
  wire  _T_5 = 3'h5 == cnt3; // @[DisplayMux.scala 29:16]
  wire  _T_6 = 3'h6 == cnt3; // @[DisplayMux.scala 29:16]
  wire  _T_7 = 3'h7 == cnt3; // @[DisplayMux.scala 29:16]
  wire [3:0] _GEN_0 = 3'h7 == cnt3 ? io_xReg[31:28] : 4'h0; // @[DisplayMux.scala 27:13 29:16 37:25]
  wire [3:0] _GEN_1 = 3'h6 == cnt3 ? io_xReg[27:24] : _GEN_0; // @[DisplayMux.scala 29:16 36:25]
  wire [3:0] _GEN_2 = 3'h5 == cnt3 ? io_xReg[23:20] : _GEN_1; // @[DisplayMux.scala 29:16 35:25]
  wire [3:0] _GEN_3 = 3'h4 == cnt3 ? io_xReg[19:16] : _GEN_2; // @[DisplayMux.scala 29:16 34:25]
  wire [3:0] _GEN_4 = 3'h3 == cnt3 ? io_xReg[15:12] : _GEN_3; // @[DisplayMux.scala 29:16 33:25]
  wire [3:0] _GEN_5 = 3'h2 == cnt3 ? io_xReg[11:8] : _GEN_4; // @[DisplayMux.scala 29:16 32:25]
  wire [3:0] _GEN_6 = 3'h1 == cnt3 ? io_xReg[7:4] : _GEN_5; // @[DisplayMux.scala 29:16 31:25]
  wire [7:0] _GEN_8 = _T_7 ? 8'h80 : 8'h1; // @[DisplayMux.scala 43:16 51:22 12:27]
  wire [7:0] _GEN_9 = _T_6 ? 8'h40 : _GEN_8; // @[DisplayMux.scala 43:16 50:22]
  wire [7:0] _GEN_10 = _T_5 ? 8'h20 : _GEN_9; // @[DisplayMux.scala 43:16 49:22]
  wire [7:0] _GEN_11 = _T_4 ? 8'h10 : _GEN_10; // @[DisplayMux.scala 43:16 48:22]
  wire [7:0] _GEN_12 = _T_3 ? 8'h8 : _GEN_11; // @[DisplayMux.scala 43:16 47:22]
  wire [7:0] _GEN_13 = _T_2 ? 8'h4 : _GEN_12; // @[DisplayMux.scala 43:16 46:22]
  wire [7:0] _GEN_14 = _T_1 ? 8'h2 : _GEN_13; // @[DisplayMux.scala 43:16 45:22]
  wire [7:0] select = _T ? 8'h1 : _GEN_14; // @[DisplayMux.scala 43:16 44:22]
  wire [6:0] sevSeg = dec_io_out; // @[DisplayMux.scala 11:27 41:10]
  SevSeg dec ( // @[DisplayMux.scala 24:19]
    .io_in(dec_io_in),
    .io_out(dec_io_out)
  );
  assign io_seg = ~sevSeg; // @[DisplayMux.scala 55:13]
  assign io_an = ~select; // @[DisplayMux.scala 56:12]
  assign dec_io_in = 3'h0 == cnt3 ? io_xReg[3:0] : _GEN_6; // @[DisplayMux.scala 29:16 30:25]
  always @(posedge clock) begin
    if (reset) begin // @[DisplayMux.scala 16:25]
      cnt3_cntReg <= 17'h0; // @[DisplayMux.scala 16:25]
    end else if (cnt3_cntReg == 17'h186a0) begin // @[DisplayMux.scala 17:30]
      cnt3_cntReg <= 17'h0;
    end else begin
      cnt3_cntReg <= _cnt3_cntReg_T_2;
    end
    if (reset) begin // @[DisplayMux.scala 16:25]
      cnt3 <= 3'h0; // @[DisplayMux.scala 16:25]
    end else if (cnt3_cntReg == 17'h186a0) begin // @[DisplayMux.scala 17:18]
      if (cnt3 == 3'h7) begin // @[DisplayMux.scala 17:30]
        cnt3 <= 3'h0;
      end else begin
        cnt3 <= _cnt3_cntReg_T_7;
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  cnt3_cntReg = _RAND_0[16:0];
  _RAND_1 = {1{`RANDOM}};
  cnt3 = _RAND_1[2:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Food(
  input        clock,
  input        reset,
  output [6:0] io_seg,
  output [7:0] io_an,
  input        io_switchin,
  input        io_switchin2,
  input        io_switchin3,
  input        io_switchin4,
  input        io_switchin5
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_22;
  reg [31:0] _RAND_23;
  reg [31:0] _RAND_24;
  reg [31:0] _RAND_25;
  reg [31:0] _RAND_26;
  reg [31:0] _RAND_27;
  reg [31:0] _RAND_28;
  reg [31:0] _RAND_29;
  reg [31:0] _RAND_30;
  reg [31:0] _RAND_31;
`endif // RANDOMIZE_REG_INIT
  wire  fetcher_clock; // @[Food.scala 25:23]
  wire  fetcher_reset; // @[Food.scala 25:23]
  wire [31:0] fetcher_io_branchIn; // @[Food.scala 25:23]
  wire  fetcher_io_branchEnable; // @[Food.scala 25:23]
  wire  fetcher_io_shouldMux; // @[Food.scala 25:23]
  wire [31:0] fetcher_io_instrOut; // @[Food.scala 25:23]
  wire [31:0] fetcher_io_pcOut; // @[Food.scala 25:23]
  wire  decoder_clock; // @[Food.scala 26:23]
  wire  decoder_reset; // @[Food.scala 26:23]
  wire [31:0] decoder_io_instrIn; // @[Food.scala 26:23]
  wire [6:0] decoder_io_opcode; // @[Food.scala 26:23]
  wire [4:0] decoder_io_rdOutput; // @[Food.scala 26:23]
  wire [2:0] decoder_io_funct3; // @[Food.scala 26:23]
  wire [6:0] decoder_io_funct7; // @[Food.scala 26:23]
  wire [4:0] decoder_io_rs1; // @[Food.scala 26:23]
  wire [4:0] decoder_io_rs2; // @[Food.scala 26:23]
  wire [11:0] decoder_io_imm_I; // @[Food.scala 26:23]
  wire [11:0] decoder_io_imm_S; // @[Food.scala 26:23]
  wire [12:0] decoder_io_imm_B; // @[Food.scala 26:23]
  wire [31:0] decoder_io_imm_U; // @[Food.scala 26:23]
  wire [20:0] decoder_io_imm_J; // @[Food.scala 26:23]
  wire [31:0] decoder_io_pcIn; // @[Food.scala 26:23]
  wire [31:0] decoder_io_pcOut; // @[Food.scala 26:23]
  wire  decoder_io_shouldMux; // @[Food.scala 26:23]
  wire  executer_clock; // @[Food.scala 27:24]
  wire  executer_reset; // @[Food.scala 27:24]
  wire [6:0] executer_io_opcode; // @[Food.scala 27:24]
  wire [2:0] executer_io_funct3; // @[Food.scala 27:24]
  wire [6:0] executer_io_funct7; // @[Food.scala 27:24]
  wire [4:0] executer_io_rdIn; // @[Food.scala 27:24]
  wire [4:0] executer_io_rs1; // @[Food.scala 27:24]
  wire [4:0] executer_io_rs2; // @[Food.scala 27:24]
  wire [11:0] executer_io_imm_I; // @[Food.scala 27:24]
  wire [11:0] executer_io_imm_S; // @[Food.scala 27:24]
  wire [12:0] executer_io_imm_B; // @[Food.scala 27:24]
  wire [31:0] executer_io_imm_U; // @[Food.scala 27:24]
  wire [20:0] executer_io_imm_J; // @[Food.scala 27:24]
  wire [31:0] executer_io_imm; // @[Food.scala 27:24]
  wire [2:0] executer_io_funct3out; // @[Food.scala 27:24]
  wire [6:0] executer_io_funct7out; // @[Food.scala 27:24]
  wire [31:0] executer_io_x_0; // @[Food.scala 27:24]
  wire [31:0] executer_io_x_1; // @[Food.scala 27:24]
  wire [31:0] executer_io_x_2; // @[Food.scala 27:24]
  wire [31:0] executer_io_x_3; // @[Food.scala 27:24]
  wire [31:0] executer_io_x_4; // @[Food.scala 27:24]
  wire [31:0] executer_io_x_5; // @[Food.scala 27:24]
  wire [31:0] executer_io_x_6; // @[Food.scala 27:24]
  wire [31:0] executer_io_x_7; // @[Food.scala 27:24]
  wire [31:0] executer_io_x_8; // @[Food.scala 27:24]
  wire [31:0] executer_io_x_9; // @[Food.scala 27:24]
  wire [31:0] executer_io_x_10; // @[Food.scala 27:24]
  wire [31:0] executer_io_x_11; // @[Food.scala 27:24]
  wire [31:0] executer_io_x_12; // @[Food.scala 27:24]
  wire [31:0] executer_io_x_13; // @[Food.scala 27:24]
  wire [31:0] executer_io_x_14; // @[Food.scala 27:24]
  wire [31:0] executer_io_x_15; // @[Food.scala 27:24]
  wire [31:0] executer_io_x_16; // @[Food.scala 27:24]
  wire [31:0] executer_io_x_17; // @[Food.scala 27:24]
  wire [31:0] executer_io_x_18; // @[Food.scala 27:24]
  wire [31:0] executer_io_x_19; // @[Food.scala 27:24]
  wire [31:0] executer_io_x_20; // @[Food.scala 27:24]
  wire [31:0] executer_io_x_21; // @[Food.scala 27:24]
  wire [31:0] executer_io_x_22; // @[Food.scala 27:24]
  wire [31:0] executer_io_x_23; // @[Food.scala 27:24]
  wire [31:0] executer_io_x_24; // @[Food.scala 27:24]
  wire [31:0] executer_io_x_25; // @[Food.scala 27:24]
  wire [31:0] executer_io_x_26; // @[Food.scala 27:24]
  wire [31:0] executer_io_x_27; // @[Food.scala 27:24]
  wire [31:0] executer_io_x_28; // @[Food.scala 27:24]
  wire [31:0] executer_io_x_29; // @[Food.scala 27:24]
  wire [31:0] executer_io_x_30; // @[Food.scala 27:24]
  wire [31:0] executer_io_x_31; // @[Food.scala 27:24]
  wire [31:0] executer_io_ALUIn; // @[Food.scala 27:24]
  wire [3:0] executer_io_group; // @[Food.scala 27:24]
  wire [31:0] executer_io_operand1; // @[Food.scala 27:24]
  wire [31:0] executer_io_operand2; // @[Food.scala 27:24]
  wire [4:0] executer_io_rdLastRegMemIn; // @[Food.scala 27:24]
  wire [31:0] executer_io_aluLastRegMemIn; // @[Food.scala 27:24]
  wire [4:0] executer_io_rdLoadRegMemIn; // @[Food.scala 27:24]
  wire [31:0] executer_io_aluLoadRegMemIn; // @[Food.scala 27:24]
  wire  executer_io_loadEnable; // @[Food.scala 27:24]
  wire [31:0] executer_io_pcIn; // @[Food.scala 27:24]
  wire [31:0] executer_io_pcOut; // @[Food.scala 27:24]
  wire  ALU_clock; // @[Food.scala 28:19]
  wire  ALU_reset; // @[Food.scala 28:19]
  wire [2:0] ALU_io_funct3; // @[Food.scala 28:19]
  wire [6:0] ALU_io_funct7; // @[Food.scala 28:19]
  wire [31:0] ALU_io_imm; // @[Food.scala 28:19]
  wire [31:0] ALU_io_pcIn; // @[Food.scala 28:19]
  wire [3:0] ALU_io_group; // @[Food.scala 28:19]
  wire [31:0] ALU_io_operand2; // @[Food.scala 28:19]
  wire [31:0] ALU_io_operand1; // @[Food.scala 28:19]
  wire [31:0] ALU_io_branchOut; // @[Food.scala 28:19]
  wire  ALU_io_branchEnable; // @[Food.scala 28:19]
  wire [31:0] ALU_io_ALUout; // @[Food.scala 28:19]
  wire [9:0] ALU_io_rdAddr; // @[Food.scala 28:19]
  wire [9:0] ALU_io_wrAddr; // @[Food.scala 28:19]
  wire  ALU_io_wrEna; // @[Food.scala 28:19]
  wire  ALU_io_rdEna; // @[Food.scala 28:19]
  wire [2:0] ALU_io_memOp; // @[Food.scala 28:19]
  wire [4:0] ALU_io_rdOut; // @[Food.scala 28:19]
  wire [4:0] ALU_io_rdIn; // @[Food.scala 28:19]
  wire  memorizer_clock; // @[Food.scala 29:25]
  wire  memorizer_reset; // @[Food.scala 29:25]
  wire [31:0] memorizer_io_ALUinput; // @[Food.scala 29:25]
  wire [4:0] memorizer_io_rdInput; // @[Food.scala 29:25]
  wire [9:0] memorizer_io_rdAddr; // @[Food.scala 29:25]
  wire [9:0] memorizer_io_wrAddr; // @[Food.scala 29:25]
  wire [31:0] memorizer_io_wrData; // @[Food.scala 29:25]
  wire  memorizer_io_wrEna; // @[Food.scala 29:25]
  wire  memorizer_io_rdEna; // @[Food.scala 29:25]
  wire [2:0] memorizer_io_memOp; // @[Food.scala 29:25]
  wire [4:0] memorizer_io_rdLastRegMemOut; // @[Food.scala 29:25]
  wire [31:0] memorizer_io_aluLastRegMemOut; // @[Food.scala 29:25]
  wire [4:0] memorizer_io_rdLoadRegMemOut; // @[Food.scala 29:25]
  wire [31:0] memorizer_io_aluLoadRegMemOut; // @[Food.scala 29:25]
  wire  memorizer_io_loadEnabler; // @[Food.scala 29:25]
  wire [31:0] memorizer_io_rdData; // @[Food.scala 29:25]
  wire  memorizer_io_rdEnaOut; // @[Food.scala 29:25]
  wire  memorizer_io_wrEnaOut; // @[Food.scala 29:25]
  wire [4:0] memorizer_io_rdOutput; // @[Food.scala 29:25]
  wire [31:0] memorizer_io_ALUoutput; // @[Food.scala 29:25]
  wire  write_backer_clock; // @[Food.scala 30:28]
  wire  write_backer_reset; // @[Food.scala 30:28]
  wire [31:0] write_backer_io_ALUinput; // @[Food.scala 30:28]
  wire [31:0] write_backer_io_ALUoutput; // @[Food.scala 30:28]
  wire [4:0] write_backer_io_rdInput; // @[Food.scala 30:28]
  wire [4:0] write_backer_io_rdOut; // @[Food.scala 30:28]
  wire  write_backer_io_rdEnaIn; // @[Food.scala 30:28]
  wire  write_backer_io_wrEnaIn; // @[Food.scala 30:28]
  wire [31:0] write_backer_io_rdData; // @[Food.scala 30:28]
  wire  Disp_clock; // @[Food.scala 31:20]
  wire  Disp_reset; // @[Food.scala 31:20]
  wire [31:0] Disp_io_xReg; // @[Food.scala 31:20]
  wire [6:0] Disp_io_seg; // @[Food.scala 31:20]
  wire [7:0] Disp_io_an; // @[Food.scala 31:20]
  reg [31:0] x_0; // @[Food.scala 24:18]
  reg [31:0] x_1; // @[Food.scala 24:18]
  reg [31:0] x_2; // @[Food.scala 24:18]
  reg [31:0] x_3; // @[Food.scala 24:18]
  reg [31:0] x_4; // @[Food.scala 24:18]
  reg [31:0] x_5; // @[Food.scala 24:18]
  reg [31:0] x_6; // @[Food.scala 24:18]
  reg [31:0] x_7; // @[Food.scala 24:18]
  reg [31:0] x_8; // @[Food.scala 24:18]
  reg [31:0] x_9; // @[Food.scala 24:18]
  reg [31:0] x_10; // @[Food.scala 24:18]
  reg [31:0] x_11; // @[Food.scala 24:18]
  reg [31:0] x_12; // @[Food.scala 24:18]
  reg [31:0] x_13; // @[Food.scala 24:18]
  reg [31:0] x_14; // @[Food.scala 24:18]
  reg [31:0] x_15; // @[Food.scala 24:18]
  reg [31:0] x_16; // @[Food.scala 24:18]
  reg [31:0] x_17; // @[Food.scala 24:18]
  reg [31:0] x_18; // @[Food.scala 24:18]
  reg [31:0] x_19; // @[Food.scala 24:18]
  reg [31:0] x_20; // @[Food.scala 24:18]
  reg [31:0] x_21; // @[Food.scala 24:18]
  reg [31:0] x_22; // @[Food.scala 24:18]
  reg [31:0] x_23; // @[Food.scala 24:18]
  reg [31:0] x_24; // @[Food.scala 24:18]
  reg [31:0] x_25; // @[Food.scala 24:18]
  reg [31:0] x_26; // @[Food.scala 24:18]
  reg [31:0] x_27; // @[Food.scala 24:18]
  reg [31:0] x_28; // @[Food.scala 24:18]
  reg [31:0] x_29; // @[Food.scala 24:18]
  reg [31:0] x_30; // @[Food.scala 24:18]
  reg [31:0] x_31; // @[Food.scala 24:18]
  wire [31:0] _x_write_backer_io_rdOut = write_backer_io_ALUoutput; // @[Food.scala 102:{28,28}]
  wire [4:0] switches = {io_switchin,io_switchin2,io_switchin3,io_switchin4,io_switchin5}; // @[Cat.scala 33:92]
  wire [31:0] _GEN_33 = 5'h1 == switches ? $signed(x_1) : $signed(x_0); // @[Food.scala 107:{16,16}]
  wire [31:0] _GEN_34 = 5'h2 == switches ? $signed(x_2) : $signed(_GEN_33); // @[Food.scala 107:{16,16}]
  wire [31:0] _GEN_35 = 5'h3 == switches ? $signed(x_3) : $signed(_GEN_34); // @[Food.scala 107:{16,16}]
  wire [31:0] _GEN_36 = 5'h4 == switches ? $signed(x_4) : $signed(_GEN_35); // @[Food.scala 107:{16,16}]
  wire [31:0] _GEN_37 = 5'h5 == switches ? $signed(x_5) : $signed(_GEN_36); // @[Food.scala 107:{16,16}]
  wire [31:0] _GEN_38 = 5'h6 == switches ? $signed(x_6) : $signed(_GEN_37); // @[Food.scala 107:{16,16}]
  wire [31:0] _GEN_39 = 5'h7 == switches ? $signed(x_7) : $signed(_GEN_38); // @[Food.scala 107:{16,16}]
  wire [31:0] _GEN_40 = 5'h8 == switches ? $signed(x_8) : $signed(_GEN_39); // @[Food.scala 107:{16,16}]
  wire [31:0] _GEN_41 = 5'h9 == switches ? $signed(x_9) : $signed(_GEN_40); // @[Food.scala 107:{16,16}]
  wire [31:0] _GEN_42 = 5'ha == switches ? $signed(x_10) : $signed(_GEN_41); // @[Food.scala 107:{16,16}]
  wire [31:0] _GEN_43 = 5'hb == switches ? $signed(x_11) : $signed(_GEN_42); // @[Food.scala 107:{16,16}]
  wire [31:0] _GEN_44 = 5'hc == switches ? $signed(x_12) : $signed(_GEN_43); // @[Food.scala 107:{16,16}]
  wire [31:0] _GEN_45 = 5'hd == switches ? $signed(x_13) : $signed(_GEN_44); // @[Food.scala 107:{16,16}]
  wire [31:0] _GEN_46 = 5'he == switches ? $signed(x_14) : $signed(_GEN_45); // @[Food.scala 107:{16,16}]
  wire [31:0] _GEN_47 = 5'hf == switches ? $signed(x_15) : $signed(_GEN_46); // @[Food.scala 107:{16,16}]
  wire [31:0] _GEN_48 = 5'h10 == switches ? $signed(x_16) : $signed(_GEN_47); // @[Food.scala 107:{16,16}]
  wire [31:0] _GEN_49 = 5'h11 == switches ? $signed(x_17) : $signed(_GEN_48); // @[Food.scala 107:{16,16}]
  wire [31:0] _GEN_50 = 5'h12 == switches ? $signed(x_18) : $signed(_GEN_49); // @[Food.scala 107:{16,16}]
  wire [31:0] _GEN_51 = 5'h13 == switches ? $signed(x_19) : $signed(_GEN_50); // @[Food.scala 107:{16,16}]
  wire [31:0] _GEN_52 = 5'h14 == switches ? $signed(x_20) : $signed(_GEN_51); // @[Food.scala 107:{16,16}]
  wire [31:0] _GEN_53 = 5'h15 == switches ? $signed(x_21) : $signed(_GEN_52); // @[Food.scala 107:{16,16}]
  wire [31:0] _GEN_54 = 5'h16 == switches ? $signed(x_22) : $signed(_GEN_53); // @[Food.scala 107:{16,16}]
  wire [31:0] _GEN_55 = 5'h17 == switches ? $signed(x_23) : $signed(_GEN_54); // @[Food.scala 107:{16,16}]
  wire [31:0] _GEN_56 = 5'h18 == switches ? $signed(x_24) : $signed(_GEN_55); // @[Food.scala 107:{16,16}]
  wire [31:0] _GEN_57 = 5'h19 == switches ? $signed(x_25) : $signed(_GEN_56); // @[Food.scala 107:{16,16}]
  wire [31:0] _GEN_58 = 5'h1a == switches ? $signed(x_26) : $signed(_GEN_57); // @[Food.scala 107:{16,16}]
  wire [31:0] _GEN_59 = 5'h1b == switches ? $signed(x_27) : $signed(_GEN_58); // @[Food.scala 107:{16,16}]
  wire [31:0] _GEN_60 = 5'h1c == switches ? $signed(x_28) : $signed(_GEN_59); // @[Food.scala 107:{16,16}]
  wire [31:0] _GEN_61 = 5'h1d == switches ? $signed(x_29) : $signed(_GEN_60); // @[Food.scala 107:{16,16}]
  wire [31:0] _GEN_62 = 5'h1e == switches ? $signed(x_30) : $signed(_GEN_61); // @[Food.scala 107:{16,16}]
  Fetcher fetcher ( // @[Food.scala 25:23]
    .clock(fetcher_clock),
    .reset(fetcher_reset),
    .io_branchIn(fetcher_io_branchIn),
    .io_branchEnable(fetcher_io_branchEnable),
    .io_shouldMux(fetcher_io_shouldMux),
    .io_instrOut(fetcher_io_instrOut),
    .io_pcOut(fetcher_io_pcOut)
  );
  Decoder decoder ( // @[Food.scala 26:23]
    .clock(decoder_clock),
    .reset(decoder_reset),
    .io_instrIn(decoder_io_instrIn),
    .io_opcode(decoder_io_opcode),
    .io_rdOutput(decoder_io_rdOutput),
    .io_funct3(decoder_io_funct3),
    .io_funct7(decoder_io_funct7),
    .io_rs1(decoder_io_rs1),
    .io_rs2(decoder_io_rs2),
    .io_imm_I(decoder_io_imm_I),
    .io_imm_S(decoder_io_imm_S),
    .io_imm_B(decoder_io_imm_B),
    .io_imm_U(decoder_io_imm_U),
    .io_imm_J(decoder_io_imm_J),
    .io_pcIn(decoder_io_pcIn),
    .io_pcOut(decoder_io_pcOut),
    .io_shouldMux(decoder_io_shouldMux)
  );
  Executer executer ( // @[Food.scala 27:24]
    .clock(executer_clock),
    .reset(executer_reset),
    .io_opcode(executer_io_opcode),
    .io_funct3(executer_io_funct3),
    .io_funct7(executer_io_funct7),
    .io_rdIn(executer_io_rdIn),
    .io_rs1(executer_io_rs1),
    .io_rs2(executer_io_rs2),
    .io_imm_I(executer_io_imm_I),
    .io_imm_S(executer_io_imm_S),
    .io_imm_B(executer_io_imm_B),
    .io_imm_U(executer_io_imm_U),
    .io_imm_J(executer_io_imm_J),
    .io_imm(executer_io_imm),
    .io_funct3out(executer_io_funct3out),
    .io_funct7out(executer_io_funct7out),
    .io_x_0(executer_io_x_0),
    .io_x_1(executer_io_x_1),
    .io_x_2(executer_io_x_2),
    .io_x_3(executer_io_x_3),
    .io_x_4(executer_io_x_4),
    .io_x_5(executer_io_x_5),
    .io_x_6(executer_io_x_6),
    .io_x_7(executer_io_x_7),
    .io_x_8(executer_io_x_8),
    .io_x_9(executer_io_x_9),
    .io_x_10(executer_io_x_10),
    .io_x_11(executer_io_x_11),
    .io_x_12(executer_io_x_12),
    .io_x_13(executer_io_x_13),
    .io_x_14(executer_io_x_14),
    .io_x_15(executer_io_x_15),
    .io_x_16(executer_io_x_16),
    .io_x_17(executer_io_x_17),
    .io_x_18(executer_io_x_18),
    .io_x_19(executer_io_x_19),
    .io_x_20(executer_io_x_20),
    .io_x_21(executer_io_x_21),
    .io_x_22(executer_io_x_22),
    .io_x_23(executer_io_x_23),
    .io_x_24(executer_io_x_24),
    .io_x_25(executer_io_x_25),
    .io_x_26(executer_io_x_26),
    .io_x_27(executer_io_x_27),
    .io_x_28(executer_io_x_28),
    .io_x_29(executer_io_x_29),
    .io_x_30(executer_io_x_30),
    .io_x_31(executer_io_x_31),
    .io_ALUIn(executer_io_ALUIn),
    .io_group(executer_io_group),
    .io_operand1(executer_io_operand1),
    .io_operand2(executer_io_operand2),
    .io_rdLastRegMemIn(executer_io_rdLastRegMemIn),
    .io_aluLastRegMemIn(executer_io_aluLastRegMemIn),
    .io_rdLoadRegMemIn(executer_io_rdLoadRegMemIn),
    .io_aluLoadRegMemIn(executer_io_aluLoadRegMemIn),
    .io_loadEnable(executer_io_loadEnable),
    .io_pcIn(executer_io_pcIn),
    .io_pcOut(executer_io_pcOut)
  );
  ALU ALU ( // @[Food.scala 28:19]
    .clock(ALU_clock),
    .reset(ALU_reset),
    .io_funct3(ALU_io_funct3),
    .io_funct7(ALU_io_funct7),
    .io_imm(ALU_io_imm),
    .io_pcIn(ALU_io_pcIn),
    .io_group(ALU_io_group),
    .io_operand2(ALU_io_operand2),
    .io_operand1(ALU_io_operand1),
    .io_branchOut(ALU_io_branchOut),
    .io_branchEnable(ALU_io_branchEnable),
    .io_ALUout(ALU_io_ALUout),
    .io_rdAddr(ALU_io_rdAddr),
    .io_wrAddr(ALU_io_wrAddr),
    .io_wrEna(ALU_io_wrEna),
    .io_rdEna(ALU_io_rdEna),
    .io_memOp(ALU_io_memOp),
    .io_rdOut(ALU_io_rdOut),
    .io_rdIn(ALU_io_rdIn)
  );
  Memorizer memorizer ( // @[Food.scala 29:25]
    .clock(memorizer_clock),
    .reset(memorizer_reset),
    .io_ALUinput(memorizer_io_ALUinput),
    .io_rdInput(memorizer_io_rdInput),
    .io_rdAddr(memorizer_io_rdAddr),
    .io_wrAddr(memorizer_io_wrAddr),
    .io_wrData(memorizer_io_wrData),
    .io_wrEna(memorizer_io_wrEna),
    .io_rdEna(memorizer_io_rdEna),
    .io_memOp(memorizer_io_memOp),
    .io_rdLastRegMemOut(memorizer_io_rdLastRegMemOut),
    .io_aluLastRegMemOut(memorizer_io_aluLastRegMemOut),
    .io_rdLoadRegMemOut(memorizer_io_rdLoadRegMemOut),
    .io_aluLoadRegMemOut(memorizer_io_aluLoadRegMemOut),
    .io_loadEnabler(memorizer_io_loadEnabler),
    .io_rdData(memorizer_io_rdData),
    .io_rdEnaOut(memorizer_io_rdEnaOut),
    .io_wrEnaOut(memorizer_io_wrEnaOut),
    .io_rdOutput(memorizer_io_rdOutput),
    .io_ALUoutput(memorizer_io_ALUoutput)
  );
  Write_backer write_backer ( // @[Food.scala 30:28]
    .clock(write_backer_clock),
    .reset(write_backer_reset),
    .io_ALUinput(write_backer_io_ALUinput),
    .io_ALUoutput(write_backer_io_ALUoutput),
    .io_rdInput(write_backer_io_rdInput),
    .io_rdOut(write_backer_io_rdOut),
    .io_rdEnaIn(write_backer_io_rdEnaIn),
    .io_wrEnaIn(write_backer_io_wrEnaIn),
    .io_rdData(write_backer_io_rdData)
  );
  DisplayMux Disp ( // @[Food.scala 31:20]
    .clock(Disp_clock),
    .reset(Disp_reset),
    .io_xReg(Disp_io_xReg),
    .io_seg(Disp_io_seg),
    .io_an(Disp_io_an)
  );
  assign io_seg = Disp_io_seg; // @[Food.scala 108:10]
  assign io_an = Disp_io_an; // @[Food.scala 109:9]
  assign fetcher_clock = clock;
  assign fetcher_reset = reset;
  assign fetcher_io_branchIn = ALU_io_branchOut; // @[Food.scala 42:23]
  assign fetcher_io_branchEnable = ALU_io_branchEnable; // @[Food.scala 43:27]
  assign fetcher_io_shouldMux = decoder_io_shouldMux; // @[Food.scala 50:24]
  assign decoder_clock = clock;
  assign decoder_reset = reset;
  assign decoder_io_instrIn = fetcher_io_instrOut; // @[Food.scala 35:22]
  assign decoder_io_pcIn = fetcher_io_pcOut; // @[Food.scala 37:19]
  assign executer_clock = clock;
  assign executer_reset = reset;
  assign executer_io_opcode = decoder_io_opcode; // @[Food.scala 54:22]
  assign executer_io_funct3 = decoder_io_funct3; // @[Food.scala 63:22]
  assign executer_io_funct7 = decoder_io_funct7; // @[Food.scala 64:22]
  assign executer_io_rdIn = ALU_io_rdOut; // @[Food.scala 40:20]
  assign executer_io_rs1 = decoder_io_rs1; // @[Food.scala 56:19]
  assign executer_io_rs2 = decoder_io_rs2; // @[Food.scala 57:19]
  assign executer_io_imm_I = decoder_io_imm_I; // @[Food.scala 58:21]
  assign executer_io_imm_S = decoder_io_imm_S; // @[Food.scala 61:21]
  assign executer_io_imm_B = decoder_io_imm_B; // @[Food.scala 59:21]
  assign executer_io_imm_U = decoder_io_imm_U; // @[Food.scala 62:21]
  assign executer_io_imm_J = decoder_io_imm_J; // @[Food.scala 60:21]
  assign executer_io_x_0 = x_0; // @[Food.scala 53:17]
  assign executer_io_x_1 = x_1; // @[Food.scala 53:17]
  assign executer_io_x_2 = x_2; // @[Food.scala 53:17]
  assign executer_io_x_3 = x_3; // @[Food.scala 53:17]
  assign executer_io_x_4 = x_4; // @[Food.scala 53:17]
  assign executer_io_x_5 = x_5; // @[Food.scala 53:17]
  assign executer_io_x_6 = x_6; // @[Food.scala 53:17]
  assign executer_io_x_7 = x_7; // @[Food.scala 53:17]
  assign executer_io_x_8 = x_8; // @[Food.scala 53:17]
  assign executer_io_x_9 = x_9; // @[Food.scala 53:17]
  assign executer_io_x_10 = x_10; // @[Food.scala 53:17]
  assign executer_io_x_11 = x_11; // @[Food.scala 53:17]
  assign executer_io_x_12 = x_12; // @[Food.scala 53:17]
  assign executer_io_x_13 = x_13; // @[Food.scala 53:17]
  assign executer_io_x_14 = x_14; // @[Food.scala 53:17]
  assign executer_io_x_15 = x_15; // @[Food.scala 53:17]
  assign executer_io_x_16 = x_16; // @[Food.scala 53:17]
  assign executer_io_x_17 = x_17; // @[Food.scala 53:17]
  assign executer_io_x_18 = x_18; // @[Food.scala 53:17]
  assign executer_io_x_19 = x_19; // @[Food.scala 53:17]
  assign executer_io_x_20 = x_20; // @[Food.scala 53:17]
  assign executer_io_x_21 = x_21; // @[Food.scala 53:17]
  assign executer_io_x_22 = x_22; // @[Food.scala 53:17]
  assign executer_io_x_23 = x_23; // @[Food.scala 53:17]
  assign executer_io_x_24 = x_24; // @[Food.scala 53:17]
  assign executer_io_x_25 = x_25; // @[Food.scala 53:17]
  assign executer_io_x_26 = x_26; // @[Food.scala 53:17]
  assign executer_io_x_27 = x_27; // @[Food.scala 53:17]
  assign executer_io_x_28 = x_28; // @[Food.scala 53:17]
  assign executer_io_x_29 = x_29; // @[Food.scala 53:17]
  assign executer_io_x_30 = x_30; // @[Food.scala 53:17]
  assign executer_io_x_31 = x_31; // @[Food.scala 53:17]
  assign executer_io_ALUIn = ALU_io_ALUout; // @[Food.scala 84:21]
  assign executer_io_rdLastRegMemIn = memorizer_io_rdLastRegMemOut; // @[Food.scala 67:30]
  assign executer_io_aluLastRegMemIn = memorizer_io_aluLastRegMemOut; // @[Food.scala 69:31]
  assign executer_io_rdLoadRegMemIn = memorizer_io_rdLoadRegMemOut; // @[Food.scala 71:30]
  assign executer_io_aluLoadRegMemIn = memorizer_io_aluLoadRegMemOut; // @[Food.scala 72:31]
  assign executer_io_loadEnable = memorizer_io_loadEnabler; // @[Food.scala 73:26]
  assign executer_io_pcIn = decoder_io_pcOut; // @[Food.scala 38:20]
  assign ALU_clock = clock;
  assign ALU_reset = reset;
  assign ALU_io_funct3 = executer_io_funct3out; // @[Food.scala 75:17]
  assign ALU_io_funct7 = executer_io_funct7out; // @[Food.scala 76:17]
  assign ALU_io_imm = executer_io_imm; // @[Food.scala 81:14]
  assign ALU_io_pcIn = executer_io_pcOut; // @[Food.scala 77:15]
  assign ALU_io_group = executer_io_group; // @[Food.scala 78:16]
  assign ALU_io_operand2 = executer_io_operand2; // @[Food.scala 80:19]
  assign ALU_io_operand1 = executer_io_operand1; // @[Food.scala 79:19]
  assign ALU_io_rdIn = decoder_io_rdOutput; // @[Food.scala 55:15]
  assign memorizer_clock = clock;
  assign memorizer_reset = reset;
  assign memorizer_io_ALUinput = ALU_io_ALUout; // @[Food.scala 87:25]
  assign memorizer_io_rdInput = ALU_io_rdOut; // @[Food.scala 86:24]
  assign memorizer_io_rdAddr = ALU_io_rdAddr; // @[Food.scala 90:23]
  assign memorizer_io_wrAddr = ALU_io_wrAddr; // @[Food.scala 91:23]
  assign memorizer_io_wrData = ALU_io_ALUout; // @[Food.scala 92:40]
  assign memorizer_io_wrEna = ALU_io_wrEna; // @[Food.scala 89:22]
  assign memorizer_io_rdEna = ALU_io_rdEna; // @[Food.scala 88:22]
  assign memorizer_io_memOp = ALU_io_memOp; // @[Food.scala 85:22]
  assign write_backer_clock = clock;
  assign write_backer_reset = reset;
  assign write_backer_io_ALUinput = memorizer_io_ALUoutput; // @[Food.scala 98:28]
  assign write_backer_io_rdInput = memorizer_io_rdOutput; // @[Food.scala 97:27]
  assign write_backer_io_rdEnaIn = memorizer_io_rdEnaOut; // @[Food.scala 96:27]
  assign write_backer_io_wrEnaIn = memorizer_io_wrEnaOut; // @[Food.scala 99:27]
  assign write_backer_io_rdData = memorizer_io_rdData; // @[Food.scala 95:26]
  assign Disp_clock = clock;
  assign Disp_reset = reset;
  assign Disp_io_xReg = 5'h1f == switches ? $signed(x_31) : $signed(_GEN_62); // @[Food.scala 107:{16,16}]
  always @(posedge clock) begin
    if (reset) begin // @[Food.scala 24:18]
      x_0 <= 32'sh0; // @[Food.scala 24:18]
    end else if (5'h0 == write_backer_io_rdOut) begin // @[Food.scala 112:28]
      x_0 <= _x_write_backer_io_rdOut; // @[Food.scala 112:28]
    end else if (5'h0 == write_backer_io_rdOut) begin // @[Food.scala 102:28]
      x_0 <= _x_write_backer_io_rdOut; // @[Food.scala 102:28]
    end
    if (reset) begin // @[Food.scala 24:18]
      x_1 <= 32'sh0; // @[Food.scala 24:18]
    end else if (5'h1 == write_backer_io_rdOut) begin // @[Food.scala 112:28]
      x_1 <= _x_write_backer_io_rdOut; // @[Food.scala 112:28]
    end else if (5'h1 == write_backer_io_rdOut) begin // @[Food.scala 102:28]
      x_1 <= _x_write_backer_io_rdOut; // @[Food.scala 102:28]
    end
    if (reset) begin // @[Food.scala 24:18]
      x_2 <= 32'sh0; // @[Food.scala 24:18]
    end else if (5'h2 == write_backer_io_rdOut) begin // @[Food.scala 112:28]
      x_2 <= _x_write_backer_io_rdOut; // @[Food.scala 112:28]
    end else if (5'h2 == write_backer_io_rdOut) begin // @[Food.scala 102:28]
      x_2 <= _x_write_backer_io_rdOut; // @[Food.scala 102:28]
    end
    if (reset) begin // @[Food.scala 24:18]
      x_3 <= 32'sh0; // @[Food.scala 24:18]
    end else if (5'h3 == write_backer_io_rdOut) begin // @[Food.scala 112:28]
      x_3 <= _x_write_backer_io_rdOut; // @[Food.scala 112:28]
    end else if (5'h3 == write_backer_io_rdOut) begin // @[Food.scala 102:28]
      x_3 <= _x_write_backer_io_rdOut; // @[Food.scala 102:28]
    end
    if (reset) begin // @[Food.scala 24:18]
      x_4 <= 32'sh0; // @[Food.scala 24:18]
    end else if (5'h4 == write_backer_io_rdOut) begin // @[Food.scala 112:28]
      x_4 <= _x_write_backer_io_rdOut; // @[Food.scala 112:28]
    end else if (5'h4 == write_backer_io_rdOut) begin // @[Food.scala 102:28]
      x_4 <= _x_write_backer_io_rdOut; // @[Food.scala 102:28]
    end
    if (reset) begin // @[Food.scala 24:18]
      x_5 <= 32'sh0; // @[Food.scala 24:18]
    end else if (5'h5 == write_backer_io_rdOut) begin // @[Food.scala 112:28]
      x_5 <= _x_write_backer_io_rdOut; // @[Food.scala 112:28]
    end else if (5'h5 == write_backer_io_rdOut) begin // @[Food.scala 102:28]
      x_5 <= _x_write_backer_io_rdOut; // @[Food.scala 102:28]
    end
    if (reset) begin // @[Food.scala 24:18]
      x_6 <= 32'sh0; // @[Food.scala 24:18]
    end else if (5'h6 == write_backer_io_rdOut) begin // @[Food.scala 112:28]
      x_6 <= _x_write_backer_io_rdOut; // @[Food.scala 112:28]
    end else if (5'h6 == write_backer_io_rdOut) begin // @[Food.scala 102:28]
      x_6 <= _x_write_backer_io_rdOut; // @[Food.scala 102:28]
    end
    if (reset) begin // @[Food.scala 24:18]
      x_7 <= 32'sh0; // @[Food.scala 24:18]
    end else if (5'h7 == write_backer_io_rdOut) begin // @[Food.scala 112:28]
      x_7 <= _x_write_backer_io_rdOut; // @[Food.scala 112:28]
    end else if (5'h7 == write_backer_io_rdOut) begin // @[Food.scala 102:28]
      x_7 <= _x_write_backer_io_rdOut; // @[Food.scala 102:28]
    end
    if (reset) begin // @[Food.scala 24:18]
      x_8 <= 32'sh0; // @[Food.scala 24:18]
    end else if (5'h8 == write_backer_io_rdOut) begin // @[Food.scala 112:28]
      x_8 <= _x_write_backer_io_rdOut; // @[Food.scala 112:28]
    end else if (5'h8 == write_backer_io_rdOut) begin // @[Food.scala 102:28]
      x_8 <= _x_write_backer_io_rdOut; // @[Food.scala 102:28]
    end
    if (reset) begin // @[Food.scala 24:18]
      x_9 <= 32'sh0; // @[Food.scala 24:18]
    end else if (5'h9 == write_backer_io_rdOut) begin // @[Food.scala 112:28]
      x_9 <= _x_write_backer_io_rdOut; // @[Food.scala 112:28]
    end else if (5'h9 == write_backer_io_rdOut) begin // @[Food.scala 102:28]
      x_9 <= _x_write_backer_io_rdOut; // @[Food.scala 102:28]
    end
    if (reset) begin // @[Food.scala 24:18]
      x_10 <= 32'sh0; // @[Food.scala 24:18]
    end else if (5'ha == write_backer_io_rdOut) begin // @[Food.scala 112:28]
      x_10 <= _x_write_backer_io_rdOut; // @[Food.scala 112:28]
    end else if (5'ha == write_backer_io_rdOut) begin // @[Food.scala 102:28]
      x_10 <= _x_write_backer_io_rdOut; // @[Food.scala 102:28]
    end
    if (reset) begin // @[Food.scala 24:18]
      x_11 <= 32'sh0; // @[Food.scala 24:18]
    end else if (5'hb == write_backer_io_rdOut) begin // @[Food.scala 112:28]
      x_11 <= _x_write_backer_io_rdOut; // @[Food.scala 112:28]
    end else if (5'hb == write_backer_io_rdOut) begin // @[Food.scala 102:28]
      x_11 <= _x_write_backer_io_rdOut; // @[Food.scala 102:28]
    end
    if (reset) begin // @[Food.scala 24:18]
      x_12 <= 32'sh0; // @[Food.scala 24:18]
    end else if (5'hc == write_backer_io_rdOut) begin // @[Food.scala 112:28]
      x_12 <= _x_write_backer_io_rdOut; // @[Food.scala 112:28]
    end else if (5'hc == write_backer_io_rdOut) begin // @[Food.scala 102:28]
      x_12 <= _x_write_backer_io_rdOut; // @[Food.scala 102:28]
    end
    if (reset) begin // @[Food.scala 24:18]
      x_13 <= 32'sh0; // @[Food.scala 24:18]
    end else if (5'hd == write_backer_io_rdOut) begin // @[Food.scala 112:28]
      x_13 <= _x_write_backer_io_rdOut; // @[Food.scala 112:28]
    end else if (5'hd == write_backer_io_rdOut) begin // @[Food.scala 102:28]
      x_13 <= _x_write_backer_io_rdOut; // @[Food.scala 102:28]
    end
    if (reset) begin // @[Food.scala 24:18]
      x_14 <= 32'sh0; // @[Food.scala 24:18]
    end else if (5'he == write_backer_io_rdOut) begin // @[Food.scala 112:28]
      x_14 <= _x_write_backer_io_rdOut; // @[Food.scala 112:28]
    end else if (5'he == write_backer_io_rdOut) begin // @[Food.scala 102:28]
      x_14 <= _x_write_backer_io_rdOut; // @[Food.scala 102:28]
    end
    if (reset) begin // @[Food.scala 24:18]
      x_15 <= 32'sh0; // @[Food.scala 24:18]
    end else if (5'hf == write_backer_io_rdOut) begin // @[Food.scala 112:28]
      x_15 <= _x_write_backer_io_rdOut; // @[Food.scala 112:28]
    end else if (5'hf == write_backer_io_rdOut) begin // @[Food.scala 102:28]
      x_15 <= _x_write_backer_io_rdOut; // @[Food.scala 102:28]
    end
    if (reset) begin // @[Food.scala 24:18]
      x_16 <= 32'sh0; // @[Food.scala 24:18]
    end else if (5'h10 == write_backer_io_rdOut) begin // @[Food.scala 112:28]
      x_16 <= _x_write_backer_io_rdOut; // @[Food.scala 112:28]
    end else if (5'h10 == write_backer_io_rdOut) begin // @[Food.scala 102:28]
      x_16 <= _x_write_backer_io_rdOut; // @[Food.scala 102:28]
    end
    if (reset) begin // @[Food.scala 24:18]
      x_17 <= 32'sh0; // @[Food.scala 24:18]
    end else if (5'h11 == write_backer_io_rdOut) begin // @[Food.scala 112:28]
      x_17 <= _x_write_backer_io_rdOut; // @[Food.scala 112:28]
    end else if (5'h11 == write_backer_io_rdOut) begin // @[Food.scala 102:28]
      x_17 <= _x_write_backer_io_rdOut; // @[Food.scala 102:28]
    end
    if (reset) begin // @[Food.scala 24:18]
      x_18 <= 32'sh0; // @[Food.scala 24:18]
    end else if (5'h12 == write_backer_io_rdOut) begin // @[Food.scala 112:28]
      x_18 <= _x_write_backer_io_rdOut; // @[Food.scala 112:28]
    end else if (5'h12 == write_backer_io_rdOut) begin // @[Food.scala 102:28]
      x_18 <= _x_write_backer_io_rdOut; // @[Food.scala 102:28]
    end
    if (reset) begin // @[Food.scala 24:18]
      x_19 <= 32'sh0; // @[Food.scala 24:18]
    end else if (5'h13 == write_backer_io_rdOut) begin // @[Food.scala 112:28]
      x_19 <= _x_write_backer_io_rdOut; // @[Food.scala 112:28]
    end else if (5'h13 == write_backer_io_rdOut) begin // @[Food.scala 102:28]
      x_19 <= _x_write_backer_io_rdOut; // @[Food.scala 102:28]
    end
    if (reset) begin // @[Food.scala 24:18]
      x_20 <= 32'sh0; // @[Food.scala 24:18]
    end else if (5'h14 == write_backer_io_rdOut) begin // @[Food.scala 112:28]
      x_20 <= _x_write_backer_io_rdOut; // @[Food.scala 112:28]
    end else if (5'h14 == write_backer_io_rdOut) begin // @[Food.scala 102:28]
      x_20 <= _x_write_backer_io_rdOut; // @[Food.scala 102:28]
    end
    if (reset) begin // @[Food.scala 24:18]
      x_21 <= 32'sh0; // @[Food.scala 24:18]
    end else if (5'h15 == write_backer_io_rdOut) begin // @[Food.scala 112:28]
      x_21 <= _x_write_backer_io_rdOut; // @[Food.scala 112:28]
    end else if (5'h15 == write_backer_io_rdOut) begin // @[Food.scala 102:28]
      x_21 <= _x_write_backer_io_rdOut; // @[Food.scala 102:28]
    end
    if (reset) begin // @[Food.scala 24:18]
      x_22 <= 32'sh0; // @[Food.scala 24:18]
    end else if (5'h16 == write_backer_io_rdOut) begin // @[Food.scala 112:28]
      x_22 <= _x_write_backer_io_rdOut; // @[Food.scala 112:28]
    end else if (5'h16 == write_backer_io_rdOut) begin // @[Food.scala 102:28]
      x_22 <= _x_write_backer_io_rdOut; // @[Food.scala 102:28]
    end
    if (reset) begin // @[Food.scala 24:18]
      x_23 <= 32'sh0; // @[Food.scala 24:18]
    end else if (5'h17 == write_backer_io_rdOut) begin // @[Food.scala 112:28]
      x_23 <= _x_write_backer_io_rdOut; // @[Food.scala 112:28]
    end else if (5'h17 == write_backer_io_rdOut) begin // @[Food.scala 102:28]
      x_23 <= _x_write_backer_io_rdOut; // @[Food.scala 102:28]
    end
    if (reset) begin // @[Food.scala 24:18]
      x_24 <= 32'sh0; // @[Food.scala 24:18]
    end else if (5'h18 == write_backer_io_rdOut) begin // @[Food.scala 112:28]
      x_24 <= _x_write_backer_io_rdOut; // @[Food.scala 112:28]
    end else if (5'h18 == write_backer_io_rdOut) begin // @[Food.scala 102:28]
      x_24 <= _x_write_backer_io_rdOut; // @[Food.scala 102:28]
    end
    if (reset) begin // @[Food.scala 24:18]
      x_25 <= 32'sh0; // @[Food.scala 24:18]
    end else if (5'h19 == write_backer_io_rdOut) begin // @[Food.scala 112:28]
      x_25 <= _x_write_backer_io_rdOut; // @[Food.scala 112:28]
    end else if (5'h19 == write_backer_io_rdOut) begin // @[Food.scala 102:28]
      x_25 <= _x_write_backer_io_rdOut; // @[Food.scala 102:28]
    end
    if (reset) begin // @[Food.scala 24:18]
      x_26 <= 32'sh0; // @[Food.scala 24:18]
    end else if (5'h1a == write_backer_io_rdOut) begin // @[Food.scala 112:28]
      x_26 <= _x_write_backer_io_rdOut; // @[Food.scala 112:28]
    end else if (5'h1a == write_backer_io_rdOut) begin // @[Food.scala 102:28]
      x_26 <= _x_write_backer_io_rdOut; // @[Food.scala 102:28]
    end
    if (reset) begin // @[Food.scala 24:18]
      x_27 <= 32'sh0; // @[Food.scala 24:18]
    end else if (5'h1b == write_backer_io_rdOut) begin // @[Food.scala 112:28]
      x_27 <= _x_write_backer_io_rdOut; // @[Food.scala 112:28]
    end else if (5'h1b == write_backer_io_rdOut) begin // @[Food.scala 102:28]
      x_27 <= _x_write_backer_io_rdOut; // @[Food.scala 102:28]
    end
    if (reset) begin // @[Food.scala 24:18]
      x_28 <= 32'sh0; // @[Food.scala 24:18]
    end else if (5'h1c == write_backer_io_rdOut) begin // @[Food.scala 112:28]
      x_28 <= _x_write_backer_io_rdOut; // @[Food.scala 112:28]
    end else if (5'h1c == write_backer_io_rdOut) begin // @[Food.scala 102:28]
      x_28 <= _x_write_backer_io_rdOut; // @[Food.scala 102:28]
    end
    if (reset) begin // @[Food.scala 24:18]
      x_29 <= 32'sh0; // @[Food.scala 24:18]
    end else if (5'h1d == write_backer_io_rdOut) begin // @[Food.scala 112:28]
      x_29 <= _x_write_backer_io_rdOut; // @[Food.scala 112:28]
    end else if (5'h1d == write_backer_io_rdOut) begin // @[Food.scala 102:28]
      x_29 <= _x_write_backer_io_rdOut; // @[Food.scala 102:28]
    end
    if (reset) begin // @[Food.scala 24:18]
      x_30 <= 32'sh0; // @[Food.scala 24:18]
    end else if (5'h1e == write_backer_io_rdOut) begin // @[Food.scala 112:28]
      x_30 <= _x_write_backer_io_rdOut; // @[Food.scala 112:28]
    end else if (5'h1e == write_backer_io_rdOut) begin // @[Food.scala 102:28]
      x_30 <= _x_write_backer_io_rdOut; // @[Food.scala 102:28]
    end
    if (reset) begin // @[Food.scala 24:18]
      x_31 <= 32'sh0; // @[Food.scala 24:18]
    end else if (5'h1f == write_backer_io_rdOut) begin // @[Food.scala 112:28]
      x_31 <= _x_write_backer_io_rdOut; // @[Food.scala 112:28]
    end else if (5'h1f == write_backer_io_rdOut) begin // @[Food.scala 102:28]
      x_31 <= _x_write_backer_io_rdOut; // @[Food.scala 102:28]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  x_0 = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  x_1 = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  x_2 = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  x_3 = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  x_4 = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  x_5 = _RAND_5[31:0];
  _RAND_6 = {1{`RANDOM}};
  x_6 = _RAND_6[31:0];
  _RAND_7 = {1{`RANDOM}};
  x_7 = _RAND_7[31:0];
  _RAND_8 = {1{`RANDOM}};
  x_8 = _RAND_8[31:0];
  _RAND_9 = {1{`RANDOM}};
  x_9 = _RAND_9[31:0];
  _RAND_10 = {1{`RANDOM}};
  x_10 = _RAND_10[31:0];
  _RAND_11 = {1{`RANDOM}};
  x_11 = _RAND_11[31:0];
  _RAND_12 = {1{`RANDOM}};
  x_12 = _RAND_12[31:0];
  _RAND_13 = {1{`RANDOM}};
  x_13 = _RAND_13[31:0];
  _RAND_14 = {1{`RANDOM}};
  x_14 = _RAND_14[31:0];
  _RAND_15 = {1{`RANDOM}};
  x_15 = _RAND_15[31:0];
  _RAND_16 = {1{`RANDOM}};
  x_16 = _RAND_16[31:0];
  _RAND_17 = {1{`RANDOM}};
  x_17 = _RAND_17[31:0];
  _RAND_18 = {1{`RANDOM}};
  x_18 = _RAND_18[31:0];
  _RAND_19 = {1{`RANDOM}};
  x_19 = _RAND_19[31:0];
  _RAND_20 = {1{`RANDOM}};
  x_20 = _RAND_20[31:0];
  _RAND_21 = {1{`RANDOM}};
  x_21 = _RAND_21[31:0];
  _RAND_22 = {1{`RANDOM}};
  x_22 = _RAND_22[31:0];
  _RAND_23 = {1{`RANDOM}};
  x_23 = _RAND_23[31:0];
  _RAND_24 = {1{`RANDOM}};
  x_24 = _RAND_24[31:0];
  _RAND_25 = {1{`RANDOM}};
  x_25 = _RAND_25[31:0];
  _RAND_26 = {1{`RANDOM}};
  x_26 = _RAND_26[31:0];
  _RAND_27 = {1{`RANDOM}};
  x_27 = _RAND_27[31:0];
  _RAND_28 = {1{`RANDOM}};
  x_28 = _RAND_28[31:0];
  _RAND_29 = {1{`RANDOM}};
  x_29 = _RAND_29[31:0];
  _RAND_30 = {1{`RANDOM}};
  x_30 = _RAND_30[31:0];
  _RAND_31 = {1{`RANDOM}};
  x_31 = _RAND_31[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
