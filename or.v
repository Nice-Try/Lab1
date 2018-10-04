// Define gate delays
`define OR or #30 // 2 inputs, and inverter

module full32BitOr
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
      // OR the inputs
      `OR(out[i], a[i], b[i]);
    end
  endgenerate

endmodule
