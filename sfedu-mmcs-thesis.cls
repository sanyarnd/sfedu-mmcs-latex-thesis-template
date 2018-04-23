%% Шаблон для студентов ИММиКН им. Воровича ЮФУ направления ФИИТ
%%
%% https://github.com/sanyarnd/sfedu-mmcs-latex-thesis-template
%%
%% Александр Бирюков <sanya.rnd@gmail.com>

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{sfedu-mmcs-thesis}[2017/10/14 SFedU MMCS thesis class]


%% Для работы с опциями (автогенерирует макросы)
\RequirePackage[]{kvoptions}
%% Вспомогательные функции
\RequirePackage[]{etoolbox}
%% Контейнер типа 'словарь'
\RequirePackage[]{xkeyval}
%% Макрос if <...> then <...> else <...>
\RequirePackage[]{ifthen}


%% Параметры
\SetupKeyvalOptions{family=opt, prefix=opt@, setkeys=\kvsetkeys}
\DeclareBoolOption[false]{scrartcl}
\DeclareBoolOption[false]{scrbook}
%\SetupKeyvalOptions{family=opt@page, prefix=opt@page@, setkeys=\kvsetkeys}
% ...


%% Запуск обработки опций
\ProcessKeyvalOptions*


%% Выбираем нужный класс
\ifopt@scrartcl
    \def\opt@class{scrartcl}
\fi
\ifopt@scrbook
    \def\opt@class{scrbook}
\fi


%% Загружаем класс
\LoadClass[a4paper,
           14pt,
           oneside,
           DIV            = 12,
           headings       = normal,
           chapterprefix  = true,
           appendixprefix = true,
           numbers        = endperiod]{\opt@class}


%% Пакеты и их настройки
\usepackage[]{fontspec}         % загрузка шрифтов, работа с кодировкой и пр.
\usepackage[]{scrlayer-scrpage} % колонтитулы
\usepackage[]{polyglossia}      % переносы слов
\usepackage[]{microtype}        % различные исправления типографии
\usepackage[]{indentfirst}      % красная строка в первом абзаце
\usepackage[]{csquotes}         % правильные ковычки, цитирование
\usepackage[shortcuts]{extdash} % Дополнительные команды для различных дефисов, тире и пр.
\usepackage[]{amsthm}           % окружения теоремы и пр.
\usepackage[]{amsfonts}         % поддержка ажурных шрифтов и пр.
\usepackage[]{amsmath}          % верстка формул
\usepackage[]{amssymb}          % дополнительные символы
\usepackage[]{amscd}            % коммутативные диаграммы
\usepackage[]{mathtools}        % доп. функции
\usepackage[]{unicode-math}     % использование математических символов юникода

\usepackage[onehalfspacing,
            nodisplayskipstretch]
{setspace}                      % полуторный интервал

\setlength{\parindent}{1.25cm}  %% Красная строка
\frenchspacing                  %% убираем лишние отступы после точек

\usepackage[backend   = biber,
            maxnames  = 10,
            hyperref  = auto,
            sorting   = none,
            language  = auto,
            citestyle = gost-numeric,
            bibstyle  = gost-numeric]
{biblatex}                      % оформление списка литературы
\usepackage[colorlinks = true,
            urlcolor   = black,
            linkcolor  = black,
            filecolor  = black,
            citecolor  = black,
            pdfkeywords={thesis}]
{hyperref}                      % ссылки


%% Перенос слов
\binoppenalty       = 10000 %% Запрет переносов строк в формулах
\relpenalty         = 10000
\pretolerance       = 5000  %% Настройки переноса
\tolerance          = 9000  %% Настройки переноса
\emergencystretch   = 0pt   %% Запрещаем выход за границы
\righthyphenmin     = 2     %% целое число, равное наименьшему количеству букв в слове, которые можно переносить на следующую строку
\lefthyphenmin      = 2
\hyphenpenalty      = 500
\clubpenalty        = 10000 %% Запрет разрывов страниц после первой
\widowpenalty       = 10000 %% и перед предпоследней строкой абзаца


%% Язык
\setmainlanguage[spelling=modern]{russian}
\setotherlanguage{english}


%% Шрифты
\defaultfontfeatures{Ligatures  = {TeX, Common},
                     Mapping    = tex-text}

%% Main font
\setmainfont
[   Path            = fonts/,
    Extension       = .otf,
    UprightFont     = *-Regular,
    BoldFont        = *-Bold,
    ItalicFont      = *-Italic,
    BoldItalicFont  = *-BoldItalic
]{FreeSerif}
\newfontfamily\cyrillicfont
[   Path            = fonts/,
    Extension       = .otf,
    UprightFont     = *-Regular,
    BoldFont        = *-Bold,
    ItalicFont      = *-Italic,
    BoldItalicFont  = *-BoldItalic
]{FreeSerif}

%% Roman font
\setromanfont
[   Path            = fonts/,
    Extension       = .otf,
    UprightFont     = *-Regular,
    BoldFont        = *-Bold,
    ItalicFont      = *-Italic,
    BoldItalicFont  = *-BoldItalic
]{FreeSerif}
\newfontfamily\cyrillicfontrm
[   Path            = fonts/,
    Extension       = .otf,
    UprightFont     = *-Regular,
    BoldFont        = *-Bold,
    ItalicFont      = *-Italic,
    BoldItalicFont  = *-BoldItalic
]{FreeSerif}

%% Sans font
\setsansfont
[   Path            = fonts/,
    Extension       = .otf,
    UprightFont     = *-Regular,
    BoldFont        = *-Bold,
    ItalicFont      = *-Oblique,
    BoldItalicFont  = *-BoldOblique
]{FreeSans}
\newfontfamily\cyrillicfontsf
[   Path            = fonts/,
    Extension       = .otf,
    UprightFont     = *-Regular,
    BoldFont        = *-Bold,
    ItalicFont      = *-Oblique,
    BoldItalicFont  = *-BoldOblique
]{FreeSans}

%% Mono font
\setmonofont
[   Path            = fonts/,
    Extension       = .otf,
    UprightFont     = *-Regular,
    BoldFont        = *-Bold,
    ItalicFont      = *-Oblique,
    BoldItalicFont  = *-BoldOblique
]{FreeMono}
\newfontfamily\cyrillicfonttt
[   Path            = fonts/,
    Extension       = .otf,
    UprightFont     = *-Regular,
    BoldFont        = *-Bold,
    ItalicFont      = *-Oblique,
    BoldItalicFont  = *-BoldOblique
]{FreeMono}

%% Math font
\setmathfont
[   Path        = fonts/,
    Extension   = .otf,
    BoldFont    = *Bold,
%   range       = {\mathup/{num}, \mathup/{greek,Greek,latin,Latin}, \mathit/{greek,Greek,latin,Latin}}
]{XITS-Math}


%% Стиль для шрифта колонтитулов
\setkomafont{pageheadfoot}{\upshape}


%% Параметры заполнения титульного листа
\define@key[ru]         {opt@title}{university}                                                 {\def\opt@title@university@ru{#1}}
\define@key[ru]         {opt@title}{faculty}                                                    {\def\opt@title@faculty@ru{#1}}
\define@key[ru]         {opt@title}{chair}                                                      {\def\opt@title@chair@ru{#1}}
\define@key[ru]         {opt@title}{title}                                                      {\def\opt@title@title@ru{#1}}
\define@key[ru]         {opt@title}{course}                                                     {\def\opt@title@group@ru{#1}}
\define@key[ru]         {opt@title}{author}                                                     {\def\opt@title@author@ru{#1}}
\define@key[ru]         {opt@title}{authorgenitive}                                             {\def\opt@title@authorgenitive@ru{#1}}
\define@key[ru]         {opt@title}{supervisor}                                                 {\def\opt@title@supervisor@ru{#1}}
\define@key[ru]         {opt@title}{supervisorPosition}                                         {\def\opt@title@supervisorPosition@ru{#1}}
\define@key[ru]         {opt@title}{reviewer}                                                   {\def\opt@title@reviewer@ru{#1}}
\define@key[ru]         {opt@title}{reviewerPosition}                                           {\def\opt@title@reviewerPosition@ru{#1}}
\define@key[ru]         {opt@title}{chairHead}                                                  {\def\opt@title@chairHead@ru{#1}}
\define@key[ru]         {opt@title}{year}                                                       {\def\opt@title@year@ru{#1}}
\define@key[ru]         {opt@title}{city}                                                       {\def\opt@title@city@ru{#1}}
\define@key[ru]         {opt@title}{company}                                                    {\def\opt@title@company@ru{#1}}
\define@choicekey*[ru]  {opt@title}{sex}    {male, female}                                      {\def\opt@title@position@ru{#1}}
\define@choicekey*[ru]  {opt@title}{type}   {bachelor, master, coursework, bachelorreport}      {\def\opt@title@type@ru{#1}}

\define@key[en]         {opt@title}{university}                                                 {\def\opt@title@university@en{#1}}
\define@key[en]         {opt@title}{faculty}                                                    {\def\opt@title@faculty@en{#1}}
\define@key[en]         {opt@title}{chair}                                                      {\def\opt@title@chair@en{#1}}
\define@key[en]         {opt@title}{title}                                                      {\def\opt@title@title@en{#1}}
\define@key[en]         {opt@title}{course}                                                     {\def\opt@title@group@en{#1}}
\define@key[en]         {opt@title}{author}                                                     {\def\opt@title@author@en{#1}}
\define@key[en]         {opt@title}{authorgenitive}                                             {\def\opt@title@authorgenitive@en{#1}}
\define@key[en]         {opt@title}{supervisor}                                                 {\def\opt@title@supervisor@en{#1}}
\define@key[en]         {opt@title}{supervisorPosition}                                         {\def\opt@title@supervisorPosition@en{#1}}
\define@key[en]         {opt@title}{reviewer}                                                   {\def\opt@title@reviewer@en{#1}}
\define@key[en]         {opt@title}{reviewerPosition}                                           {\def\opt@title@reviewerPosition@en{#1}}
\define@key[en]         {opt@title}{chairHead}                                                  {\def\opt@title@chairHead@en{#1}}
\define@key[en]         {opt@title}{year}                                                       {\def\opt@title@year@en{#1}}
\define@key[en]         {opt@title}{city}                                                       {\def\opt@title@city@en{#1}}
\define@key[en]         {opt@title}{company}                                                    {\def\opt@title@company@en{#1}}
\define@choicekey*[en]  {opt@title}{sex}    {male, female}                                      {\def\opt@title@position@en{#1}}
\define@choicekey*[en]  {opt@title}{type}   {bachelor, master, coursework, bachelorreport}      {\def\opt@title@type@en{#1}}

\newcommand\filltitle[2]{
    \ifthenelse{\equal{#1}{ru}}
    {
        \presetkeys[#1]{opt@title}{
            type                = {bachelor},
            university          = {Федеральное государственное автономное образовательное\\учреждение высшего образования\\ \vspace*{0.1cm}\uppercase{Южный Федеральный Университет}},
            faculty             = {Институт математики, механики и компьютерных наук\\ имени И. И. Воровича},
            chair               = {Направление подготовки\\02.\ifthenelse{ \equal{\opt@title@type@ru}{master} }{04}{03}.02 -- Фундаментальная информатика\\и информационные технологии},
            title               = {title},
            company             = {company},
            sex                 = {male},
            course              = {course},
            author              = {author},
            authorgenitive      = {authorgenitive},
            supervisor          = {supervisor},
            supervisorPosition  = {supervisorPosition},
            reviewer            = {reviewer},
            reviewerPosition    = {reviewerPosition},
            chairHead           = {chairHead},
            city                = {Ростов-на-Дону},
            year                = {\the\year},
        }{}
    }{}

    \ifthenelse{\equal{#1}{en}}
    {
        \presetkeys[#1]{opt@title}{
            type                = {bachelor},
            university          = {Federal state autonomous educational \\ institution of higher education \\ \vspace*{0.1cm}\uppercase{Southern Federal University}},
            faculty             = {Institute of Mathematics, Mechanics and Computer Science \\ named after I.I. Voronovich},
            chair               = {Program \\02.\ifthenelse{ \equal{\opt@title@type@en}{master} }{04}{03}.02 -- Fundamental informatics\\ and information technology},
            title               = {title},
            company             = {company},
            sex                 = {male},
            course              = {course},
            author              = {author},
            authorgenitive      = {authorgenitive},
            supervisor          = {supervisor},
            supervisorPosition  = {supervisorPosition},
            reviewer            = {reviewer},
            reviewerPosition    = {reviewerPosition},
            chairHead           = {chairHead},
            city                = {Rostov-on-Don},
            year                = {\the\year},
        }{}
    }{}

    \setkeys[#1]{opt@title}{#2}

    \ifthenelse{\equal{#1}{ru}}
    {\hypersetup{pdfauthor={\opt@title@author@ru{}}, pdftitle={\opt@title@title@ru{}}}}
    {\hypersetup{pdfauthor={\opt@title@author@en{}}, pdftitle={\opt@title@title@en{}}}}
}


\newcommand\makenewtitleru{%
    \begin{titlepage}
        \thispagestyle{scrheadings}
        \cfoot
        { \parbox[b]{\textwidth}{\centering \opt@title@city@ru\\ \opt@title@year@ru} }

        \begin{center}
            \vskip 1em
            \uppercase{министерство образования и науки рф} \\
            \vskip 1em
            \opt@title@university@ru \\
            \vskip 1em
            \opt@title@faculty@ru \\
            \vskip 1em
            \opt@title@chair@ru
            \vskip 1em

            \ifthenelse{ \equal{\opt@title@type@ru}{master} }
            {
                \vskip 4em
                \opt@title@author@ru \\
                \vskip 1em
            }
            %else
            { \vskip 3em }

            \ifthenelse{ \not\equal{\opt@title@type@ru}{bachelorreport} }
            {
                \opt@title@title@ru \\
                \vskip 1em
            }

            \ifthenelse{ \equal{\opt@title@type@ru}{coursework} }
            { Курсовая работа }
            %else
            {
                \ifthenelse{ \equal{\opt@title@type@ru}{master} }
                { Магистерская диссертация }
                %else
                {
                    \ifthenelse{ \equal{\opt@title@type@ru}{bachelor} }
                    { Выпускная квалификационная работа\\на степень бакалавра }
                    % else
                    {
                        \ifthenelse{ \equal{\opt@title@type@ru}{bachelorreport} }
                        {
                            \uppercase{Отчет} \\
                            о преддипломной практике \\
                            в \opt@title@company@ru
                        }
                    }
                }
                \\
            }
            \vskip 3em

            \ifthenelse{\equal{\opt@title@type@ru}{master}} % магистерская
            {
                \vskip 4em
                \normalsize \raggedleft
                Научный руководитель:\\
                \opt@title@supervisorPosition@ru\ \opt@title@supervisor@ru \\
                \vskip 0.5em
                Рецензент:\\
                \opt@title@reviewerPosition@ru\ \opt@title@reviewer@ru
            }
            %else % бакалаврская или курсовая
            {
                \normalsize\raggedleft
                \ifthenelse{\equal{\opt@title@position@ru}{male}}{Студента}{Студентки}\space \opt@title@group@ru\space курса \\
                \opt@title@author@ru \\
                \vskip 0.5em
                Научный руководитель:\\
                \opt@title@supervisorPosition@ru\ \opt@title@supervisor@ru \\
            }

            \vskip 5em
            \ifthenelse{\equal{\opt@title@type@ru}{bachelor}} % место для допуска
            {
                \begin{flushleft}
                    Допущено к защите: \\
                    руководитель направления ФИИТ \underline{\hspace{4cm}} \opt@title@chairHead@ru
                \end{flushleft}
            }{}
            \ifthenelse{\equal{\opt@title@type@ru}{coursework}} % место для рейтинга
            {
                \begin{flushleft}
                    \begin{tabular}{cc}
                        \underline{\hspace{4cm}}&\underline{\hspace{5cm}}\\
                        {\small оценка (рейтинг)} & {\small  подпись руководителя}\\
                    \end{tabular}
                \end{flushleft}
            }{}
        \end{center}
    \end{titlepage}
}


\newcommand\makenewtitleen{%
    \begin{titlepage}
        \thispagestyle{scrheadings}
        \cfoot
        { \parbox[b]{\textwidth}{\centering \opt@title@city@en\\ \opt@title@year@en} }

        \begin{center}
            \vskip 1em
            \uppercase{Ministry of Education and Science of the Russian Federation} \\
            \vskip 1em
            \opt@title@university@en \\
            \vskip 1em
            \opt@title@faculty@en \\
            \vskip 1em
            \opt@title@chair@en
            \vskip 1em

            \ifthenelse{ \equal{\opt@title@type@en}{master} }
            {
                \vskip 4em
                \opt@title@author@en \\
                \vskip 1em
            }
            %else
            { \vskip 3em }

            \ifthenelse{ \not\equal{\opt@title@type@en}{bachelorreport} }
            {
                \opt@title@title@en \\
                \vskip 1em
            }

            \ifthenelse{ \equal{\opt@title@type@en}{coursework} }
            { Course work }
            %else
            {
                \ifthenelse{ \equal{\opt@title@type@en}{master} }
                { Master's thesis }
                %else
                {
                    \ifthenelse{ \equal{\opt@title@type@en}{bachelor} }
                    { Graduation qualification work \\ for a bachelor's degree }
                    % else
                    {
                        \ifthenelse{ \equal{\opt@title@type@en}{bachelorreport} }
                        {
                            \uppercase{Report} \\
                            about pre-diploma practice \\
                            at \opt@title@company@en
                        }
                    }
                }
                \\
            }
            \vskip 3em

            \ifthenelse{\equal{\opt@title@type@en}{master}} % магистерская
            {
                \vskip 4em
                \normalsize \raggedleft
                Scientific advisor:\\
                \opt@title@supervisorPosition@en\ \opt@title@supervisor@en \\
                \vskip 0.5em
                Reviewer:\\
                \opt@title@reviewerPosition@en\ \opt@title@reviewer@en
            }
            %else % бакалаврская или курсовая
            {
                \normalsize\raggedleft
                \ifthenelse{\equal{\opt@title@position@en}{male}}{Student}{Student}\space \opt@title@group@en\space курса \\
                \opt@title@author@en \\
                \vskip 0.5em
                Scientific advisor:\\
                \opt@title@supervisorPosition@en\ \opt@title@supervisor@en \\
            }

            \vskip 5em
            \ifthenelse{\equal{\opt@title@type@en}{bachelor}} % место для допуска
            {
                \begin{flushleft}
                    Approved for defense: \\
                    head of FIIT \underline{\hspace{4cm}} \opt@title@chairHead@en
                \end{flushleft}
            }{}
            \ifthenelse{\equal{\opt@title@type@en}{coursework}} % место для рейтинга
            {
                \begin{flushleft}
                    \begin{tabular}{cc}
                        \underline{\hspace{4cm}}&\underline{\hspace{5cm}}\\
                        {\small score (rating)} & {\small  supervisor's signature}\\
                    \end{tabular}
                \end{flushleft}
            }{}
        \end{center}
    \end{titlepage}
}



%% Переопределяем maketitle
\renewcommand\maketitle{
    % Создаем фиктивный счетчик, чтобы включить первую страницу в нумерацию
    \newcounter{titlepages}
    \setcounter{titlepages}{1}

    % Выводим титульную страницу
    \begin{spacing}{1.0}
        \ifthenelse{\isundefined{\opt@title@title@ru}}{}{
            \makenewtitleru
            \addtocounter{titlepages}{1}
        }
        \ifthenelse{\isundefined{\opt@title@title@en}}{}{
            \makenewtitleen
            \addtocounter{titlepages}{1}
        }
    \end{spacing}
    \setcounter{page}{\value{titlepages}}

    % убираем колонтитулы KOMA-Script
    \pagestyle{plain}
}


%% Оглавление -> Содержание
\AtBeginDocument{\renewcommand{\contentsname}{Содержание}}


%\setcounter{secnumdepth}{4} %% глубина нумерации
%\setcounter{tocdepth}{4}    %% глубина ToC
