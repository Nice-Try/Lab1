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
  wire [7:0] firstand;
  wire [3:0] firstor;
  wire [7:0] carryouts, overflowout;

  full32BitAdder adder (ADD, carryouts[0], overflowout[0], a, b, othercontrolsignal);
  full32BitAdder subber (SUB, carryouts[1], overflowout[1], a, b, othercontrolsignal);
  full32BitXor xormod (XOR, carryouts[2], overflowout[2], a, b);
  full32BitSLT slt (SLT, carryouts[3], overflowout[3], SUB, overflowout[0]);
  full32BitAnd andmod (AND, carryouts[4], overflowout[4], a, b, othercontrolsignal);
  full32BitAnd nandmod (NAND, carryouts[5], overflowout[5], a, b, othercontrolsignal);
  full32BitOr normod (NOR, carryouts[6], overflowout[6], a, b, othercontrolsignal);
  full32BitOr ormod (OR, carryouts[7], overflowout[7], a, b, othercontrolsignal);

  assign overflow = overflowout[muxindex]; //does this not count as structural? might need to change
  assign S0=muxindex[0]; assign S1=muxindex[1];assign S2=muxindex[2];

  not not1(nS0, S0);
  not not2(nS1, S1);
  not not3(nS2, S2);
  genvar i;
  generate
    for(i=0; i<32; i=i+1)
    begin:genblock
      // mux the results
      and andgate0(firstand[0], nS2, nS0, nS1, ADD[i]);
      and andgate1(firstand[1], nS2, S0, nS1, SUB[i]);
      and andgate2(firstand[2], nS2, nS0, S1, XOR[i]);
      and andgate3(firstand[3], nS2, S0, S1, SLT[i]);
      and andgate4(firstand[4], S2, nS0, nS1, AND[i]);
      and andgate5(firstand[5], S2, S0, nS1, NAND[i]);
      and andgate6(firstand[6], S2, nS0, S1, NOR[i]);
      and andgate7(firstand[7], S2, S0, S1, OR[i]);

      // or all of the results
      or orgate(result[i], firstand[0], firstand[1], firstand[2], firstand[3], firstand[4], firstand[5], firstand[6], firstand[7]);      
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
