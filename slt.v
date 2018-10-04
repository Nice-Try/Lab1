`include "adder.v"
`define XOR xor #20 // 2 inputs so delay 20

module SLT
(
  output less,
  input signed [31:0] sum,
  input overflow
  );

  wire overflow, carryout;
  xor xorgate(less, overflow, sum[31]); //output is just sign of sum[31]


endmodule
