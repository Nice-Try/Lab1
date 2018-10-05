`include "and.v"
`include "or.v"
`include "slt.v"
`include "xor.v"
`include "adder.v"

`define ADD  3'd0
`define SUB  3'd1
`define XOR  3'd2
`define SLT  3'd3
`define AND  3'd4
`define NAND 3'd5
`define NOR  3'd6
`define OR   3'd7

module ALUcontrolLUT
(
output reg[2:0] 	muxindex,
output reg	othercontrolsignal,
input[2:0]	ALUcommand
);

  always @(ALUcommand) begin
    case (ALUcommand)
      `ADD:  begin muxindex = 0; othercontrolsignal = 0; end
      `SUB:  begin muxindex = 0; othercontrolsignal = 1; end
      `XOR:  begin muxindex = 1; othercontrolsignal = 0; end
      `SLT:  begin muxindex = 2; othercontrolsignal = 0; end
      `AND:  begin muxindex = 3; othercontrolsignal = 0; end
      `NAND: begin muxindex = 3; othercontrolsignal = 1; end
      `NOR:  begin muxindex = 4; othercontrolsignal = 1; end
      `OR:   begin muxindex = 4; othercontrolsignal = 0; end
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
  wire[31:0] ADD, SUB, XOR, SLT, AND, NAND, NOR, OR; //each operation output
  wire S0,S1,S2, nS0, nS1, nS2; //select bits
  wire andOut0, andOut1, andOut2, andOut3, andOut4, andOut5, andOut6, andOut7;
  wire [7:0] carryout, overflowout;

  full32BitAdder adder (ADD, carryout[0], overflowout[0], a, b, othercontrolsignal);
  full32BitAdder subber (SUB, carryout[1], overflowout[1], a, b, othercontrolsignal);
  full32BitXor xormod (XOR, carryout[2], overflowout[2], a, b);
  full32BitSLT slt (SLT, carryout[3], overflowout[3], SUB, overflow[0]);
  full32BitAnd andmod (AND, carryout[4], overflowout[4], a, b, othercontrolsignal);
  full32BitAnd nandmod (NAND, carryout[5], overflowout[5], a, b, othercontrolsignal);
  full32BitOr normod (NOR, carryout[6], overflowout[6], a, b, othercontrolsignal);
  full32BitOr ormod (OR, carryout[7], overflowout[7], a, b, othercontrolsignal);

  assign overflow = overflowout[muxindex]; //does this not count as structural? might need to change
  assign S0=muxindex[0]; assign S1=muxindex[1];assign S2=muxindex[2];

    for(i=0; i<32; i=1+1) begin
    not not1(nS0, S0);
    not not2(nS1, S1);
    not not3(nS2, S2);
    and andgate0(andOut0, nS2, nS1, nS0);
    and andgate1(andOut1, nS2, nS1, S0);

    //or orgate(result[i], andOut0, andOut1, andOut2, andOut3, andOut4, andOut5, andOut6, andOut7);
    end

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
