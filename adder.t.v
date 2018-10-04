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
    $display("Add positive numbers");
    subtract=0;
    a=12543;b=43298; #1000
    if ((a+b) !== sum) begin
      $display("Test failed");
      $display("Expected: %b", a+b);
      $display("Actual:   %b", sum);
    end

  end
endmodule
