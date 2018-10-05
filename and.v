// Define gate delays
`define NAND nand #20 // 2 inputs
`define XNOR xnor #30 // XOR/XNOR gates are weird so I'm just gonna call it 30...

module full32BitAnd
(
  output[31:0] out,
  output carryout,
  output overflow,
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
      // OR with andflag: if andflag, out will be NAND, otherwise out is AND
      `XNOR xnorgate(out[i], _out, andflag);
    end
  endgenerate

endmodule
