#!/usr/bin/env bash
# Сборка всех документов шаблона и проверка результата.
#
#   tests/run.sh            -- собрать и проверить всё
#   tests/run.sh diploma    -- только указанные цели
#
# Требуется: TeX Live (xelatex, biber, latexmk) и poppler-utils
# (pdfinfo, pdffonts, pdftotext).
#
# Проверки:
#   * документ компилируется без ошибок;
#   * в логе нет неопределённых ссылок и цитат, выходов строк за поля
#     (Overfull \hbox), отсутствующих символов шрифта и прочих предупреждений;
#   * PDF имеет формат A4, все шрифты внедрены;
#   * в тексте PDF есть ожидаемые фрагменты (титульный лист и т.п.).

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BUILD="$ROOT/build"
cd "$ROOT"

failures=0
fail() { echo "  FAIL: $*" >&2; failures=$((failures + 1)); }
pass() { echo "  ok:   $*"; }

# latexmk <каталог запуска> <tex файл> <каталог результата>
build() {
    local dir="$1" tex="$2" out="$3"
    # \include пишет .aux в подкаталоги (items/), их нужно создать заранее
    mkdir -p "$out"
    (cd "$dir" && find . -name '*.tex' -not -path './build/*' -printf '%h\n' | sort -u \
        | while read -r d; do mkdir -p "$out/$d"; done)
    if ! (cd "$dir" && latexmk -xelatex -bibtex -interaction=nonstopmode -halt-on-error \
            -file-line-error -outdir="$out" "$tex" > "$out/$(basename "$tex" .tex).latexmk.log" 2>&1); then
        fail "$tex: ошибка компиляции, см. $out"
        grep -E -A5 '^(!|.*:[0-9]+: )' "$out/$(basename "$tex" .tex).log" | head -30 >&2 || true
        return 1
    fi
    pass "$tex: собран"
}

# check_log <log> [регулярное выражение допустимых предупреждений]
check_log() {
    local log="$1" allow="${2:-^$}"
    local patterns=(
        'LaTeX Warning: (Reference|Citation).*undefined'
        'There were undefined references'
        'Label\(s\) may have changed'
        'Overfull \\hbox'
        'Overfull \\vbox'
        'Missing character'
        'Warning'
    )
    local found
    found="$(grep -E "$(IFS='|'; echo "${patterns[*]}")" "$log" \
        | grep -Ev "$allow" | sort | uniq -c || true)"
    if [[ -n "$found" ]]; then
        fail "$(basename "$log"): предупреждения в логе:"
        echo "$found" >&2
    else
        pass "$(basename "$log"): лог чистый"
    fi
}

# check_pdf <pdf> <ширина x высота в pt>
check_pdf() {
    local pdf="$1" size="$2"
    if pdfinfo "$pdf" | grep -Eq "Page size: *($size)"; then
        pass "$(basename "$pdf"): размер страницы $size"
    else
        fail "$(basename "$pdf"): размер страницы не $size"
    fi
    # Столбец emb (внедрён ли шрифт) -- третий с конца
    if pdffonts "$pdf" | tail -n +3 | awk '{ if ($(NF-4) != "yes") exit 1 }'; then
        pass "$(basename "$pdf"): все шрифты внедрены"
    else
        fail "$(basename "$pdf"): есть невнедрённые шрифты"
        pdffonts "$pdf" >&2
    fi
}

# expect_text <pdf> <фрагмент>... ; фрагмент с префиксом "!" не должен встречаться
expect_text() {
    local pdf="$1"; shift
    local text
    text="$(pdftotext -enc UTF-8 "$pdf" - | tr -s '[:space:]' ' ')"
    for s in "$@"; do
        if [[ "$s" == !* ]]; then
            if [[ "$text" == *"${s:1}"* ]]; then fail "$(basename "$pdf"): найден лишний текст «${s:1}»"
            else pass "$(basename "$pdf"): нет «${s:1}»"; fi
        else
            if [[ "$text" == *"$s"* ]]; then pass "$(basename "$pdf"): есть «$s»"
            else fail "$(basename "$pdf"): не найден текст «$s»"; fi
        fi
    done
}

# expect_pages <pdf> <число страниц>
expect_pages() {
    local n
    n="$(pdfinfo "$1" | awk '/^Pages:/ { print $2 }')"
    if [[ "$n" == "$2" ]]; then pass "$(basename "$1"): $n стр."
    else fail "$(basename "$1"): $n стр., ожидалось $2"; fi
}

A4="595.276 x 841.89|595.28 x 841.89"

# Ожидаемые предупреждения:
#   unicode-math переопределяет команды amsmath;
#   datatool 3.x не имеет русского языкового модуля (datatool-russian);
#   scrhack сообщает, что патч для новой версии listings не нужен.
EXPECTED_WARNINGS="unicode-math Warning|No \`datatool' support for dialect|scrhack Warning: unknown .lstlistoflistings"


test_diploma() {
    echo "== diploma"
    local out="$BUILD/diploma"
    build "$ROOT" diploma.tex "$out" || return 0
    check_log "$out/diploma.log" "$EXPECTED_WARNINGS"
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
        "Листинг 1" \
        "Алгоритм 1" \
        "мс" \
        "!Оглавление" \
        "!??"
}

test_master() {
    echo "== tests/master"
    local out="$BUILD/tests"
    build "$ROOT" tests/master.tex "$out" || return 0
    check_log "$out/master.log" "$EXPECTED_WARNINGS"
    check_pdf "$out/master.pdf" "$A4"
    expect_text "$out/master.pdf" \
        "02.04.02" \
        "Магистерская диссертация" \
        "Рецензент" \
        "В. В. Рецензентов" \
        "2030" \
        "Глава 1" \
        "Содержание" \
        "Рисунок 1 – Рисунок в главе" \
        "Ссылка: рисунок 1, формула 1" \
        "!Допущено к защите" \
        "!Оглавление"
}

test_coursework() {
    echo "== tests/coursework"
    local out="$BUILD/tests"
    build "$ROOT" tests/coursework.tex "$out" || return 0
    check_log "$out/coursework.log" "$EXPECTED_WARNINGS"
    check_pdf "$out/coursework.pdf" "$A4"
    expect_text "$out/coursework.pdf" \
        "Курсовая работа" \
        "Студентки 3 курса" \
        "Г. Г. Студенткиной" \
        "оценка (рейтинг)" \
        "!Допущено к защите" \
        "!Рецензент"
}

test_titlepage_pdf() {
    echo "== tests/titlepage-pdf"
    local out="$BUILD/tests"
    build "$ROOT" tests/titlepage-pdf.tex "$out" || return 0
    check_log "$out/titlepage-pdf.log" "$EXPECTED_WARNINGS"
    expect_pages "$out/titlepage-pdf.pdf" 2
    expect_text "$out/titlepage-pdf.pdf" \
        "Введение" \
        "!Не должно попасть в документ" \
        "!МИНИСТЕРСТВО"
}

test_presentation() {
    echo "== presentation"
    local out="$BUILD/presentation"
    build "$ROOT/presentation" presentation.tex "$out" || return 0
    # Тема metropolis ищет шрифты Fira (мы их заменяем), FreeSans не
    # поддерживает моноширинные цифры, а титульный слайд темы даёт
    # небольшой Overfull \vbox -- это известные особенности темы.
    check_log "$out/presentation.log" \
        "$EXPECTED_WARNINGS|metropolis Warning|Numbers=Monospaced|Overfull \\\\vbox"
    check_pdf "$out/presentation.pdf" "453.543 x 255.118|453.54 x 255.12"
    expect_text "$out/presentation.pdf" "Тема презентации" "Спасибо за внимание"
}

test_reference() {
    echo "== reference"
    local out="$BUILD/reference"
    build "$ROOT" reference.tex "$out" || return 0
    check_log "$out/reference.log"
    check_pdf "$out/reference.pdf" "$A4"
    expect_pages "$out/reference.pdf" 1
}

targets=("$@")
if [[ ${#targets[@]} -eq 0 ]]; then
    targets=(diploma master coursework titlepage_pdf presentation reference)
fi
for t in "${targets[@]}"; do
    "test_${t//-/_}"
done

echo
if [[ $failures -gt 0 ]]; then
    echo "Провалено проверок: $failures" >&2
    exit 1
fi
echo "Все проверки пройдены"
