filename = vorlage

neededfiles = vorlage.tex abkuerzungen.tex einleitung.tex einstellungen.tex grundlagen.tex hauptteil.tex schluss.tex literatur.bib


UNAME_S := $(shell uname -s)

ifeq ($(UNAME_S), Linux)
	pdflatexcmd = pdflatex
	bibtexcmd = bibtex
	pdfviewercmd = atril
endif

ifeq ($(UNAME_S), Darwin)
	pdflatexcmd = /usr/texbin/pdflatex
	bibtexcmd = /usr/texbin/bibtex
	pdfviewercmd = open
endif


all: $(neededfiles) latex clean
latex:
	$(pdflatexcmd) $(filename)
	$(bibtexcmd) $(filename)
	$(pdflatexcmd) $(filename)
	$(pdflatexcmd) $(filename)

view:
	if [ -f $(filename).pdf ]; then \
		$(pdfviewercmd) $(filename).pdf; \
	else \
		$(MAKE) all ;\
		$(MAKE) view ;\
	fi
clean:
	git clean -fx
distclean:
	git checkout -f master
	$(MAKE) clean
