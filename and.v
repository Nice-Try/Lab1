// Define gate delays
`define NAND nand #20 // 2 inputs
`define XOR xor #20 // 2 inputs

module full32BitAnd
(
  output[31:0] out,
  input[31:0] a,
  input[31:0] b,
  input andflag
);
  // Generate all the gates
  genvar i;
  generate
    for (i=0; i<32; i=i+1)
    begin:genblock
      wire _out;
      // NAND the inputs
      `NAND nandgate(_out, a[i], b[i]);
      // XOR with andflag: if andflag, out will be AND, otherwise out is NAND
      `XOR xorgate(out[i], _out, andflag);
    end
  endgenerate

endmodule
