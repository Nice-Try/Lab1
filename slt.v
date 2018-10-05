`define XOR xor #20 // 2 inputs so delay 20

module full32BitSLT
(
  output [31:0]less,
  output carryout,
  output overflow,
  input signed [31:0] sum,
  input overflowin
  );
  
  wire overflow, carryout;
  xor xorgate(less[0], overflowin, sum[31]); //output is just sign of sum[31]
  assign carryout = 0;
  assign overflow = 0;

endmodule
