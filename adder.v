// Define gate delays
`define AND and #30 // 2 inputs, then 1 inverter
`define OR or #30 // 2 inputs, then 1 inverter
`define XOR xor #20 // 2 inputs

module bitsliceAdder
/*
  This is a bitslice of an adder. It cannot complete accurate subtraction on its
  own.
  TODO: figure out how best to define timing on gates
*/
(
  output sum,
  output carryout,
  input a,
  input b,
  input carryin,
  input subtract
);
  wire xorAout, xorCout, andAout, andBout;

  `XOR xorC(xorCout, b, subtract);
  `XOR xorA(xorAout, a, xorCout);
  `AND andA(andAout, a, xorCout);
  `XOR xorB(sum, xorAout, carryin);
  `AND andB(andBout, xorAout, carryin);
  `OR orgate(carryout, andAout, andBout);
endmodule

module twoBitAdder
(
  output[1:0] sum,
  output carryout,
  output overflow,
  input[1:0] a,
  input[1:0] b,
  input subtract
  );

  wire carryout0;

  bitsliceAdder adder0(sum[0], carryout0, a[0], b[0], subtract, subtract);
  bitsliceAdder adder1(sum[1], carryout, a[1], b[1], subtract, carryout0);

  // Calculate overflow
  `XOR xorgate(overflow, carryout, carryout0);

endmodule

module FullAdder4bit
(
  output[3:0] sum,  // 2's complement sum of a and b
  output carryout,  // Carry out of the summation of a and b
  output overflow,  // True if the calculation resulted in an overflow
  input[3:0] a,     // First operand in 2's complement format
  input[3:0] b,      // Second operand in 2's complement format
  input subtract
);
  wire carryout0, carryout1, carryout2, carryout3;
  // reg carryin = 0;

  bitsliceAdder adder0 (sum[0], carryout0, a[0], b[0], subtract, subtract);
  bitsliceAdder adder1 (sum[1], carryout1, a[1], b[1], subtract, carryout0);
  bitsliceAdder adder2 (sum[2], carryout2, a[2], b[2], subtract, carryout1);
  bitsliceAdder adder3 (sum[3], carryout, a[3], b[3], subtract, carryout2);

  `XOR xorgate(overflow, carryout, carryout2);

  endmodule


module full32BitAdder
/*
  Some description
*/
(
  output[31:0] sum,
  output carryout,
  output overflow,
  input[31:0] a,
  input[31:0] b,
  input subtract
);
  wire carryouts[30:0];

  // Generate the first adder, because its carryin should be subtract
  bitsliceAdder adder0(sum[0], carryouts[0], a[0], b[0], subtract, subtract);

  // Generate adders 0-31
  genvar i;
  generate
    for (i=1; i<31; i=i+1)
    begin:genblock
      bitsliceAdder adder(sum[i], carryouts[i], a[i], b[i], carryouts[i-1], subtract);
    end
  endgenerate

  // Generate the last (31st) adder for the right variable name on carryout
  bitsliceAdder adder31(sum[31], carryout, a[31], b[31], carryouts[30], subtract);

  // Calculate overflow
  `XOR xorgate(overflow, carryout, carryouts[30]);
endmodule
