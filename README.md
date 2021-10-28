A Gentle Introduction to Bayesian Statistics
================

This repository will contain course material for the one-day course “A
Gentle Introduction to Bayesian Statistics” at the [Epinor Annual
Meeting
2021](https://en.uit.no/forskning/forskningsgrupper/nyheter/artikkel?p_document_id=476300&sub_id=744901).

The plan for the day is as follows:

| Time          | What                                          |
|---------------|-----------------------------------------------|
| 10:00 - 11:30 | Part I - Introduction to Bayesian Statistics  |
| 11:30 - 12:30 | Lunch                                         |
| 12:30 - 14:00 | Part II - Bayesian Workflow for Data Analysis |
| 14:15 - 15:15 | Part III - Bayesian Analysis with R           |
| 15:30 - 17:00 | Exercises with “brms” in R                    |

The course material is not quite ready yet, but below are some
instructions for those who want to have the ‘brms’ packages properly
installed before we start.

# Setup

If you want to follow the last session, “Exercises with ‘brms’ in R”,
please follow the instructions here to make sure your system is properly
set up. Installing ‘brms’ is slightly more complicated than installing
most other R packages, and I will of course also help with this on-site.

First, if you don’t have it already, [download
RStudio](https://www.rstudio.com/products/rstudio/download/#download).

Next, make sure you have R version 4.1.0 or later installed. If in
doubt, open RStudio and type `sessionInfo()`. It should give you
something like this, with the R version printed on the first line.

``` r
sessionInfo()
```

    ## R version 4.1.1 (2021-08-10)
    ## Platform: x86_64-apple-darwin17.0 (64-bit)
    ## Running under: macOS Big Sur 10.16
    ## 
    ## Matrix products: default
    ## BLAS:   /Library/Frameworks/R.framework/Versions/4.1/Resources/lib/libRblas.0.dylib
    ## LAPACK: /Library/Frameworks/R.framework/Versions/4.1/Resources/lib/libRlapack.dylib
    ## 
    ## locale:
    ## [1] en_US.UTF-8/en_US.UTF-8/en_US.UTF-8/C/en_US.UTF-8/en_US.UTF-8
    ## 
    ## attached base packages:
    ## [1] stats     graphics  grDevices utils     datasets  methods   base     
    ## 
    ## loaded via a namespace (and not attached):
    ##  [1] compiler_4.1.1  magrittr_2.0.1  fastmap_1.1.0   tools_4.1.1    
    ##  [5] htmltools_0.5.2 yaml_2.2.1      stringi_1.7.5   rmarkdown_2.11 
    ##  [9] knitr_1.36      stringr_1.4.0   xfun_0.27       digest_0.6.28  
    ## [13] rlang_0.4.12    evaluate_0.14

If the version is too old, [go here to download the latest
version](https://cloud.r-project.org/).

Next, we need to install ‘brms’. The instructions below are hopefully
sufficient, but if you have trouble, please write me an e-mail or (even
better) open an [Issue in this
repository](https://github.com/osorensen/BayesCourseEPINOR2021/issues),
since then everyone else will be able to see.

## Mac OS

If you’re on a Mac, make sure you have Xcode installed. You can install
Xcode by [clicking this link which you can open in App
Store](https://apps.apple.com/us/app/xcode/id497799835?mt=12).

After you’ve installed Xcode, issue this command:

``` r
install.packages("brms")
```

## Windows

On Windows, you first need to install RTools. [Go here, and follow the
installation
instructions](https://cran.r-project.org/bin/windows/Rtools/). You’re
very likely on Windows 64-bit.

After you’ve installed RTools, restart the computer, open RStudio and
type:

``` r
install.packages("brms")
```
