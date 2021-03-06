// Define gate delays
`define NAND nand #20 // 2 inputs
`define XNOR xnor #20 // 2 inputs

module full32BitAnd
(
  output[31:0] out,
  output zero,
  output carryout,
  output overflow,
  input[31:0] a,
  input[31:0] b,
  input andflag
);
  reg zero = 0;
  reg carryout = 0;
  reg overflow = 0;
  // Generate all the gates
  genvar i;
  generate
    for (i=0; i<32; i=i+1)
    begin:genblock
      wire _out;
      // NAND the inputs
      `NAND nandgate(_out, a[i], b[i]);
      // OR with andflag: if andflag, out will be NAND, otherwise out is AND
      `XNOR xnorgate(out[i], _out, andflag);
    end
  endgenerate

endmodule
