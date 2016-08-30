####################
# Makefile

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
PRESENT_SOURCE = $(wildcard $(PRESENT_DIR)*.Rmd)
PRESENTED = $(patsubst $(PRESENT_DIR)%.Rmd, $(PRESENTED_DIR)%.rda, $(PRESENT_SOURCE))

KNIT = Rscript -e "rmarkdown::render('$<')"
GATHER = Rscript -e "rmarkdown::render('$(<:.sql=.Rmd)', output_dir = '$(GATHERED_DIR)')"
COOK = Rscript -e "rmarkdown::render('$<', output_dir = '$(COOKED_DIR)')"
ANALYZE = Rscript -e "rmarkdown::render('$<', output_dir = '$(ANALYZED_DIR)')"
PRESENT = Rscript -e "rmarkdown::render('$<', output_dir = '$(PRESENTED_DIR)')"

#///////////////////////////////////////////////////
## M A I N   R E C I P E
all: $(GATHERED) $(COOKED) $(ANALYZED) $(PRESENTED)

## End Main recipe
##==================================================

#///////////////////////////////////////////////////
## O N L Y  C O O K
no_gather: $(COOKED) $(ANALYZED) $(PRESENTED)

## End no_gather
##==================================================

#///////////////////////////////////////////////////
## G A T H E R
gather: $(GATHERED)
$(GATHER_DIR)%.Rmd:$(GATHER_DIR)%.sql
	@echo =============================================
	@echo == SQL updated for $(@:.Rmd=.)
	@echo =============================================
	touch $@

$(GATHERED_DIR)%.rda:$(GATHER_DIR)%.Rmd
	@echo =============================================
	@echo == Working on $(<:.Rmd=.)
	@echo =============================================
	$(GATHER)

## End Gather
##==================================================

#///////////////////////////////////////////////////
# C O O K
cook: $(COOKED)
$(COOKED_DIR)%.rda:$(COOK_DIR)%.Rmd $(GATHERED)
	@echo =============================================
	@echo == Working on $(<:.Rmd=.)
	@echo =============================================
	$(COOK)

## End Cook
##==================================================

#///////////////////////////////////////////////////
## A N A L Y Z E
analyze: $(ANALYZED)
$(ANALYZED_DIR)%.rda:$(ANALYZE_DIR)%.Rmd $(COOKED)
	@echo =============================================
	@echo == Analyze $(<:.Rmd=)
	@echo =============================================
	$(ANALYZE)

## End Anaylze
##==================================================

#///////////////////////////////////////////////////
## P R E S E N T
$present: $(PRESENTED)
$(PRESENTED_DIR)%.rda:$(PRESENT_DIR)%.Rmd $(ANALYZED)
	@echo =============================================
	@echo == Working on $(<:.Rmd=)
	@echo =============================================
	$(PRESENT)

## End Present
##==================================================

clean:
	rm -fv $(COOKED_DIR)/*
	rm -fv $(ANALYZED_DIR)/*
	rm -fv $(PRESENTED_DIR)/*
