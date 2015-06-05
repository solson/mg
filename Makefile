all: mg.svg

mg.svg: mg.gv
	dot -Tsvg $^ -o $@

mg.gv: mg.rb
	ruby mg.rb > $@

clean:
	$(RM) mg.gv mg.svg

.PHONY: all clean
