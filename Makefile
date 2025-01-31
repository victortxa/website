PY=python
PELICAN=pelican
PELICANOPTS=

BASEDIR=$(CURDIR)
INPUTDIR=$(BASEDIR)/content
OUTPUTDIR=$(BASEDIR)/output
CONFFILE=$(BASEDIR)/conf.py
PUBLISHCONF=$(BASEDIR)/publishconf.py


html: clean $(OUTPUTDIR)/index.html

help:
	@echo 'Usage:'
	@echo '   make html         (re)generate the web site          '
	@echo '   make clean        remove the generated files         '
	@echo '   make regenerate   regenerate files upon modification '
	@echo '   make publish      generate using production settings '
	@echo '   make serve        start a server in port 8001        '
	@echo ''

$(OUTPUTDIR)/%.html:
	$(PELICAN) $(INPUTDIR) -o $(OUTPUTDIR) -s $(CONFFILE) $(PELICANOPTS)

debug:
	$(PELICAN) $(INPUTDIR) -o $(OUTPUTDIR) -s $(CONFFILE) $(PELICANOPTS) -D

clean:
	[ ! -d $(OUTPUTDIR) ] || find $(OUTPUTDIR) -mindepth 1 -delete
	rm -f *.pyc
	rm -rf cache

regenerate: clean
	$(PELICAN) -r $(INPUTDIR) -o $(OUTPUTDIR) -s $(CONFFILE) $(PELICANOPTS)

serve:
	cd $(OUTPUTDIR) && $(PY) -m SimpleHTTPServer 8005

publish:
	$(PELICAN) $(INPUTDIR) -o $(OUTPUTDIR) -s $(PUBLISHCONF) $(PELICANOPTS)

.PHONY: html help clean regenerate publish serve
