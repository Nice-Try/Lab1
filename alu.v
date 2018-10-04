module ALUcontrolLUT
(
output reg[2:0] 	muxindex,
output reg	othercontrolsignal
input[2:0]	ALUcommand
)

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
  output result,
  output carryout,
  output zero,
  output overflow,
  input[2:0] muxindex,
  input othercontrolsignal,
  input[31:0] a,
  input[31:0] b
  );
  // TODO: Make the MUX
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

	ALUcontrolLUT lut (muxindex, othercontrolsignal, command);
  MUX mux1 (result, carryout, zero, overflow, muxindex, othecontrolsignal, a, b;

endmodule
