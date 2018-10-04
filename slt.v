`include "adder.v"
`define XOR xor #20 // 2 inputs

module SLT
(
  output less,
  output overflow, //this isn't necessary I just want to see it
  input[31:0] a,
  input[31:0] b
  );

  wire overflow, carryout;
  wire[31:0] sum;

  //subtract A-B
  full32BitAdder subtract(.a(a), .b(b), .subtract(1'b1), .overflow(overflow), .sum(sum), .carryout(carryout));
  `XOR xorgate(sum[31], overflow, less);
  //if negative & no overflow = 1, if overflow & neg = 0, overflow & pos = 1

endmodule
