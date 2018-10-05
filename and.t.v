`include "and.v"
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


    andflag=0;
    /******************
     **   AND TESTS  **
     ******************/
    $display("Running AND tests");
    a=4294967294;b=3234987534; #1000
    if ((a&b) !== out) begin
      $display("Test failed with a %b, b %b", a, b);
    end
    $display("%b",a);
    $display("%b",b);
    $display("%b",(a&b));
    a=100029384;b=234987534; #1000
    if ((a&b) !== out) begin
      $display("Test failed with a %b, b %b", a, b);
    end
    $display("%b",a);
    $display("%b",b);
    $display("%b",(a&b));

    andflag=1;
    /******************
     **  NAND TESTS  **
     ******************/
    $display("Running NAND tests");
    a=4294967294;b=3234987534; #1000
    if ((a~&b) !== out) begin
      $display("Test failed with a %b, b %b", a, b);
    end
    $display("%b",a);
    $display("%b",b);
    $display("%b",(a~&b));
    a=100029384;b=234987534; #1000
    if ((a~&b) !== out) begin
      $display("Test failed with a %b, b %b", a, b);
    end
    $display("%b",a);
    $display("%b",b);
    $display("%b",(a~&b));



    $display("Tests completed");

    $finish();

  end
endmodule
