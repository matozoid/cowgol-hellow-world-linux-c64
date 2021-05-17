COWGOLDIR=../cowgol
FE=$(COWGOLDIR)/bin/cowfe-6502.lx386.lx386.exe
BE=$(COWGOLDIR)/bin/cowbe-6502.lx386.lx386.exe
LINKER=$(COWGOLDIR)/bin/cowlink-c64.lx386.lx386.exe
AS=64tass

%.cob: %.cow
	$(FE) -I$(COWGOLDIR)/ -I$(COWGOLDIR)/rt/ -I$(COWGOLDIR)/rt/c64/ $< $@

%.coo: %.cob
	$(BE) $< $@

%.asm: %.coo
	$(LINKER) $(COWGOLDIR)/.obj/rt/c64/cowgol.coo $< -o $@

all: test.asm
	$(AS) --nostart test.asm -o test.prg

clean:
	rm *.cob *.coo *.asm *.prg
