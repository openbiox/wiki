#!/usr/bin/env Rscript
if (!requireNamespace("pacman"))
  install.packages("pacman")
pacman::p_load(rmarkdown, knitr)

rmarkdown::render('./README.Rmd', encoding = "UTF-8")