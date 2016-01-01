####################
# Makefile
####################

ROOT_DIR = ./

GATHER_DIR = $(ROOT_DIR)gather/
GATHERED_DIR = $(ROOT_DIR)gathered/
GATHER_SOURCE = $(wildcard $(GATHER_DIR)*.Rmd)
GATHERED = $(patsubst $(GATHER_DIR)%.Rmd, $(GATHERED_DIR)%.rda, $(GATHER_SOURCE))

COOK_DIR = $(ROOT_DIR)cook/
COOKED_DIR = $(ROOT_DIR)cooked/
COOK_SOURCE = $(wildcard $(COOK_DIR)*.Rmd)
COOKED = $(patsubst $(COOK_DIR)%.Rmd, $(COOKED_DIR)%.rda, $(COOK_SOURCE))

ANALYZE_DIR = $(ROOT_DIR)analyze/
ANALYZED_DIR = $(ROOT_DIR)analyzed/
ANALYZE_SOURCE = $(wildcard $(ANALYZE_DIR)*.Rmd)
ANALYZED = $(patsubst $(ANALYZE_DIR)%.Rmd, $(ANALYZED_DIR)%.rda, $(ANALYZE_SOURCE))

PRESENT_DIR = $(ROOT_DIR)present/
PRESENTED_DIR = $(ROOT_DIR)presented/
PRESENT_DOC_SOURCE = $(wildcard $(PRESENT_DIR)*-d.Rmd)
PRESENTED_DOCX = $(patsubst $(PRESENT_DIR)%-d.Rmd, $(PRESENTED_DIR)%.docx, $(PRESENT_DOC_SOURCE))
PRESENT_HTML_SOURCE = $(wildcard $(PRESENT_DIR)*-h.Rmd)
PRESENTED_HTML = $(patsubst $(PRESENT_DIR)%-h.Rmd, $(PRESENTED_DIR)%.html, $(PRESENT_HTML_SOURCE))
PRESENTED = $(PRESENTED_HTML) $(PRESENTED_DOCX)

KNIT = Rscript -e "rmarkdown::render('$<')"
GATHER = $(KNIT)
COOK = Rscript -e "rmarkdown::render('$<', output_dir = '$(COOKED_DIR)')"
ANALYZE = Rscript -e "rmarkdown::render('$<', output_dir = '$(ANALYZED_DIR)')"
PRESENT = Rscript -e "rmarkdown::render('$<', output_dir = '$(PRESENTED_DIR)', output_file = '$@')"

###################################################
# Main recipe
all: $(GATHERED) $(COOKED) $(ANALYZED) $(PRESENTED)
###################################################

#########################
## Gather
$(GATHERED_DIR)%.rda:$(GATHER_DIR)%.Rmd $(GATHER_DIR)%.sql
	$(GATHER)

#########################
# Process
$(COOKED_DIR)%.rda:$(COOK_DIR)%.Rmd $(GATHERED)
	$(COOK)

#########################
# Analyze
$(ANALYZED_DIR)%.rda:$(ANALYZE_DIR)%.Rmd $(COOKED)
	$(ANALYZE)

#########################
# Present
$(PRESENTED_DIR)%.html:$(PRESENT_DIR)%-h.Rmd $(ANALYZED)
	$(PRESENT)

$(PRESENTED_DIR)%.docx:$(PRESENT_DIR)%-d.Rmd $(ANALYZED)
	$(PRESENT)

clean:
	rm -fv $(GATHERED)
	rm -fv $(COOKED)
	rm -fv $(ANALYZED)
	rm -fv $(PRESENTED)

clean_cooked:
	rm -fv $(COOKED)
	rm -fv $(ANALYZED)
	rm -fv $(PRESENTED)
