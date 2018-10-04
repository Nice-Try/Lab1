`include "slt.v"
`timescale 1 ns / 1 ps

module testSLT();
  reg[31:0] a, b;
  wire lessthan;
  wire[31:0] sum;
  wire carryout, overflow;
  reg dutpassed;

  SLT setlessthan(lessthan, a, b);
  full32BitAdder testadder(sum, carryout, overflow, a, b, 1'b1);

  initial begin
  dutpassed = 1;

  //test cases in the form a_sign | b_sign | overflow   result

  a=32'd8; b=32'd3; #1000
  if (lessthan !== 0) begin
    dutpassed = 0;
    $display("Failed Test Case 1: ++0 False");
    $display("%b %b 0 %b %b", a,b,lessthan, sum);
  end

  a=32'd2; b=32'd3; #1000
  if (lessthan !== 1) begin
    dutpassed = 0;
    $display("Failed Test Case 1: ++0 True");
    $display("%b %b 1 %b %b", a,b,lessthan, sum);
  end

  a=32'd5;b=-32'd3; #1000
  if (lessthan !== 0) begin
    dutpassed = 0;
    $display("Failed Test Case 2: +-1 False");
    $display("%b %b 0 %b", a,b,lessthan);
  end

  a=32'd0;b=-32'd6;#1000
  if (lessthan !== 0) begin
    dutpassed = 0;
    $display("Failed Test Case 3: +-0 False");
    $display("%b %b 0 %b", a,b,lessthan);
  end

  a=-32'd3;b=-32'd8;#1000
  if (lessthan !== 0) begin
    dutpassed = 0;
    $display("Failed Test Case 4: --0 False");
    $display("%b %b 0 %b", a,b,lessthan);
  end

  a=-32'd8;b=-32'd3;#1000
  if (lessthan !== 1) begin
    dutpassed = 0;
    $display("Failed Test Case 4: --0 True");
    $display("%b %b 1 %b", a,b,lessthan);
  end

  a=-32'd3;b=32'd2;#1000
  if (lessthan !== 1) begin
    dutpassed = 0;
    $display("Failed Test Case 5: -+0 True");
    $display("%b %b 1 %b", a,b,lessthan);
  end

  a=-32'd8;b=32'd3;#1000
  if (lessthan !== 1) begin
    dutpassed = 0;
    $display("Failed Test Case 6: -+1 True");
    $display("%b %b 1 %b", a,b,lessthan);
  end

  a=32'd2;b=32'd2;#1000
  if (lessthan !== 0) begin
    dutpassed = 0;
    $display("Failed Test Case 7: same+ False");
    $display("%b %b 0 %b", a,b,lessthan);
  end

  a=-32'd4;b=-32'd4;#1000
  if (lessthan !== 0) begin
    dutpassed = 0;
    $display("Failed Test Case 8: same- False");
    $display("%b %b 0 %b", a,b,lessthan);
  end

  if(dutpassed==1)
    $display("All 8 Tests Passed.");

  end
  endmodule
