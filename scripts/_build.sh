#!/bin/sh
Rscript -e "install.packages(c('rmarkdown','xaringan'));rmarkdown::render('slides.Rmd', 'xaringan::moon_reader')"