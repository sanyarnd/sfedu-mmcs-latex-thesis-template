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
\LoadClass[
    a4paper,
    oneside,
    fontsize       = 14pt,
    DIV            = 12,
    headings       = normal,
    chapterprefix  = true,
    appendixprefix = true,
    numbers        = endperiod
]{\opt@class}


%% Пакеты и их настройки
\usepackage[]{fontspec}         %% загрузка шрифтов, работа с кодировкой и пр.
\usepackage[]{scrlayer-scrpage} %% колонтитулы
\usepackage[]{polyglossia}      %% переносы слов
\usepackage[]{microtype}        %% различные исправления типографии
\usepackage[]{indentfirst}      %% красная строка в первом абзаце
\usepackage{pdfpages}           %% возможность загружать PDF файлы
\usepackage[]{chngcntr}         %% модификация нумерации
\usepackage[]{csquotes}         %% правильные кавычки, цитирование
\usepackage[
    onehalfspacing,
    nodisplayskipstretch
]{setspace}                     %% полуторный интервал
\usepackage[
    backend   = biber,
    hyperref  = auto,
    sorting   = none,
    language  = auto,
    citestyle = gost-numeric,
    bibstyle  = gost-numeric
]{biblatex}                     %% оформление списка литературы

\setlength{\parindent}{1.25cm}  %% Красная строка
\frenchspacing                  %% убираем лишние отступы после точек

%% Перенос слов
\binoppenalty       = 10000     %% Запрет переносов строк в формулах
\relpenalty         = 10000
\pretolerance       = 5000      %% Настройки переноса
\tolerance          = 9000      %% Настройки переноса
\emergencystretch   = 0pt       %% Запрещаем выход за границы
\righthyphenmin     = 2         %% целое число, равное наименьшему количеству букв в слове, которые можно переносить на следующую строку
\lefthyphenmin      = 2
\hyphenpenalty      = 500
\clubpenalty        = 10000     %% Запрет разрывов страниц после первой
\widowpenalty       = 10000     %% и перед предпоследней строкой абзаца

%% Убираем нумерацию на уровне глав, прямая нумерация для всех окружений
\@ifclassloaded{scrbook}{
    \counterwithout{figure}{chapter}
    \counterwithout{equation}{chapter}
    \counterwithout{table}{chapter}
}{}

%% Стиль для шрифта колонтитулов
\setkomafont{pageheadfoot}{\upshape}

%% Оглавление -> Содержание
\AtBeginDocument{\renewcommand{\contentsname}{Содержание}}

%% -------------------------------------
%% Титульная страница
%% -------------------------------------

%% Параметры заполнения титульного листа
\define@key         {opt@title}{university}                            {\def\opt@title@university{#1}}
\define@key         {opt@title}{faculty}                               {\def\opt@title@faculty{#1}}
\define@key         {opt@title}{chair}                                 {\def\opt@title@chair{#1}}
\define@key         {opt@title}{title}                                 {\def\opt@title@title{#1}}
\define@key         {opt@title}{course}                                {\def\opt@title@group{#1}}
\define@key         {opt@title}{author}                                {\def\opt@title@author{#1}}
\define@key         {opt@title}{authorgenitive}                        {\def\opt@title@authorgenitive{#1}}
\define@key         {opt@title}{supervisor}                            {\def\opt@title@supervisor{#1}}
\define@key         {opt@title}{supervisorPosition}                    {\def\opt@title@supervisorPosition{#1}}
\define@key         {opt@title}{reviewer}                              {\def\opt@title@reviewer{#1}}
\define@key         {opt@title}{reviewerPosition}                      {\def\opt@title@reviewerPosition{#1}}
\define@key         {opt@title}{chairHead}                             {\def\opt@title@chairHead{#1}}
\define@key         {opt@title}{year}                                  {\def\opt@title@year{#1}}
\define@key         {opt@title}{city}                                  {\def\opt@title@city{#1}}
\define@key         {opt@title}{titlepage}                             {\def\opt@title@titlepage{#1}}
\define@choicekey*  {opt@title}{sex}    {male, female}                 {\def\opt@title@position{#1}}
\define@choicekey*  {opt@title}{type}   {bachelor, master, coursework} {\def\opt@title@type{#1}}


\newcommand\filltitle[1]{
    \presetkeys{opt@title}{
        type                = {bachelor},
        university          = {Федеральное государственное автономное образовательное\\учреждение высшего образования\\ \vspace*{0.1cm}\uppercase{Южный Федеральный Университет}},
        faculty             = {Институт математики, механики и компьютерных наук\\ имени И. И. Воровича},
        chair               = {Направление подготовки\\02.\ifthenelse{ \equal{\opt@title@type}{master} }{04}{03}.02 -- Фундаментальная информатика\\и информационные технологии},
        title               = {title},
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
    
    \setkeys{opt@title}{#1}
    \@ifpackageloaded{hyperref}{
        \pdfstringdefDisableCommands{\let\uppercase\@firstofone}
        \hypersetup{pdfauthor={\opt@title@author{}}, pdftitle={\opt@title@title{}}}
    }{}
}

\newcommand\makenewtitleru{%
    \begin{titlepage}
        \thispagestyle{scrheadings}
        \cfoot
        { \parbox[b]{\textwidth}{\centering \opt@title@city\\ \opt@title@year} }
        
        \begin{center}
            \vskip 1em
            \uppercase{министерство образования и науки рф} \\
            \vskip 1em
            \opt@title@university \\
            \vskip 1em
            \opt@title@faculty \\
            \vskip 1em
            \opt@title@chair
            \vskip 1em
            
            \ifthenelse{ \equal{\opt@title@type}{master} }
            {
                \vskip 4em
                \opt@title@author \\
                \vskip 1em
            }
            %else
            { \vskip 3em }
            
            \opt@title@title \\
            \vskip 1em
            
            \ifthenelse{ \equal{\opt@title@type}{coursework} }
            { Курсовая работа }
            %else
            {
                \ifthenelse{ \equal{\opt@title@type}{master} }
                { Магистерская диссертация }
                %else
                {
                    \ifthenelse{ \equal{\opt@title@type}{bachelor} }
                    { Выпускная квалификационная работа\\на степень бакалавра }
                }
                \\
            }
            \vskip 3em
            
            \ifthenelse{\equal{\opt@title@type}{master}} % магистерская
            {
                \vskip 4em
                \normalsize \raggedleft
                Научный руководитель:\\
                \opt@title@supervisorPosition\ \opt@title@supervisor \\
                \vskip 0.5em
                Рецензент:\\
                \opt@title@reviewerPosition\ \opt@title@reviewer
            }
            %else % бакалаврская или курсовая
            {
                \normalsize\raggedleft
                \ifthenelse{\equal{\opt@title@position}{male}}{Студента}{Студентки}\space \opt@title@group\space курса \\
                \opt@title@authorgenitive \\
                \vskip 0.5em
                Научный руководитель:\\
                \opt@title@supervisorPosition\ \opt@title@supervisor \\
            }
            
            \vskip 5em
            \ifthenelse{\equal{\opt@title@type}{bachelor}} % место для допуска
            {
                \begin{flushleft}
                    Допущено к защите: \\
                    руководитель направления ФИИТ \underline{\hspace{4cm}} \opt@title@chairHead
                \end{flushleft}
            }{}
            \ifthenelse{\equal{\opt@title@type}{coursework}} % место для рейтинга
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


%% Переопределяем maketitle
\renewcommand\maketitle{
    % Создаем фиктивный счетчик, чтобы включить первую страницу в нумерацию
    \newcounter{titlepages}
    \setcounter{titlepages}{1}
    
    % Выводим титульную страницу
    \begin{spacing}{1.0}
        \ifthenelse{\isundefined{\opt@title@titlepage}}{\makenewtitleru}{\includepdf[pages=-]{\opt@title@titlepage}}
        \addtocounter{titlepages}{1}
    \end{spacing}
    \setcounter{page}{\value{titlepages}}
    
    % убираем колонтитулы KOMA-Script
    \pagestyle{plain}
}


%% -----------------------------------
%% Шрифты и язык
%% -----------------------------------

\setmainlanguage[spelling=modern]{russian}
\setotherlanguage{english}

\defaultfontfeatures{
    Ligatures  = {TeX},
    Mapping    = tex-text
}

%% Main font
\setmainfont[
    Path            = fonts/,
    Extension       = .otf,
    UprightFont     = *-Regular,
    BoldFont        = *-Bold,
    ItalicFont      = *-Italic,
    BoldItalicFont  = *-BoldItalic
]{FreeSerif}
\newfontfamily\cyrillicfont[
    Path            = fonts/,
    Extension       = .otf,
    UprightFont     = *-Regular,
    BoldFont        = *-Bold,
    ItalicFont      = *-Italic,
    BoldItalicFont  = *-BoldItalic
]{FreeSerif}

%% Roman font
\setromanfont[
    Path            = fonts/,
    Extension       = .otf,
    UprightFont     = *-Regular,
    BoldFont        = *-Bold,
    ItalicFont      = *-Italic,
    BoldItalicFont  = *-BoldItalic
]{FreeSerif}
\newfontfamily\cyrillicfontrm[
    Path            = fonts/,
    Extension       = .otf,
    UprightFont     = *-Regular,
    BoldFont        = *-Bold,
    ItalicFont      = *-Italic,
    BoldItalicFont  = *-BoldItalic
]{FreeSerif}

%% Sans font
\setsansfont[
    Path            = fonts/,
    Extension       = .otf,
    UprightFont     = *-Regular,
    BoldFont        = *-Bold,
    ItalicFont      = *-Oblique,
    BoldItalicFont  = *-BoldOblique
]{FreeSans}
\newfontfamily\cyrillicfontsf[
    Path            = fonts/,
    Extension       = .otf,
    UprightFont     = *-Regular,
    BoldFont        = *-Bold,
    ItalicFont      = *-Oblique,
    BoldItalicFont  = *-BoldOblique
]{FreeSans}

%% Mono font
\setmonofont[
    Path            = fonts/,
    Extension       = .otf,
    UprightFont     = *-Regular,
    BoldFont        = *-Bold,
    ItalicFont      = *-Oblique,
    BoldItalicFont  = *-BoldOblique
]{FreeMono}
\newfontfamily\cyrillicfonttt[
    Path            = fonts/,
    Extension       = .otf,
    UprightFont     = *-Regular,
    BoldFont        = *-Bold,
    ItalicFont      = *-Oblique,
    BoldItalicFont  = *-BoldOblique
]{FreeMono}

