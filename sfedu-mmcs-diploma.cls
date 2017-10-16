%% Шаблон для студентов ИММиКН им. Воровича ЮФУ направления ФИИТ
%%
%% https://github.com/sanyarnd/sfedu-mmcs-latex-thesis-template
%%
%% Александр Бирюков <sanya.rnd at gmail.com>

%% TODO:
%% Переход с fancyhdr на scrpage

\NeedsTeXFormat{LaTeX2e} % Было бы интересно посмотреть на LaTeX3
\ProvidesClass{sfedu-mmcs-diploma}[2017/10/14 SFedU MMCS diploma class]


%% Для работы с опциями (автогенерирует макросы)
\RequirePackage{kvoptions}
%% Вспомогательные функции
\RequirePackage{etoolbox}


%% Параметры
\SetupKeyvalOptions{family=opt, prefix=opt@, setkeys=\kvsetkeys}
\DeclareBoolOption[false]{bachelor}
\DeclareBoolOption[false]{master}
%\SetupKeyvalOptions{family=opt@page, prefix=opt@page@, setkeys=\kvsetkeys}
% ...


%% Запуск обработки опций
\ProcessKeyvalOptions*


%% Загружаем нужный класс
\ifopt@bachelor
    \def\opt@class{scrartcl}
\fi
\ifopt@master
    \def\opt@class{scrbook}
\fi


%% Загружаем класс
\LoadClass[a4paper, 14pt, oneside, usegeometry]{\opt@class}


%% Пакеты и их настройки
\usepackage[pass]{geometry}
\usepackage[]{fancyhdr}
\usepackage[]{ifthen}
\usepackage{fontspec}
\usepackage[]{polyglossia}
\usepackage[]{microtype}
\usepackage[]{indentfirst}
\usepackage[]{xkeyval}
\usepackage[nodisplayskipstretch]{setspace}
\usepackage[]{csquotes}
\usepackage[backend   = biber,
            maxnames  = 10,
            hyperref  = auto,
            sorting   = none,
            language  = auto,
            citestyle = gost-numeric,
            bibstyle  = gost-numeric]
{biblatex}
\addbibresource{biblio.bib}

%\usepackage[]{pythontex}
%\usepackage[]{showframe}
%\usepackage[]{layout}
%\usepackage[]{blindtext}
%\usepackage[shortcuts]{extdash}

\usepackage[colorlinks = true,
			urlcolor   = black,
			linkcolor  = black,
			filecolor  = black,
			citecolor  = black,
			pdfkeywords={thesis}]
{hyperref}


%% Перенос слов
\pretolerance=5000      %% Настройки переноса
\tolerance=9000         %% Настройки переноса
\emergencystretch=0pt   %% Запрещаем выход за границы
\righthyphenmin=2       %% целое число, равное наименьшему количеству букв в слове, которые можно переносить на следующую строку
\lefthyphenmin=2
\hyphenpenalty=500


%% Язык
\setmainlanguage[spelling=modern]{russian}
\setotherlanguage{english}


%% Шрифты
\defaultfontfeatures{Ligatures	= TeX,
					 Mapping	= tex-text}

\setmainfont[ItalicFont     = {Times New Roman Italic},
			 BoldFont       = {Times New Roman Bold},
			 BoldItalicFont = {Times New Roman Bold Italic}]{Times New Roman}
\newfontfamily\cyrillicfont{Times New Roman}

\setsansfont[ItalicFont     = {Arial Italic},
			 BoldFont       = {Arial Bold},
			 BoldItalicFont = {Arial Bold Italic}]{Arial}
\newfontfamily\cyrillicfontsf{Arial}

\setmonofont[ItalicFont     = {Courier New Italic},
			 BoldFont       = {Courier New Bold},
			 BoldItalicFont = {Courier New Bold Italic}]{Courier New}
\newfontfamily\cyrillicfonttt{Courier New}


%\defaultfontfeatures{Ligatures=TeX,Mapping=tex-text}
%\setmainfont{Times New Roman}
%\newfontfamily\cyrillicfont{Times New Roman}
%\setsansfont{Arial}
%\newfontfamily\cyrillicfontsf{Arial}
%\setmonofont{Courier New}
%\newfontfamily\cyrillicfonttt{Courier New}


%% Параметры заполнения титульного листа
\define@key[ru]         {opt@title}{university}                             {\def\opt@title@university@ru{#1}}
\define@key[ru]         {opt@title}{faculty}                                {\def\opt@title@faculty@ru{#1}}
\define@key[ru]         {opt@title}{chair}                                  {\def\opt@title@chair@ru{#1}}
\define@key[ru]         {opt@title}{title}                                  {\def\opt@title@title@ru{#1}}
\define@key[ru]         {opt@title}{course}                                 {\def\opt@title@group@ru{#1}}
\define@key[ru]         {opt@title}{author}                                 {\def\opt@title@author@ru{#1}}
\define@key[ru]         {opt@title}{authorgenitive}                         {\def\opt@title@authorgenitive@ru{#1}}
\define@key[ru]         {opt@title}{supervisor}                             {\def\opt@title@supervisor@ru{#1}}
\define@key[ru]         {opt@title}{supervisorPosition}                     {\def\opt@title@supervisorPosition@ru{#1}}
\define@key[ru]         {opt@title}{reviewer}                               {\def\opt@title@reviewer@ru{#1}}
\define@key[ru]         {opt@title}{reviewerPosition}                       {\def\opt@title@reviewerPosition@ru{#1}}
\define@key[ru]         {opt@title}{chairHead}                              {\def\opt@title@chairHead@ru{#1}}
\define@key[ru]         {opt@title}{year}                                   {\def\opt@title@year@ru{#1}}
\define@key[ru]         {opt@title}{city}                                   {\def\opt@title@city@ru{#1}}
\define@key[ru]         {opt@title}{company}                                {\def\opt@title@company@ru{#1}}
\define@choicekey*[ru]  {opt@title}{sex}    {male, female}                  {\def\opt@title@position@ru{#1}}
\define@choicekey*[ru]  {opt@title}{type}   {coursework, diploma, report}   {\def\opt@title@type@ru{#1}}

\define@key[en]         {opt@title}{university}                             {\def\opt@title@university@en{#1}}
\define@key[en]         {opt@title}{faculty}                                {\def\opt@title@faculty@en{#1}}
\define@key[en]         {opt@title}{chair}                                  {\def\opt@title@chair@en{#1}}
\define@key[en]         {opt@title}{title}                                  {\def\opt@title@title@en{#1}}
\define@key[en]         {opt@title}{course}                                 {\def\opt@title@group@en{#1}}
\define@key[en]         {opt@title}{author}                                 {\def\opt@title@author@en{#1}}
\define@key[en]         {opt@title}{authorgenitive}                         {\def\opt@title@authorgenitive@en{#1}}
\define@key[en]         {opt@title}{supervisor}                             {\def\opt@title@supervisor@en{#1}}
\define@key[en]         {opt@title}{supervisorPosition}                     {\def\opt@title@supervisorPosition@en{#1}}
\define@key[en]         {opt@title}{reviewer}                               {\def\opt@title@reviewer@en{#1}}
\define@key[en]         {opt@title}{reviewerPosition}                       {\def\opt@title@reviewerPosition@en{#1}}
\define@key[en]         {opt@title}{chairHead}                              {\def\opt@title@chairHead@en{#1}}
\define@key[en]         {opt@title}{year}                                   {\def\opt@title@year@en{#1}}
\define@key[en]         {opt@title}{city}                                   {\def\opt@title@city@en{#1}}
\define@key[en]         {opt@title}{company}                                {\def\opt@title@company@en{#1}}
\define@choicekey*[en]  {opt@title}{sex}    {male, female}                  {\def\opt@title@position@en{#1}}
\define@choicekey*[en]  {opt@title}{type}   {coursework, diploma, report}   {\def\opt@title@type@en{#1}}

\newcommand\filltitle[2]{
    \ifthenelse{\equal{#1}{ru}}
    {
        \presetkeys[#1]{opt@title}{
            type                = {diploma},
            university          = {Федеральное государственное автономное образовательное\\учреждение высшего образования\\ \vspace*{0.1cm}\uppercase{Южный Федеральный Университет}},
            faculty             = {Институт математики, механики и компьютерных наук\\ имени И. И. Воровича},
            chair               = {Направление подготовки\\02.\ifopt@bachelor03\fi\ifopt@master04\fi.02 -- Фундаментальная информатика\\и информационные технологии},
            title               = {title},
            company             = {company},
            sex                 = {male},
            course              = {course},
            author              = {author},
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
            type                = {diploma},
            university          = {Федеральное государственное автономное образовательное\\учреждение высшего образования\\ \vspace*{0.1cm}\uppercase{Южный Федеральный Университет}},
            faculty             = {Институт математики, механики и компьютерных наук\\ имени И. И. Воровича},
            chair               = {Направление подготовки\\02.\ifopt@bachelor03\fi\ifopt@master04\fi.02 -- Фундаментальная информатика\\и информационные технологии},
            title               = {title},
            company             = {company},
            sex                 = {male},
            course              = {course},
            author              = {author},
            supervisor          = {supervisor},
            supervisorPosition  = {supervisorPosition},
            reviewer            = {reviewer},
            reviewerPosition    = {reviewerPosition},
            chairHead           = {chairHead},
            city                = {Ростов-на-Дону},
            year                = {\the\year},
        }{}
    }{}

    \setkeys[#1]{opt@title}{#2}
    
    \ifthenelse{\equal{#1}{ru}}
    {\hypersetup{pdfauthor={\opt@title@author@ru{}}, pdftitle={\opt@title@title@ru{}}}}
    {\hypersetup{pdfauthor={\opt@title@author@en{}}, pdftitle={\opt@title@title@en{}}}}
}



%% Титульная страница
\fancypagestyle{titlepage_fancyhdr}{
	\fancyhf{}
	\renewcommand{\headrulewidth}{0pt}
	\chead
	{
		\vskip 1em
		\uppercase{министерство образования и науки рф} \\
		\vskip 1em
		\opt@title@university@ru \\
		\vskip 1em
		\opt@title@faculty@ru \\
		\vskip 1em
		\opt@title@chair@ru
		\vskip 1em
	}
	\cfoot
	{ \parbox[b]{\textwidth}{\centering \opt@title@city@ru\\ \opt@title@year@ru} }
}

\newcommand\makenewtitle{%
	\begin{titlepage}
		\newgeometry{top=20mm,bottom=20mm,left=20mm,right=15mm,nohead,includeheadfoot}
		\thispagestyle{titlepage_fancyhdr}
		\begin{center}
			\ifthenelse{ \equal{\opt@title@type@ru}{diploma} }
			{
				\vspace*{0.35\textheight}
				\opt@title@author@ru \\
				\vskip 1em
			}
			%else
			{ \vspace*{0.33\textheight} }
			
			\ifthenelse{ \not\equal{\opt@title@type@ru}{diploma} }
			{
				\opt@title@title@ru \\
				\vskip 1em
			}
			
			\ifthenelse{ \equal{\opt@title@type@ru}{diploma} }
			{ Курсовая работа }
			%else
			{
				\ifthenelse{ \equal{\opt@title@ru}{diploma} }
				{ Магистерская диссертация }
				%else
				{
					\ifthenelse{ \equal{\opt@title@type@ru}{diploma} }
					{ Выпускная квалификационная работа\\на степень бакалавра }
					% else
					{
						\ifthenelse{ \equal{\opt@title@type@ru}{diploma} }
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
%			
			\ifthenelse{\equal{\opt@title@type@ru}{diploma}} % магистерская
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
				\ifthenelse{\equal{\opt@title@sex@ru}{male}}{Студента}{Студентки}\space \opt@title@group@ru\space курса \\
				\opt@title@author@ru \\
				\vskip 0.5em
				Научный руководитель:\\
				\opt@title@supervisorPosition@ru\ \opt@title@supervisor@ru \\
			}
			
			\vskip 5em
			\ifthenelse{\equal{\opt@title@type@ru}{diploma}} % место для допуска
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


%% Переопределяем maketitle
\renewcommand\maketitle{
	% Создаем фиктивный счетчик, чтобы включить первую страницу в нумерацию
	\newcounter{titlepages}
	\setcounter{titlepages}{1}
	
	
	% Выводим титульную страницу
	\begin{spacing}{1.0}
		\makenewtitle
		\addtocounter{titlepages}{1}
	\end{spacing}
	\setcounter{page}{\value{titlepages}}
	
	\thispagestyle{empty}
	% возвращаем нормальные значения отступов
	\newgeometry{top=20mm,bottom=20mm,left=25mm,right=20mm,nohead,includeheadfoot}
}


%% Оглавление -> Содержание
\AtBeginDocument{\renewcommand{\contentsname}{Содержание}}


%% Полуторный интервал
\onehalfspacing


%% Красная строка
%\setlength{\parindent}{15pt}


% Новая страница с каждой subsection
%\addtokomafont{subsection}{\clearpage}


%\setcounter{secnumdepth}{4} %% глубина нумерации
%\setcounter{tocdepth}{4}    %% глубина ToC