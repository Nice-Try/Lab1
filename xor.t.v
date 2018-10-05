// Decoder testbench
`timescale 1 ns / 1 ps
`include "xor.v"

module testXor ();
    reg [31:0] inA;
    reg [31:0] inB;
    wire [31:0] out;
    wire carryout, overflow;

    full32BitXor xormod (out, carryout, overflow, inA, inB); // Swap after testing

    initial begin
    $display("A B | Output");
    inA=0;inB=0; #1000
    $display("%b %b |  %b | All false", inA, inB, out);
    inA=1;inB=1; #1000
    $display("%b %b |  %b | All false", inA, inB, out);
    $finish();
    end

endmodule
