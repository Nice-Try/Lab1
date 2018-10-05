`include "adder.v"
// I don't know what timescale means...maybe that should be implemented?
//
module testFullAdder();
  // Inputs for an adder
  reg signed [31:0] a, b;
  reg subtract;

  // Outputs
  wire signed [31:0] sum;
  wire carryout;
  wire overflow;

  // Instantiate device under test
  full32BitAdder adder (sum, carryout, overflow, a, b, subtract);

  initial begin

    $dumpfile("adder.vcd");
    $dumpvars();

    $display("Beginning tests");

    subtract=0;

    /******************
     **   ADD TESTS  **
     ******************/
    $display("Running Adder Tests - Addition");
    // A+, B+, no carryout, no overflow
    a=30000;b=30000; #10000
    if ((a+b) !== sum) begin
      $display("Addition test failed");
      $display("- a:        %b", a);
      $display("- b:        %b", b);
      $display("- expected: %b", a+b);
      $display("- actual:   %b", sum);
    end
    // A+, B-, no carryout, no overflow
    a=60000;b=-60005; #10000
    if ((a+b) !== sum) begin
      $display("Addition test failed");
      $display("- a:        %b", a);
      $display("- b:        %b", b);
      $display("- expected: %b", a+b);
      $display("- actual:   %b", sum);
    end
    // A+, B-, carryout, no overflow
    a=2147483647;b=-2147483647; #10000
    if ((a+b) !== sum) begin
      $display("Addition test failed");
      $display("- a:        %b", a);
      $display("- b:        %b", b);
      $display("- expected: %b", a+b);
      $display("- actual:   %b", sum);
    end
    // A-, B+, no carryout, no overflow
    a=-6600;b=5000; #10000
    if ((a+b) !== sum) begin
      $display("Addition test failed");
      $display("- a:        %b", a);
      $display("- b:        %b", b);
      $display("- expected: %b", a+b);
      $display("- actual:   %b", sum);
    end
    // A-, B+, carryout, no overflow
    a=-36;b=1073741824; #10000
    if ((a+b) !== sum) begin
      $display("Addition test failed");
      $display("- a:        %b", a);
      $display("- b:        %b", b);
      $display("- expected: %b", a+b);
      $display("- actual:   %b", sum);
    end
    // A-, B-, carryout, no overflow
    a=-650;b=-5001; #10000
    if ((a+b) !== sum) begin
      $display("Addition test failed");
      $display("- a:        %b", a);
      $display("- b:        %b", b);
      $display("- expected: %b", a+b);
      $display("- actual:   %b", sum);
    end

    // A+, B+, no carryout, overflow
    a=2147483647;b=1; #10000
    if ((a+b) !== sum) begin
      $display("Addition test failed");
      $display("- a:        %b", a);
      $display("- b:        %b", b);
      $display("- expected: %b", a+b);
      $display("- actual:   %b", sum);
    end
    // A-, B-, carryout, overflow
    a=-1500000000;b=-2000000000; #10000
    if ((a+b) !== sum) begin
      $display("Addition test failed");
      $display("- a:        %b", a);
      $display("- b:        %b", b);
      $display("- expected: %b", a+b);
      $display("- actual:   %b", sum);
    end



    subtract=1;

    /******************
     **   SUB TESTS  **
     ******************/
    $display("Running Adder Tests - Subtraction");
    // A+, B+, no carryout, no overflow
    a=55;b=60; #10000
    if ((a-b) !== sum) begin
      $display("Subtraction test failed");
      $display("- a:        %b", a);
      $display("- b:        %b", b);
      $display("- expected: %b", a-b);
      $display("- actual:   %b", sum);
    end
    // A+, B+, carryout, no overflow
    a=2147483647;b=60; #10000
    if ((a-b) !== sum) begin
      $display("Subtraction test failed");
      $display("- a:        %b", a);
      $display("- b:        %b", b);
      $display("- expected: %b", a-b);
      $display("- actual:   %b", sum);
    end
    // A+, B-, no carryout, no overflow
    a=6000000;b=-3500; #10000
    if ((a-b) !== sum) begin
      $display("Subtraction test failed");
      $display("- a:        %b", a);
      $display("- b:        %b", b);
      $display("- expected: %b", a-b);
      $display("- actual:   %b", sum);
    end
    // A-, B+, no carryout, no overflow
    a=-26000;b=450612; #10000
    if ((a-b) !== sum) begin
      $display("Subtraction test failed");
      $display("- a:        %b", a);
      $display("- b:        %b", b);
      $display("- expected: %b", a-b);
      $display("- actual:   %b", sum);
    end
    // A-, B-, no carryout, no overflow
    a=-2147483647;b=-26; #10000
    if ((a-b) !== sum) begin
      $display("Subtraction test failed");
      $display("- a:        %b", a);
      $display("- b:        %b", b);
      $display("- expected: %b", a-b);
      $display("- actual:   %b", sum);
    end
    // A-, B-, carryout, no overflow
    a=-36;b=-36; #10000
    if ((a-b) !== sum) begin
      $display("Subtraction test failed");
      $display("- a:        %b", a);
      $display("- b:        %b", b);
      $display("- expected: %b", a-b);
      $display("- actual:   %b", sum);
    end

    // A+, B-, no carryout, overflow
    a=1500000000;b=-1500000000; #10000
    if ((a-b) !== sum) begin
      $display("Subtraction test failed");
      $display("- a:        %b", a);
      $display("- b:        %b", b);
      $display("- expected: %b", a-b);
      $display("- actual:   %b", sum);
    end
    // A-, B+, no carryout, overflow
    a=-2100000000;b=1073741824; #10000
    if ((a-b) !== sum) begin
      $display("Subtraction test failed");
      $display("- a:        %b", a);
      $display("- b:        %b", b);
      $display("- expected: %b", a-b);
      $display("- actual:   %b", sum);
    end
    $display("%b",a);
    $display("%b",b);
    $display("%b",sum);
    $display("%b",a-b);
    $display("%b",carryout);
    $display("%b",overflow);

  end
endmodule
