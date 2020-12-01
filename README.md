# PdM
PdM is an R package for predictive maintenance
_________________________________________________
![](https://github.com/forvis/PdM/blob/main/data/Pdm2019.PNG)
_________________________________________________
## Installation

You can install the development version of the forvision package
(containing the latest improvements and bug fixes) from github:

``` r
intall.packages("devtools")
devtools::install_github("forvis/PdM", build_vignettes = TRUE)
```

The PdM package also provides interactive graphical user interface (web-application) developed by using Shiny (Cerulean theme). To use interactive graphical user interface of the PdM package use:
```r
library(PdM)
runShinyPdM()
```
