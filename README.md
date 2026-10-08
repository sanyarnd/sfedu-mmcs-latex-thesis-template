# Шаблон работ для студентов ФИИТ Института Математики, Механики и Компьютерных Наук им. Воровича

[![Build](https://github.com/sanyarnd/sfedu-mmcs-latex-thesis-template/actions/workflows/build.yml/badge.svg)](https://github.com/sanyarnd/sfedu-mmcs-latex-thesis-template/actions/workflows/build.yml)

Альтернатива [текущему шаблону](https://github.com/mmcs-sfedu/mmcs_sfedu_thesis): курсовая, ВКР бакалавра, магистерская диссертация, а также презентация (`presentation/`) и отзыв о практике (`reference.tex`).

Собранные PDF — в [релизах](https://github.com/sanyarnd/sfedu-mmcs-latex-thesis-template/releases).

## Сборка
Нужны `TeX Live` 2023+ (`XeLaTeX`, `biber`). Шрифты лежат в `fonts/`.

* **Overleaf**: [скопируйте проект](https://www.overleaf.com/read/prpvyzswtpbr), в `Settings` выберите компилятор `XeLaTeX`.
* **TeXstudio**: `Options` → `Build`, компилятор `XeLaTeX`, библиография `Biber`.
* **VS Code**: расширение [LaTeX Workshop](https://marketplace.visualstudio.com/items?itemName=James-Yu.latex-workshop).
* **Терминал**: `make` (или `latexmk`), `make watch`, `make all`, `make clean`.

Установка `TeX Live`: [установщик](https://www.tug.org/texlive/acquire-netinstall.html), [MacTeX](https://www.tug.org/mactex/) или пакетный менеджер (`texlive-full` в Ubuntu, `texlive-scheme-full` в Fedora).

## Как пользоваться
Тип работы задаётся опцией класса: `\documentclass[bachelor|coursework|master]{sfedu-mmcs-thesis}`. В магистерской главы оформляются через `\chapter` ([требования](http://it.mmcs.sfedu.ru/docs/IT-papers-2015.pdf)).

Данные титульного листа заполняются в `\filltitle` в `diploma.tex`. Вместо шаблонного титульного листа можно подставить готовый PDF: `titlepage = {front.pdf}`.

Главы лежат в `items/`, изображения — в `images/`, CSV-данные — в `data/`. Введение и Заключение оформляются через `\unnumbered{...}`.

Пакеты подключаются в `packages.tex`, остальные настройки — в `commands.tex`.

## Проверки
`make test` собирает все документы и падает, если в логе есть предупреждения (битые ссылки, выход строк за поля и т.п.). Нужен `poppler-utils`. То же запускается в CI.

## Частые проблемы
* **`??` вместо ссылок или нет списка литературы.** Пересоберите документ: нужно несколько проходов и запуск `biber`. `latexmk` делает это сам.
* **Источника из `biblio.bib` нет в списке.** Выводятся только процитированные; для всех — `\nocite{*}`.
* **Нет пакета.** `tlmgr install <пакет>`.
