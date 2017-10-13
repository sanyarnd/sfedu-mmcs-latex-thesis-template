# Шаблон работ для студентов ФИИТ Института Математики, Механики и Компьютерных Наук им. Воровича

Шаблон для курсовых и выпускных работ студентов ФИИТ ИММиКН им. Воровича.

## Зависимости

* текстовый редактор или специализированная программа, например, [TeXStudio](https://www.texstudio.org/).
* компилятор `XeLaTeX`
* система управления библиографией `Biber`
* некоторые пакеты

Для получения данных зависимостей потребуется дистрибутив `LaTeX`.
Стандартным кроссплатформенным решением является [TeX Live](https://www.tug.org/texlive/). Присутствует сборка в виде .iso (~3-4GB) и сетевой установки.

Если вы используете `Linux`, то скачивать инсталлятор не требуется. Все необходимые пакеты будут доступны в репозиториях вашего дистрибутива.
#### Ubuntu, Linux Mint
> sudo apt-get install texlive-full biber
#### Arch Linux
> sudo pacman -S texlive-most texlive-bin texlive-core texlive-lang biber
#### Fedora
> sudo dnf install texlive-scheme-full biber

Обратите внимание, что в некоторых дистрибутивах `Biber` не входит в состав `TeX Live` и распространяется как отдельный пакет.

Все пакеты можно скачать и заставить работать по отдельности, но это достаточно сложно и не нужно.

## Настройка TeXStudio

Войдите в настройки и выберите нужный компилятор для текста и библиографии. Делается это на вкладке `Build`. Нас интересует `XeLaTeX` и `Biber`.

![Настройки](./images/settings.png)
<!-- <img src="./images/settings.png" width="70%"> -->

## Как пользоваться

Открыть `diploma.tex` и вписать свои данные в макрос установки. В окружении `document` присутствуют заготовки для стандартных разделов работы.

По аналогии создать в папке `items/` необходимые вам .tex файлы и включить их в основной документ при помощи команды `\include` (либо `\input`, [разница](https://tex.stackexchange.com/a/32058/72742) для _нас_ не сильно существенная). Обратите внимание, что на `Windows` не допускаются кириллические имена файлов. Причина кроется в кодировке CP-1251. На `Linux` же такой проблемы не существует (UTF-8 на уровне ядра).

## Стандартные ошибки при работе с LaTeX

* При запуске компиляции есть вероятность получить ошибку об отсутсвии пакетов. В этом случае воспользуйтесь менеджером `TeX Live (Windows)` и доустановите пакеты из сети либо найтите эти пакеты в `texlive-пакетах` вашего дистрибутива и установите их (`Linux`).

* Если при сборке библиография не появилась -- не пугайтесь. `Biber` нужно запускать **отдельно**. В `TeXStudio` это делается очень удобно: `Tools -> Bibliography`, либо запустите его руками в терминале, если вы пользуетесь обычным редактором.

* Если вдруг вместо ссылки на уравнение, цитирование, или то, на что можно состаться, вы получаете имя самой метки, просто запустите компиляцию второй раз. `LaTeX` требует двух-трех проходов для составления ссылок, оглавления и ряда других вещей.

    Пояснение проблемы на примере цитирования и библиографии:
    + Сначала `LaTeX` собирает всю информацию об использовании `\cite` в .aux файл.
    + Запускается `Biber`, он получает эту информацию и записывает соответствующие записи в .bbl файл, сортирует и форматирует их в соответствии с вашими настройками (в нашем случае это стиль ГОСТ).
    + При следующем запуске .bbl файл включается в основной документ, обновленная информация о `\cite` записывается в .aux.
    + Только после предоставления всех этих данных LaTeX может выдать полностью корректный документ.

    Схема работы выше аналогично переносится на использования `\ref` и `\label`.

* Если список литературы не появляется -- действия аналогичны. запустить компиляцию, запустить компиляцию библиографии, запустить компиляцию.

    Замечание: _в дальнейшем достаточно одного прохода компиляции, но если вдруг возникают проблемы, алгоритм выше их поможет решить._

* Вы добавили данные в список литературы, все правильно скомпилировали, но список так и не появился. Причина кроется в том, что по-умолчанию LaTeX игнорирует источники на которые нет ссылок. Если вас это не устраивает, то пригодится команда `\nocite{*}`. Ее можно поместить в начало документа.

