# Сборка документов через latexmk (настройки -- в .latexmkrc).
#
#   make              -- собрать diploma.pdf
#   make watch        -- пересобирать при каждом сохранении
#   make presentation -- собрать презентацию
#   make reference    -- собрать отзыв о практике
#   make all          -- собрать всё
#   make test         -- собрать всё и проверить (то же, что в CI)
#   make clean        -- удалить временные файлы

LATEXMK := latexmk

.PHONY: diploma watch presentation reference all test clean

diploma:
	$(LATEXMK) diploma.tex

watch:
	$(LATEXMK) -pvc diploma.tex

presentation:
	cd presentation && $(LATEXMK) -xelatex presentation.tex

reference:
	$(LATEXMK) reference.tex

all: diploma presentation reference

test:
	tests/run.sh

clean:
	$(LATEXMK) -c diploma.tex
	$(LATEXMK) -c reference.tex
	cd presentation && $(LATEXMK) -c presentation.tex
	rm -rf build
