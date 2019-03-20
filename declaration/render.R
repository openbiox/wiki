#!/usr/bin/env Rscript
if (!requireNamespace("pacman")){
	install.packages("pacman")
}
pacman::p_load(rmarkdown, knitr)
rmarkdown::render('./README.Rmd', output_format='all',encoding = "UTF-8")