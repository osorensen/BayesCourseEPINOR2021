rmarkdown::render("README.Rmd", output_format = "html_document", output_file = "index.html")
library(tidyverse)
library(glue)

files <- list.files(pattern = "part.*Rmd")
walk(files, function(f){
  rmarkdown::render(f, output_format = "xaringan::moon_reader", 
                    output_file = glue("{str_replace(f, 'Rmd', 'html')}"))
  })
