source <- getwd()
out <- paste0(getwd(), "/", "docs")

#Render reports
rmarkdown::render(input = paste0(source, "/", "CGA-Playtest-Analysis.rmd"),
                  output_format = "html_document",
                  output_file = "CGA Playtest Analysis.html",
                  output_dir = out)

rmarkdown::render(input = paste0(source, "/", "CGA-0.13.rmd"),
                  output_format = "html_document",
                  output_file = "CGA-0.13.html",
                  output_dir = out)