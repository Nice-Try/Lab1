// Define gate delays
`define NOR nor #20 // 2 inputs
`define XOR xor #20 // 2 inputs

module full32BitOr
(
  output[31:0] out,
  output carryout,
  output overflow,
  input[31:0] a,
  input[31:0] b,
  input orflag
);
  assign carryout = 0;
  assign overflow = 0;
  // Generate all the gates
  genvar i;
  generate
    for (i=0; i<32; i=i+1)
    begin:genblock
      wire _out;
      // NOR the inputs
      `NOR(_out, a[i], b[i]);
      // XOR with andflag: if andflag, out will be AND, otherwise out is NAND
      `XOR(out[i], _out, orflag);
    end
  endgenerate

endmodule
