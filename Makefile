# Simple Verilog simulation Makefile example

ICARUS_OPTIONS := -Wall
IVERILOG := iverilog $(ICARUS_OPTIONS)
SIM := vvp

CIRCUITS := alu.v
TEST := alu


# Pattern rule for compiling vvp (Icarus assembly) from a testbench
%.vvp: %.t.v $(CIRCUITS)
	$(IVERILOG) -o $@ $<


# Shortcut (phony) targets for convenience
compile: $(TEST).vvp

run: $(TEST).vvp
	$(SIM) $<

clean:
	-rm -f $(TEST).vvp


.PHONY: compile run clean