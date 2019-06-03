# Шаблон работ для студентов ФИИТ Института Математики, Механики и Компьютерных Наук им. Воровича
[Текущий шаблон](https://github.com/mmcs-sfedu/mmcs_sfedu_thesis)

Альтернативный шаблон для курсовых и выпускных работ студентов ФИИТ ИММиКН им. Воровича.

В шаблоне присутствуют следующие варианты работ:
* Курсовая работа в конце третьего курса
* Выпускная квалификационная работа (бакалавриат)
* Магистерская диссертация

Присутствует пример презентации выполненный при помощи `Beamer` (папка `presentation`).

Дополнительно в файле `reference.tex` содержится пример отзыва прохождения производственной практики (бакалавриат).

Если вас не интересует оффлайн установка дистрибутива `LaTeX`, то существует возможность облачной работы при помощи сервиса `Overleaf`. В этом случае из инструкции вам следует прочесть только пункт [`как пользоваться`](#Как-пользоваться).

[Шаблон в `Overleaf`](https://www.overleaf.com/read/prpvyzswtpbr), в панели меню слева есть кнопка `Copy project` (а здесь можно [зарегистрироваться](https://www.overleaf.com?r=03a8feb5&rm=d&rs=b)).


## Содержание
* [Зависимости](#Зависимости)
    * [Установка TeX Live](#Установка-tex-live)
      * [Windows](#windows)
      * [Linux](#linux)
* [Настройка TeXStudio](#Настройка-texstudio)
    * [LanguageTool](#languagetool)
* [Как пользоваться](#Как-пользоваться)
    * [Правила оформления магистерских работ](#Правила-оформления-магистерских-работ)
* [Стандартные ошибки при работе с LaTeX](#Стандартные-ошибки-при-работе-с-latex)
* [Прочие ошибки](#Прочие-ошибки)


## Зависимости
Для работы вам потребуется текстовый редактор [[1](https://www.gnu.org/software/emacs/), [2](https://code.visualstudio.com/), [3](https://atom.io/)] (возможно потребуется установка доп. плагинов!) или специализированная программа [[1](https://www.texstudio.org/), [2](http://www.xm1math.net/texmaker/), [3](http://www.texniccenter.org/), [4](http://www.tug.org/texworks/)].

Используемые шрифты входят в состав репозитория _(при необходимости их можно изменить в [`.cls`](https://github.com/sanyarnd/sfedu-mmcs-latex-thesis-template/blob/master/sfedu-mmcs-thesis.cls#L397) файле)_.

Также потребуется дистрибутив `LaTeX`.

В шаблоне используется компилятор `XeLaTeX` и система библиографии `biber`.

### Установка TeX Live
Стандартным кроссплатформенным решением является [TeX Live](https://www.tug.org/texlive/). Присутствует сборка в виде .iso (~3-4GB) и вариант сетевой установки.

#### Windows
Скачать образ или сетевой инсталлятор на сайте [TeX Live](https://www.tug.org/texlive/).

#### Linux
Если вы используете `Linux`, то скачивать инсталлятор не требуется. Все необходимые пакеты будут доступны в репозиториях вашего дистрибутива.

##### Ubuntu, Mint
> sudo apt install texlive-full biber

##### Arch
> sudo pacman -S texlive-most texlive-bin texlive-core texlive-lang biber

##### Fedora
> sudo dnf install texlive-scheme-full biber

_Обратите внимание: в отличие от `Windows`, в некоторых дистрибутивах `Biber` не входит в состав `TeX Live` и распространяется как отдельный пакет._

## Настройка TeXStudio
Войдите в настройки и выберите нужный компилятор для текста и библиографии. Делается это на вкладке `Build`. Нас интересует `XeLaTeX` и `Biber`.

<!-- ![Настройки](./images/settings.png) -->
<img src="./images/settings.png" width="70%">

### LanguageTool
Дополнительно можно установить средство проверки орфографии [LanguageTool](https://languagetool.org/ru/) (для работы требуется [JRE](http://www.oracle.com/technetwork/java/javase/overview/index.html)).

После загрузки распакуйте архив с программой (в случае `Linux` установите программу через пакетный менеджер вашего дистрибутива).

Зайдите в настройки `TeXStudio` и перейдите на вкладку `Language Checking`. В `Server URL` введите `http://localhost:8081`, А в `LT Path` укажите путь к исполняемому файлу `LanguageTool`.

Также потребуется добавить [русский словарь](https://extensions.openoffice.org/en/project/russian-dictionary) в `TeXStudio` (подойдет любой из определяющихся как `ru_RU`). Для этого перейдите на вкладку `Language Checking` и импортируйте словарь, который вы скачали. Выберите `Default Language` как `ru_RU`.

<!-- ![Настройки](./images/settings.png) -->
<img src="./images/languagetool.png" width="70%">

_Существуют более полные словари, но они определяются как `ru_RU_yo` (или как-нибудь еще), что является неправильным названием, и `LanguageTool` не может понять какой язык нужно проверять._

Для запуска возможно потребуется перезапустить `TeXStudio`.

На `Linux` дистрибутивах, в силу некоторых обстоятельств, `TeXStudio` может быть не способна запустить `LanguageTool` (индикатор запуска находится на нижней панели), поэтому придется запускать сервер вручную каждый раз, когда он вам потребуется.


## Как пользоваться
Открыть `diploma.tex` и вписать свои данные в макрос установки. В окружении `document` присутствуют заготовки для стандартных разделов работы.

По аналогии создать в папке `items/` необходимые вам .tex файлы и включить их в основной документ при помощи команды `\include` (или `\input`; [разница](https://tex.stackexchange.com/a/32058/72742)). 
На `Windows` не допускаются кириллические имена файлов. На `Linux` такой проблемы не возникает.

Обратите внимание на специальный комментарий (который тоже необходимо скопировать), присутствующий на первой строке:

> % !TEX root = ../diploma.tex

Это так называемый магический комментарий. В нем можно указать программу-компилятор, кодировку, язык, а также корневой документ. В примере выше указан корневой документ. 
Это сделано для удобства: вызывать компиляцию можно на любом файле проекта, а не только `diploma.tex`. Другие магические комментарии могут пригодиться, если вы не используете `TeXStudio`, [подробнее](https://www.texdev.net/2011/03/24/texworks-magic-comments/).

Все изображения помещаются в каталог `images/`. Он является корневым для команд типа `\includegraphics`. В данном каталоге можно создавать дополнительные каталоги.

Например, вы создали директорию `chap01` в `images/` и поместили в нее файл `image.png`. Тогда команда включения изображения должна быть следующего вида: `\includegraphics{chap01/image}`. Дописывать расширение файла не обязательно (только в случае конфликта имен).

### Правила оформления магистерских работ
Шаблон по-умолчанию настроен для бакалаврских работ (курсовая, выпускная квалификационная работа), но превратить его в магистерский шаблон можно следуя следующим инструкциям:
1. Заменить в `diploma.tex` в начале документа `scrartcl` на `scrbook`.
2. В файлах `items/intro.tex` и `items/ending.tex` заменить в `\addcontentsline{toc}{section}{}` слово `section` на `chapter`.
3. Использовать `chapter` для создания глав, `section` для разделов, `subsection` для подразделов и так далее.

Такое оформление требуется [формальными требованиями](http://it.mmcs.sfedu.ru/docs/IT-papers-2015.pdf).

## Стандартные ошибки при работе с LaTeX
* При запуске компиляции есть вероятность получить ошибку об отсутствии пакетов. В этом случае воспользуйтесь менеджером `TeX Live (Windows)` и доустановите пакеты из сети или найдите эти пакеты в `texlive-*`пакетах вашего дистрибутива и установите их (`Linux`).

* При сборке библиография может не появиться: `Biber` нужно запускать **отдельно**. В `TeXStudio` это делается очень удобно: `Tools -> Bibliography`, или запустите его руками в терминале, если вы пользуетесь обычным редактором.

* Если вдруг вместо ссылки на уравнение, цитирование, или то, на что нужно было сослаться, вы получаете имя самой метки, просто запустите компиляцию второй раз. `LaTeX` требует двух-трех проходов для составления ссылок, оглавления и ряда других вещей.

    Пояснение проблемы на примере цитирования и библиографии:
    + Сначала `LaTeX` собирает всю информацию об использовании `\cite` в .aux файл.
    + Запускается `Biber`, он получает эту информацию и заносит соответствующие записи в .bbl файл, сортирует и форматирует их в соответствии с вашими настройками (в нашем случае это стиль ГОСТ).
    + При следующем запуске .bbl файл включается в основной документ, обновленная информация о `\cite` записывается в .aux.
    + Только после предоставления всех этих данных LaTeX может выдать полностью корректный документ.

    Схема работы выше аналогично переносится на использования `\ref` и `\label`.

* Если список литературы не появляется -- действия аналогичны: запустить компиляцию, запустить компиляцию библиографии, запустить компиляцию.

    Замечание: _в дальнейшем достаточно одного прохода компиляции, но если вдруг возникают проблемы, алгоритм выше их поможет решить._

* Если вы добавили данные в список литературы, скомпилировали все согласно инструкции, но список так и не появился, то проблема в том, что по умолчанию LaTeX игнорирует источники, на которые нет ссылок. Если вас это не устраивает, то пригодится команда `\nocite{*}`. Ее можно поместить в начало документа.

* При добавлении изображения типа `.jpg`, `.png` и т.п. компиляция перестает работать и выдает ошибку. Для решения достаточно просто пересохранить файл (можно в том же формате, если не сработает -- попробуйте пересохранить в другой программе).

## Прочие ошибки
### Долгая сборка пустого проекта
Проблема в старом кеше шрифтов. Решение: обновить кеш.
#### Windows
Запустить от имени администратора `fc-cache.exe`, которая находится в папке `C:\texlive\2017\bin\win32`.
#### Linux
Запустить `sudo fc-cache` и `fc-cache`.
