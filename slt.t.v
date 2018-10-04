`include "slt.v"

module testSLT();
  reg signed [31:0] a, b;
  wire lessthan;
  wire signed [31:0] sum;
  wire carryout, overflow;
  reg dutpassed;
  reg subtract = 1;

  full32BitAdder adder (sum, carryout, overflow, a, b, subtract);
  SLT setlessthan(lessthan, sum, overflow);

  initial begin
  dutpassed = 1;

  //test cases in the form a_sign | b_sign | result
  a=-32'd2147483648; b=32'd5; #2000
  if (lessthan !== 1) begin
    dutpassed = 0;
    $display("Actual:   %b", sum);
    $display("Failed Test Case 01: -+ Overflow True");
    $display("%b %b 1 %b", a,b,lessthan);
    end

  a=32'd2147483642; b=-32'd5; #2000
  if (lessthan !== 0) begin
      dutpassed = 0;
      $display("Actual:   %b", sum);
      $display("Failed Test Case 02: +- Overflow False");
      $display("%b %b 0 %b", a,b,lessthan);
      end

  a=32'd8; b=32'd3; #2000
  if (lessthan !== 0) begin
    dutpassed = 0;
    $display("Actual:   %b", sum);
    $display("Failed Test Case 1: ++ False");
    $display("%b %b 0 %b", a,b,lessthan);
  end

  a=32'd2; b=32'd3; #2000
  if (lessthan !== 1) begin
    dutpassed = 0;
    $display("Failed Test Case 2: ++ True");
    $display("%b %b 1 %b", a,b,lessthan);
  end

  a=32'd5;b=-32'd3; #2000
  if (lessthan !== 0) begin
    dutpassed = 0;
    $display("Failed Test Case 3: +- False");
    $display("%b %b 0 %b", a,b,lessthan);
  end

  a=32'd0;b=-32'd6;#2000
  if (lessthan !== 0) begin
    dutpassed = 0;
    $display("Failed Test Case 4: +- False");
    $display("%b %b 0 %b", a,b,lessthan);
  end

  a=-32'd3;b=-32'd8;#2000
  if (lessthan !== 0) begin
    dutpassed = 0;
    $display("Failed Test Case 5: -- False");
    $display("%b %b 0 %b", a,b,lessthan);
  end

  a=-32'd8;b=-32'd3;#2000
  if (lessthan !== 1) begin
    dutpassed = 0;
    $display("Failed Test Case 6: -- True");
    $display("%b %b 1 %b", a,b,lessthan);
  end

  a=-32'd3;b=32'd2;#2000
  if (lessthan !== 1) begin
    dutpassed = 0;
    $display("Failed Test Case 7: -+ True");
    $display("%b %b 1 %b", a,b,lessthan);
  end

  a=-32'd8;b=32'd3;#2000
  if (lessthan !== 1) begin
    dutpassed = 0;
    $display("Failed Test Case 8: -+1 True");
    $display("%b %b 1 %b", a,b,lessthan);
  end

  a=32'd2;b=32'd2;#2000
  if (lessthan !== 0) begin
    dutpassed = 0;
    $display("Failed Test Case 9: same+ False");
    $display("%b %b 0 %b", a,b,lessthan);
  end

  a=-32'd4;b=-32'd4;#1000
  if (lessthan !== 0) begin
    dutpassed = 0;
    $display("Failed Test Case 10: same- False");
    $display("%b %b 0 %b %b", a,b,lessthan, overflow);
  end

  if(dutpassed==1)
    $display("All 10 Tests Passed.");

  end

  endmodule
