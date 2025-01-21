module Fetcher(
  input         clock,
  input         reset,
  output [31:0] io_instruction,
  input  [31:0] io_branchIn,
  input         io_shouldMux,
  output [31:0] io_pcOut,
  input         io_branchEnable
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] pcReg; // @[Fetcher.scala 20:22]
  reg [31:0] instruction; // @[Fetcher.scala 21:28]
  wire [31:0] _pcPlusReg_T_2 = $signed(pcReg) + 32'sh4; // @[Fetcher.scala 32:85]
  wire [31:0] _pcPlusReg_T_3 = io_branchEnable ? $signed(io_branchIn) : $signed(_pcPlusReg_T_2); // @[Fetcher.scala 32:46]
  wire [31:0] pcPlusReg = io_shouldMux ? $signed(pcReg) : $signed(_pcPlusReg_T_3); // @[Fetcher.scala 32:22]
  wire [29:0] _instruction_T = pcPlusReg[31:2]; // @[Fetcher.scala 40:32]
  wire [31:0] _GEN_1 = 4'h1 == _instruction_T[3:0] ? 32'ha00193 : 32'h200113; // @[Fetcher.scala 40:{15,15}]
  wire [31:0] _GEN_2 = 4'h2 == _instruction_T[3:0] ? 32'h310663 : _GEN_1; // @[Fetcher.scala 40:{15,15}]
  wire [31:0] _GEN_3 = 4'h3 == _instruction_T[3:0] ? 32'h200293 : _GEN_2; // @[Fetcher.scala 40:{15,15}]
  wire [31:0] _GEN_4 = 4'h4 == _instruction_T[3:0] ? 32'h210263 : _GEN_3; // @[Fetcher.scala 40:{15,15}]
  wire [31:0] _GEN_5 = 4'h5 == _instruction_T[3:0] ? 32'hc00113 : _GEN_4; // @[Fetcher.scala 40:{15,15}]
  wire [31:0] _GEN_6 = 4'h6 == _instruction_T[3:0] ? 32'h211a63 : _GEN_5; // @[Fetcher.scala 40:{15,15}]
  wire [31:0] _GEN_7 = 4'h7 == _instruction_T[3:0] ? 32'h300293 : _GEN_6; // @[Fetcher.scala 40:{15,15}]
  wire [31:0] _GEN_8 = 4'h8 == _instruction_T[3:0] ? 32'h311663 : _GEN_7; // @[Fetcher.scala 40:{15,15}]
  wire [31:0] _GEN_9 = 4'h9 == _instruction_T[3:0] ? 32'ha00213 : _GEN_8; // @[Fetcher.scala 40:{15,15}]
  assign io_instruction = instruction; // @[Fetcher.scala 42:18]
  assign io_pcOut = pcReg; // @[Fetcher.scala 44:12]
  always @(posedge clock) begin
    if (reset) begin // @[Fetcher.scala 20:22]
      pcReg <= -32'sh4; // @[Fetcher.scala 20:22]
    end else if (!(io_shouldMux)) begin // @[Fetcher.scala 32:22]
      if (io_branchEnable) begin // @[Fetcher.scala 32:46]
        pcReg <= io_branchIn;
      end else begin
        pcReg <= _pcPlusReg_T_2;
      end
    end
    if (reset) begin // @[Fetcher.scala 21:28]
      instruction <= 32'h0; // @[Fetcher.scala 21:28]
    end else if (4'hc == _instruction_T[3:0]) begin // @[Fetcher.scala 40:15]
      instruction <= 32'he00293; // @[Fetcher.scala 40:15]
    end else if (4'hb == _instruction_T[3:0]) begin // @[Fetcher.scala 40:15]
      instruction <= 32'h100113; // @[Fetcher.scala 40:15]
    end else if (4'ha == _instruction_T[3:0]) begin // @[Fetcher.scala 40:15]
      instruction <= 32'ha00293; // @[Fetcher.scala 40:15]
    end else begin
      instruction <= _GEN_9;
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
  instruction = _RAND_1[31:0];
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
  input  [31:0] io_instruction,
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
  wire [4:0] poop1 = io_instruction[19:15]; // @[Decoder.scala 33:27]
  wire [4:0] poop2 = io_instruction[24:20]; // @[Decoder.scala 34:29]
  reg [31:0] instruction; // @[Decoder.scala 37:28]
  wire  loadMemEnable = instruction[6:0] == 7'h3; // @[Decoder.scala 38:49]
  wire [11:0] _io_imm_S_T_1 = {instruction[31:25], 5'h0}; // @[Decoder.scala 64:38]
  wire [11:0] _GEN_0 = {{7'd0}, instruction[11:7]}; // @[Decoder.scala 64:44]
  wire [12:0] _io_imm_B_T_1 = {instruction[31], 12'h0}; // @[Decoder.scala 65:34]
  wire [11:0] _io_imm_B_T_3 = {instruction[7], 11'h0}; // @[Decoder.scala 65:59]
  wire [12:0] _GEN_1 = {{1'd0}, _io_imm_B_T_3}; // @[Decoder.scala 65:41]
  wire [12:0] _io_imm_B_T_4 = _io_imm_B_T_1 | _GEN_1; // @[Decoder.scala 65:41]
  wire [10:0] _io_imm_B_T_6 = {instruction[30:25], 5'h0}; // @[Decoder.scala 65:89]
  wire [12:0] _GEN_2 = {{2'd0}, _io_imm_B_T_6}; // @[Decoder.scala 65:66]
  wire [12:0] _io_imm_B_T_7 = _io_imm_B_T_4 | _GEN_2; // @[Decoder.scala 65:66]
  wire [4:0] _io_imm_B_T_9 = {instruction[11:8], 1'h0}; // @[Decoder.scala 65:117]
  wire [12:0] _GEN_3 = {{8'd0}, _io_imm_B_T_9}; // @[Decoder.scala 65:95]
  wire [20:0] _io_imm_J_T_1 = {instruction[31], 20'h0}; // @[Decoder.scala 67:35]
  wire [19:0] _io_imm_J_T_3 = {instruction[19:12], 12'h0}; // @[Decoder.scala 67:65]
  wire [20:0] _GEN_4 = {{1'd0}, _io_imm_J_T_3}; // @[Decoder.scala 67:42]
  wire [20:0] _io_imm_J_T_4 = _io_imm_J_T_1 | _GEN_4; // @[Decoder.scala 67:42]
  wire [11:0] _io_imm_J_T_6 = {instruction[20], 11'h0}; // @[Decoder.scala 67:91]
  wire [20:0] _GEN_5 = {{9'd0}, _io_imm_J_T_6}; // @[Decoder.scala 67:72]
  wire [20:0] _io_imm_J_T_7 = _io_imm_J_T_4 | _GEN_5; // @[Decoder.scala 67:72]
  wire [10:0] _io_imm_J_T_9 = {instruction[30:21], 1'h0}; // @[Decoder.scala 67:121]
  wire [20:0] _GEN_6 = {{10'd0}, _io_imm_J_T_9}; // @[Decoder.scala 67:98]
  assign io_opcode = instruction[6:0]; // @[Decoder.scala 56:27]
  assign io_rdOutput = instruction[11:7]; // @[Decoder.scala 57:33]
  assign io_funct3 = instruction[14:12]; // @[Decoder.scala 58:27]
  assign io_funct7 = instruction[31:25]; // @[Decoder.scala 62:27]
  assign io_rs1 = instruction[19:15]; // @[Decoder.scala 59:27]
  assign io_rs2 = instruction[24:20]; // @[Decoder.scala 61:27]
  assign io_imm_I = instruction[31:20]; // @[Decoder.scala 63:36]
  assign io_imm_S = _io_imm_S_T_1 | _GEN_0; // @[Decoder.scala 64:66]
  assign io_imm_B = _io_imm_B_T_7 | _GEN_3; // @[Decoder.scala 65:124]
  assign io_imm_U = {{12'd0}, instruction[31:12]}; // @[Decoder.scala 66:13]
  assign io_imm_J = _io_imm_J_T_7 | _GEN_6; // @[Decoder.scala 67:129]
  assign io_pcOut = io_pcIn; // @[Decoder.scala 51:12]
  assign io_shouldMux = loadMemEnable & (poop1 == io_rdOutput | poop2 == io_rdOutput); // @[Decoder.scala 41:33]
  always @(posedge clock) begin
    if (reset) begin // @[Decoder.scala 37:28]
      instruction <= 32'h0; // @[Decoder.scala 37:28]
    end else if (io_shouldMux) begin // @[Decoder.scala 44:23]
      instruction <= 32'h13;
    end else begin
      instruction <= io_instruction;
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
  instruction = _RAND_0[31:0];
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
  reg [31:0] aluLastRegEx; // @[Executer.scala 57:29]
  wire [31:0] _rs1Wire_T_8 = io_loadEnable & io_rdLoadRegMemIn == rs1Reg ? $signed(io_aluLoadRegMemIn) : $signed(
    io_aluLastRegMemIn); // @[Executer.scala 81:146]
  wire [31:0] _GEN_1 = 5'h1 == rs1Reg ? $signed(io_x_1) : $signed(io_x_0); // @[Executer.scala 81:{90,90}]
  wire [31:0] _GEN_2 = 5'h2 == rs1Reg ? $signed(io_x_2) : $signed(_GEN_1); // @[Executer.scala 81:{90,90}]
  wire [31:0] _GEN_3 = 5'h3 == rs1Reg ? $signed(io_x_3) : $signed(_GEN_2); // @[Executer.scala 81:{90,90}]
  wire [31:0] _GEN_4 = 5'h4 == rs1Reg ? $signed(io_x_4) : $signed(_GEN_3); // @[Executer.scala 81:{90,90}]
  wire [31:0] _GEN_5 = 5'h5 == rs1Reg ? $signed(io_x_5) : $signed(_GEN_4); // @[Executer.scala 81:{90,90}]
  wire [31:0] _GEN_6 = 5'h6 == rs1Reg ? $signed(io_x_6) : $signed(_GEN_5); // @[Executer.scala 81:{90,90}]
  wire [31:0] _GEN_7 = 5'h7 == rs1Reg ? $signed(io_x_7) : $signed(_GEN_6); // @[Executer.scala 81:{90,90}]
  wire [31:0] _GEN_8 = 5'h8 == rs1Reg ? $signed(io_x_8) : $signed(_GEN_7); // @[Executer.scala 81:{90,90}]
  wire [31:0] _GEN_9 = 5'h9 == rs1Reg ? $signed(io_x_9) : $signed(_GEN_8); // @[Executer.scala 81:{90,90}]
  wire [31:0] _GEN_10 = 5'ha == rs1Reg ? $signed(io_x_10) : $signed(_GEN_9); // @[Executer.scala 81:{90,90}]
  wire [31:0] _GEN_11 = 5'hb == rs1Reg ? $signed(io_x_11) : $signed(_GEN_10); // @[Executer.scala 81:{90,90}]
  wire [31:0] _GEN_12 = 5'hc == rs1Reg ? $signed(io_x_12) : $signed(_GEN_11); // @[Executer.scala 81:{90,90}]
  wire [31:0] _GEN_13 = 5'hd == rs1Reg ? $signed(io_x_13) : $signed(_GEN_12); // @[Executer.scala 81:{90,90}]
  wire [31:0] _GEN_14 = 5'he == rs1Reg ? $signed(io_x_14) : $signed(_GEN_13); // @[Executer.scala 81:{90,90}]
  wire [31:0] _GEN_15 = 5'hf == rs1Reg ? $signed(io_x_15) : $signed(_GEN_14); // @[Executer.scala 81:{90,90}]
  wire [31:0] _GEN_16 = 5'h10 == rs1Reg ? $signed(io_x_16) : $signed(_GEN_15); // @[Executer.scala 81:{90,90}]
  wire [31:0] _GEN_17 = 5'h11 == rs1Reg ? $signed(io_x_17) : $signed(_GEN_16); // @[Executer.scala 81:{90,90}]
  wire [31:0] _GEN_18 = 5'h12 == rs1Reg ? $signed(io_x_18) : $signed(_GEN_17); // @[Executer.scala 81:{90,90}]
  wire [31:0] _GEN_19 = 5'h13 == rs1Reg ? $signed(io_x_19) : $signed(_GEN_18); // @[Executer.scala 81:{90,90}]
  wire [31:0] _GEN_20 = 5'h14 == rs1Reg ? $signed(io_x_20) : $signed(_GEN_19); // @[Executer.scala 81:{90,90}]
  wire [31:0] _GEN_21 = 5'h15 == rs1Reg ? $signed(io_x_21) : $signed(_GEN_20); // @[Executer.scala 81:{90,90}]
  wire [31:0] _GEN_22 = 5'h16 == rs1Reg ? $signed(io_x_22) : $signed(_GEN_21); // @[Executer.scala 81:{90,90}]
  wire [31:0] _GEN_23 = 5'h17 == rs1Reg ? $signed(io_x_23) : $signed(_GEN_22); // @[Executer.scala 81:{90,90}]
  wire [31:0] _GEN_24 = 5'h18 == rs1Reg ? $signed(io_x_24) : $signed(_GEN_23); // @[Executer.scala 81:{90,90}]
  wire [31:0] _GEN_25 = 5'h19 == rs1Reg ? $signed(io_x_25) : $signed(_GEN_24); // @[Executer.scala 81:{90,90}]
  wire [31:0] _GEN_26 = 5'h1a == rs1Reg ? $signed(io_x_26) : $signed(_GEN_25); // @[Executer.scala 81:{90,90}]
  wire [31:0] _GEN_27 = 5'h1b == rs1Reg ? $signed(io_x_27) : $signed(_GEN_26); // @[Executer.scala 81:{90,90}]
  wire [31:0] _GEN_28 = 5'h1c == rs1Reg ? $signed(io_x_28) : $signed(_GEN_27); // @[Executer.scala 81:{90,90}]
  wire [31:0] _GEN_29 = 5'h1d == rs1Reg ? $signed(io_x_29) : $signed(_GEN_28); // @[Executer.scala 81:{90,90}]
  wire [31:0] _GEN_30 = 5'h1e == rs1Reg ? $signed(io_x_30) : $signed(_GEN_29); // @[Executer.scala 81:{90,90}]
  wire [31:0] _GEN_31 = 5'h1f == rs1Reg ? $signed(io_x_31) : $signed(_GEN_30); // @[Executer.scala 81:{90,90}]
  wire [31:0] _rs1Wire_T_9 = io_rdLastRegMemIn == rs1Reg & rs1Reg != 5'h0 ? $signed(_rs1Wire_T_8) : $signed(_GEN_31); // @[Executer.scala 81:90]
  wire [31:0] _rs2Wire_T_8 = io_loadEnable & io_rdLoadRegMemIn == rs2Reg ? $signed(io_aluLoadRegMemIn) : $signed(
    io_aluLastRegMemIn); // @[Executer.scala 82:146]
  wire [31:0] _GEN_33 = 5'h1 == rs2Reg ? $signed(io_x_1) : $signed(io_x_0); // @[Executer.scala 82:{90,90}]
  wire [31:0] _GEN_34 = 5'h2 == rs2Reg ? $signed(io_x_2) : $signed(_GEN_33); // @[Executer.scala 82:{90,90}]
  wire [31:0] _GEN_35 = 5'h3 == rs2Reg ? $signed(io_x_3) : $signed(_GEN_34); // @[Executer.scala 82:{90,90}]
  wire [31:0] _GEN_36 = 5'h4 == rs2Reg ? $signed(io_x_4) : $signed(_GEN_35); // @[Executer.scala 82:{90,90}]
  wire [31:0] _GEN_37 = 5'h5 == rs2Reg ? $signed(io_x_5) : $signed(_GEN_36); // @[Executer.scala 82:{90,90}]
  wire [31:0] _GEN_38 = 5'h6 == rs2Reg ? $signed(io_x_6) : $signed(_GEN_37); // @[Executer.scala 82:{90,90}]
  wire [31:0] _GEN_39 = 5'h7 == rs2Reg ? $signed(io_x_7) : $signed(_GEN_38); // @[Executer.scala 82:{90,90}]
  wire [31:0] _GEN_40 = 5'h8 == rs2Reg ? $signed(io_x_8) : $signed(_GEN_39); // @[Executer.scala 82:{90,90}]
  wire [31:0] _GEN_41 = 5'h9 == rs2Reg ? $signed(io_x_9) : $signed(_GEN_40); // @[Executer.scala 82:{90,90}]
  wire [31:0] _GEN_42 = 5'ha == rs2Reg ? $signed(io_x_10) : $signed(_GEN_41); // @[Executer.scala 82:{90,90}]
  wire [31:0] _GEN_43 = 5'hb == rs2Reg ? $signed(io_x_11) : $signed(_GEN_42); // @[Executer.scala 82:{90,90}]
  wire [31:0] _GEN_44 = 5'hc == rs2Reg ? $signed(io_x_12) : $signed(_GEN_43); // @[Executer.scala 82:{90,90}]
  wire [31:0] _GEN_45 = 5'hd == rs2Reg ? $signed(io_x_13) : $signed(_GEN_44); // @[Executer.scala 82:{90,90}]
  wire [31:0] _GEN_46 = 5'he == rs2Reg ? $signed(io_x_14) : $signed(_GEN_45); // @[Executer.scala 82:{90,90}]
  wire [31:0] _GEN_47 = 5'hf == rs2Reg ? $signed(io_x_15) : $signed(_GEN_46); // @[Executer.scala 82:{90,90}]
  wire [31:0] _GEN_48 = 5'h10 == rs2Reg ? $signed(io_x_16) : $signed(_GEN_47); // @[Executer.scala 82:{90,90}]
  wire [31:0] _GEN_49 = 5'h11 == rs2Reg ? $signed(io_x_17) : $signed(_GEN_48); // @[Executer.scala 82:{90,90}]
  wire [31:0] _GEN_50 = 5'h12 == rs2Reg ? $signed(io_x_18) : $signed(_GEN_49); // @[Executer.scala 82:{90,90}]
  wire [31:0] _GEN_51 = 5'h13 == rs2Reg ? $signed(io_x_19) : $signed(_GEN_50); // @[Executer.scala 82:{90,90}]
  wire [31:0] _GEN_52 = 5'h14 == rs2Reg ? $signed(io_x_20) : $signed(_GEN_51); // @[Executer.scala 82:{90,90}]
  wire [31:0] _GEN_53 = 5'h15 == rs2Reg ? $signed(io_x_21) : $signed(_GEN_52); // @[Executer.scala 82:{90,90}]
  wire [31:0] _GEN_54 = 5'h16 == rs2Reg ? $signed(io_x_22) : $signed(_GEN_53); // @[Executer.scala 82:{90,90}]
  wire [31:0] _GEN_55 = 5'h17 == rs2Reg ? $signed(io_x_23) : $signed(_GEN_54); // @[Executer.scala 82:{90,90}]
  wire [31:0] _GEN_56 = 5'h18 == rs2Reg ? $signed(io_x_24) : $signed(_GEN_55); // @[Executer.scala 82:{90,90}]
  wire [31:0] _GEN_57 = 5'h19 == rs2Reg ? $signed(io_x_25) : $signed(_GEN_56); // @[Executer.scala 82:{90,90}]
  wire [31:0] _GEN_58 = 5'h1a == rs2Reg ? $signed(io_x_26) : $signed(_GEN_57); // @[Executer.scala 82:{90,90}]
  wire [31:0] _GEN_59 = 5'h1b == rs2Reg ? $signed(io_x_27) : $signed(_GEN_58); // @[Executer.scala 82:{90,90}]
  wire [31:0] _GEN_60 = 5'h1c == rs2Reg ? $signed(io_x_28) : $signed(_GEN_59); // @[Executer.scala 82:{90,90}]
  wire [31:0] _GEN_61 = 5'h1d == rs2Reg ? $signed(io_x_29) : $signed(_GEN_60); // @[Executer.scala 82:{90,90}]
  wire [31:0] _GEN_62 = 5'h1e == rs2Reg ? $signed(io_x_30) : $signed(_GEN_61); // @[Executer.scala 82:{90,90}]
  wire [31:0] _GEN_63 = 5'h1f == rs2Reg ? $signed(io_x_31) : $signed(_GEN_62); // @[Executer.scala 82:{90,90}]
  wire [31:0] _rs2Wire_T_9 = io_rdLastRegMemIn == rs2Reg & rs2Reg != 5'h0 ? $signed(_rs2Wire_T_8) : $signed(_GEN_63); // @[Executer.scala 82:90]
  wire [31:0] rs2Wire = io_rdLastRegMemIn == rs2Reg & rs2Reg != 5'h0 ? $signed(aluLastRegEx) : $signed(_rs2Wire_T_9); // @[Executer.scala 82:20]
  wire [4:0] _io_operand2_T = rs2Reg; // @[Executer.scala 104:33]
  wire [6:0] _GEN_64 = 3'h5 == funct3Reg ? funct7Reg : 7'h0; // @[Executer.scala 100:20 101:25 107:24]
  wire [11:0] _GEN_65 = 3'h5 == funct3Reg ? $signed({{7{_io_operand2_T[4]}},_io_operand2_T}) : $signed(imm_IReg); // @[Executer.scala 101:25 108:23 99:19]
  wire [6:0] _GEN_66 = 3'h1 == funct3Reg ? funct7Reg : _GEN_64; // @[Executer.scala 101:25 103:24]
  wire [11:0] _GEN_67 = 3'h1 == funct3Reg ? $signed({{7{_io_operand2_T[4]}},_io_operand2_T}) : $signed(_GEN_65); // @[Executer.scala 101:25 104:23]
  wire [3:0] _GEN_68 = 7'h17 == opcodeReg ? 4'h8 : 4'h0; // @[Executer.scala 140:16 91:12 92:21]
  wire [31:0] _GEN_69 = 7'h17 == opcodeReg ? $signed(imm_UReg) : $signed({{20{imm_IReg[11]}},imm_IReg}); // @[Executer.scala 141:14 87:10 92:21]
  wire [3:0] _GEN_70 = 7'h37 == opcodeReg ? 4'h7 : _GEN_68; // @[Executer.scala 136:16 92:21]
  wire [31:0] _GEN_71 = 7'h37 == opcodeReg ? $signed(imm_UReg) : $signed(_GEN_69); // @[Executer.scala 137:14 92:21]
  wire [3:0] _GEN_72 = 7'h67 == opcodeReg ? 4'h6 : _GEN_70; // @[Executer.scala 132:16 92:21]
  wire [31:0] _GEN_73 = 7'h67 == opcodeReg ? $signed({{20{imm_IReg[11]}},imm_IReg}) : $signed(_GEN_71); // @[Executer.scala 133:14 92:21]
  wire [3:0] _GEN_74 = 7'h6f == opcodeReg ? 4'h5 : _GEN_72; // @[Executer.scala 128:16 92:21]
  wire [31:0] _GEN_75 = 7'h6f == opcodeReg ? $signed({{11{imm_JReg[20]}},imm_JReg}) : $signed(_GEN_73); // @[Executer.scala 129:14 92:21]
  wire [3:0] _GEN_76 = 7'h63 == opcodeReg ? 4'h4 : _GEN_74; // @[Executer.scala 123:16 92:21]
  wire [31:0] _GEN_77 = 7'h63 == opcodeReg ? $signed(rs2Wire) : $signed(32'sh0); // @[Executer.scala 124:19 90:15 92:21]
  wire [31:0] _GEN_78 = 7'h63 == opcodeReg ? $signed({{19{imm_BReg[12]}},imm_BReg}) : $signed(_GEN_75); // @[Executer.scala 125:14 92:21]
  wire [3:0] _GEN_79 = 7'h23 == opcodeReg ? 4'h3 : _GEN_76; // @[Executer.scala 118:16 92:21]
  wire [31:0] _GEN_80 = 7'h23 == opcodeReg ? $signed(rs2Wire) : $signed(_GEN_77); // @[Executer.scala 119:19 92:21]
  wire [31:0] _GEN_81 = 7'h23 == opcodeReg ? $signed({{20{imm_SReg[11]}},imm_SReg}) : $signed(_GEN_78); // @[Executer.scala 120:14 92:21]
  wire [3:0] _GEN_82 = 7'h3 == opcodeReg ? 4'h2 : _GEN_79; // @[Executer.scala 113:16 92:21]
  wire [31:0] _GEN_83 = 7'h3 == opcodeReg ? $signed(rs2Wire) : $signed(_GEN_80); // @[Executer.scala 114:19 92:21]
  wire [31:0] _GEN_84 = 7'h3 == opcodeReg ? $signed({{20{imm_IReg[11]}},imm_IReg}) : $signed(_GEN_81); // @[Executer.scala 115:14 92:21]
  wire [3:0] _GEN_85 = 7'h13 == opcodeReg ? 4'h1 : _GEN_82; // @[Executer.scala 92:21 98:16]
  wire [31:0] _GEN_86 = 7'h13 == opcodeReg ? $signed({{20{_GEN_67[11]}},_GEN_67}) : $signed(_GEN_83); // @[Executer.scala 92:21]
  wire [6:0] _GEN_87 = 7'h13 == opcodeReg ? _GEN_66 : funct7Reg; // @[Executer.scala 73:16 92:21]
  wire [31:0] _GEN_88 = 7'h13 == opcodeReg ? $signed({{20{imm_IReg[11]}},imm_IReg}) : $signed(_GEN_84); // @[Executer.scala 87:10 92:21]
  assign io_imm = 7'h33 == opcodeReg ? $signed({{20{imm_IReg[11]}},imm_IReg}) : $signed(_GEN_88); // @[Executer.scala 87:10 92:21]
  assign io_funct3out = funct3Reg; // @[Executer.scala 74:16]
  assign io_funct7out = 7'h33 == opcodeReg ? funct7Reg : _GEN_87; // @[Executer.scala 73:16 92:21]
  assign io_group = 7'h33 == opcodeReg ? 4'h1 : _GEN_85; // @[Executer.scala 92:21 95:16]
  assign io_operand1 = io_rdLastRegMemIn == rs1Reg & rs1Reg != 5'h0 ? $signed(aluLastRegEx) : $signed(_rs1Wire_T_9); // @[Executer.scala 81:20]
  assign io_operand2 = 7'h33 == opcodeReg ? $signed(rs2Wire) : $signed(_GEN_86); // @[Executer.scala 92:21 94:19]
  assign io_pcOut = pcReg; // @[Executer.scala 149:12]
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
      pcReg <= io_pcIn; // @[Executer.scala 78:9]
    end
    if (reset) begin // @[Executer.scala 57:29]
      aluLastRegEx <= 32'sh0; // @[Executer.scala 57:29]
    end else begin
      aluLastRegEx <= io_ALUIn; // @[Executer.scala 146:16]
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
  aluLastRegEx = _RAND_11[31:0];
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
`endif // RANDOMIZE_REG_INIT
  wire  _T_1 = 3'h0 == io_funct3; // @[ALU.scala 52:22]
  wire [31:0] _io_ALUout_T_2 = $signed(io_operand1) + $signed(io_operand2); // @[ALU.scala 54:40]
  wire [31:0] _io_ALUout_T_5 = $signed(io_operand1) - $signed(io_operand2); // @[ALU.scala 57:44]
  wire [31:0] _GEN_0 = 7'h20 == io_funct7 ? $signed(_io_ALUout_T_5) : $signed(_io_ALUout_T_2); // @[ALU.scala 54:21 55:26 57:25]
  wire  _T_3 = 3'h4 == io_funct3; // @[ALU.scala 52:22]
  wire [31:0] _io_ALUout_T_7 = $signed(io_operand1) ^ $signed(io_operand2); // @[ALU.scala 62:40]
  wire  _T_4 = 3'h6 == io_funct3; // @[ALU.scala 52:22]
  wire [31:0] _io_ALUout_T_9 = $signed(io_operand1) | $signed(io_operand2); // @[ALU.scala 65:40]
  wire  _T_5 = 3'h7 == io_funct3; // @[ALU.scala 52:22]
  wire [31:0] _io_ALUout_T_11 = $signed(io_operand1) & $signed(io_operand2); // @[ALU.scala 68:40]
  wire  _T_6 = 3'h1 == io_funct3; // @[ALU.scala 52:22]
  wire [31:0] _io_ALUout_T_12 = io_operand1; // @[ALU.scala 72:34]
  wire [31:0] _io_ALUout_T_13 = io_operand2; // @[ALU.scala 72:53]
  wire [524318:0] _GEN_18 = {{524287'd0}, _io_ALUout_T_12}; // @[ALU.scala 72:41]
  wire [524318:0] _io_ALUout_T_16 = _GEN_18 << _io_ALUout_T_13[18:0]; // @[ALU.scala 72:67]
  wire  _T_7 = 3'h5 == io_funct3; // @[ALU.scala 52:22]
  wire [31:0] _io_ALUout_T_20 = io_operand1 >> io_operand2; // @[ALU.scala 76:61]
  wire [31:0] _io_ALUout_T_22 = $signed(io_operand1) >>> io_operand2; // @[ALU.scala 79:37]
  wire [31:0] _GEN_1 = io_funct7 == 7'h20 ? $signed(_io_ALUout_T_22) : $signed(_io_ALUout_T_20); // @[ALU.scala 76:21 78:34 79:25]
  wire  _T_9 = 3'h2 == io_funct3; // @[ALU.scala 52:22]
  wire  _io_ALUout_T_23 = $signed(io_operand1) < $signed(io_operand2); // @[ALU.scala 85:44]
  wire [1:0] _io_ALUout_T_24 = $signed(io_operand1) < $signed(io_operand2) ? $signed(2'sh1) : $signed(2'sh0); // @[ALU.scala 85:27]
  wire [1:0] _io_ALUout_T_28 = io_operand1 < io_operand2 ? $signed(2'sh1) : $signed(2'sh0); // @[ALU.scala 88:27]
  wire [1:0] _GEN_2 = 3'h3 == io_funct3 ? $signed(_io_ALUout_T_28) : $signed(2'sh0); // @[ALU.scala 44:13 52:22 88:21]
  wire [1:0] _GEN_3 = 3'h2 == io_funct3 ? $signed(_io_ALUout_T_24) : $signed(_GEN_2); // @[ALU.scala 52:22 85:21]
  wire [31:0] _GEN_4 = 3'h5 == io_funct3 ? $signed(_GEN_1) : $signed({{30{_GEN_3[1]}},_GEN_3}); // @[ALU.scala 52:22]
  wire [524318:0] _GEN_5 = 3'h1 == io_funct3 ? $signed(_io_ALUout_T_16) : $signed({{524287{_GEN_4[31]}},_GEN_4}); // @[ALU.scala 52:22 72:21]
  wire [524318:0] _GEN_6 = 3'h7 == io_funct3 ? $signed({{524287{_io_ALUout_T_11[31]}},_io_ALUout_T_11}) : $signed(_GEN_5
    ); // @[ALU.scala 52:22 68:21]
  wire [524318:0] _GEN_7 = 3'h6 == io_funct3 ? $signed({{524287{_io_ALUout_T_9[31]}},_io_ALUout_T_9}) : $signed(_GEN_6); // @[ALU.scala 52:22 65:21]
  wire [524318:0] _GEN_8 = 3'h4 == io_funct3 ? $signed({{524287{_io_ALUout_T_7[31]}},_io_ALUout_T_7}) : $signed(_GEN_7); // @[ALU.scala 52:22 62:21]
  wire [524318:0] _GEN_9 = 3'h0 == io_funct3 ? $signed({{524287{_GEN_0[31]}},_GEN_0}) : $signed(_GEN_8); // @[ALU.scala 52:22]
  wire [31:0] _io_rdAddr_T_2 = $signed(io_operand1) + $signed(io_imm); // @[ALU.scala 93:30]
  wire [2:0] _GEN_10 = _T_7 ? 3'h5 : 3'h0; // @[ALU.scala 110:20 42:12 95:22]
  wire [2:0] _GEN_11 = _T_3 ? 3'h4 : _GEN_10; // @[ALU.scala 107:20 95:22]
  wire [2:0] _GEN_12 = _T_9 ? 3'h3 : _GEN_11; // @[ALU.scala 104:20 95:22]
  wire [2:0] _GEN_13 = _T_6 ? 3'h2 : _GEN_12; // @[ALU.scala 101:20 95:22]
  wire [2:0] _GEN_14 = _T_1 ? 3'h1 : _GEN_13; // @[ALU.scala 95:22 98:20]
  wire [1:0] _GEN_15 = _T_9 ? 2'h3 : 2'h0; // @[ALU.scala 119:22 127:20 42:12]
  wire [1:0] _GEN_16 = _T_6 ? 2'h2 : _GEN_15; // @[ALU.scala 119:22 124:20]
  wire [1:0] _GEN_17 = _T_1 ? 2'h1 : _GEN_16; // @[ALU.scala 119:22 121:20]
  wire  _T_23 = $signed(io_operand1) == $signed(io_operand2); // @[ALU.scala 135:25]
  wire [31:0] _io_branchOut_T_2 = $signed(io_pcIn) + $signed(io_imm); // @[ALU.scala 137:35]
  wire [31:0] _io_branchOut_T_5 = $signed(_io_branchOut_T_2) - 32'sh4; // @[ALU.scala 137:41]
  wire [31:0] _GEN_19 = $signed(io_operand1) == $signed(io_operand2) ? $signed(_io_branchOut_T_5) : $signed(32'sh0); // @[ALU.scala 135:39 137:26 45:16]
  wire  _T_25 = $signed(io_operand1) != $signed(io_operand2); // @[ALU.scala 141:25]
  wire [31:0] _GEN_21 = $signed(io_operand1) != $signed(io_operand2) ? $signed(_io_branchOut_T_5) : $signed(32'sh0); // @[ALU.scala 141:39 143:26 45:16]
  wire [31:0] _GEN_23 = _io_ALUout_T_23 ? $signed(_io_branchOut_T_5) : $signed(32'sh0); // @[ALU.scala 148:37 150:26 45:16]
  wire  _T_29 = $signed(io_operand1) >= $signed(io_operand2); // @[ALU.scala 154:25]
  wire [31:0] _GEN_25 = $signed(io_operand1) >= $signed(io_operand2) ? $signed(_io_branchOut_T_5) : $signed(32'sh0); // @[ALU.scala 154:38 156:26 45:16]
  wire  _T_35 = io_operand1 >= io_operand2; // @[ALU.scala 167:34]
  wire [31:0] _GEN_29 = io_operand1 >= io_operand2 ? $signed(_io_branchOut_T_5) : $signed(32'sh0); // @[ALU.scala 167:54 169:28 45:16]
  wire  _GEN_30 = _T_5 & _T_35; // @[ALU.scala 133:22 46:19]
  wire [31:0] _GEN_31 = _T_5 ? $signed(_GEN_29) : $signed(32'sh0); // @[ALU.scala 133:22 45:16]
  wire  _GEN_32 = _T_4 ? _io_ALUout_T_23 : _GEN_30; // @[ALU.scala 133:22]
  wire [31:0] _GEN_33 = _T_4 ? $signed(_GEN_23) : $signed(_GEN_31); // @[ALU.scala 133:22]
  wire  _GEN_34 = _T_7 ? _T_29 : _GEN_32; // @[ALU.scala 133:22]
  wire [31:0] _GEN_35 = _T_7 ? $signed(_GEN_25) : $signed(_GEN_33); // @[ALU.scala 133:22]
  wire  _GEN_36 = _T_3 ? _io_ALUout_T_23 : _GEN_34; // @[ALU.scala 133:22]
  wire [31:0] _GEN_37 = _T_3 ? $signed(_GEN_23) : $signed(_GEN_35); // @[ALU.scala 133:22]
  wire  _GEN_38 = _T_6 ? _T_25 : _GEN_36; // @[ALU.scala 133:22]
  wire [31:0] _GEN_39 = _T_6 ? $signed(_GEN_21) : $signed(_GEN_37); // @[ALU.scala 133:22]
  wire  _GEN_40 = _T_1 ? _T_23 : _GEN_38; // @[ALU.scala 133:22]
  wire [31:0] _GEN_41 = _T_1 ? $signed(_GEN_19) : $signed(_GEN_39); // @[ALU.scala 133:22]
  wire [31:0] _io_ALUout_T_31 = {io_imm[19:0], 12'h0}; // @[ALU.scala 183:41]
  wire [31:0] _io_ALUout_T_37 = $signed(io_pcIn) + $signed(_io_ALUout_T_31); // @[ALU.scala 186:26]
  wire [31:0] _GEN_42 = 4'h8 == io_group ? $signed(_io_ALUout_T_37) : $signed(32'sh0); // @[ALU.scala 186:17 44:13 50:17]
  wire [31:0] _GEN_43 = 4'h7 == io_group ? $signed(_io_ALUout_T_31) : $signed(_GEN_42); // @[ALU.scala 183:17 50:17]
  wire [31:0] _GEN_44 = 4'h6 == io_group ? $signed(_io_rdAddr_T_2) : $signed(32'sh0); // @[ALU.scala 50:17 180:20 45:16]
  wire [31:0] _GEN_45 = 4'h6 == io_group ? $signed(32'sh0) : $signed(_GEN_43); // @[ALU.scala 44:13 50:17]
  wire [31:0] _GEN_46 = 4'h5 == io_group ? $signed(_io_branchOut_T_2) : $signed(_GEN_44); // @[ALU.scala 50:17 176:20]
  wire [31:0] _GEN_47 = 4'h5 == io_group ? $signed(32'sh0) : $signed(_GEN_45); // @[ALU.scala 44:13 50:17]
  wire [31:0] _GEN_49 = 4'h4 == io_group ? $signed(_GEN_41) : $signed(_GEN_46); // @[ALU.scala 50:17]
  wire [31:0] _GEN_50 = 4'h4 == io_group ? $signed(32'sh0) : $signed(_GEN_47); // @[ALU.scala 44:13 50:17]
  wire [31:0] _GEN_51 = 4'h3 == io_group ? $signed(io_operand2) : $signed(_GEN_50); // @[ALU.scala 116:17 50:17]
  wire [9:0] _GEN_52 = 4'h3 == io_group ? _io_rdAddr_T_2[9:0] : 10'h0; // @[ALU.scala 117:17 41:13 50:17]
  wire [1:0] _GEN_54 = 4'h3 == io_group ? _GEN_17 : 2'h0; // @[ALU.scala 42:12 50:17]
  wire  _GEN_55 = 4'h3 == io_group ? 1'h0 : 4'h4 == io_group & _GEN_40; // @[ALU.scala 50:17 46:19]
  wire [31:0] _GEN_56 = 4'h3 == io_group ? $signed(32'sh0) : $signed(_GEN_49); // @[ALU.scala 45:16 50:17]
  wire [9:0] _GEN_57 = 4'h2 == io_group ? _io_rdAddr_T_2[9:0] : 10'h0; // @[ALU.scala 40:13 50:17 93:17]
  wire [2:0] _GEN_59 = 4'h2 == io_group ? _GEN_14 : {{1'd0}, _GEN_54}; // @[ALU.scala 50:17]
  wire [31:0] _GEN_60 = 4'h2 == io_group ? $signed(32'sh0) : $signed(_GEN_51); // @[ALU.scala 44:13 50:17]
  wire [9:0] _GEN_61 = 4'h2 == io_group ? 10'h0 : _GEN_52; // @[ALU.scala 41:13 50:17]
  wire  _GEN_62 = 4'h2 == io_group ? 1'h0 : 4'h3 == io_group; // @[ALU.scala 38:12 50:17]
  wire  _GEN_63 = 4'h2 == io_group ? 1'h0 : _GEN_55; // @[ALU.scala 50:17 46:19]
  wire [31:0] _GEN_64 = 4'h2 == io_group ? $signed(32'sh0) : $signed(_GEN_56); // @[ALU.scala 45:16 50:17]
  wire [524318:0] _GEN_65 = 4'h1 == io_group ? $signed(_GEN_9) : $signed({{524287{_GEN_60[31]}},_GEN_60}); // @[ALU.scala 50:17]
  reg [4:0] rdReg; // @[ALU.scala 195:22]
  assign io_branchOut = 4'h1 == io_group ? $signed(32'sh0) : $signed(_GEN_64); // @[ALU.scala 45:16 50:17]
  assign io_branchEnable = 4'h1 == io_group ? 1'h0 : _GEN_63; // @[ALU.scala 50:17 46:19]
  assign io_ALUout = _GEN_65[31:0];
  assign io_rdAddr = 4'h1 == io_group ? 10'h0 : _GEN_57; // @[ALU.scala 40:13 50:17]
  assign io_wrAddr = 4'h1 == io_group ? 10'h0 : _GEN_61; // @[ALU.scala 41:13 50:17]
  assign io_wrEna = 4'h1 == io_group ? 1'h0 : _GEN_62; // @[ALU.scala 38:12 50:17]
  assign io_rdEna = 4'h1 == io_group ? 1'h0 : 4'h2 == io_group; // @[ALU.scala 39:12 50:17]
  assign io_memOp = 4'h1 == io_group ? 3'h0 : _GEN_59; // @[ALU.scala 42:12 50:17]
  assign io_rdOut = rdReg; // @[ALU.scala 198:11]
  always @(posedge clock) begin
    if ($signed(io_imm) > 32'sh4 & io_branchEnable) begin // @[ALU.scala 195:49]
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
  rdReg = _RAND_0[4:0];
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
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
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
`endif // RANDOMIZE_REG_INIT
  reg [7:0] mem [0:1023]; // @[Memorizer.scala 57:24]
  wire  mem_readByte0_en; // @[Memorizer.scala 57:24]
  wire [9:0] mem_readByte0_addr; // @[Memorizer.scala 57:24]
  wire [7:0] mem_readByte0_data; // @[Memorizer.scala 57:24]
  wire  mem_readByte1_en; // @[Memorizer.scala 57:24]
  wire [9:0] mem_readByte1_addr; // @[Memorizer.scala 57:24]
  wire [7:0] mem_readByte1_data; // @[Memorizer.scala 57:24]
  wire  mem_readByte2_en; // @[Memorizer.scala 57:24]
  wire [9:0] mem_readByte2_addr; // @[Memorizer.scala 57:24]
  wire [7:0] mem_readByte2_data; // @[Memorizer.scala 57:24]
  wire  mem_readByte3_en; // @[Memorizer.scala 57:24]
  wire [9:0] mem_readByte3_addr; // @[Memorizer.scala 57:24]
  wire [7:0] mem_readByte3_data; // @[Memorizer.scala 57:24]
  wire  mem_io_rdData_MPORT_en; // @[Memorizer.scala 57:24]
  wire [9:0] mem_io_rdData_MPORT_addr; // @[Memorizer.scala 57:24]
  wire [7:0] mem_io_rdData_MPORT_data; // @[Memorizer.scala 57:24]
  wire [7:0] mem_MPORT_data; // @[Memorizer.scala 57:24]
  wire [9:0] mem_MPORT_addr; // @[Memorizer.scala 57:24]
  wire  mem_MPORT_mask; // @[Memorizer.scala 57:24]
  wire  mem_MPORT_en; // @[Memorizer.scala 57:24]
  wire [7:0] mem_MPORT_1_data; // @[Memorizer.scala 57:24]
  wire [9:0] mem_MPORT_1_addr; // @[Memorizer.scala 57:24]
  wire  mem_MPORT_1_mask; // @[Memorizer.scala 57:24]
  wire  mem_MPORT_1_en; // @[Memorizer.scala 57:24]
  wire [7:0] mem_MPORT_2_data; // @[Memorizer.scala 57:24]
  wire [9:0] mem_MPORT_2_addr; // @[Memorizer.scala 57:24]
  wire  mem_MPORT_2_mask; // @[Memorizer.scala 57:24]
  wire  mem_MPORT_2_en; // @[Memorizer.scala 57:24]
  wire [7:0] mem_MPORT_3_data; // @[Memorizer.scala 57:24]
  wire [9:0] mem_MPORT_3_addr; // @[Memorizer.scala 57:24]
  wire  mem_MPORT_3_mask; // @[Memorizer.scala 57:24]
  wire  mem_MPORT_3_en; // @[Memorizer.scala 57:24]
  wire [7:0] mem_MPORT_4_data; // @[Memorizer.scala 57:24]
  wire [9:0] mem_MPORT_4_addr; // @[Memorizer.scala 57:24]
  wire  mem_MPORT_4_mask; // @[Memorizer.scala 57:24]
  wire  mem_MPORT_4_en; // @[Memorizer.scala 57:24]
  wire [7:0] mem_MPORT_5_data; // @[Memorizer.scala 57:24]
  wire [9:0] mem_MPORT_5_addr; // @[Memorizer.scala 57:24]
  wire  mem_MPORT_5_mask; // @[Memorizer.scala 57:24]
  wire  mem_MPORT_5_en; // @[Memorizer.scala 57:24]
  wire [7:0] mem_MPORT_6_data; // @[Memorizer.scala 57:24]
  wire [9:0] mem_MPORT_6_addr; // @[Memorizer.scala 57:24]
  wire  mem_MPORT_6_mask; // @[Memorizer.scala 57:24]
  wire  mem_MPORT_6_en; // @[Memorizer.scala 57:24]
  reg  mem_readByte0_en_pipe_0;
  reg [9:0] mem_readByte0_addr_pipe_0;
  reg  mem_readByte1_en_pipe_0;
  reg [9:0] mem_readByte1_addr_pipe_0;
  reg  mem_readByte2_en_pipe_0;
  reg [9:0] mem_readByte2_addr_pipe_0;
  reg  mem_readByte3_en_pipe_0;
  reg [9:0] mem_readByte3_addr_pipe_0;
  reg  mem_io_rdData_MPORT_en_pipe_0;
  reg [9:0] mem_io_rdData_MPORT_addr_pipe_0;
  reg [4:0] rdReg; // @[Memorizer.scala 37:22]
  reg [31:0] ALUreg; // @[Memorizer.scala 38:23]
  reg [4:0] rdLastRegMem; // @[Memorizer.scala 43:29]
  reg [31:0] aluLastRegMem; // @[Memorizer.scala 44:30]
  reg  wrEnaReg; // @[Memorizer.scala 51:25]
  reg  rdEnaReg; // @[Memorizer.scala 52:25]
  reg [31:0] wrDataReg; // @[Memorizer.scala 53:26]
  reg [9:0] wrAddrReg; // @[Memorizer.scala 55:26]
  reg [2:0] memOpReg; // @[Memorizer.scala 56:25]
  wire [7:0] _io_rdData_T_2 = mem_io_rdData_MPORT_data; // @[Memorizer.scala 69:36]
  wire  _T = 3'h0 == memOpReg; // @[Memorizer.scala 72:20]
  wire [7:0] _io_rdData_T_3 = mem_readByte0_data; // @[Memorizer.scala 77:30]
  wire [15:0] _io_rdData_T_5 = {mem_readByte1_data,mem_readByte0_data}; // @[Memorizer.scala 83:47]
  wire [31:0] _io_rdData_T_7 = {mem_readByte3_data,mem_readByte2_data,mem_readByte1_data,mem_readByte0_data}; // @[Memorizer.scala 90:68]
  wire [31:0] _io_rdData_T_9 = {24'h0,mem_readByte0_data}; // @[Memorizer.scala 100:46]
  wire [31:0] _io_rdData_T_11 = {16'h0,mem_readByte1_data,mem_readByte0_data}; // @[Memorizer.scala 103:58]
  wire [31:0] _GEN_25 = 3'h5 == memOpReg ? $signed(_io_rdData_T_11) : $signed({{24{_io_rdData_T_2[7]}},_io_rdData_T_2}); // @[Memorizer.scala 103:17 69:13 72:20]
  wire [31:0] _GEN_26 = 3'h4 == memOpReg ? $signed(_io_rdData_T_9) : $signed(_GEN_25); // @[Memorizer.scala 100:17 72:20]
  wire [31:0] _GEN_27 = 3'h3 == memOpReg ? $signed(_io_rdData_T_7) : $signed(_GEN_26); // @[Memorizer.scala 72:20 90:17]
  wire [31:0] _GEN_39 = 3'h2 == memOpReg ? $signed({{16{_io_rdData_T_5[15]}},_io_rdData_T_5}) : $signed(_GEN_27); // @[Memorizer.scala 72:20 83:17]
  wire  _GEN_49 = 3'h2 == memOpReg ? 1'h0 : 3'h3 == memOpReg & wrEnaReg; // @[Memorizer.scala 72:20 57:24]
  wire [31:0] _GEN_58 = 3'h1 == memOpReg ? $signed({{24{_io_rdData_T_3[7]}},_io_rdData_T_3}) : $signed(_GEN_39); // @[Memorizer.scala 72:20 77:17]
  wire  _GEN_61 = 3'h1 == memOpReg & wrEnaReg; // @[Memorizer.scala 72:20 57:24]
  wire  _GEN_66 = 3'h1 == memOpReg ? 1'h0 : 3'h2 == memOpReg & wrEnaReg; // @[Memorizer.scala 72:20 57:24]
  wire  _GEN_73 = 3'h1 == memOpReg ? 1'h0 : _GEN_49; // @[Memorizer.scala 72:20 57:24]
  reg [4:0] rdLoadRegger; // @[Memorizer.scala 106:29]
  reg [31:0] aluLoadRegger; // @[Memorizer.scala 107:30]
  reg  enabler; // @[Memorizer.scala 108:24]
  assign mem_readByte0_en = mem_readByte0_en_pipe_0;
  assign mem_readByte0_addr = mem_readByte0_addr_pipe_0;
  assign mem_readByte0_data = mem[mem_readByte0_addr]; // @[Memorizer.scala 57:24]
  assign mem_readByte1_en = mem_readByte1_en_pipe_0;
  assign mem_readByte1_addr = mem_readByte1_addr_pipe_0;
  assign mem_readByte1_data = mem[mem_readByte1_addr]; // @[Memorizer.scala 57:24]
  assign mem_readByte2_en = mem_readByte2_en_pipe_0;
  assign mem_readByte2_addr = mem_readByte2_addr_pipe_0;
  assign mem_readByte2_data = mem[mem_readByte2_addr]; // @[Memorizer.scala 57:24]
  assign mem_readByte3_en = mem_readByte3_en_pipe_0;
  assign mem_readByte3_addr = mem_readByte3_addr_pipe_0;
  assign mem_readByte3_data = mem[mem_readByte3_addr]; // @[Memorizer.scala 57:24]
  assign mem_io_rdData_MPORT_en = mem_io_rdData_MPORT_en_pipe_0;
  assign mem_io_rdData_MPORT_addr = mem_io_rdData_MPORT_addr_pipe_0;
  assign mem_io_rdData_MPORT_data = mem[mem_io_rdData_MPORT_addr]; // @[Memorizer.scala 57:24]
  assign mem_MPORT_data = wrDataReg[7:0];
  assign mem_MPORT_addr = wrAddrReg;
  assign mem_MPORT_mask = 1'h1;
  assign mem_MPORT_en = _T ? 1'h0 : _GEN_61;
  assign mem_MPORT_1_data = wrDataReg[7:0];
  assign mem_MPORT_1_addr = wrAddrReg;
  assign mem_MPORT_1_mask = 1'h1;
  assign mem_MPORT_1_en = _T ? 1'h0 : _GEN_66;
  assign mem_MPORT_2_data = wrDataReg[15:8];
  assign mem_MPORT_2_addr = wrAddrReg + 10'h1;
  assign mem_MPORT_2_mask = 1'h1;
  assign mem_MPORT_2_en = _T ? 1'h0 : _GEN_66;
  assign mem_MPORT_3_data = wrDataReg[7:0];
  assign mem_MPORT_3_addr = wrAddrReg;
  assign mem_MPORT_3_mask = 1'h1;
  assign mem_MPORT_3_en = _T ? 1'h0 : _GEN_73;
  assign mem_MPORT_4_data = wrDataReg[15:8];
  assign mem_MPORT_4_addr = wrAddrReg + 10'h1;
  assign mem_MPORT_4_mask = 1'h1;
  assign mem_MPORT_4_en = _T ? 1'h0 : _GEN_73;
  assign mem_MPORT_5_data = wrDataReg[23:16];
  assign mem_MPORT_5_addr = wrAddrReg + 10'h2;
  assign mem_MPORT_5_mask = 1'h1;
  assign mem_MPORT_5_en = _T ? 1'h0 : _GEN_73;
  assign mem_MPORT_6_data = wrDataReg[31:24];
  assign mem_MPORT_6_addr = wrAddrReg + 10'h3;
  assign mem_MPORT_6_mask = 1'h1;
  assign mem_MPORT_6_en = _T ? 1'h0 : _GEN_73;
  assign io_rdLastRegMemOut = rdLastRegMem; // @[Memorizer.scala 48:22]
  assign io_aluLastRegMemOut = aluLastRegMem; // @[Memorizer.scala 49:23]
  assign io_rdLoadRegMemOut = rdLoadRegger; // @[Memorizer.scala 113:22]
  assign io_aluLoadRegMemOut = aluLoadRegger; // @[Memorizer.scala 114:23]
  assign io_loadEnabler = enabler; // @[Memorizer.scala 110:18]
  assign io_rdData = 3'h0 == memOpReg ? $signed(32'sh4) : $signed(_GEN_58); // @[Memorizer.scala 72:20 74:17]
  assign io_rdEnaOut = rdEnaReg; // @[Memorizer.scala 59:15]
  assign io_wrEnaOut = wrEnaReg; // @[Memorizer.scala 58:15]
  assign io_rdOutput = rdReg; // @[Memorizer.scala 39:15]
  assign io_ALUoutput = ALUreg; // @[Memorizer.scala 40:16]
  always @(posedge clock) begin
    if (mem_MPORT_en & mem_MPORT_mask) begin
      mem[mem_MPORT_addr] <= mem_MPORT_data; // @[Memorizer.scala 57:24]
    end
    if (mem_MPORT_1_en & mem_MPORT_1_mask) begin
      mem[mem_MPORT_1_addr] <= mem_MPORT_1_data; // @[Memorizer.scala 57:24]
    end
    if (mem_MPORT_2_en & mem_MPORT_2_mask) begin
      mem[mem_MPORT_2_addr] <= mem_MPORT_2_data; // @[Memorizer.scala 57:24]
    end
    if (mem_MPORT_3_en & mem_MPORT_3_mask) begin
      mem[mem_MPORT_3_addr] <= mem_MPORT_3_data; // @[Memorizer.scala 57:24]
    end
    if (mem_MPORT_4_en & mem_MPORT_4_mask) begin
      mem[mem_MPORT_4_addr] <= mem_MPORT_4_data; // @[Memorizer.scala 57:24]
    end
    if (mem_MPORT_5_en & mem_MPORT_5_mask) begin
      mem[mem_MPORT_5_addr] <= mem_MPORT_5_data; // @[Memorizer.scala 57:24]
    end
    if (mem_MPORT_6_en & mem_MPORT_6_mask) begin
      mem[mem_MPORT_6_addr] <= mem_MPORT_6_data; // @[Memorizer.scala 57:24]
    end
    mem_readByte0_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      mem_readByte0_addr_pipe_0 <= io_rdAddr;
    end
    mem_readByte1_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      mem_readByte1_addr_pipe_0 <= io_rdAddr + 10'h1;
    end
    mem_readByte2_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      mem_readByte2_addr_pipe_0 <= io_rdAddr + 10'h2;
    end
    mem_readByte3_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      mem_readByte3_addr_pipe_0 <= io_rdAddr + 10'h3;
    end
    mem_io_rdData_MPORT_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      mem_io_rdData_MPORT_addr_pipe_0 <= io_rdAddr;
    end
    if (reset) begin // @[Memorizer.scala 37:22]
      rdReg <= 5'h0; // @[Memorizer.scala 37:22]
    end else begin
      rdReg <= io_rdInput; // @[Memorizer.scala 37:22]
    end
    if (reset) begin // @[Memorizer.scala 38:23]
      ALUreg <= 32'sh0; // @[Memorizer.scala 38:23]
    end else begin
      ALUreg <= io_ALUinput; // @[Memorizer.scala 38:23]
    end
    if (reset) begin // @[Memorizer.scala 43:29]
      rdLastRegMem <= 5'h0; // @[Memorizer.scala 43:29]
    end else begin
      rdLastRegMem <= io_rdOutput; // @[Memorizer.scala 46:16]
    end
    if (reset) begin // @[Memorizer.scala 44:30]
      aluLastRegMem <= 32'sh0; // @[Memorizer.scala 44:30]
    end else begin
      aluLastRegMem <= io_ALUoutput; // @[Memorizer.scala 47:17]
    end
    if (reset) begin // @[Memorizer.scala 51:25]
      wrEnaReg <= 1'h0; // @[Memorizer.scala 51:25]
    end else begin
      wrEnaReg <= io_wrEna; // @[Memorizer.scala 51:25]
    end
    if (reset) begin // @[Memorizer.scala 52:25]
      rdEnaReg <= 1'h0; // @[Memorizer.scala 52:25]
    end else begin
      rdEnaReg <= io_rdEna; // @[Memorizer.scala 52:25]
    end
    if (reset) begin // @[Memorizer.scala 53:26]
      wrDataReg <= 32'h0; // @[Memorizer.scala 53:26]
    end else begin
      wrDataReg <= io_wrData; // @[Memorizer.scala 53:26]
    end
    if (reset) begin // @[Memorizer.scala 55:26]
      wrAddrReg <= 10'h0; // @[Memorizer.scala 55:26]
    end else begin
      wrAddrReg <= io_wrAddr; // @[Memorizer.scala 55:26]
    end
    if (reset) begin // @[Memorizer.scala 56:25]
      memOpReg <= 3'h0; // @[Memorizer.scala 56:25]
    end else begin
      memOpReg <= io_memOp; // @[Memorizer.scala 56:25]
    end
    if (reset) begin // @[Memorizer.scala 106:29]
      rdLoadRegger <= 5'h0; // @[Memorizer.scala 106:29]
    end else begin
      rdLoadRegger <= rdReg; // @[Memorizer.scala 111:16]
    end
    if (reset) begin // @[Memorizer.scala 107:30]
      aluLoadRegger <= 32'sh0; // @[Memorizer.scala 107:30]
    end else begin
      aluLoadRegger <= io_rdData; // @[Memorizer.scala 112:16]
    end
    if (reset) begin // @[Memorizer.scala 108:24]
      enabler <= 1'h0; // @[Memorizer.scala 108:24]
    end else begin
      enabler <= rdEnaReg; // @[Memorizer.scala 109:11]
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
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 1024; initvar = initvar+1)
    mem[initvar] = _RAND_0[7:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  mem_readByte0_en_pipe_0 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  mem_readByte0_addr_pipe_0 = _RAND_2[9:0];
  _RAND_3 = {1{`RANDOM}};
  mem_readByte1_en_pipe_0 = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  mem_readByte1_addr_pipe_0 = _RAND_4[9:0];
  _RAND_5 = {1{`RANDOM}};
  mem_readByte2_en_pipe_0 = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  mem_readByte2_addr_pipe_0 = _RAND_6[9:0];
  _RAND_7 = {1{`RANDOM}};
  mem_readByte3_en_pipe_0 = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  mem_readByte3_addr_pipe_0 = _RAND_8[9:0];
  _RAND_9 = {1{`RANDOM}};
  mem_io_rdData_MPORT_en_pipe_0 = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  mem_io_rdData_MPORT_addr_pipe_0 = _RAND_10[9:0];
  _RAND_11 = {1{`RANDOM}};
  rdReg = _RAND_11[4:0];
  _RAND_12 = {1{`RANDOM}};
  ALUreg = _RAND_12[31:0];
  _RAND_13 = {1{`RANDOM}};
  rdLastRegMem = _RAND_13[4:0];
  _RAND_14 = {1{`RANDOM}};
  aluLastRegMem = _RAND_14[31:0];
  _RAND_15 = {1{`RANDOM}};
  wrEnaReg = _RAND_15[0:0];
  _RAND_16 = {1{`RANDOM}};
  rdEnaReg = _RAND_16[0:0];
  _RAND_17 = {1{`RANDOM}};
  wrDataReg = _RAND_17[31:0];
  _RAND_18 = {1{`RANDOM}};
  wrAddrReg = _RAND_18[9:0];
  _RAND_19 = {1{`RANDOM}};
  memOpReg = _RAND_19[2:0];
  _RAND_20 = {1{`RANDOM}};
  rdLoadRegger = _RAND_20[4:0];
  _RAND_21 = {1{`RANDOM}};
  aluLoadRegger = _RAND_21[31:0];
  _RAND_22 = {1{`RANDOM}};
  enabler = _RAND_22[0:0];
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
  wire [5:0] _GEN_2 = {{1'd0}, rdReg}; // @[Write_backer.scala 31:45]
  assign io_ALUoutput = wrEnaInReg | rdReg == 5'h0 | _GEN_2 == 6'h20 ? $signed(32'sh0) : $signed(_io_ALUoutput_T); // @[Write_backer.scala 28:16 31:55 32:18]
  assign io_rdOut = wrEnaInReg | rdReg == 5'h0 | _GEN_2 == 6'h20 ? 5'h0 : rdReg; // @[Write_backer.scala 29:12 31:55 33:14]
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
  wire [6:0] _GEN_5 = 3'h2 == cnt3 ? io_xReg[11:5] : {{3'd0}, _GEN_4}; // @[DisplayMux.scala 29:16 32:25]
  wire [6:0] _GEN_6 = 3'h1 == cnt3 ? {{3'd0}, io_xReg[7:4]} : _GEN_5; // @[DisplayMux.scala 29:16 31:25]
  wire [6:0] _GEN_7 = 3'h0 == cnt3 ? {{3'd0}, io_xReg[3:0]} : _GEN_6; // @[DisplayMux.scala 29:16 30:25]
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
  assign dec_io_in = _GEN_7[3:0];
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
  output [7:0] io_an
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
  wire  fetcher_clock; // @[Food.scala 15:29]
  wire  fetcher_reset; // @[Food.scala 15:29]
  wire [31:0] fetcher_io_instruction; // @[Food.scala 15:29]
  wire [31:0] fetcher_io_branchIn; // @[Food.scala 15:29]
  wire  fetcher_io_shouldMux; // @[Food.scala 15:29]
  wire [31:0] fetcher_io_pcOut; // @[Food.scala 15:29]
  wire  fetcher_io_branchEnable; // @[Food.scala 15:29]
  wire  decoder_clock; // @[Food.scala 16:29]
  wire  decoder_reset; // @[Food.scala 16:29]
  wire [31:0] decoder_io_instruction; // @[Food.scala 16:29]
  wire [6:0] decoder_io_opcode; // @[Food.scala 16:29]
  wire [4:0] decoder_io_rdOutput; // @[Food.scala 16:29]
  wire [2:0] decoder_io_funct3; // @[Food.scala 16:29]
  wire [6:0] decoder_io_funct7; // @[Food.scala 16:29]
  wire [4:0] decoder_io_rs1; // @[Food.scala 16:29]
  wire [4:0] decoder_io_rs2; // @[Food.scala 16:29]
  wire [11:0] decoder_io_imm_I; // @[Food.scala 16:29]
  wire [11:0] decoder_io_imm_S; // @[Food.scala 16:29]
  wire [12:0] decoder_io_imm_B; // @[Food.scala 16:29]
  wire [31:0] decoder_io_imm_U; // @[Food.scala 16:29]
  wire [20:0] decoder_io_imm_J; // @[Food.scala 16:29]
  wire [31:0] decoder_io_pcIn; // @[Food.scala 16:29]
  wire [31:0] decoder_io_pcOut; // @[Food.scala 16:29]
  wire  decoder_io_shouldMux; // @[Food.scala 16:29]
  wire  executer_clock; // @[Food.scala 17:29]
  wire  executer_reset; // @[Food.scala 17:29]
  wire [6:0] executer_io_opcode; // @[Food.scala 17:29]
  wire [2:0] executer_io_funct3; // @[Food.scala 17:29]
  wire [6:0] executer_io_funct7; // @[Food.scala 17:29]
  wire [4:0] executer_io_rs1; // @[Food.scala 17:29]
  wire [4:0] executer_io_rs2; // @[Food.scala 17:29]
  wire [11:0] executer_io_imm_I; // @[Food.scala 17:29]
  wire [11:0] executer_io_imm_S; // @[Food.scala 17:29]
  wire [12:0] executer_io_imm_B; // @[Food.scala 17:29]
  wire [31:0] executer_io_imm_U; // @[Food.scala 17:29]
  wire [20:0] executer_io_imm_J; // @[Food.scala 17:29]
  wire [31:0] executer_io_imm; // @[Food.scala 17:29]
  wire [2:0] executer_io_funct3out; // @[Food.scala 17:29]
  wire [6:0] executer_io_funct7out; // @[Food.scala 17:29]
  wire [31:0] executer_io_x_0; // @[Food.scala 17:29]
  wire [31:0] executer_io_x_1; // @[Food.scala 17:29]
  wire [31:0] executer_io_x_2; // @[Food.scala 17:29]
  wire [31:0] executer_io_x_3; // @[Food.scala 17:29]
  wire [31:0] executer_io_x_4; // @[Food.scala 17:29]
  wire [31:0] executer_io_x_5; // @[Food.scala 17:29]
  wire [31:0] executer_io_x_6; // @[Food.scala 17:29]
  wire [31:0] executer_io_x_7; // @[Food.scala 17:29]
  wire [31:0] executer_io_x_8; // @[Food.scala 17:29]
  wire [31:0] executer_io_x_9; // @[Food.scala 17:29]
  wire [31:0] executer_io_x_10; // @[Food.scala 17:29]
  wire [31:0] executer_io_x_11; // @[Food.scala 17:29]
  wire [31:0] executer_io_x_12; // @[Food.scala 17:29]
  wire [31:0] executer_io_x_13; // @[Food.scala 17:29]
  wire [31:0] executer_io_x_14; // @[Food.scala 17:29]
  wire [31:0] executer_io_x_15; // @[Food.scala 17:29]
  wire [31:0] executer_io_x_16; // @[Food.scala 17:29]
  wire [31:0] executer_io_x_17; // @[Food.scala 17:29]
  wire [31:0] executer_io_x_18; // @[Food.scala 17:29]
  wire [31:0] executer_io_x_19; // @[Food.scala 17:29]
  wire [31:0] executer_io_x_20; // @[Food.scala 17:29]
  wire [31:0] executer_io_x_21; // @[Food.scala 17:29]
  wire [31:0] executer_io_x_22; // @[Food.scala 17:29]
  wire [31:0] executer_io_x_23; // @[Food.scala 17:29]
  wire [31:0] executer_io_x_24; // @[Food.scala 17:29]
  wire [31:0] executer_io_x_25; // @[Food.scala 17:29]
  wire [31:0] executer_io_x_26; // @[Food.scala 17:29]
  wire [31:0] executer_io_x_27; // @[Food.scala 17:29]
  wire [31:0] executer_io_x_28; // @[Food.scala 17:29]
  wire [31:0] executer_io_x_29; // @[Food.scala 17:29]
  wire [31:0] executer_io_x_30; // @[Food.scala 17:29]
  wire [31:0] executer_io_x_31; // @[Food.scala 17:29]
  wire [31:0] executer_io_ALUIn; // @[Food.scala 17:29]
  wire [3:0] executer_io_group; // @[Food.scala 17:29]
  wire [31:0] executer_io_operand1; // @[Food.scala 17:29]
  wire [31:0] executer_io_operand2; // @[Food.scala 17:29]
  wire [4:0] executer_io_rdLastRegMemIn; // @[Food.scala 17:29]
  wire [31:0] executer_io_aluLastRegMemIn; // @[Food.scala 17:29]
  wire [4:0] executer_io_rdLoadRegMemIn; // @[Food.scala 17:29]
  wire [31:0] executer_io_aluLoadRegMemIn; // @[Food.scala 17:29]
  wire  executer_io_loadEnable; // @[Food.scala 17:29]
  wire [31:0] executer_io_pcIn; // @[Food.scala 17:29]
  wire [31:0] executer_io_pcOut; // @[Food.scala 17:29]
  wire  ALU_clock; // @[Food.scala 18:29]
  wire [2:0] ALU_io_funct3; // @[Food.scala 18:29]
  wire [6:0] ALU_io_funct7; // @[Food.scala 18:29]
  wire [31:0] ALU_io_imm; // @[Food.scala 18:29]
  wire [31:0] ALU_io_pcIn; // @[Food.scala 18:29]
  wire [3:0] ALU_io_group; // @[Food.scala 18:29]
  wire [31:0] ALU_io_operand2; // @[Food.scala 18:29]
  wire [31:0] ALU_io_operand1; // @[Food.scala 18:29]
  wire [31:0] ALU_io_branchOut; // @[Food.scala 18:29]
  wire  ALU_io_branchEnable; // @[Food.scala 18:29]
  wire [31:0] ALU_io_ALUout; // @[Food.scala 18:29]
  wire [9:0] ALU_io_rdAddr; // @[Food.scala 18:29]
  wire [9:0] ALU_io_wrAddr; // @[Food.scala 18:29]
  wire  ALU_io_wrEna; // @[Food.scala 18:29]
  wire  ALU_io_rdEna; // @[Food.scala 18:29]
  wire [2:0] ALU_io_memOp; // @[Food.scala 18:29]
  wire [4:0] ALU_io_rdOut; // @[Food.scala 18:29]
  wire [4:0] ALU_io_rdIn; // @[Food.scala 18:29]
  wire  memorizer_clock; // @[Food.scala 19:29]
  wire  memorizer_reset; // @[Food.scala 19:29]
  wire [31:0] memorizer_io_ALUinput; // @[Food.scala 19:29]
  wire [4:0] memorizer_io_rdInput; // @[Food.scala 19:29]
  wire [9:0] memorizer_io_rdAddr; // @[Food.scala 19:29]
  wire [9:0] memorizer_io_wrAddr; // @[Food.scala 19:29]
  wire [31:0] memorizer_io_wrData; // @[Food.scala 19:29]
  wire  memorizer_io_wrEna; // @[Food.scala 19:29]
  wire  memorizer_io_rdEna; // @[Food.scala 19:29]
  wire [2:0] memorizer_io_memOp; // @[Food.scala 19:29]
  wire [4:0] memorizer_io_rdLastRegMemOut; // @[Food.scala 19:29]
  wire [31:0] memorizer_io_aluLastRegMemOut; // @[Food.scala 19:29]
  wire [4:0] memorizer_io_rdLoadRegMemOut; // @[Food.scala 19:29]
  wire [31:0] memorizer_io_aluLoadRegMemOut; // @[Food.scala 19:29]
  wire  memorizer_io_loadEnabler; // @[Food.scala 19:29]
  wire [31:0] memorizer_io_rdData; // @[Food.scala 19:29]
  wire  memorizer_io_rdEnaOut; // @[Food.scala 19:29]
  wire  memorizer_io_wrEnaOut; // @[Food.scala 19:29]
  wire [4:0] memorizer_io_rdOutput; // @[Food.scala 19:29]
  wire [31:0] memorizer_io_ALUoutput; // @[Food.scala 19:29]
  wire  write_backer_clock; // @[Food.scala 20:29]
  wire  write_backer_reset; // @[Food.scala 20:29]
  wire [31:0] write_backer_io_ALUinput; // @[Food.scala 20:29]
  wire [31:0] write_backer_io_ALUoutput; // @[Food.scala 20:29]
  wire [4:0] write_backer_io_rdInput; // @[Food.scala 20:29]
  wire [4:0] write_backer_io_rdOut; // @[Food.scala 20:29]
  wire  write_backer_io_rdEnaIn; // @[Food.scala 20:29]
  wire  write_backer_io_wrEnaIn; // @[Food.scala 20:29]
  wire [31:0] write_backer_io_rdData; // @[Food.scala 20:29]
  wire  Disp_clock; // @[Food.scala 21:20]
  wire  Disp_reset; // @[Food.scala 21:20]
  wire [31:0] Disp_io_xReg; // @[Food.scala 21:20]
  wire [6:0] Disp_io_seg; // @[Food.scala 21:20]
  wire [7:0] Disp_io_an; // @[Food.scala 21:20]
  reg [31:0] x_0; // @[Food.scala 14:18]
  reg [31:0] x_1; // @[Food.scala 14:18]
  reg [31:0] x_2; // @[Food.scala 14:18]
  reg [31:0] x_3; // @[Food.scala 14:18]
  reg [31:0] x_4; // @[Food.scala 14:18]
  reg [31:0] x_5; // @[Food.scala 14:18]
  reg [31:0] x_6; // @[Food.scala 14:18]
  reg [31:0] x_7; // @[Food.scala 14:18]
  reg [31:0] x_8; // @[Food.scala 14:18]
  reg [31:0] x_9; // @[Food.scala 14:18]
  reg [31:0] x_10; // @[Food.scala 14:18]
  reg [31:0] x_11; // @[Food.scala 14:18]
  reg [31:0] x_12; // @[Food.scala 14:18]
  reg [31:0] x_13; // @[Food.scala 14:18]
  reg [31:0] x_14; // @[Food.scala 14:18]
  reg [31:0] x_15; // @[Food.scala 14:18]
  reg [31:0] x_16; // @[Food.scala 14:18]
  reg [31:0] x_17; // @[Food.scala 14:18]
  reg [31:0] x_18; // @[Food.scala 14:18]
  reg [31:0] x_19; // @[Food.scala 14:18]
  reg [31:0] x_20; // @[Food.scala 14:18]
  reg [31:0] x_21; // @[Food.scala 14:18]
  reg [31:0] x_22; // @[Food.scala 14:18]
  reg [31:0] x_23; // @[Food.scala 14:18]
  reg [31:0] x_24; // @[Food.scala 14:18]
  reg [31:0] x_25; // @[Food.scala 14:18]
  reg [31:0] x_26; // @[Food.scala 14:18]
  reg [31:0] x_27; // @[Food.scala 14:18]
  reg [31:0] x_28; // @[Food.scala 14:18]
  reg [31:0] x_29; // @[Food.scala 14:18]
  reg [31:0] x_30; // @[Food.scala 14:18]
  reg [31:0] x_31; // @[Food.scala 14:18]
  wire [31:0] _x_write_backer_io_rdOut = write_backer_io_ALUoutput; // @[Food.scala 116:{28,28}]
  Fetcher fetcher ( // @[Food.scala 15:29]
    .clock(fetcher_clock),
    .reset(fetcher_reset),
    .io_instruction(fetcher_io_instruction),
    .io_branchIn(fetcher_io_branchIn),
    .io_shouldMux(fetcher_io_shouldMux),
    .io_pcOut(fetcher_io_pcOut),
    .io_branchEnable(fetcher_io_branchEnable)
  );
  Decoder decoder ( // @[Food.scala 16:29]
    .clock(decoder_clock),
    .reset(decoder_reset),
    .io_instruction(decoder_io_instruction),
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
  Executer executer ( // @[Food.scala 17:29]
    .clock(executer_clock),
    .reset(executer_reset),
    .io_opcode(executer_io_opcode),
    .io_funct3(executer_io_funct3),
    .io_funct7(executer_io_funct7),
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
  ALU ALU ( // @[Food.scala 18:29]
    .clock(ALU_clock),
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
  Memorizer memorizer ( // @[Food.scala 19:29]
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
  Write_backer write_backer ( // @[Food.scala 20:29]
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
  DisplayMux Disp ( // @[Food.scala 21:20]
    .clock(Disp_clock),
    .reset(Disp_reset),
    .io_xReg(Disp_io_xReg),
    .io_seg(Disp_io_seg),
    .io_an(Disp_io_an)
  );
  assign io_seg = Disp_io_seg; // @[Food.scala 112:10]
  assign io_an = Disp_io_an; // @[Food.scala 113:9]
  assign fetcher_clock = clock;
  assign fetcher_reset = reset;
  assign fetcher_io_branchIn = ALU_io_branchOut; // @[Food.scala 40:23]
  assign fetcher_io_shouldMux = decoder_io_shouldMux; // @[Food.scala 55:24]
  assign fetcher_io_branchEnable = ALU_io_branchEnable; // @[Food.scala 41:27]
  assign decoder_clock = clock;
  assign decoder_reset = reset;
  assign decoder_io_instruction = fetcher_io_instruction; // @[Food.scala 43:26]
  assign decoder_io_pcIn = fetcher_io_pcOut; // @[Food.scala 45:19]
  assign executer_clock = clock;
  assign executer_reset = reset;
  assign executer_io_opcode = decoder_io_opcode; // @[Food.scala 61:22]
  assign executer_io_funct3 = decoder_io_funct3; // @[Food.scala 70:22]
  assign executer_io_funct7 = decoder_io_funct7; // @[Food.scala 71:22]
  assign executer_io_rs1 = decoder_io_rs1; // @[Food.scala 63:19]
  assign executer_io_rs2 = decoder_io_rs2; // @[Food.scala 64:19]
  assign executer_io_imm_I = decoder_io_imm_I; // @[Food.scala 65:21]
  assign executer_io_imm_S = decoder_io_imm_S; // @[Food.scala 68:21]
  assign executer_io_imm_B = decoder_io_imm_B; // @[Food.scala 66:21]
  assign executer_io_imm_U = decoder_io_imm_U; // @[Food.scala 69:21]
  assign executer_io_imm_J = decoder_io_imm_J; // @[Food.scala 67:21]
  assign executer_io_x_0 = x_0; // @[Food.scala 60:17]
  assign executer_io_x_1 = x_1; // @[Food.scala 60:17]
  assign executer_io_x_2 = x_2; // @[Food.scala 60:17]
  assign executer_io_x_3 = x_3; // @[Food.scala 60:17]
  assign executer_io_x_4 = x_4; // @[Food.scala 60:17]
  assign executer_io_x_5 = x_5; // @[Food.scala 60:17]
  assign executer_io_x_6 = x_6; // @[Food.scala 60:17]
  assign executer_io_x_7 = x_7; // @[Food.scala 60:17]
  assign executer_io_x_8 = x_8; // @[Food.scala 60:17]
  assign executer_io_x_9 = x_9; // @[Food.scala 60:17]
  assign executer_io_x_10 = x_10; // @[Food.scala 60:17]
  assign executer_io_x_11 = x_11; // @[Food.scala 60:17]
  assign executer_io_x_12 = x_12; // @[Food.scala 60:17]
  assign executer_io_x_13 = x_13; // @[Food.scala 60:17]
  assign executer_io_x_14 = x_14; // @[Food.scala 60:17]
  assign executer_io_x_15 = x_15; // @[Food.scala 60:17]
  assign executer_io_x_16 = x_16; // @[Food.scala 60:17]
  assign executer_io_x_17 = x_17; // @[Food.scala 60:17]
  assign executer_io_x_18 = x_18; // @[Food.scala 60:17]
  assign executer_io_x_19 = x_19; // @[Food.scala 60:17]
  assign executer_io_x_20 = x_20; // @[Food.scala 60:17]
  assign executer_io_x_21 = x_21; // @[Food.scala 60:17]
  assign executer_io_x_22 = x_22; // @[Food.scala 60:17]
  assign executer_io_x_23 = x_23; // @[Food.scala 60:17]
  assign executer_io_x_24 = x_24; // @[Food.scala 60:17]
  assign executer_io_x_25 = x_25; // @[Food.scala 60:17]
  assign executer_io_x_26 = x_26; // @[Food.scala 60:17]
  assign executer_io_x_27 = x_27; // @[Food.scala 60:17]
  assign executer_io_x_28 = x_28; // @[Food.scala 60:17]
  assign executer_io_x_29 = x_29; // @[Food.scala 60:17]
  assign executer_io_x_30 = x_30; // @[Food.scala 60:17]
  assign executer_io_x_31 = x_31; // @[Food.scala 60:17]
  assign executer_io_ALUIn = ALU_io_ALUout; // @[Food.scala 91:21]
  assign executer_io_rdLastRegMemIn = memorizer_io_rdLastRegMemOut; // @[Food.scala 74:30]
  assign executer_io_aluLastRegMemIn = memorizer_io_aluLastRegMemOut; // @[Food.scala 76:31]
  assign executer_io_rdLoadRegMemIn = memorizer_io_rdLoadRegMemOut; // @[Food.scala 78:30]
  assign executer_io_aluLoadRegMemIn = memorizer_io_aluLoadRegMemOut; // @[Food.scala 79:31]
  assign executer_io_loadEnable = memorizer_io_loadEnabler; // @[Food.scala 80:26]
  assign executer_io_pcIn = decoder_io_pcOut; // @[Food.scala 46:20]
  assign ALU_clock = clock;
  assign ALU_io_funct3 = executer_io_funct3out; // @[Food.scala 82:17]
  assign ALU_io_funct7 = executer_io_funct7out; // @[Food.scala 83:17]
  assign ALU_io_imm = executer_io_imm; // @[Food.scala 88:14]
  assign ALU_io_pcIn = executer_io_pcOut; // @[Food.scala 84:15]
  assign ALU_io_group = executer_io_group; // @[Food.scala 85:16]
  assign ALU_io_operand2 = executer_io_operand2; // @[Food.scala 87:19]
  assign ALU_io_operand1 = executer_io_operand1; // @[Food.scala 86:19]
  assign ALU_io_rdIn = decoder_io_rdOutput; // @[Food.scala 62:15]
  assign memorizer_clock = clock;
  assign memorizer_reset = reset;
  assign memorizer_io_ALUinput = ALU_io_ALUout; // @[Food.scala 96:25]
  assign memorizer_io_rdInput = ALU_io_rdOut; // @[Food.scala 95:24]
  assign memorizer_io_rdAddr = ALU_io_rdAddr; // @[Food.scala 99:23]
  assign memorizer_io_wrAddr = ALU_io_wrAddr; // @[Food.scala 100:23]
  assign memorizer_io_wrData = ALU_io_ALUout; // @[Food.scala 101:40]
  assign memorizer_io_wrEna = ALU_io_wrEna; // @[Food.scala 98:22]
  assign memorizer_io_rdEna = ALU_io_rdEna; // @[Food.scala 97:22]
  assign memorizer_io_memOp = ALU_io_memOp; // @[Food.scala 94:22]
  assign write_backer_clock = clock;
  assign write_backer_reset = reset;
  assign write_backer_io_ALUinput = memorizer_io_ALUoutput; // @[Food.scala 107:28]
  assign write_backer_io_rdInput = memorizer_io_rdOutput; // @[Food.scala 106:27]
  assign write_backer_io_rdEnaIn = memorizer_io_rdEnaOut; // @[Food.scala 105:27]
  assign write_backer_io_wrEnaIn = memorizer_io_wrEnaOut; // @[Food.scala 108:27]
  assign write_backer_io_rdData = memorizer_io_rdData; // @[Food.scala 104:26]
  assign Disp_clock = clock;
  assign Disp_reset = reset;
  assign Disp_io_xReg = x_17; // @[Food.scala 111:16]
  always @(posedge clock) begin
    if (reset) begin // @[Food.scala 14:18]
      x_0 <= 32'sh0; // @[Food.scala 14:18]
    end else if (5'h0 == write_backer_io_rdOut) begin // @[Food.scala 116:28]
      x_0 <= _x_write_backer_io_rdOut; // @[Food.scala 116:28]
    end
    if (reset) begin // @[Food.scala 14:18]
      x_1 <= 32'sh0; // @[Food.scala 14:18]
    end else if (5'h1 == write_backer_io_rdOut) begin // @[Food.scala 116:28]
      x_1 <= _x_write_backer_io_rdOut; // @[Food.scala 116:28]
    end
    if (reset) begin // @[Food.scala 14:18]
      x_2 <= 32'sh0; // @[Food.scala 14:18]
    end else if (5'h2 == write_backer_io_rdOut) begin // @[Food.scala 116:28]
      x_2 <= _x_write_backer_io_rdOut; // @[Food.scala 116:28]
    end
    if (reset) begin // @[Food.scala 14:18]
      x_3 <= 32'sh0; // @[Food.scala 14:18]
    end else if (5'h3 == write_backer_io_rdOut) begin // @[Food.scala 116:28]
      x_3 <= _x_write_backer_io_rdOut; // @[Food.scala 116:28]
    end
    if (reset) begin // @[Food.scala 14:18]
      x_4 <= 32'sh0; // @[Food.scala 14:18]
    end else if (5'h4 == write_backer_io_rdOut) begin // @[Food.scala 116:28]
      x_4 <= _x_write_backer_io_rdOut; // @[Food.scala 116:28]
    end
    if (reset) begin // @[Food.scala 14:18]
      x_5 <= 32'sh0; // @[Food.scala 14:18]
    end else if (5'h5 == write_backer_io_rdOut) begin // @[Food.scala 116:28]
      x_5 <= _x_write_backer_io_rdOut; // @[Food.scala 116:28]
    end
    if (reset) begin // @[Food.scala 14:18]
      x_6 <= 32'sh0; // @[Food.scala 14:18]
    end else if (5'h6 == write_backer_io_rdOut) begin // @[Food.scala 116:28]
      x_6 <= _x_write_backer_io_rdOut; // @[Food.scala 116:28]
    end
    if (reset) begin // @[Food.scala 14:18]
      x_7 <= 32'sh0; // @[Food.scala 14:18]
    end else if (5'h7 == write_backer_io_rdOut) begin // @[Food.scala 116:28]
      x_7 <= _x_write_backer_io_rdOut; // @[Food.scala 116:28]
    end
    if (reset) begin // @[Food.scala 14:18]
      x_8 <= 32'sh0; // @[Food.scala 14:18]
    end else if (5'h8 == write_backer_io_rdOut) begin // @[Food.scala 116:28]
      x_8 <= _x_write_backer_io_rdOut; // @[Food.scala 116:28]
    end
    if (reset) begin // @[Food.scala 14:18]
      x_9 <= 32'sh0; // @[Food.scala 14:18]
    end else if (5'h9 == write_backer_io_rdOut) begin // @[Food.scala 116:28]
      x_9 <= _x_write_backer_io_rdOut; // @[Food.scala 116:28]
    end
    if (reset) begin // @[Food.scala 14:18]
      x_10 <= 32'sh0; // @[Food.scala 14:18]
    end else if (5'ha == write_backer_io_rdOut) begin // @[Food.scala 116:28]
      x_10 <= _x_write_backer_io_rdOut; // @[Food.scala 116:28]
    end
    if (reset) begin // @[Food.scala 14:18]
      x_11 <= 32'sh0; // @[Food.scala 14:18]
    end else if (5'hb == write_backer_io_rdOut) begin // @[Food.scala 116:28]
      x_11 <= _x_write_backer_io_rdOut; // @[Food.scala 116:28]
    end
    if (reset) begin // @[Food.scala 14:18]
      x_12 <= 32'sh0; // @[Food.scala 14:18]
    end else if (5'hc == write_backer_io_rdOut) begin // @[Food.scala 116:28]
      x_12 <= _x_write_backer_io_rdOut; // @[Food.scala 116:28]
    end
    if (reset) begin // @[Food.scala 14:18]
      x_13 <= 32'sh0; // @[Food.scala 14:18]
    end else if (5'hd == write_backer_io_rdOut) begin // @[Food.scala 116:28]
      x_13 <= _x_write_backer_io_rdOut; // @[Food.scala 116:28]
    end
    if (reset) begin // @[Food.scala 14:18]
      x_14 <= 32'sh0; // @[Food.scala 14:18]
    end else if (5'he == write_backer_io_rdOut) begin // @[Food.scala 116:28]
      x_14 <= _x_write_backer_io_rdOut; // @[Food.scala 116:28]
    end
    if (reset) begin // @[Food.scala 14:18]
      x_15 <= 32'sh0; // @[Food.scala 14:18]
    end else if (5'hf == write_backer_io_rdOut) begin // @[Food.scala 116:28]
      x_15 <= _x_write_backer_io_rdOut; // @[Food.scala 116:28]
    end
    if (reset) begin // @[Food.scala 14:18]
      x_16 <= 32'sh0; // @[Food.scala 14:18]
    end else if (5'h10 == write_backer_io_rdOut) begin // @[Food.scala 116:28]
      x_16 <= _x_write_backer_io_rdOut; // @[Food.scala 116:28]
    end
    if (reset) begin // @[Food.scala 14:18]
      x_17 <= 32'sh0; // @[Food.scala 14:18]
    end else if (5'h11 == write_backer_io_rdOut) begin // @[Food.scala 116:28]
      x_17 <= _x_write_backer_io_rdOut; // @[Food.scala 116:28]
    end else begin
      x_17 <= 32'shf; // @[Food.scala 110:9]
    end
    if (reset) begin // @[Food.scala 14:18]
      x_18 <= 32'sh0; // @[Food.scala 14:18]
    end else if (5'h12 == write_backer_io_rdOut) begin // @[Food.scala 116:28]
      x_18 <= _x_write_backer_io_rdOut; // @[Food.scala 116:28]
    end
    if (reset) begin // @[Food.scala 14:18]
      x_19 <= 32'sh0; // @[Food.scala 14:18]
    end else if (5'h13 == write_backer_io_rdOut) begin // @[Food.scala 116:28]
      x_19 <= _x_write_backer_io_rdOut; // @[Food.scala 116:28]
    end
    if (reset) begin // @[Food.scala 14:18]
      x_20 <= 32'sh0; // @[Food.scala 14:18]
    end else if (5'h14 == write_backer_io_rdOut) begin // @[Food.scala 116:28]
      x_20 <= _x_write_backer_io_rdOut; // @[Food.scala 116:28]
    end
    if (reset) begin // @[Food.scala 14:18]
      x_21 <= 32'sh0; // @[Food.scala 14:18]
    end else if (5'h15 == write_backer_io_rdOut) begin // @[Food.scala 116:28]
      x_21 <= _x_write_backer_io_rdOut; // @[Food.scala 116:28]
    end
    if (reset) begin // @[Food.scala 14:18]
      x_22 <= 32'sh0; // @[Food.scala 14:18]
    end else if (5'h16 == write_backer_io_rdOut) begin // @[Food.scala 116:28]
      x_22 <= _x_write_backer_io_rdOut; // @[Food.scala 116:28]
    end
    if (reset) begin // @[Food.scala 14:18]
      x_23 <= 32'sh0; // @[Food.scala 14:18]
    end else if (5'h17 == write_backer_io_rdOut) begin // @[Food.scala 116:28]
      x_23 <= _x_write_backer_io_rdOut; // @[Food.scala 116:28]
    end
    if (reset) begin // @[Food.scala 14:18]
      x_24 <= 32'sh0; // @[Food.scala 14:18]
    end else if (5'h18 == write_backer_io_rdOut) begin // @[Food.scala 116:28]
      x_24 <= _x_write_backer_io_rdOut; // @[Food.scala 116:28]
    end
    if (reset) begin // @[Food.scala 14:18]
      x_25 <= 32'sh0; // @[Food.scala 14:18]
    end else if (5'h19 == write_backer_io_rdOut) begin // @[Food.scala 116:28]
      x_25 <= _x_write_backer_io_rdOut; // @[Food.scala 116:28]
    end
    if (reset) begin // @[Food.scala 14:18]
      x_26 <= 32'sh0; // @[Food.scala 14:18]
    end else if (5'h1a == write_backer_io_rdOut) begin // @[Food.scala 116:28]
      x_26 <= _x_write_backer_io_rdOut; // @[Food.scala 116:28]
    end
    if (reset) begin // @[Food.scala 14:18]
      x_27 <= 32'sh0; // @[Food.scala 14:18]
    end else if (5'h1b == write_backer_io_rdOut) begin // @[Food.scala 116:28]
      x_27 <= _x_write_backer_io_rdOut; // @[Food.scala 116:28]
    end
    if (reset) begin // @[Food.scala 14:18]
      x_28 <= 32'sh0; // @[Food.scala 14:18]
    end else if (5'h1c == write_backer_io_rdOut) begin // @[Food.scala 116:28]
      x_28 <= _x_write_backer_io_rdOut; // @[Food.scala 116:28]
    end
    if (reset) begin // @[Food.scala 14:18]
      x_29 <= 32'sh0; // @[Food.scala 14:18]
    end else if (5'h1d == write_backer_io_rdOut) begin // @[Food.scala 116:28]
      x_29 <= _x_write_backer_io_rdOut; // @[Food.scala 116:28]
    end
    if (reset) begin // @[Food.scala 14:18]
      x_30 <= 32'sh0; // @[Food.scala 14:18]
    end else if (5'h1e == write_backer_io_rdOut) begin // @[Food.scala 116:28]
      x_30 <= _x_write_backer_io_rdOut; // @[Food.scala 116:28]
    end
    if (reset) begin // @[Food.scala 14:18]
      x_31 <= 32'sh0; // @[Food.scala 14:18]
    end else if (5'h1f == write_backer_io_rdOut) begin // @[Food.scala 116:28]
      x_31 <= _x_write_backer_io_rdOut; // @[Food.scala 116:28]
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
