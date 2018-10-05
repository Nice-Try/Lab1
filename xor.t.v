// Decoder testbench
`timescale 1 ns / 1 ps
`include "xor.v"

module testXor ();
    reg [31:0] a;
    reg [31:0] b;
    wire [31:0] out;
    wire carryout, overflow;

    full32BitXor xormod (out, carryout, overflow, a, b); // Swap after testing

    initial begin
        $display("Running XOR tests");
        a=4294967294;b=3234987534; #10000
        if ((a^b) !== out) begin
          $display("Test failed with a %b, b %b", a, b);
        end
        a=100029384;b=234987534; #10000
        if ((a^b) !== out) begin
          $display("Test failed with a %b, b %b", a, b);
        end
    end

endmodule
