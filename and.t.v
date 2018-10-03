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

  $display("hello!");
  a=4294967294;b=3234987534;andflag=0; #50
  $display("a = %b, b = %b, andflag = %b", a, b, andflag);
  $display("%b", a~&b);
  $display("%b", out);

  $finish();

  end
endmodule
