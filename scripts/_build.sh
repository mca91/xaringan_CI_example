#!/bin/sh
Rscript -e "install.packages('rmarkdown');rmarkdown::render('slides.Rmd', 'xaringan::moon_reader')"