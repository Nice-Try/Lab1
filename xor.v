// Define gate delays
`define XOR xor #20 // 2 inputs

module full32BitXor
(
  output[31:0] out,
  output carryout,
  output overflow,
  input[31:0] a,
  input[31:0] b
);
  assign carryout = 0;
  assign overflow = 0;
  // Generate all the gates
  genvar i;
  generate
    for (i=0; i<32; i=i+1)
    begin:genblock
      // XOR the inputs
      `XOR(out[i], a[i], b[i]);
    end
  endgenerate

endmodule
