library(tidyverse)
library(glue)
files <- list.files(pattern = "part.*Rmd")
walk(files, function(f){
  rmarkdown::render(f, output_format = "html_document", 
                    output_file = glue("docs/{str_replace(f, 'Rmd', 'html')}"))
  })
