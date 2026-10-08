%% Шаблон для студентов ИММиКН им. Воровича ЮФУ направления ФИИТ
%%
%% https://github.com/sanyarnd/sfedu-mmcs-latex-thesis-template
%%
%% Александр Бирюков <sanya.rnd@gmail.com>
%%
%% Компилятор: XeLaTeX, библиография: biber.
%%
%% Опции класса:
%%   bachelor   -- выпускная квалификационная работа бакалавра (по умолчанию)
%%   coursework -- курсовая работа
%%   master     -- магистерская диссертация (основа -- scrbook, главы через \chapter)
%%   scrartcl, scrbook -- явный выбор базового класса KOMA-Script

\NeedsTeXFormat{LaTeX2e}[2022-06-01]
\ProvidesClass{sfedu-mmcs-thesis}[2026/10/08 v2.0 SFedU MMCS thesis class]

%% ---------------------------------------------------------------------
%% Опции класса
%% ---------------------------------------------------------------------
\newcommand\sfedu@baseclass{}
\newcommand\sfedu@worktype{bachelor}

\DeclareOption{bachelor}  {\def\sfedu@worktype{bachelor}}
\DeclareOption{coursework}{\def\sfedu@worktype{coursework}}
\DeclareOption{master}    {\def\sfedu@worktype{master}}
\DeclareOption{scrartcl}  {\def\sfedu@baseclass{scrartcl}}
\DeclareOption{scrbook}   {\def\sfedu@baseclass{scrbook}}
\DeclareOption*{\ClassWarning{sfedu-mmcs-thesis}{Unknown option `\CurrentOption'}}
\ProcessOptions\relax

%% Если базовый класс не задан явно, выбираем его по типу работы
\RequirePackage{etoolbox}
\ifdefempty\sfedu@baseclass{%
    \ifdefstring\sfedu@worktype{master}
        {\def\sfedu@baseclass{scrbook}}
        {\def\sfedu@baseclass{scrartcl}}%
}{}

%% ---------------------------------------------------------------------
%% Базовый класс
%% ---------------------------------------------------------------------
%% Размер бумаги и поля задаются ниже пакетом geometry.
\PassOptionsToPackage{DIV=calc}{typearea}
\LoadClass[
    oneside,
    fontsize=14pt,
    headings=normal,
    numbers=endperiod,
]{\sfedu@baseclass}
\@ifclassloaded{scrbook}{\KOMAoptions{chapterprefix=true, appendixprefix=true}}{}

%% ---------------------------------------------------------------------
%% Пакеты
%% ---------------------------------------------------------------------
\RequirePackage{iftex}
\RequireTUTeX                       %% нужен Unicode-движок (XeLaTeX)
\RequirePackage{scrhack}            %% совместимость KOMA-Script с float, listings и др.
\RequirePackage{fontspec}           %% загрузка шрифтов
\RequirePackage{polyglossia}        %% язык и переносы
\RequirePackage{microtype}          %% типографские улучшения
\RequirePackage{indentfirst}        %% абзацный отступ в первом абзаце
\RequirePackage{pdfpages}           %% вставка PDF (готовый титульный лист)
\RequirePackage{csquotes}           %% кавычки и цитаты
\RequirePackage[
    onehalfspacing,
    nodisplayskipstretch
]{setspace}                         %% полуторный интервал
\RequirePackage[singlespacing=true]{scrlayer-scrpage} %% колонтитулы
\RequirePackage[
    a4paper,
    left=30mm,
    right=15mm,
    top=20mm,
    bottom=20mm,
    footskip=10mm,
]{geometry}                         %% поля по ГОСТ 7.32-2017
\RequirePackage{caption}            %% оформление подписей
\RequirePackage[
    backend=biber,
    hyperref=auto,
    sorting=none,
    language=autobib,
    autolang=other,
    style=gost-numeric,
]{biblatex}                         %% библиография по ГОСТ Р 7.0.5-2008

%% ---------------------------------------------------------------------
%% Язык и шрифты
%% ---------------------------------------------------------------------
\setdefaultlanguage{russian}
\setotherlanguage{english}

%% Все шрифты лежат в каталоге fonts/ и содержат кириллицу, поэтому
%% отдельные \cyrillicfont* не нужны.
\defaultfontfeatures{Ligatures=TeX, Path=fonts/, Extension=.otf}

\setmainfont{FreeSerif}[
    UprightFont    = *-Regular,
    BoldFont       = *-Bold,
    ItalicFont     = *-Italic,
    BoldItalicFont = *-BoldItalic,
]
\setsansfont{FreeSans}[
    UprightFont    = *-Regular,
    BoldFont       = *-Bold,
    ItalicFont     = *-Oblique,
    BoldItalicFont = *-BoldOblique,
]
\setmonofont{FreeMono}[
    UprightFont    = *-Regular,
    BoldFont       = *-Bold,
    ItalicFont     = *-Oblique,
    BoldItalicFont = *-BoldOblique,
    Scale          = MatchLowercase,
]

%% ---------------------------------------------------------------------
%% Абзацы и переносы
%% ---------------------------------------------------------------------
\setlength{\parindent}{1.25cm}      %% абзацный отступ
\frenchspacing                      %% одинаковые пробелы после точек

\binoppenalty     = 10000           %% запрет переноса формул
\relpenalty       = 10000
\pretolerance     = 5000
\tolerance        = 9000
\emergencystretch = 1em             %% меньше выходов за поля
\lefthyphenmin    = 2
\righthyphenmin   = 2
\hyphenpenalty    = 500
\clubpenalty      = 10000           %% висячие строки
\widowpenalty     = 10000

%% ---------------------------------------------------------------------
%% Заголовки, колонтитулы, нумерация
%% ---------------------------------------------------------------------
%% Заголовки тем же шрифтом с засечками, что и текст
\setkomafont{disposition}{\normalcolor\bfseries}
\setkomafont{descriptionlabel}{\bfseries}
\setkomafont{pageheadfoot}{\upshape}
\setkomafont{pagenumber}{\normalfont}

%% Номер страницы внизу по центру
\pagestyle{plain.scrheadings}
\clearpairofpagestyles
\cfoot*{\pagemark}

%% Сквозная нумерация рисунков, таблиц и формул в магистерской
\@ifclassloaded{scrbook}{%
    \counterwithout{figure}{chapter}
    \counterwithout{table}{chapter}
    \counterwithout{equation}{chapter}
}{}

%% Подписи: "Рисунок 1 -- Название", "Таблица 1 -- Название" (подпись сверху)
\captionsetup{labelformat=simple, labelsep=endash, justification=centering, singlelinecheck=false}
\captionsetup[figure]{name=Рисунок, position=bottom}
\captionsetup[table]{position=top}

%% Ненумеруемые структурные элементы (Введение, Заключение и т.п.):
%% \unnumbered{...}  -- с записью в содержании,
%% \unnumbered*{...} -- без записи.
%% Автоматически выбирается уровень (chapter/section) по классу.
\NewDocumentCommand\unnumbered{s m}{%
    \@ifundefined{chapter}
        {\IfBooleanTF{#1}{\addsec*{#2}}{\addsec{#2}}}
        {\IfBooleanTF{#1}{\addchap*{#2}}{\addchap{#2}}}%
}

%% Русские имена для \autoref и <<Содержание>> вместо <<Оглавление>>.
%% Добавляются к \captionsrussian, чтобы polyglossia и hyperref
%% не перезаписали их при переключении языка.
\newcommand\sfedu@russiannames{%
    \def\contentsname{Содержание}%
    \def\equationautorefname{формула}%
    \def\figureautorefname{рисунок}%
    \def\tableautorefname{таблица}%
    \def\sectionautorefname{раздел}%
    \def\subsectionautorefname{подраздел}%
    \def\subsubsectionautorefname{подраздел}%
    \def\chapterautorefname{глава}%
    \def\appendixautorefname{приложение}%
    \def\Itemautorefname{пункт}%
    \def\theoremautorefname{теорема}%
    \def\algorithmautorefname{алгоритм}%
    \def\lstlistingautorefname{листинг}%
    \def\pageautorefname{страница}%
}
\appto\captionsrussian{\sfedu@russiannames}
\AtBeginDocument{\sfedu@russiannames}

%% ---------------------------------------------------------------------
%% Данные титульного листа
%% ---------------------------------------------------------------------
\ExplSyntaxOn
\keys_define:nn { sfedu / title }
  {
    ministry           .tl_set:N = \sfedu@ministry,
    university         .tl_set:N = \sfedu@university,
    faculty            .tl_set:N = \sfedu@faculty,
    chair              .tl_set:N = \sfedu@chair,
    programCode        .tl_set:N = \sfedu@programcode,
    programName        .tl_set:N = \sfedu@programname,
    title              .tl_set:N = \sfedu@title,
    course             .tl_set:N = \sfedu@course,
    author             .tl_set:N = \sfedu@author,
    authorgenitive     .tl_set:N = \sfedu@authorgenitive,
    supervisor         .tl_set:N = \sfedu@supervisor,
    supervisorPosition .tl_set:N = \sfedu@supervisorposition,
    reviewer           .tl_set:N = \sfedu@reviewer,
    reviewerPosition   .tl_set:N = \sfedu@reviewerposition,
    chairHead          .tl_set:N = \sfedu@chairhead,
    chairHeadPosition  .tl_set:N = \sfedu@chairheadposition,
    city               .tl_set:N = \sfedu@city,
    year               .tl_set:N = \sfedu@year,
    titlepage          .tl_set:N = \sfedu@titlepage,
    type               .choices:nn =
      { bachelor, master, coursework } { \tl_set_eq:NN \sfedu@worktype \l_keys_choice_tl },
    sex                .choices:nn =
      { male, female } { \tl_set_eq:NN \sfedu@sex \l_keys_choice_tl },
    gender             .meta:n = { sex = #1 },
  }
\keys_set:nn { sfedu / title }
  {
    ministry          = {Министерство~науки~и~высшего~образования\\Российской~Федерации},
    university        = {Федеральное~государственное~автономное~образовательное\\
                         учреждение~высшего~образования\\[0.1cm]
                         \MakeUppercase{Южный~федеральный~университет}},
    faculty           = {Институт~математики,~механики~и~компьютерных~наук\\
                         имени~И.\,И.~Воровича},
    programName       = {Фундаментальная~информатика\\и~информационные~технологии},
    title             = {Название~работы},
    sex               = male,
    course            = {4},
    author            = {И.\,О.~Фамилия},
    authorgenitive    = {И.\,О.~Фамилии},
    supervisor        = {И.\,О.~Фамилия},
    supervisorPosition= {},
    reviewer          = {И.\,О.~Фамилия},
    reviewerPosition  = {},
    chairHead         = {И.\,О.~Фамилия},
    chairHeadPosition = {руководитель~направления~ФИИТ},
    city              = {Ростов-на-Дону},
    year              = {\the\year},
  }

%% \filltitle{ключ = значение, ...} -- см. diploma.tex
%% Пустые строки между ключами допускаются.
\cs_generate_variant:Nn \keys_set:nn { nV }
\NewDocumentCommand \filltitle { +m }
  {
    \tl_set:Nn \l_tmpa_tl {#1}
    \tl_replace_all:Nnn \l_tmpa_tl { \par } { }
    \keys_set:nV { sfedu / title } \l_tmpa_tl
  }
\ExplSyntaxOff

%% Код направления зависит от уровня образования
\newcommand\sfedu@defaultprogramcode{%
    \ifdefstring\sfedu@worktype{master}{02.04.02}{02.03.02}%
}
\newcommand\sfedu@chairtext{%
    \ifdefvoid\sfedu@chair
        {Направление подготовки\\
         \ifdefvoid\sfedu@programcode{\sfedu@defaultprogramcode}{\sfedu@programcode}
         \textendash\ \sfedu@programname}
        {\sfedu@chair}%
}

\AtBeginDocument{%
    \@ifpackageloaded{hyperref}{%
        \pdfstringdefDisableCommands{%
            \let\MakeUppercase\@firstofone
            \let\uppercase\@firstofone
            \def\\{ }%
            \def\,{ }%
        }%
        \hypersetup{
            pdfauthor = {\sfedu@author},
            pdftitle  = {\sfedu@title},
            pdflang   = {ru-RU},
        }%
    }{}%
}

%% ---------------------------------------------------------------------
%% Титульный лист
%% ---------------------------------------------------------------------
\newcommand\sfedu@worktitle{%
    \ifdefstring\sfedu@worktype{coursework}{Курсовая работа}{}%
    \ifdefstring\sfedu@worktype{bachelor}%
        {Выпускная квалификационная работа\\на степень бакалавра}{}%
    \ifdefstring\sfedu@worktype{master}{Магистерская диссертация}{}%
}

\newcommand\makenewtitleru{%
    \begin{titlepage}
        \centering
        \MakeUppercase{\sfedu@ministry}\par
        \vspace{1em}
        \sfedu@university\par
        \vspace{1em}
        \sfedu@faculty\par
        \vspace{1em}
        \sfedu@chairtext\par

        \ifdefstring\sfedu@worktype{master}
            {\vspace{3em}\sfedu@author\par\vspace{1em}}
            {\vspace{3em}}

        {\sfedu@title\par}
        \vspace{1em}
        \sfedu@worktitle\par
        \vspace{3em}

        {\raggedleft
        \ifdefstring\sfedu@worktype{master}{%
            Научный руководитель:\\
            \ifdefvoid\sfedu@supervisorposition{}{\sfedu@supervisorposition\ }%
            \sfedu@supervisor\par
            \vspace{0.5em}
            Рецензент:\\
            \ifdefvoid\sfedu@reviewerposition{}{\sfedu@reviewerposition\ }%
            \sfedu@reviewer\par
        }{%
            \ifdefstring\sfedu@sex{female}{Студентки}{Студента}~\sfedu@course~курса\\
            \sfedu@authorgenitive\par
            \vspace{0.5em}
            Научный руководитель:\\
            \ifdefvoid\sfedu@supervisorposition{}{\sfedu@supervisorposition\ }%
            \sfedu@supervisor\par
        }}

        \vspace{3em}
        \ifdefstring\sfedu@worktype{bachelor}{%
            {\raggedright
            Допущено к защите:\\
            \sfedu@chairheadposition\ \underline{\hspace{4cm}}\ \sfedu@chairhead\par}
        }{}%
        \ifdefstring\sfedu@worktype{coursework}{%
            {\raggedright
            \begin{tabular}{cc}
                \underline{\hspace{4cm}} & \underline{\hspace{5cm}}\\
                {\small оценка (рейтинг)} & {\small подпись руководителя}\\
            \end{tabular}\par}
        }{}%

        \vfill
        \sfedu@city\\
        \sfedu@year
    \end{titlepage}
}

%% Титульный лист входит в нумерацию, но номер на нём не печатается
\renewcommand\maketitle{%
    \begingroup
    \singlespacing
    \ifdefvoid\sfedu@titlepage
        {\makenewtitleru\setcounter{page}{2}}
        {\includepdf[pages=-]{\sfedu@titlepage}}%
    \endgroup
}

\endinput
