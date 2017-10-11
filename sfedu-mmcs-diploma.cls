% По-хорошему, нужно перенести на KOMA-Script и выкинуть fancyhdr с tocloft
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{sfedu-mmcs-diploma}[2017/05/12 SFedU MMCS diploma class]
\LoadClass[a4paper, 14pt]{extarticle}

\usepackage[]{fancyhdr}
\usepackage[]{geometry}
\usepackage[]{ifthen}
\usepackage{fontspec}
\usepackage[]{polyglossia}
\usepackage[]{indentfirst}
\usepackage[]{xkeyval}
\usepackage[nodisplayskipstretch]{setspace}
\usepackage[]{tocloft}
\usepackage[colorlinks = true,
			urlcolor   = black,
			linkcolor  = black,
			filecolor  = black,
			citecolor  = black]
{hyperref}

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

%% Язык
\setmainlanguage[spelling=modern]{russian}
%\setotherlanguage{english}

%% Шрифты
\defaultfontfeatures{Ligatures=TeX,Mapping=tex-text}
\setmainfont{Times New Roman}
\newfontfamily\cyrillicfont{Times New Roman}
\setsansfont{Arial}
\newfontfamily\cyrillicfontsf{Arial}
\setmonofont{Courier New}
\newfontfamily\cyrillicfonttt{Courier New}

%% Параметры заполнения титульного листа
\define@key{mytitle}{university}{\def\my@title@university{#1}}
\define@key{mytitle}{faculty}{\def\my@title@faculty{#1}}
\define@key{mytitle}{chair}{\def\my@title@chair{#1}}
\define@key{mytitle}{title}{\def\my@title@title{#1}}
\define@choicekey*{mytitle}{position}{male, female}{\def\my@title@position{#1}}
\define@key{mytitle}{group}{\def\my@title@group{#1}}
\define@key{mytitle}{author}{\def\my@title@author{#1}}
\define@key{mytitle}{supervisor}{\def\my@title@supervisor{#1}}
\define@key{mytitle}{supervisorPosition}{\def\my@title@supervisorPosition{#1}}
\define@key{mytitle}{reviewer}{\def\my@title@reviewer{#1}}
\define@key{mytitle}{reviewerPosition}{\def\my@title@reviewerPosition{#1}}
\define@key{mytitle}{chairHead}{\def\my@title@chairHead{#1}}
\define@key{mytitle}{chairHeadPosition}{\def\my@title@chairHeadPosition{#1}}
\define@key{mytitle}{year}{\def\my@title@year{#1}}
\define@key{mytitle}{city}{\def\my@title@city{#1}}
\define@key{mytitle}{company}{\def\my@title@company{#1}}
\define@choicekey*{mytitle}{type}{coursework,master,bachelor,bachelorreport}{\def\my@title@type{#1}}

\newcommand\filltitle[1]{
    \presetkeys{mytitle}{
     	type 			  = {bachelor},
      	university 		  = {Федеральное государственное автономное образовательное\\учреждение высшего образования\\ \vspace*{0.1cm}\uppercase{Южный Федеральный Университет}},
      	faculty    		  = {Институт математики, механики и компьютерных наук\\ имени И. И. Воровича},
	  	chair      		  = {Направление подготовки\\02.\ifthenelse{\equal{\my@title@type}{master}}{04}{03}.02 -- Фундаментальная информатика\\и информационные технологии},
	  	title			  = {title},
	  	company			  = {company},
	  	position		  = {male},
	  	group 			  = {group},
	  	author			  = {author},
	  	supervisor		  = {supervisor},
	  	supervisorPosition= {supervisorPosition},
	  	reviewer          = {reviewer},
   	    reviewerPosition  = {reviewerPosition},
   	    chairHead 		  = {chairHead},
      	chairHeadPosition = {chairHeadPosition},
      	city 			  = {Ростов-на-Дону},
      	year 			  = {\the\year},
    }{}
    \setkeys{mytitle}{#1}
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
		\my@title@university \\
		\vskip 1em
		\my@title@faculty \\
		\vskip 1em
		\my@title@chair
		\vskip 1em
	}
	\cfoot
	{ \parbox[b]{\textwidth}{\centering \my@title@city\\ \my@title@year} }
}

\newcommand\makenewtitle{%
\begin{titlepage}
	\newgeometry{top=20mm,bottom=20mm,left=20mm,right=15mm,nohead,includeheadfoot}
	\thispagestyle{titlepage_fancyhdr}
	\begin{center}
		\ifthenelse{ \equal{\my@title@type}{master} }
		{
			\vspace*{0.35\textheight}
			\my@title@author \\
			\vskip 1em
		}
		%else
		{ \vspace*{0.33\textheight} }
		
		\ifthenelse{ \not\equal{\my@title@type}{bachelorreport} }
		{
			\my@title@title \\
			\vskip 1em
		}
	
		\ifthenelse{ \equal{\my@title@type}{coursework} }
		{ Курсовая работа }
		%else
		{
			\ifthenelse{ \equal{\my@title@type}{master} }
			{ Магистерская диссертация }
			%else
			{
				\ifthenelse{ \equal{\my@title@type}{bachelor} }
				{ Выпускная квалификационная работа\\на степень бакалавра }
				% else
				{
					\ifthenelse{ \equal{\my@title@type}{bachelorreport} }
					{
						\uppercase{Отчет} \\
						о преддипломной практике \\
						в \my@title@company 
					}
				}
			}
			\\
		}
		\vskip 3em
	
		\ifthenelse{\equal{\my@title@type}{master}} % магистерская
		{
			\vskip 4em
			\normalsize \raggedleft 
			Научный руководитель:\\
			\my@title@supervisorPosition\ \my@title@supervisor \\
			\vskip 0.5em
			Рецензент:\\
			\my@title@reviewerPosition\ \my@title@reviewer
		}
		%else % бакалаврская или курсовая
		{
			\normalsize\raggedleft 
			\ifthenelse{\equal{\my@title@position}{male}}{Студента}{Студентки}\space \my@title@group\space курса \\
			\my@title@author \\
			\vskip 0.5em
			Научный руководитель:\\
			\my@title@supervisorPosition\ \my@title@supervisor \\
		}
	
		\vskip 5em
		\ifthenelse{\equal{\my@title@type}{bachelor}} % место для допуска
		{
			\begin{flushleft}
				Допущено к защите: \\
				руководитель направления ФИИТ \underline{\hspace{4cm}} \my@title@chairHead
			\end{flushleft}
		}{}
		\ifthenelse{\equal{\my@title@type}{coursework}} % место для рейтинга
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

\renewcommand\maketitle{
	\newcounter{titlepages}
	\setcounter{titlepages}{1}
	\begin{spacing}{1.0}
		\makenewtitle
		\addtocounter{titlepages}{1}
	\end{spacing}
	\setcounter{page}{\value{titlepages}}
	\newgeometry{a4paper,top=20mm,bottom=20mm,left=25mm,right=20mm,nohead,includeheadfoot}
}

%% Стили оглавления
\renewcommand{\cftsecleader}{\cftdotfill{\cftdotsep}}
\renewcommand\cftsecfont{\mdseries}
\renewcommand\cftsecpagefont{\mdseries}

\renewcommand{\cfttoctitlefont}{\normalfont\Large\bfseries}
\AtBeginDocument{\renewcommand{\contentsname}{Содержание}}

%% Полуторный интервал
\onehalfspacing

