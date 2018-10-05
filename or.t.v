// Decoder testbench
`timescale 1 ns / 1 ps
`include "or.v"

module testOr ();
    reg [31:0] inA;
    reg [31:0] inB;
    wire [31:0] out;
    reg orflag;

    wire carryout, overflow;
    full32BitOr ormod (out, carryout, overflow, inA, inB, orflag); // Swap after testing

    initial begin
    $display("A B | Output");
    inA=0;inB=0;orflag=0; #1000
    $display("%b %b |  %b | All false", inA, inB, out, );
    inA=1;inB=1;orflag=1; #1000
    $display("%b %b |  %b | All false", inA, inB, out);
    $finish();
    end

endmodule
