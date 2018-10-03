`include "slt.v"
`timescale 1 ns / ps

module testSLT();
  reg[31:0] a, b;
  reg lessthan;
  wire[31:0] sum;
  wire carryout, overflow;

  SLT setlessthan(lessthan, overflow, a, b);

  initial begin

  /*Test Cases: a b overflow
  ++T
  ++F
  --T
  --F
  +-T
  +-F
  -+T
  -+F
