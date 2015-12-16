
# inFile <- readLines("../gather/Hitters.Rmd")
#
# yamlBlocks <- grep("^---\\s*$", inFile)
# numBlocks <- length(yamlBlocks) / 2
# evens <- seq(2, by=2, length.out = numBlocks)
# odds <- evens - 1
# starts <- yamlBlocks[odds] + 1
# ends <- yamlBlocks[evens] - 1
#
# yamlMatter <- vector("list", numBlocks)
#
# for (i in 1:numBlocks){
#   yamlMatter[[i]] <- inFile[starts[i]:ends[i]]
# }
#
# yamlMatter <- lapply(yamlMatter, paste, collapse = "\n")
# yamlMatter <- lapply(yamlMatter, yaml::yaml.load)
#
# blockNames <- lapply(yamlMatter, names) %>% lapply(`[`, 1)
#
# represMatter <- yamlMatter[blockNames == "represtools"]
