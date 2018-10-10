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
  $dumpfile("alu.vcd");
  $dumpvars();

  // A+, B+, no carryout, no overflow
  a=30000;b=30000; #10000
  $display("Testing a = %b  b = %b",a,b);
  control=3'b000; #2000 //ADD
    if(result !== a+b) begin
      dutpassed = 0;
      $display("Failed adding:");
      $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a+b);
    end
    if(carryout !==  0 || overflow !== 0) begin
      dutpassed = 0;
      $display("Failed adding:");
      $display("Cout = %b  expected 0 Overflow = %b  expected 0", carryout, overflow);
    end

  control=3'b001; #20000//SUB
    if(result !== a-b) begin
      dutpassed = 0;
      $display("Failed Subtracting:");
      $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a-b);
    end
    if(carryout !==  1 || overflow !== 0) begin
      dutpassed = 0;
      $display("Failed subtracting:");
      $display("Cout = %b  expected 0 Overflow = %b  expected 0", carryout, overflow);
    end

  control=3'b010; #2000//XOR
    if(result !== (a^b)) begin
      dutpassed = 0;
      $display("Failed XOR:");
      $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a^b);
    end
    if(carryout !==  0 || overflow !== 0) begin
      dutpassed = 0;
      $display("Failed XOR:");
      $display("Cout = %b  expected 0 Overflow = %b  expected 0", carryout, overflow);
    end

  control=3'b011; #2000//SLT
    if(result[31] !== (a<b)) begin
      dutpassed = 0;
      $display("Failed SLT:");
      $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a<b);
    end
    if(carryout !==  0 || overflow !== 0) begin
      dutpassed = 0;
      $display("Failed SLT:");
      $display("Cout = %b  expected 0 Overflow = %b  expected 0", carryout, overflow);
    end

  control=3'b100; #2000//AND
    if(result !== (a&b)) begin
      dutpassed = 0;
      $display("Failed AND:");
      $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a&b);
    end
    if(carryout !==  0 || overflow !== 0) begin
      dutpassed = 0;
      $display("Failed AND:");
      $display("Cout = %b  expected 0 Overflow = %b  expected 0", carryout, overflow);
    end

  control=3'b101; #2000//NAND
    if(result !== (a~&b)) begin //need to make NAND
      dutpassed = 0;
      $display("Failed NAND:");
      $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a~&b);
    end
    if(carryout !==  0 || overflow !== 0) begin
      dutpassed = 0;
      $display("Failed NAND:");
      $display("Cout = %b  expected 0 Overflow = %b  expected 0", carryout, overflow);
    end

  control=3'b110; #2000//NOR
    if(result !== (a~|b)) begin
      dutpassed = 0;
      $display("Failed NOR:");
      $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a~|b);
    end
    if(carryout !== 0 || overflow !== 0) begin
      dutpassed = 0;
      $display("Failed NOR:");
      $display("Cout = %b  expected 0 Overflow = %b  expected 0", carryout, overflow);
    end

  control=3'b111; #2000//OR
    if(result !== (a|b)) begin
      dutpassed = 0;
      $display("Failed OR:");
      $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a|b);
    end
    if(carryout !==  0 || overflow !== 0) begin
      dutpassed = 0;
      $display("Failed XOR:");
      $display("Cout = %b  expected 0 Overflow = %b  expected 0", carryout, overflow);
    end

  // A+, B-, carryout, no overflow
  a=2147483647;b=-2147483647; #10000
  $display("Testing a = %b  b = %b",a,b);
  control=3'b000; #2000 //ADD
    if(result !== a+b) begin
      dutpassed = 0;
      $display("Failed adding:");
      $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a+b);
    end
    if(carryout !== 1 || overflow !== 0) begin
      dutpassed = 0;
      $display("Failed adding:");
      $display("Cout = %b  expected 1 Overflow = %b  expected 0", carryout, overflow);
    end

  control=3'b001; #2000//SUB
    if(result !== a-b) begin
      dutpassed = 0;
      $display("Failed Subtracting:");
      $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a-b);
    end
    if(carryout !== 0 || overflow !== 1) begin
      dutpassed = 0;
      $display("Failed subtracting:");
      $display("Cout = %b  expected 0 Overflow = %b  expected 0", carryout, overflow);
    end

  control=3'b010; #2000//XOR
    if(result !== (a^b)) begin
      dutpassed = 0;
      $display("Failed XOR:");
      $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a^b);
    end
    if(carryout !== 0 || overflow !== 0) begin
      dutpassed = 0;
      $display("Failed XOR:");
      $display("Cout = %b  expected 0 Overflow = %b  expected 0", carryout, overflow);
    end

  control=3'b011; #2000//SLT
    if(result[31] !== (a<b)) begin
      dutpassed = 0;
      $display("Failed SLT:");
      $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a<b);
    end
    if(carryout !==  0 || overflow !== 0) begin
      dutpassed = 0;
      $display("Failed SLT:");
      $display("Cout = %b  expected 0 Overflow = %b  expected 0", carryout, overflow);
    end

  control=3'b100; #2000//AND
    if(result !== (a&b)) begin
      dutpassed = 0;
      $display("Failed AND:");
      $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a&b);
    end
    if(carryout !==  0 || overflow !== 0) begin
      dutpassed = 0;
      $display("Failed AND:");
      $display("Cout = %b  expected 0 Overflow = %b  expected 0", carryout, overflow);
    end

  control=3'b101; #2000//NAND
    if(result !== (a~&b)) begin //need to make NAND
      dutpassed = 0;
      $display("Failed NAND:");
      $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a~&b);
    end
    if(carryout !==  0 || overflow !== 0) begin
      dutpassed = 0;
      $display("Failed NAND:");
      $display("Cout = %b  expected 0 Overflow = %b  expected 0", carryout, overflow);
    end

  control=3'b110; #2000//NOR
    if(result !== (a~|b)) begin
      dutpassed = 0;
      $display("Failed NOR:");
      $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a~|b);
    end
    if(carryout !==  0 || overflow !== 0) begin
      dutpassed = 0;
      $display("Failed NOR:");
      $display("Cout = %b  expected 0 Overflow = %b  expected 0", carryout, overflow);
    end

  control=3'b111; #2000//OR
    if(result !== (a|b)) begin
      dutpassed = 0;
      $display("Failed OR:");
      $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a|b);
    end
    if(carryout !==  0 || overflow !== 0) begin
      dutpassed = 0;
      $display("Failed XOR:");
      $display("Cout = %b  expected 0 Overflow = %b  expected 0", carryout, overflow);
    end

  // A-, B-, carryout, no overflow
  a=-650;b=-5001; #10000
  $display("Testing a = %b  b = %b",a,b);
  control=3'b000; #2000 //ADD
    if(result !== a+b) begin
      dutpassed = 0;
      $display("Failed adding:");
      $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a+b);
    end
    if(carryout !==  1 || overflow !== 0) begin
      dutpassed = 0;
      $display("Failed adding:");
      $display("Cout = %b  expected 1 Overflow = %b  expected 0", carryout, overflow);
    end

  control=3'b001; #2000//SUB
    if(result !== a-b) begin
      dutpassed = 0;
      $display("Failed Subtracting:");
      $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a-b);
    end
    if(carryout !==  1 || overflow !== 0) begin
      dutpassed = 0;
      $display("Failed subtracting:");
      $display("Cout = %b  expected 0 Overflow = %b  expected 0", carryout, overflow);
    end

  control=3'b010; #2000//XOR
    if(result !== (a^b)) begin
      dutpassed = 0;
      $display("Failed XOR:");
      $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a^b);
    end
    if(carryout !==  0 || overflow !== 0) begin
      dutpassed = 0;
      $display("Failed XOR:");
      $display("Cout = %b  expected 0 Overflow = %b  expected 0", carryout, overflow);
    end

  control=3'b011; #2000//SLT
    if(result[31] !== (a<b)) begin
      dutpassed = 0;
      $display("Failed SLT:");
      $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a<b);
    end
    if(carryout !==  0 || overflow !== 0) begin
      dutpassed = 0;
      $display("Failed SLT:");
      $display("Cout = %b  expected 0 Overflow = %b  expected 0", carryout, overflow);
    end

  control=3'b100; #2000//AND
    if(result !== (a&b)) begin
      dutpassed = 0;
      $display("Failed AND:");
      $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a&b);
    end
    if(carryout !==  0 || overflow !== 0) begin
      dutpassed = 0;
      $display("Failed AND:");
      $display("Cout = %b  expected 0 Overflow = %b  expected 0", carryout, overflow);
    end

  control=3'b101; #2000//NAND
    if(result !== (a~&b)) begin //need to make NAND
      dutpassed = 0;
      $display("Failed NAND:");
      $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a~&b);
    end
    if(carryout !==  0 || overflow !== 0) begin
      dutpassed = 0;
      $display("Failed NAND:");
      $display("Cout = %b  expected 0 Overflow = %b  expected 0", carryout, overflow);
    end

  control=3'b110; #2000//NOR
    if(result !== (a~|b)) begin
      dutpassed = 0;
      $display("Failed NOR:");
      $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a~|b);
    end
    if(carryout !==  0 || overflow !== 0) begin
      dutpassed = 0;
      $display("Failed NOR:");
      $display("Cout = %b  expected 0 Overflow = %b  expected 0", carryout, overflow);
    end

  control=3'b111; #2000//OR
    if(result !== (a|b)) begin
      dutpassed = 0;
      $display("Failed OR:");
      $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a|b);
    end
    if(carryout !==  0 || overflow !== 0) begin
      dutpassed = 0;
      $display("Failed XOR:");
      $display("Cout = %b  expected 0 Overflow = %b  expected 0", carryout, overflow);
    end

  // A-, B-, carryout, overflow
  a=-1500000000;b=-2000000000;
  $display("Testing a = %b  b = %b",a,b);
  control=3'b000; #2000 //ADD
    if(result !== a+b) begin
      dutpassed = 0;
      $display("Failed adding:");
      $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a+b);
    end
    if(carryout !==  1 || overflow !== 1) begin
      dutpassed = 0;
      $display("Failed adding:");
      $display("Cout = %b  expected 1 Overflow = %b  expected 1", carryout, overflow);
    end

  control=3'b001; #2000//SUB
    if(result !== a-b) begin
      dutpassed = 0;
      $display("Failed Subtracting:");
      $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a-b);
    end
    if(carryout !==  1 || overflow !== 0) begin
      dutpassed = 0;
      $display("Failed subtracting:");
      $display("Cout = %b  expected 0 Overflow = %b  expected 0", carryout, overflow);
    end

  control=3'b010; #2000//XOR
    if(result !== (a^b)) begin
      dutpassed = 0;
      $display("Failed XOR:");
      $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a^b);
    end
    if(carryout !==  0 || overflow !== 0) begin
      dutpassed = 0;
      $display("Failed XOR:");
      $display("Cout = %b  expected 0 Overflow = %b  expected 0", carryout, overflow);
    end

  control=3'b011; #2000//SLT
    if(result[31] !== (a<b)) begin
      dutpassed = 0;
      $display("Failed SLT:");
      $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a<b);
    end
    if(carryout !==  0 || overflow !== 0) begin
      dutpassed = 0;
      $display("Failed SLT:");
      $display("Cout = %b  expected 0 Overflow = %b  expected 0", carryout, overflow);
    end

  control=3'b100; #2000//AND
    if(result !== (a&b)) begin
      dutpassed = 0;
      $display("Failed AND:");
      $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a&b);
    end
    if(carryout !==  0 || overflow !== 0) begin
      dutpassed = 0;
      $display("Failed AND:");
      $display("Cout = %b  expected 0 Overflow = %b  expected 0", carryout, overflow);
    end

  control=3'b101; #2000//NAND
    if(result !== (a~&b)) begin //need to make NAND
      dutpassed = 0;
      $display("Failed NAND:");
      $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a~&b);
    end
    if(carryout !==  0 || overflow !== 0) begin
      dutpassed = 0;
      $display("Failed NAND:");
      $display("Cout = %b  expected 0 Overflow = %b  expected 0", carryout, overflow);
    end

  control=3'b110; #2000//NOR
    if(result !== (a~|b)) begin
      dutpassed = 0;
      $display("Failed NOR:");
      $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a~|b);
    end
    if(carryout !==  0 || overflow !== 0) begin
      dutpassed = 0;
      $display("Failed NOR:");
      $display("Cout = %b  expected 0 Overflow = %b  expected 0", carryout, overflow);
    end

  control=3'b111; #2000//OR
    if(result !== (a|b)) begin
      dutpassed = 0;
      $display("Failed OR:");
      $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a|b);
    end
    if(carryout !==  0 || overflow !== 0) begin
      dutpassed = 0;
      $display("Failed XOR:");
      $display("Cout = %b  expected 0 Overflow = %b  expected 0", carryout, overflow);
    end

  // A-, B+, carryout, no overflow
  a=-36;b=1073741824; #10000
  $display("Testing a = %b  b = %b",a,b);
  control=3'b000; #2000 //ADD
    if(result !== a+b) begin
      dutpassed = 0;
      $display("Failed adding:");
      $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a+b);
    end
    if(carryout !==  1 || overflow !== 0) begin
      dutpassed = 0;
      $display("Failed adding:");
      $display("Cout = %b  expected 1 Overflow = %b  expected 0", carryout, overflow);
    end

  control=3'b001; #2000//SUB
    if(result !== a-b) begin
      dutpassed = 0;
      $display("Failed Subtracting:");
      $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a-b);
    end
    if(carryout !==  1 || overflow !== 0) begin
      dutpassed = 0;
      $display("Failed subtracting:");
      $display("Cout = %b  expected 0 Overflow = %b  expected 0", carryout, overflow);
    end

  control=3'b010; #2000//XOR
    if(result !== (a^b)) begin
      dutpassed = 0;
      $display("Failed XOR:");
      $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a^b);
    end
    if(carryout !==  0 || overflow !== 0) begin
      dutpassed = 0;
      $display("Failed XOR:");
      $display("Cout = %b  expected 0 Overflow = %b  expected 0", carryout, overflow);
    end

  control=3'b011; #5000//SLT
    if(result[31] !== (a<b)) begin
      dutpassed = 0;
      $display("Failed SLT:");
      $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a<b);
    end
    if(carryout !==  0 || overflow !== 0) begin
      dutpassed = 0;
      $display("Failed SLT:");
      $display("Cout = %b  expected 0 Overflow = %b  expected 0", carryout, overflow);
    end

  control=3'b100; #2000//AND
    if(result !== (a&b)) begin
      dutpassed = 0;
      $display("Failed AND:");
      $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a&b);
    end
    if(carryout !==  0 || overflow !== 0) begin
      dutpassed = 0;
      $display("Failed AND:");
      $display("Cout = %b  expected 0 Overflow = %b  expected 0", carryout, overflow);
    end

  control=3'b101; #2000//NAND
    if(result !== (a~&b)) begin //need to make NAND
      dutpassed = 0;
      $display("Failed NAND:");
      $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a~&b);
    end
    if(carryout !==  0 || overflow !== 0) begin
      dutpassed = 0;
      $display("Failed NAND:");
      $display("Cout = %b  expected 0 Overflow = %b  expected 0", carryout, overflow);
    end

  control=3'b110; #2000//NOR
    if(result !== (a~|b)) begin
      dutpassed = 0;
      $display("Failed NOR:");
      $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a~|b);
    end
    if(carryout !==  0 || overflow !== 0) begin
      dutpassed = 0;
      $display("Failed NOR:");
      $display("Cout = %b  expected 0 Overflow = %b  expected 0", carryout, overflow);
    end

  control=3'b111; #2000//OR
    if(result !== (a|b)) begin
      dutpassed = 0;
      $display("Failed OR:");
      $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a|b);
    end
    if(carryout !==  0 || overflow !== 0) begin
      dutpassed = 0;
      $display("Failed XOR:");
      $display("Cout = %b  expected 0 Overflow = %b  expected 0", carryout, overflow);
    end

  // A+, B+, no carryout, overflow
  a=2147483647;b=1; #10000
  $display("Testing a = %b  b = %b",a,b);
  control=3'b000; #2000 //ADD
    if(result !== a+b) begin
      dutpassed = 0;
      $display("Failed adding:");
      $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a+b);
    end
    if(carryout !==  0 || overflow !== 1) begin
      dutpassed = 0;
      $display("Failed adding:");
      $display("Cout = %b  expected 0 Overflow = %b  expected 1", carryout, overflow);
    end

  control=3'b001; #2000//SUB
    if(result !== a-b) begin
      dutpassed = 0;
      $display("Failed Subtracting:");
      $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a-b);
    end
    if(carryout !==  1 || overflow !== 0) begin
      dutpassed = 0;
      $display("Failed subtracting:");
      $display("Cout = %b  expected 0 Overflow = %b  expected 0", carryout, overflow);
    end

  control=3'b010; #2000//XOR
    if(result !== (a^b)) begin
      dutpassed = 0;
      $display("Failed XOR:");
      $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a^b);
    end
    if(carryout !==  0 || overflow !== 0) begin
      dutpassed = 0;
      $display("Failed XOR:");
      $display("Cout = %b  expected 0 Overflow = %b  expected 0", carryout, overflow);
    end

  control=3'b011; #2000//SLT
    if(result[31] !== (a<b)) begin
      dutpassed = 0;
      $display("Failed SLT:");
      $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a<b);
    end
    if(carryout !==  0 || overflow !== 0) begin
      dutpassed = 0;
      $display("Failed SLT:");
      $display("Cout = %b  expected 0 Overflow = %b  expected 0", carryout, overflow);
    end

  control=3'b100; #2000//AND
    if(result !== (a&b)) begin
      dutpassed = 0;
      $display("Failed AND:");
      $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a&b);
    end
    if(carryout !==  0 || overflow !== 0) begin
      dutpassed = 0;
      $display("Failed AND:");
      $display("Cout = %b  expected 0 Overflow = %b  expected 0", carryout, overflow);
    end

  control=3'b101; #2000//NAND
    if(result !== (a~&b)) begin //need to make NAND
      dutpassed = 0;
      $display("Failed NAND:");
      $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a~&b);
    end
    if(carryout !==  0 || overflow !== 0) begin
      dutpassed = 0;
      $display("Failed NAND:");
      $display("Cout = %b  expected 0 Overflow = %b  expected 0", carryout, overflow);
    end

  control=3'b110; #2000//NOR
    if(result !== (a~|b)) begin
      dutpassed = 0;
      $display("Failed NOR:");
      $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a~|b);
    end
    if(carryout !==  0 || overflow !== 0) begin
      dutpassed = 0;
      $display("Failed NOR:");
      $display("Cout = %b  expected 0 Overflow = %b  expected 0", carryout, overflow);
    end

  control=3'b111; #2000//OR
    if(result !== (a|b)) begin
      dutpassed = 0;
      $display("Failed OR:");
      $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a|b);
    end
    if(carryout !==  0 || overflow !== 0) begin
      dutpassed = 0;
      $display("Failed XOR:");
      $display("Cout = %b  expected 0 Overflow = %b  expected 0", carryout, overflow);
    end


  if(dutpassed==1)
    $display("All tests passed.");
end

endmodule
