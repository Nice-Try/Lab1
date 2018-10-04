// Define gate delays
`define NOR nor #20 // 2 inputs

module full32BitNor
(
  output[31:0] out,
  input[31:0] a,
  input[31:0] b
);
  // Generate all the gates
  genvar i;
  generate
    for (i=0; i<32; i=i+1)
    begin:genblock
      // NOR the inputs
      `NOR(out[i], a[i], b[i]);
    end
  endgenerate

endmodule
