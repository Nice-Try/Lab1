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

  a=32'd1;b=-32'd5; #2000
  $display("a = %b  b = %b",a,b);

  control=3'b000; #2000 //ADD
  if(result !== a+b) begin
    dutpassed = 0;
    $display("Failed adding:");
    $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a+b);
  end

  control=3'b001; #2000//SUB
  if(result !== a-b) begin
    dutpassed = 0;
    $display("Failed Subtracting:");
    $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a-b);
  end

  control=3'b010; #2000//XOR
  if(result !== a^b) begin
    dutpassed = 0;
    $display("Failed XOR:");
    $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a^b);
  end

  control=3'b011; #2000//SLT
  if(result !== a<b) begin
    dutpassed = 0;
    $display("Failed SLT:");
    $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a<b);
  end

  control=3'b100; #2000//AND
  if(result !== a&b) begin
    dutpassed = 0;
    $display("Failed AND:");
    $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a&b);
  end

  control=3'b101; #2000//NAND
  if(result == a&b) begin
    dutpassed = 0;
    $display("Failed NAND:");
    $display("a = %b  b = %b   result = %b  expected %b", a,b,result,!a&b);
  end

  control=3'b110; #2000//NOR
  if(result !== a|b) begin
    dutpassed = 0;
    $display("Failed NOR:");
    $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a|b);
  end

  control=3'b111; #2000//OR
  if(result == a|b) begin
    dutpassed = 0;
    $display("Failed OR:");
    $display("a = %b  b = %b   result = %b  expected %b", a,b,result,!a|b);
  end

end

endmodule
