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

  a=32'd1;b=-32'd5;
  control=3'b000;
  if(result !== a+b) begin
    dutpassed = 0;
    $display("Failed adding:");
    $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a+b);
  end

  control=3'b001;
  if(result !== a-b) begin
    dutpassed = 0;
    $display("Failed Subtracting:");
    $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a-b);
  end

  control=3'b010;
  if(result !== a^b) begin
    dutpassed = 0;
    $display("Failed XOR:");
    $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a^b);
  end

  control=3'b011;
  if(result !== a<b) begin
    dutpassed = 0;
    $display("Failed SLT:");
    $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a<b);
  end

  control=3'b100;
  if(result !== a&b) begin
    dutpassed = 0;
    $display("Failed SLT:");
    $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a&b);
  end

  control=3'b101;
  if(result == a&b) begin
    dutpassed = 0;
    $display("Failed SLT:");
    $display("a = %b  b = %b   result = %b  expected %b", a,b,result,!a&b);
  end

  control=3'b110;
  if(result !== a|b) begin
    dutpassed = 0;
    $display("Failed SLT:");
    $display("a = %b  b = %b   result = %b  expected %b", a,b,result,a|b);
  end

  control=3'b111;
  if(result == a|b) begin
    dutpassed = 0;
    $display("Failed SLT:");
    $display("a = %b  b = %b   result = %b  expected %b", a,b,result,!a|b);
  end

end

endmodule
