[![Travis-CI Build Status](https://travis-ci.org/PirateGrunt/represtools.svg?branch=master)](https://travis-ci.org/PirateGrunt/represtools)
[![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/represtools)](http://cran.r-project.org/package=represtools)
[![Downloads from the RStudio CRAN mirror](http://cranlogs.r-pkg.org/badges/grand-total/represtools)](https://cran.r-project.org/package=represtools)
[![codecov](https://codecov.io/gh/PirateGrunt/represtools/branch/master/graph/badge.svg)](https://codecov.io/gh/PirateGrunt/represtools)
[![Coverage Status](https://coveralls.io/repos/github/PirateGrunt/represtools/badge.svg?branch=master)](https://coveralls.io/github/PirateGrunt/represtools?branch=master)


# represtools

Basic utility functions to support reproducible research. Based on ideas published by Christopher Gandrud. This package relies on four stages of data analysis:

1. Gather - collect data
2. Cook - alter raw data so that it is fit for analysis
3. Analyze - construct models or other analysis
4. Present - synthesize the analysis so that it may be presented to an end-user or decision maker

## A sample workflow

```
represtools::NewResearch("Baseball")
represtools::Gather("Hitters")

# write some code

represtools::Cook("Hitters")

# write some code

represtools::Analyze("Handedness")

# write some code

represtools::Present("Handedness", title = "On the quality of right-handed batters", output = "html")

# write some code

represtools::Make()
```

This workflow ensures that anything which changes at an earlier stage of the process _must_ force reconstruction of later stages.

More information is available here: [http://pirategrunt.com/represtools/](http://pirategrunt.com/represtools/).
