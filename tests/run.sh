#!/usr/bin/env bash
# Сборка и проверка документов: tests/run.sh [diploma master ...]
# Нужны latexmk, biber и poppler-utils.

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BUILD="$ROOT/build"
cd "$ROOT"

failures=0
fail() { echo "  FAIL: $*" >&2; failures=$((failures + 1)); }

# build <каталог запуска> <tex файл> <каталог результата>
build() {
    local dir="$1" tex="$2" out="$3" name
    name="$(basename "$tex" .tex)"
    # \include пишет .aux в подкаталоги, сами они не создаются
    (cd "$dir" && find . -name '*.tex' -not -path './build/*' -printf "$out/%h\n" | sort -u | xargs -d '\n' mkdir -p)
    if ! (cd "$dir" && latexmk -xelatex -bibtex -interaction=nonstopmode -halt-on-error \
            -outdir="$out" "$tex" > "$out/$name.latexmk.log" 2>&1); then
        fail "$tex не собирается"
        grep -A5 '^!' "$out/$name.log" | head -30 >&2 || true
        return 1
    fi
}

# check_log <log> [допустимые предупреждения]
check_log() {
    local found
    found="$(grep -E 'Warning|Overfull|Missing character' "$1" | grep -Ev "${2:-^$}" | sort | uniq -c || true)"
    [[ -z "$found" ]] || { fail "$(basename "$1"):"; echo "$found" >&2; }
}

# check_pdf <pdf> <размер страницы в pt>
check_pdf() {
    pdfinfo "$1" | grep -Eq "Page size: *($2)" || fail "$(basename "$1"): размер страницы не $2"
    # $(NF-4) -- столбец emb
    pdffonts "$1" | tail -n +3 | awk '$(NF-4) != "yes" { exit 1 }' \
        || fail "$(basename "$1"): есть невнедрённые шрифты"
}

# expect_text <pdf> <фрагмент>...; "!фрагмент" -- не должен встречаться
expect_text() {
    local pdf="$1" text s; shift
    text="$(pdftotext -enc UTF-8 "$pdf" - | tr -s '[:space:]' ' ')"
    for s in "$@"; do
        if [[ "$s" == !* ]]; then
            [[ "$text" != *"${s:1}"* ]] || fail "$(basename "$pdf"): лишний текст «${s:1}»"
        else
            [[ "$text" == *"$s"* ]] || fail "$(basename "$pdf"): нет текста «$s»"
        fi
    done
}

expect_pages() {
    local n
    n="$(pdfinfo "$1" | awk '/^Pages:/ { print $2 }')"
    [[ "$n" == "$2" ]] || fail "$(basename "$1"): $n стр. вместо $2"
}

A4="595.276 x 841.89|595.28 x 841.89"

# У datatool 3.x нет модуля для русского, scrhack не узнаёт новый listings
EXPECTED="unicode-math Warning|No \`datatool' support for dialect|scrhack Warning: unknown .lstlistoflistings"

test_diploma() {
    local out="$BUILD/diploma"
    build "$ROOT" diploma.tex "$out" || return 0
    check_log "$out/diploma.log" "$EXPECTED"
    check_pdf "$out/diploma.pdf" "$A4"
    expect_text "$out/diploma.pdf" \
        "МИНИСТЕРСТВО НАУКИ И ВЫСШЕГО ОБРАЗОВАНИЯ" \
        "02.03.02" \
        "Выпускная квалификационная работа на степень бакалавра" \
        "Студента 4 курса" \
        "Допущено к защите" \
        "Содержание" \
        "Список литературы" \
        "Рисунок 1 – " \
        "Таблица 1 – " \
        "Продолжение таблицы" \
        "// прямое преобразование" \
        "составляет 4,2 раза" \
        "!Оглавление" \
        "!??"
}

test_master() {
    local out="$BUILD/tests"
    build "$ROOT" tests/master.tex "$out" || return 0
    check_log "$out/master.log" "$EXPECTED"
    check_pdf "$out/master.pdf" "$A4"
    expect_text "$out/master.pdf" \
        "02.04.02" \
        "Магистерская диссертация" \
        "В. В. Рецензентов" \
        "2030" \
        "Глава 1" \
        "Содержание" \
        "Рисунок 1 – Рисунок в главе" \
        "Ссылка: рисунок 1, формула 1" \
        "!Допущено к защите"
}

test_coursework() {
    local out="$BUILD/tests"
    build "$ROOT" tests/coursework.tex "$out" || return 0
    check_log "$out/coursework.log" "$EXPECTED"
    expect_text "$out/coursework.pdf" \
        "Курсовая работа" \
        "Студентки 3 курса" \
        "Г. Г. Студенткиной" \
        "оценка (рейтинг)" \
        "!Допущено к защите" \
        "!Рецензент"
}

test_titlepage_pdf() {
    local out="$BUILD/tests"
    build "$ROOT" tests/titlepage-pdf.tex "$out" || return 0
    check_log "$out/titlepage-pdf.log" "$EXPECTED"
    expect_pages "$out/titlepage-pdf.pdf" 2
    expect_text "$out/titlepage-pdf.pdf" "Введение" "!МИНИСТЕРСТВО"
}

test_presentation() {
    local out="$BUILD/presentation"
    build "$ROOT/presentation" presentation.tex "$out" || return 0
    # Особенности темы metropolis: ищет шрифты Fira, моноширинные цифры,
    # Overfull \vbox на титульном слайде
    check_log "$out/presentation.log" \
        "$EXPECTED|metropolis Warning|Numbers=Monospaced|Overfull \\\\vbox"
    check_pdf "$out/presentation.pdf" "453.543 x 255.118|453.54 x 255.12"
}

test_reference() {
    local out="$BUILD/reference"
    build "$ROOT" reference.tex "$out" || return 0
    check_log "$out/reference.log"
    check_pdf "$out/reference.pdf" "$A4"
    expect_pages "$out/reference.pdf" 1
}

targets=("$@")
[[ ${#targets[@]} -gt 0 ]] || targets=(diploma master coursework titlepage-pdf presentation reference)
for t in "${targets[@]}"; do
    echo "== $t"
    "test_${t//-/_}"
done

if [[ $failures -gt 0 ]]; then
    echo "Провалено проверок: $failures" >&2
    exit 1
fi
