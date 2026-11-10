\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{notes}[2014/12/16 Notes for various letures]

% ----- Options ---------------------------------------------------------------

\newif\if@chaptertitle\@chaptertitlefalse
\DeclareOption{chaptertitle}{\@chaptertitletrue}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrreprt}}
\ProcessOptions\relax
\LoadClass[twoside=semi,chapterprefix,usegeometry]{scrreprt}

% ----- Packages --------------------------------------------------------------

% Better fonts with accents and italian
\RequirePackage[T1]{fontenc}
\RequirePackage[utf8]{inputenc}
\RequirePackage[british]{babel}

% Fonts
% \RequirePackage{newtxtext,newtxmath}
% \RequirePackage{helvet}
% \RequirePackage{marcellus}
\RequirePackage{ebgaramond}
\RequirePackage[ebgaramond,cmintegrals,cmbraces]{newtxmath}

\RequirePackage{fontspec}
\setsansfont{QTOptimum}

% Required for starred commands
\RequirePackage{suffix}

% Math symbols
\RequirePackage{amsmath}
\RequirePackage{amsfonts}
% \RequirePackage{amsthm}
% \RequirePackage{amssymb}
\RequirePackage{centernot}
\RequirePackage{bm}
\RequirePackage{physics}
\RequirePackage{siunitx}
\sisetup{per-mode=symbol}


% Nice lists
\RequirePackage{enumerate}
% \RequirePackage{enumitem}

% Nice images, figures, and listings
\RequirePackage{graphicx}
\RequirePackage{subfig}
\RequirePackage{grffile}
\RequirePackage{wrapfig}
\RequirePackage{fancyvrb}
\RequirePackage{listings}
\RequirePackage{framed}
\RequirePackage[dvipsnames]{xcolor}

% Conditionals
\RequirePackage{ifthen}

% Header & Page Setup
\RequirePackage[automark]{scrlayer-scrpage}
\RequirePackage[
    top=2.5cm,
    bottom=2.5cm,
    left=5.5cm,
    right=2.5cm,
    %right=5.5cm,
    %left=2.5cm,
    marginparwidth=4cm,
    includeheadfoot
]{geometry}

% Links
\RequirePackage{hyperref}

\hypersetup{
  colorlinks, urlcolor=., bookmarks
}
\renewcommand\UrlFont{\color{blue}}
\newcommand\mail[1]{\href{mailto:#1}{\color{blue}#1}}

% natbib
\RequirePackage[super]{natbib}
\bibpunct{}{}{,}{s}{}{\textsuperscript{,}}
\renewcommand\bibnumfmt[1]{#1.}

% ----- Define colors ---------------------------------------------------------

\colorlet{shadecolor}{gray!20!white}

% ----- Maketitle -------------------------------------------------------------


\newif\if@citempty\@citemptytrue
\def\@citationtext{\@empty}
\def\@citationauthor{\@empty}
\def\@university{\@empty}
\def\@version{\@empty}
\def\@lecture{\@empty}
\def\@class{\@empty}

\def\class#1{\renewcommand\@class{(#1)}}
\def\@class{\@latex@error{No \noexpand\class given}\@ehc}
\DeclareRobustCommand\citation[2]{\gdef\@citationtext{#1}\gdef\@citationauthor{#2}\@citemptyfalse}
\DeclareRobustCommand\lecture[1]{\gdef\@lecture{#1}}
\DeclareRobustCommand\version[1]{\gdef\@version{#1}}
\DeclareRobustCommand\university[1]{\gdef\@university{#1}}

% All prof.
\gdef\@professor{}
\DeclareRobustCommand\professor[1]{
  \g@addto@macro\@professor{Prof.: \hfill #1 \\}
}

\renewcommand{\maketitle}[0]{
  \thispagestyle{empty}
  \begin{flushleft}
    \vspace*{6em}
    {\Huge \sffamily {\bfseries\@author}}\par
    \vspace{0.75em}
    {\Large\sffamily\@university}\par
    \vspace{2.5em}
    {
      \bfseries\fontsize{25pt}{28pt}\selectfont\sffamily 
      Lecture notes\par\vspace{0.2em}
      % \begin{framed}
        \fontsize{45}{46}\selectfont\@lecture\par
      % \end{framed}
    }
    \vspace*{2em}
    {\Huge \sffamily \@class} \par
    \vfill
    {\sffamily (\@date) vers. \@version}
    \hfill
    \begin{minipage}[b]{4.5cm}
      {\sffamily \@professor}
    \end{minipage}
  \end{flushleft}
  \if@citempty
    \cleardoublepage
  \else
    \clearpage
    \thispagestyle{empty}
    \vspace*{7.5cm}
    {
      \flushright
      \begin{minipage}{9.5cm}
        \flushright
        \@citationtext\par\medskip
        -- \@citationauthor
      \end{minipage}
      \clearpage
    }
  \fi
}

\hypersetup{
  pdfpagelabels,
  hidelinks,
  pdftitle={Notes},
  pdfauthor={Mattia Sotgia},
  pdfcreator={\copyright~ \the\year~ Mattia Sotgia},
  pdfpagelayout={TwoColumnRight}
}

% ----- Headers & footers -----------------------------------------------------

% Bare copy from D.J. Griffiths 'Introduction to Electrodynamic' textbook
\pagestyle{scrheadings}
\setkomafont{pagenumber}{\bfseries\small\sffamily\upshape}
\setkomafont{pagehead}{\small\sffamily\upshape}
\rohead{\pagemark}
\lohead{\rightmark}
\lehead{\llap{\rlap{\pagemark}\hspace*{3cm}}\leftmark}
\ofoot{}

% ----- Chapter page ----------------------------------------------------------

\renewcommand\raggedchapter{\raggedright}
\renewcommand*{\chapterformat}{%
  \if@chaptertitle\llap{\chaptername\hspace{35pt}}\par\vspace{0.5cm}\else\fi
  \llap{\fontsize{65}{73}\selectfont{\thechapter}\hspace*{35pt}}
  }

\renewcommand\chapterlinesformat[3]{%
\ifstr{#1}{chapter}
    {\hfill#2\makebox[0pt][r]{\parbox[b]{\textwidth}{\raggedchapter#3}}}%
    {\@hangfrom{#2}{#3}}% original definition for other commands with style=chapter
}

\RequirePackage{marginnote}
\RequirePackage{mparhack}
\RequirePackage{scrlayer-notecolumn}

\RedeclareSectionCommand[
    afterskip=-\parindent
]{section}
\RedeclareSectionCommand[
    afterskip=-\parindent
]{subsection}
\RedeclareSectionCommand[
    afterskip=-\parindent
]{subsubsection}

\renewcommand*\sectionformat{{\bfseries\thesection}\enskip}
\renewcommand*\subsectionformat{{\bfseries\thesubsection}\enskip}
\renewcommand*\subsubsectionformat{{\bfseries\thesubsubsection}\enskip}

\setkomafont{section}{\normalfont\large\sffamily\uppercase}
\setkomafont{subsection}{\normalfont\large\sffamily}
\setkomafont{subsubsection}{\normalfont\sffamily}

\renewcommand*\thesection{\arabic{chapter}-\arabic{section}}


\renewcommand{\sectioncatchphraseformat}[4]{%
	\ifstr{#1}{paragraph}{
		\@hangfrom{\hskip #2#3}{#4}%
	}{\Ifthispageodd{
		\reversemarginpar
		\marginnote{
			\raggedleft%\bfseries\large\sffamily
			#3\par
			#4}
		}{
		\marginnote{
			\raggedleft%\bfseries\large\sffamily
			#3\par
			#4}
		}
}}

% ----- TOC -------------------------------------------------------------------

\RedeclareSectionCommands[%
  toclinefill={,\enskip},%
  tocraggedpagenumber,%
  tocpagenumberbox=\mbox
]{part,chapter,section,subsection,subsubsection,paragraph,subparagraph}


% ----- Define \helv ----------------------------------------------------------

\def\helv{\fontfamily{phv}\selectfont}

% ----- Quotes ----------------------------------------------------------------

\renewenvironment{quote}{
  \def\FrameCommand{\vrule width 0.75pt}
    \MakeFramed {\advance\hsize-\width \FrameRestore}
      \list{}{\rightmargin\leftmargin}%
        \item\relax
}{
  \endlist
    \endMakeFramed
}

% ----- Enviroment floating {box} ---------------------------------------------

\DeclareNewTOC[
  type=memofloat,
  float,
  name=Nota,
  counterwithin=chapter
]{memofloat}

\newenvironment{memo}[1][]{
  \begin{memofloat}
    \begin{shaded}
      \caption{#1}
}{
    \end{shaded}
  \end{memofloat}
}

% ----- Caption for figures ---------------------------------------------------

\setkomafont{caption}{\ifstr{\@captype}{memofloat}{\raggedright\fontsize{10pt}{12pt}}{\fontsize{8pt}{9pt}\selectfont}\sffamily}
\setkomafont{captionlabel}{\ifstr{\@captype}{memofloat}{\bfseries\fontsize{10pt}{12pt}}{\fontsize{8pt}{9pt}\selectfont}\sffamily}
\renewcommand{\thefigure}{\arabic{chapter}--\arabic{figure}}
\setcapindent{0pt}

\renewcommand\labelitemi{\textendash}
\renewcommand\labelitemii{\textendash}
\renewcommand\labelitemiii{\textendash}
\renewcommand\labelitemiv{\textendash}

% ----- Appendix --------------------------------------------------------------

\let\tmpappendix=\appendix

\renewcommand{\appendix}{
  \tmpappendix
  % \renewcommand{\chaptername}{Appendice}
  \renewcommand\thesection{\Alph{chapter}-\arabic{section}}
}

\DeclareFixedFont\trfont{OT1}{phv}{b}{sc}{11}

% -----------------------------------------------------------------------------

\RequirePackage[left]{showlabels}
\renewcommand\showlabelfont{\footnotesize\ttfamily}


% Common graphics path
\graphicspath{{figures/}}