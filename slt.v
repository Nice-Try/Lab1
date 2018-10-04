`include "adder.v"
`define XOR xor #20 // 2 inputs so delay 20

module SLT
(
  output less,
  input signed [31:0] sum,
  input overflow
  );

  wire overflow, carryout;
  and andgate(less, 1'b1, sum[31]); //output is just sign of sum[31]

endmodule
