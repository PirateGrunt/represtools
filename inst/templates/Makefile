####################
# Makefile

# GATHER_DIR  = ./gather
# COOK_DIR = ./cook
# ANALYZE_DIR = ./analyze
# PUBLISH_DIR = ./publish

GATHER_SOURCE = $(wildcard ./gather/*.Rmd)
GATHERED =

COOK_SOURCE = $(wildcard ./cook/*.Rmd)
COOKED =

ANALYZE_SOURCE = $(wildcard ./analyze/*.Rmd)
ANALYZED =

PUBLISH_SOURCE = $(wildcard ./publish/*.Rmd)
PUBLISHED =

KNIT = Rscript -e "require(rmarkdown); render('$<')"
PUBLISH = Rscript -e "require(rmarkdown); render('$<', output_dir = '../published')"

#########################
## Build recipes
#########################

all: $(GATHERED) $(COOKED) $(ANALYZED) $(PUBLISHED)

cooked: $(COOKED) $(ANALYZED) $(PUBLISHED)

#########################
## Gather
#########################

$(GATHER_DIR)/%.docx:$(GATHER_DIR)/%.Rmd
	$(KNIT)

#########################
# Cook
#########################

$(COOK_DIR)/%.docx:$(COOK_DIR)/%.Rmd $(GATHER_OUT)
	$(KNIT)

#########################
# Analyze
#########################

$(ANALYZE_DIR)/%.docx:$(ANALYZE_DIR)/%.Rmd $(COOK_OUT)
	$(KNIT)

#########################
# Publish
#########################

$(PUBLISH_DIR)/%.html:$(PUBLISH_DIR)/%.Rmd $(ANALYZE_OUT)
	$(PUBLISH)

clean:
	rm -fv $(GATHERED)
	rm -fv $(COOKED)
	rm -fv $(ANALYZED)
	rm -fv $(PUBLISHED)

cleanCooked:
	rm -fv $(COOKED)
	rm -fv $(ANALYZED)
	rm -fv $(PUBLISHED)
