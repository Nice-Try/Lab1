#! /bin/bash

iverilog -o adder.vvp adder.t.v
iverilog -o xor.vvp xor.t.v
iverilog -o or.vvp or.t.v
iverilog -o and.vvp and.t.v
iverilog -o or.vvp or.t.v
