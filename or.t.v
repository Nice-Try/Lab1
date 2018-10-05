// Decoder testbench
`timescale 1 ns / 1 ps
`include "or.v"

module testOr ();
    reg [31:0] a;
    reg [31:0] b;
    wire [31:0] out;
    reg orflag;

    wire carryout, overflow;
    full32BitOr ormod (out, carryout, overflow, a, b, orflag); // Swap after testing

    initial begin
    $display("Beginning tests");


    orflag=0;
    /******************
     **   NOR TESTS  **
     ******************/
    $display("Running NOR tests");
    a=4294967294;b=3234987534; #10000
    if ((a~|b) !== out) begin
      $display("Test failed with a %b, b %b", a, b);
    end
    a=100029384;b=234987534; #10000
    if ((a~|b) !== out) begin
      $display("Test failed with a %b, b %b", a, b);
    end

    orflag=1;
    /******************
     **    OR TESTS  **
     ******************/
    $display("Running OR tests");
    a=4294967294;b=3234987534; #1000
    if ((a|b) !== out) begin
      $display("Test failed with a %b, b %b", a, b);
    end
    a=100029384;b=234987534; #1000
    if ((a|b) !== out) begin
      $display("Test failed with a %b, b %b", a, b);
    end



    $display("Tests completed");
    end

endmodule
