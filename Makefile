# Simple Verilog simulation Makefile example

ICARUS_OPTIONS := -Wall
IVERILOG := iverilog $(ICARUS_OPTIONS)
SIM := vvp

CIRCUITS := or.v nor.v xor.v
TEST := or nor xor


# Pattern rule for compiling vvp (Icarus assembly) from a testbench
%.vvp: %.t.v $(CIRCUITS)
	echo $@ $<
	#$(IVERILOG) -o $@ $<


# Shortcut (phony) targets for convenience
compile: $(TEST).vvp

run: $(TEST).vvp
	$(SIM) $<

clean:
	-rm -f $(TEST).vvp


.PHONY: compile run clean