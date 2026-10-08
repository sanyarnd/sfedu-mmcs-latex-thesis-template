.PHONY: diploma watch presentation reference all test clean

diploma:
	latexmk diploma.tex

watch:
	latexmk -pvc diploma.tex

presentation:
	cd presentation && latexmk -xelatex presentation.tex

reference:
	latexmk reference.tex

all: diploma presentation reference

test:
	tests/run.sh

clean:
	latexmk -c diploma.tex reference.tex
	cd presentation && latexmk -c presentation.tex
	rm -rf build
