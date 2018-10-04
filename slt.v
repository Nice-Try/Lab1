`include "adder.v"
`define XOR xor #20 // 2 inputs so delay 20

module SLT
(
  output less,
  input[31:0] a,
  input[31:0] b
  );

  wire overflow, carryout;
  wire[31:0] sum;

  //subtract A-B
  full32BitAdder subtract(.a(a), .b(b), .subtract(1'b1), .overflow(overflow), .sum(sum), .carryout(carryout));
  `XOR xorgate(less, overflow, sum[31]);
  //if negative & no overflow = 1, if overflow & neg = 0, overflow & pos = 1

endmodule
