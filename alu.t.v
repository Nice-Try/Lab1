`include "alu.v"

module testALU();
  reg signed [31:0] a, b;
  reg [2:0] control;
  reg dutpassed;
  wire lessthan;
  wire signed [31:0] result;
  wire carryout, overflow, zero;

  ALU dut (result, carryout, zero, overflow, a, b, control);

  initial begin
  dutpassed =1;

  $display("-----Count-----");

  // A+, B+, no carryout, no overflow
  a=30000;b=30000; #10000
  $display("a = %b  b = %b",a,b);
  control=3'b000; #200000 //ADD
  if(result !== a+b) begin
    dutpassed = 0;
    $display("Failed adding:");
    $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a+b);
  end

  control=3'b001; #200000//SUB
  if(result !== a-b) begin
    dutpassed = 0;
    $display("Failed Subtracting:");
    $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a-b);
  end

  control=3'b010; #200000//XOR
  if(result !== a^b) begin
    dutpassed = 0;
    $display("Failed XOR:");
    $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a^b);
  end

  control=3'b011; #200000//SLT
  if(result !== a<b) begin
    dutpassed = 0;
    $display("Failed SLT:");
    $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a<b);
  end

  control=3'b100; #200000//AND
  if(result !== a&b) begin
    dutpassed = 0;
    $display("Failed AND:");
    $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a&b);
  end

  control=3'b101; #200000//NAND
  if(result !== ~a&b) begin //need to make NAND
    dutpassed = 0;
    $display("Failed NAND:");
    $display("a = %b  b = %b   result = %b  expected %b", a,b,result,~a&b);
  end

  control=3'b110; #200000//NOR
  if(result !== a|b) begin
    dutpassed = 0;
    $display("Failed NOR:");
    $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a|b);
  end

  control=3'b111; #200000//OR
  if(result !== ~a|b) begin // need to make NOR
    dutpassed = 0;
    $display("Failed OR:");
    $display("a = %b  b = %b   result = %b  expected %b", a,b,result,~a|b);
  end

  $display("-----Count-----");


  // A+, B-, carryout, no overflow
  a=2147483647;b=-2147483647; #10000
  $display("a = %b  b = %b",a,b);
  control=3'b000; #200000 //ADD
  if(result !== a+b) begin
    dutpassed = 0;
    $display("Failed adding:");
    $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a+b);
  end

  control=3'b001; #200000//SUB
  if(result !== a-b) begin
    dutpassed = 0;
    $display("Failed Subtracting:");
    $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a-b);
  end

  control=3'b010; #200000//XOR
  if(result !== a^b) begin
    dutpassed = 0;
    $display("Failed XOR:");
    $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a^b);
  end

  control=3'b011; #200000//SLT
  if(result !== a<b) begin
    dutpassed = 0;
    $display("Failed SLT:");
    $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a<b);
  end

  control=3'b100; #200000//AND
  if(result !== a&b) begin
    dutpassed = 0;
    $display("Failed AND:");
    $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a&b);
  end

  control=3'b101; #200000//NAND
  if(result !== a&b) begin //need to make NAND
    dutpassed = 0;
    $display("Failed NAND:");
    $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a&b);
  end

  control=3'b110; #200000//NOR
  if(result !== a|b) begin
    dutpassed = 0;
    $display("Failed NOR:");
    $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a|b);
  end

  control=3'b111; #200000//OR
  if(result !== a|b) begin // need to make NOR
    dutpassed = 0;
    $display("Failed OR:");
    $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a|b);
  end

  $display("-----Count-----");

  // A-, B-, carryout, no overflow
  a=-650;b=-5001; #10000
  $display("a = %b  b = %b",a,b);
  control=3'b000; #200000 //ADD
  if(result !== a+b) begin
    dutpassed = 0;
    $display("Failed adding:");
    $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a+b);
  end

  control=3'b001; #200000//SUB
  if(result !== a-b) begin
    dutpassed = 0;
    $display("Failed Subtracting:");
    $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a-b);
  end

  control=3'b010; #200000//XOR
  if(result !== a^b) begin
    dutpassed = 0;
    $display("Failed XOR:");
    $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a^b);
  end

  control=3'b011; #200000//SLT
  if(result !== a<b) begin
    dutpassed = 0;
    $display("Failed SLT:");
    $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a<b);
  end

  control=3'b100; #200000//AND
  if(result !== a&b) begin
    dutpassed = 0;
    $display("Failed AND:");
    $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a&b);
  end

  control=3'b101; #200000//NAND
  if(result !== a&b) begin //need to make NAND
    dutpassed = 0;
    $display("Failed NAND:");
    $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a&b);
  end

  control=3'b110; #200000//NOR
  if(result !== a|b) begin
    dutpassed = 0;
    $display("Failed NOR:");
    $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a|b);
  end

  control=3'b111; #200000//OR
  if(result !== a|b) begin // need to make NOR
    dutpassed = 0;
    $display("Failed OR:");
    $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a|b);
  end

  $display("-----Count-----");

  // A-, B-, carryout, overflow
  a=-1500000000;b=-2000000000;
  $display("a = %b  b = %b",a,b);
  control=3'b000; #200000 //ADD
  if(result !== a+b) begin
    dutpassed = 0;
    $display("Failed adding:");
    $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a+b);
  end

  control=3'b001; #200000//SUB
  if(result !== a-b) begin
    dutpassed = 0;
    $display("Failed Subtracting:");
    $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a-b);
  end

  control=3'b010; #200000//XOR
  if(result !== a^b) begin
    dutpassed = 0;
    $display("Failed XOR:");
    $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a^b);
  end

  control=3'b011; #200000//SLT
  if(result !== a<b) begin
    dutpassed = 0;
    $display("Failed SLT:");
    $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a<b);
  end

  control=3'b100; #200000//AND
  if(result !== a&b) begin
    dutpassed = 0;
    $display("Failed AND:");
    $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a&b);
  end

  control=3'b101; #200000//NAND
  if(result !== a&b) begin //need to make NAND
    dutpassed = 0;
    $display("Failed NAND:");
    $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a&b);
  end

  control=3'b110; #200000//NOR
  if(result !== a|b) begin
    dutpassed = 0;
    $display("Failed NOR:");
    $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a|b);
  end

  control=3'b111; #200000//OR
  if(result !== a|b) begin // need to make NOR
    dutpassed = 0;
    $display("Failed OR:");
    $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a|b);
  end

  $display("-----Count-----");

  // A-, B+, carryout, no overflow
  a=-36;b=1073741824; #10000
  $display("a = %b  b = %b",a,b);
  control=3'b000; #200000 //ADD
  if(result !== a+b) begin
    dutpassed = 0;
    $display("Failed adding:");
    $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a+b);
  end

  control=3'b001; #200000//SUB
  if(result !== a-b) begin
    dutpassed = 0;
    $display("Failed Subtracting:");
    $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a-b);
  end

  control=3'b010; #200000//XOR
  if(result !== a^b) begin
    dutpassed = 0;
    $display("Failed XOR:");
    $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a^b);
  end

  control=3'b011; #200000//SLT
  if(result !== a<b) begin
    dutpassed = 0;
    $display("Failed SLT:");
    $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a<b);
  end

  control=3'b100; #200000//AND
  if(result !== a&b) begin
    dutpassed = 0;
    $display("Failed AND:");
    $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a&b);
  end

  control=3'b101; #200000//NAND
  if(result !== a&b) begin //need to make NAND
    dutpassed = 0;
    $display("Failed NAND:");
    $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a&b);
  end

  control=3'b110; #200000//NOR
  if(result !== a|b) begin
    dutpassed = 0;
    $display("Failed NOR:");
    $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a|b);
  end

  control=3'b111; #200000//OR
  if(result !== a|b) begin // need to make NOR
    dutpassed = 0;
    $display("Failed OR:");
    $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a|b);
  end

  $display("-----Count-----");

  // A+, B+, no carryout, overflow
  a=2147483647;b=1; #10000
  $display("a = %b  b = %b",a,b);
  control=3'b000; #200000 //ADD
  if(result !== a+b) begin
    dutpassed = 0;
    $display("Failed adding:");
    $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a+b);
  end

  control=3'b001; #200000//SUB
  if(result !== a-b) begin
    dutpassed = 0;
    $display("Failed Subtracting:");
    $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a-b);
  end

  control=3'b010; #200000//XOR
  if(result !== a^b) begin
    dutpassed = 0;
    $display("Failed XOR:");
    $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a^b);
  end

  control=3'b011; #200000//SLT
  if(result !== a<b) begin
    dutpassed = 0;
    $display("Failed SLT:");
    $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a<b);
  end

  control=3'b100; #200000//AND
  if(result !== a&b) begin
    dutpassed = 0;
    $display("Failed AND:");
    $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a&b);
  end

  control=3'b101; #200000//NAND
  if(result !== a&b) begin //need to make NAND
    dutpassed = 0;
    $display("Failed NAND:");
    $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a&b);
  end

  control=3'b110; #200000//NOR
  if(result !== a|b) begin
    dutpassed = 0;
    $display("Failed NOR:");
    $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a|b);
  end

  control=3'b111; #200000//OR
  if(result !== a|b) begin // need to make NOR
    dutpassed = 0;
    $display("Failed OR:");
    $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a|b);
  end
  
  if(dutpassed==1)
    $display("All tests passed.");
end

endmodule
