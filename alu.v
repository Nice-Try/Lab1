`include "and.v"
`include "or.v"
`include "slt.v"
`include "xor.v"
`include "adder.v"

`define ADDMODULE  3'd0
`define SUBMODULE  3'd1
`define XORMODULE  3'd2
`define SLTMODULE  3'd3
`define ANDMODULE  3'd4
`define NANDMODULE 3'd5
`define NORMODULE  3'd6
`define ORMODULE   3'd7

`define ANDGATE and #50 // 4 inputs, 1 inverter
`define ORGATE or #90 // 8 inputs, 1 inverter
`define NOT not #10 // 1 inverter

module ALUcontrolLUT
(
output reg[2:0] 	muxindex,
output reg	othercontrolsignal,
input[2:0]	ALUcommand
);

  always @(ALUcommand) begin
    case (ALUcommand)
      `ADDMODULE:  begin muxindex = 0; othercontrolsignal = 0; end
      `SUBMODULE:  begin muxindex = 1; othercontrolsignal = 1; end
      `XORMODULE:  begin muxindex = 2; othercontrolsignal = 0; end
      `SLTMODULE:  begin muxindex = 3; othercontrolsignal = 1; end
      `ANDMODULE:  begin muxindex = 4; othercontrolsignal = 0; end
      `NANDMODULE: begin muxindex = 5; othercontrolsignal = 1; end
      `NORMODULE:  begin muxindex = 6; othercontrolsignal = 0; end
      `ORMODULE:   begin muxindex = 7; othercontrolsignal = 1; end
    endcase
  end
endmodule

module MUX
(
  output[31:0] result,
  output carryout,
  output zero,
  output overflow,
  input[2:0] muxindex,
  input othercontrolsignal,
  input[31:0] a,
  input[31:0] b
  );
  wire[31:0] ADDMODULE, SUBMODULE, XORMODULE, SLTMODULE, ANDMODULE, NANDMODULE, NORMODULE, ORMODULE; //each operation output
  wire S0,S1,S2, nS0, nS1, nS2; //select bits
  wire [7:0] carryouts, overflowout, zeros;

  full32BitAdder adder (ADDMODULE, zeros[0], carryouts[0], overflowout[0], a, b, othercontrolsignal);
  full32BitAdder subber (SUBMODULE, zeros[1], carryouts[1], overflowout[1], a, b, othercontrolsignal);
  full32BitXor xormod (XORMODULE, zeros[2], carryouts[2], overflowout[2], a, b);
  full32BitSLT slt (SLTMODULE, zeros[3], carryouts[3], overflowout[3], SUBMODULE, overflowout[1]);
  full32BitAnd andmod (ANDMODULE, zeros[4], carryouts[4], overflowout[4], a, b, othercontrolsignal);
  full32BitAnd nandmod (NANDMODULE, zeros[5], carryouts[5], overflowout[5], a, b, othercontrolsignal);
  full32BitOr normod (NORMODULE, zeros[6], carryouts[6], overflowout[6], a, b, othercontrolsignal);
  full32BitOr ormod (ORMODULE, zeros[7], carryouts[7], overflowout[7], a, b, othercontrolsignal);

  assign overflow = overflowout[muxindex];
  assign carryout = carryouts[muxindex];
  assign zero = zeros[muxindex];
  assign S0=muxindex[0]; assign S1=muxindex[1];assign S2=muxindex[2];

  `NOT not1(nS0, S0);
  `NOT not2(nS1, S1);
  `NOT not3(nS2, S2);
  genvar i;
  generate
    for(i=0; i<32; i=i+1)
    begin:genblock
      // mux the results
      wire [7:0] resultand;
      `ANDGATE(resultand[0], nS2, nS0, nS1, ADDMODULE[i]);
      `ANDGATE(resultand[1], nS2, S0, nS1, SUBMODULE[i]);
      `ANDGATE(resultand[2], nS2, nS0, S1, XORMODULE[i]);
      `ANDGATE(resultand[3], nS2, S0, S1, SLTMODULE[i]);
      `ANDGATE(resultand[4], S2, nS0, nS1, ANDMODULE[i]);
      `ANDGATE(resultand[5], S2, S0, nS1, NANDMODULE[i]);
      `ANDGATE(resultand[6], S2, nS0, S1, NORMODULE[i]);
      `ANDGATE(resultand[7], S2, S0, S1, ORMODULE[i]);

      // or all of the results
      `ORGATE(result[i], resultand[0], resultand[1], resultand[2], resultand[3], resultand[4], resultand[5], resultand[6], resultand[7]);
    end
  endgenerate

endmodule

module ALU
(
output[31:0]  result,
output        carryout,
output        zero,
output        overflow,
input[31:0]   operandA,
input[31:0]   operandB,
input[2:0]    command
);
  wire[2:0] muxindex;
  wire othercontrolsignal;

	ALUcontrolLUT lut (muxindex, othercontrolsignal, command);
  MUX mux1 (result, carryout, zero, overflow, muxindex, othercontrolsignal, operandA, operandB);

endmodule
