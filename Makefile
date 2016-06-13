# Makefile for the LaTeX Thesis Example Files

FILES= thesis.bib thesis.tex \
WSU/abstract.tex WSU/approvalPage.tex WSU/titlePage.tex \
LaTeX/acmtrans.bst LaTeX/pmthesis.cls \
Chapters/english.tex Chapters/intro.tex	\
Chapters/latexStyle.tex Chapters/learn.tex Chapters/pmthesis.tex \
Chapters/techReport.tex Chapters/tools.tex Chapters/typeWriting.tex \
Tables/metrictab.tex \
Figures/tiger.pdf Figures/trie.tex

%.src: %.c
	indent -kr -i2 --no-tabs  $<
	echo \\singleSpacing \\begin\{verbatim\} > $@
	cat $<  >> $@
	echo \\end\{verbatim\}\\doubleSpacing  >> $@

thesis.pdf: ${FILES} thesis.bbl
	pdflatex thesis
	if ( fgrep 'Rerun to get cross-references right' thesis.log ) ; then \
		pdflatex thesis; \
	fi

all:	thesis.dvi thesis.pdf archive
	pdflatex thesis


thesis.dvi: ${FILES} thesis.bbl
	latex thesis
	if ( fgrep 'Rerun to get cross-references right' thesis.log ) ; then \
		latex thesis; \
	fi

thesis.ps: thesis.dvi
	dvips -o thesis.ps thesis.dvi

pdf:	thesis.dvi
	pdflatex thesis

thesis.bbl: ${FILES}
	pdflatex thesis
	bibtex thesis

tar archive: clean
	(cd ..; tar -cjf thesis`date '+%G%m%d%H%M'`.tbz Thesis)

clean:
	rm -f *~ *.dvi *.aux *.log *.lot *.lof *.toc *.out \
	*.bbl *.blg *.gz *.pdf *.ps \
	Chapters/*~ Figures/*~ Tables/*~ WSU/*~ LaTeX/*~
