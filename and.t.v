`include "and.v"
// `timescale 1 ns / 1 ps
// I don't know what timescale means...maybe that should be implemented?

module testFullAndNand();
  // Inputs for an adder
  reg[31:0] a, b;
  reg andflag;

  // Outputs
  wire [31:0] out;

  // Instantiate device under test
  full32BitAnd andNand (out, a, b, andflag);

  initial begin

    $dumpfile("and.vcd");
    $dumpvars();

    $display("Beginning tests");
    $display("Running NAND tests");
    andflag=0;
    a=4294967294;b=3234987534; #90
    if ((a~&b) !== out) begin
      $display("Test failed with a %b, b %b", a, b);
    end
    a=100029384;b=234987534; #90
    if ((a~&b) !== out) begin
      $display("Test failed with a %b, b %b", a, b);
    end

    $display("Running AND tests");
    andflag=1;
    a=4294967294;b=3234987534; #90
    if ((a&b) !== out) begin
      $display("Test failed with a %b, b %b", a, b);
    end
    a=100029384;b=234987534; #90
    if ((a&b) !== out) begin
      $display("Test failed with a %b, b %b", a, b);
    end


    $display("Tests completed");

    $finish();

  end
endmodule
